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
    
    // Nombres de los modelos AR correspondientes a cada índice
    var iconsAR: [String] = ["riego_agua", "filtros_agua", "captacion_agua", "tanques_agua"]
    
    // Índice seleccionado para mostrar el modelo
    @State private var selectedIndex: Int = 2
    @State private var selectedModelName: String = "captacion_agua" // Nombre del modelo AR inicial
    
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Pasamos el modelo seleccionado usando `selectedModelName`
            ARViewContainer(modelName: $selectedModelName)
                .ignoresSafeArea()

            VStack {
                // Botón para regresar
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
                                )
                                .frame(width: selectedIndex == index ? 70 : 50, height: selectedIndex == index ? 70 : 50)
                            
                            Image(iconsAR[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: selectedIndex == index ? 50 : 35, height: selectedIndex == index ? 50 : 35)
                        }
                        .onTapGesture {
                            withAnimation(.bouncy) {
                                selectedIndex = index
                                selectedModelName = iconsAR[selectedIndex] // Actualiza el modelo AR
                            }
                        }
                    }
                }
                .padding(.vertical, 60)
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .frame(width: 250, height: 90)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .cornerRadius(12, corners: [.topRight, .bottomRight])

                HStack(spacing: 15) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 17)
                            .stroke(Color(currentTheme.dark), lineWidth: 5)
                            .background(
                                RoundedRectangle(cornerRadius: 17)
                                    .fill(Color(currentTheme.normal))
                            )
                            .frame(width: 50, height: 50)

                        Image(iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .foregroundColor(.white)
                    }
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
            try? await Task.sleep(nanoseconds: 300_000_000)
            isNotification = true
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
}
struct ARViewContainer: UIViewRepresentable {
    @Binding var modelName: String // Nombre del modelo AR seleccionado

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.automaticallyConfigureSession = true

        // Configuración de la sesión AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)

        // Cargar el modelo inicial
        loadModel(named: modelName, into: arView)

        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Al actualizar la vista, elimina el modelo anterior y carga el nuevo
        uiView.scene.anchors.removeAll()
        loadModel(named: modelName, into: uiView)
    }

    private func loadModel(named name: String, into arView: ARView) {
        if let modelEntity = try? ModelEntity.loadModel(named: name) {
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity)
            arView.scene.addAnchor(anchorEntity)
        } else {
            print("Error: No se pudo cargar el modelo \(name).usdz")
        }
    }
}
