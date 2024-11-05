//
//  PhotoPickerControllerVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 03/11/24.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selectedPhotos: [UIImage]  // Referencia a capturedPhotos para almacenar las imágenes seleccionadas

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0  // 0 permite seleccionar varias fotos; usa 1 para una sola foto
        config.filter = .images  // Filtra solo imágenes

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        if let uiImage = image as? UIImage {
                            DispatchQueue.main.async {
                                self?.parent.selectedPhotos.append(uiImage)  // Agrega la imagen seleccionada a capturedPhotos
                            }
                        }
                    }
                }
            }
        }
    }
}
