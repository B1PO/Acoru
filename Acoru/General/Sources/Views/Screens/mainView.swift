import SwiftUI

struct MainView: View {
    @State private var selectedSection: String? = nil
    @State private var isExpanded = false
    @State private var circleScale: CGFloat = 0.001

    // Variables para obtener el tamaño de la pantalla
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            
            Image("acoru")
                .resizable()
                .scaledToFit()
            if let section = selectedSection {
                // Manejamos qué vista abrir según el círculo seleccionado
                switch section {
                case "Viviendas":
                    ViviendasViewVV(onClose: {
                        withAnimation {
                            selectedSection = nil
                        }
                    })
                    .transition(.scale)
                    
                case "Riesgo":
                    zonasViewZR(onClose: {
                        withAnimation {
                            selectedSection = nil
                        }
                    })
                    .transition(.scale)
                    
                case "Agrosil":
                    agrosilViewAS(onClose: {
                        withAnimation {
                            selectedSection = nil
                        }
                    })
                    .transition(.scale)
                    
                default:
                    EmptyView()
                }
            } else {
                // Vista inicial con los círculos
                CirclesView(selectedSection: $selectedSection, isExpanded: $isExpanded, circleScale: $circleScale, UISW: UISW, UISH: UISH)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isExpanded)
        .ignoresSafeArea()
    }
}

struct CirclesView: View {
    @Binding var selectedSection: String?
    @Binding var isExpanded: Bool
    @Binding var circleScale: CGFloat

    var UISW: CGFloat
    var UISH: CGFloat

    var body: some View {
        ZStack {
            // Representamos los tres círculos en posiciones absolutas usando position
            CircleButton(label: "Viviendas", color: .blue, action: {
                selectSection("Viviendas")
            })
            .position(x: UISW * 0.8, y: UISH * 0.3)

            CircleButton(label: "Riesgo", color: .red, action: {
                selectSection("Riesgo")
            })
            .position(x: UISW * 0.3, y: UISH * 0.4)


            CircleButton(label: "Agrosil", color: .green, action: {
                selectSection("Agrosil")
            })
            .position(x: UISW * 0.67, y: UISH * 0.8)
        }
        .scaleEffect(isExpanded ? 1 : 1)
    }

    func selectSection(_ section: String) {
        withAnimation(.easeInOut(duration: 0.4)) {
            isExpanded = true
            circleScale = 1.5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation {
                selectedSection = section
            }
        }
    }
}

struct CircleButton: View {
    var label: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 100, height: 100)
                Text(label)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    MainView()
}


