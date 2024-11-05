import SwiftUI
import ARKit
import RealityKit

struct InsideSimuladorVV: View {
    var body: some View {
        ZStack {
            // Fondo: usa ARViewContainer para el dispositivo, o Color negro para el preview
            cameraBackground()
            
            // Superposición de elementos en la vista
            VStack {
                // Encabezado en la esquina superior izquierda, pegado al borde izquierdo
                HStack {
                    ZStack {
                        // Fondo blanco con esquinas superiores e inferiores derechas redondeadas
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(width: 250, height: 90) // Ajusta el ancho y la altura del fondo
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Sombra opcional
                            .cornerRadius(12, corners: [.topRight, .bottomRight]) // Aplica solo a las esquinas derechas

                        // Contenido dentro del fondo blanco
                        HStack(spacing: 15) { // Ajusta el espacio entre el cuadrado y el texto
                            // Cuadrado azul en el lado izquierdo
                            ZStack {
                                RoundedRectangle(cornerRadius: 17)
                                    .stroke(Color(red: 46 / 255, green: 166 / 255, blue: 222 / 255), lineWidth: 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 17)
                                            .fill(Color(red: 97 / 255, green: 193 / 255, blue: 238 / 255))
                                    )
                                    .frame(width: 50, height: 50) // Tamaño del botón

                                // Ícono en el centro del botón
                                Image("Gota")
                                    .resizable() // Hace que la imagen pueda cambiar de tamaño
                                                .scaledToFit() // Escala la imagen para que se ajuste al contenedor sin deformarse
                                                .frame(width: 26, height: 26) // Tamaño de la imagen
                                                .foregroundColor(.white)
                            } // Tamaño del cuadrado

                            // Texto en el lado derecho
                            Text("Simulador")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 8) // Ajusta el espacio interno a la izquierda del cuadrado
                    }
                    Spacer()
                }
                .padding(.top, 16) // Solo padding superior
                .padding(.trailing, 16) // Solo padding derecho para mantener espaciado de la derecha
                
                Spacer()
                
                // Notificación en la esquina superior derecha
                HStack {
                    Spacer()
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.gray)
                        Text("Selecciona una instalación para continuar")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding([.top, .trailing], 16)
                
                Spacer()
                
                // Botones en la parte inferior
                HStack(spacing: 16) {
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                    Circle().fill(Color.white).frame(width: 12, height: 12) // botón activo
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                }
                .padding(.bottom, 30)
            }
        }
    }
    
    @ViewBuilder
    private func cameraBackground() -> some View {
        #if targetEnvironment(simulator)
        // En el simulador y preview: usa fondo negro si la imagen no está disponible
        if let _ = UIImage(named: "fondoLetrasAcoru") {
            Image("fondoLetrasAcoru")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        } else {
            Color.black.ignoresSafeArea() // Fondo negro si no tienes una imagen
        }
        #else
        // En el dispositivo: usa la cámara en tiempo real (ARViewContainer)
        ARViewContainer().ignoresSafeArea()
        #endif
    }
}

struct InsideSimuladorVV_Previews: PreviewProvider {
    static var previews: some View {
        InsideSimuladorVV()
    }
}

// ARViewContainer para usar la cámara real en el dispositivo
struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configuración de la sesión AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
