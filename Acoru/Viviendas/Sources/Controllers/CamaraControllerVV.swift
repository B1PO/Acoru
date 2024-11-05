import SwiftUI
import AVFoundation

import SwiftUI
import AVFoundation

struct CameraControllerVV: UIViewControllerRepresentable {
    @Binding var capturedPhotos: [UIImage]  // Array para almacenar las fotos capturadas
    
    func makeUIViewController(context: Context) -> AVCaptureViewController {
        let controller = AVCaptureViewController()
        controller.capturedPhotos = $capturedPhotos
        return controller
    }

    func updateUIViewController(_ uiViewController: AVCaptureViewController, context: Context) {}
}

class AVCaptureViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var photoOutput = AVCapturePhotoOutput()
    var capturedPhotos: Binding<[UIImage]>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCameraPermissions()
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                } else {
                    print("Permiso denegado para acceder a la cámara.")
                }
            }
        case .denied, .restricted:
            print("El acceso a la cámara está restringido o denegado.")
        @unknown default:
            break
        }
    }

    private func setupCamera() {
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else { return }

        guard let videoCaptureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }

        do {
            let input = try AVCaptureDeviceInput(device: videoCaptureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            // Configurar la salida de foto
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
        } catch {
            print("Error al configurar el dispositivo de la cámara: \(error)")
            return
        }

        // Configurar la capa de vista previa
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        if let videoPreviewLayer = videoPreviewLayer {
            view.layer.addSublayer(videoPreviewLayer)
        }

        captureSession.startRunning()
        
        // Agregar un botón para capturar fotos en la vista de la cámara
        setupCaptureButton()
    }
    
    private func setupCaptureButton() {
        let captureButton = UIButton(type: .system)
        captureButton.setTitle("Capturar", for: .normal)
        captureButton.setTitleColor(.white, for: .normal)
        captureButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        captureButton.layer.cornerRadius = 25
        captureButton.clipsToBounds = true
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(captureButton)
        
        NSLayoutConstraint.activate([
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            captureButton.widthAnchor.constraint(equalToConstant: 100),
            captureButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    // Delegate para manejar la captura de fotos
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error al capturar foto: \(error)")
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        // Agregar la foto al array
        capturedPhotos?.wrappedValue.append(image)
    }
}

