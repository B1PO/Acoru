import SwiftUI
import ARKit
import RealityKit


struct InsideSimuladorVV: View {
    @Binding var path: NavigationPath
    @Binding var currentTheme: ColorVariant // Color temático recibido
    @Binding var iconName: String           // Nombre del ícono recibido
    @State private var isNotification: Bool = false
    @State private var descriptionNotification: String =
        "Selecciona una instalacion para continuar"
    var iconsAR: [String] = ["riego_agua", "filtros_agua", "captacion_agua","tanques_agua"]
    @State private var selectedIndex: Int = 2 //
    
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Fondo: usa ARViewContainer para cargar el modelo AR
            ARViewContainer().ignoresSafeArea()
            // Superposición de elementos en la vista
            VStack {
                // Botón para regresar con color y estilo del tema
                HStack {
                    Button(
                        action: {
                            path.removeLast()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 20)

                        }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Spacer()
                
                // Indicadores en la parte inferior
                HStack(spacing: 10) {
                    ForEach(0..<iconsAR.count, id: \.self) { index in
                        ZStack {
                            Circle()
                                .fill(
                                    selectedIndex == index ? Color.white : Color.gray
                                        .opacity(0.5)
                                ) // Cambia el color según selección
                                .frame(width: selectedIndex == index ? 70 : 50, height: selectedIndex == index ? 70 : 50) // Tamaño según selección
                            
                            Image(iconsAR[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: selectedIndex == index ? 50 : 35, height: selectedIndex == index ? 50 : 35) // Tamaño de la imagen según selección
                        }
                        .onTapGesture {
                            withAnimation(.bouncy){
                                selectedIndex = index // Actualiza el índice seleccionado
                            }
                        }
                    }
                }
                .padding(.vertical, 60)

            }
            .padding(.top, 10)
            .frame(
                maxWidth: .infinity, maxHeight: .infinity)
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
            .position(x: UISW * 0.1, y: UISH * 0.17)
            NotificationWidget(
                descriptionText: descriptionNotification,
                isVisible: $isNotification
            )
            .position(x: UISW * 0.75, y: UISH * 0.17)
        }
        .task {
            // Espera 0.3 segundos antes de mostrar la notificación
            try? await Task.sleep(nanoseconds: 300_000_000)  // 0.3 segundos en nanosegundos
            isNotification = true

            // Puedes agregar otras acciones aquí si las necesitas
            // capturedPhotos.append(UIImage(systemName: "house.fill")!)
            // capturedPhotos.append(UIImage(systemName: "camera.fill")!)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
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
