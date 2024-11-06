import SwiftUI
import ARKit
import RealityKit

struct InsideSimuladorVV: View {
    @Binding var path: NavigationPath
    @Binding var currentTheme: ColorVariant // Color temático recibido
    @Binding var iconName: String           // Nombre del ícono recibido
    @State private var isNotification: Bool = true
    
    var body: some View {
        ZStack {
            // Fondo: usa ARViewContainer para cargar el modelo AR
            ARViewContainer().ignoresSafeArea()
            
            // Superposición de elementos en la vista
            VStack {
                // Botón para regresar con color y estilo del tema
                Button(
                    action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 45))
                            .foregroundColor(Color(currentTheme.normal))
                            .padding(.horizontal)
                            .padding(.top, 20)
                    }
                    .padding(.trailing, 1100)
                
                HStack {
                    ZStack {
                        // Fondo blanco con esquinas redondeadas según el tema
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(width: 250, height: 90)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                            .cornerRadius(12, corners: [.topRight, .bottomRight])

                        // Contenido dentro del fondo blanco
                        HStack(spacing: 15) {
                            // Cuadrado azul o color temático en el lado izquierdo
                            ZStack {
                                RoundedRectangle(cornerRadius: 17)
                                    .stroke(Color(currentTheme.dark), lineWidth: 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 17)
                                            .fill(Color(currentTheme.normal))
                                    )
                                    .frame(width: 50, height: 50) // Tamaño del botón

                                // Ícono dinámico en el centro del botón
                                Image(iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 26, height: 26)
                                    .foregroundColor(.white)
                            }

                            // Texto en el lado derecho
                            Text("Simulador")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        .padding(.leading, 8)
                    }
                    Spacer()
                    
                    NotificationWidget(
                        descriptionText: "Para empezar, sube una foto de la instalación o toma una foto del área que deseas evaluar",
                        isVisible: $isNotification
                    )
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
                
                Spacer()
                
                // Indicadores en la parte inferior
                HStack(spacing: 16) {
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                    Circle().fill(Color.white).frame(width: 12, height: 12)
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                    Circle().fill(Color.gray).frame(width: 12, height: 12)
                }
                .padding(.bottom, 30)
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configuración de la sesión AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        // Cargar el modelo .usdz
        if let modelEntity = try? ModelEntity.loadModel(named: "RainModel") { // Cambia "nombre_del_modelo" por el nombre real del archivo .usdz
            // Crear un ancla y añadir el modelo
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity)
            arView.scene.addAnchor(anchorEntity)
        } else {
            print("Error: No se pudo cargar el modelo .usdz")
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct InsideSimuladorVV_Previews: PreviewProvider {
    static var previews: some View {
        InsideSimuladorVV(
            path: .constant(NavigationPath()),
            currentTheme: .constant(ColorPaletteVV.agua),
            iconName: .constant("Gota")
        )
    }
}
