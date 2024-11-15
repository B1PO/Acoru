import SwiftUI

struct MainView: View {
    @State private var selectedSection: String? = nil
    @State private var isExpanded = false
    @State private var circleScale: CGFloat = 0.001
    @State private var isBackgroundChanged = false // Estado para cambiar el color de fondo

    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            // Cambia el fondo entre gradiente y `frameColor`
            if isBackgroundChanged {
                Color.frameColor
                    .animation(.easeInOut(duration: 0), value: isBackgroundChanged)
                    .edgesIgnoringSafeArea(.all)
            } else {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 97/255, green: 193/255, blue: 238/255), Color(red: 176/255, green: 228/255, blue: 255/255)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            }

            Image("mainZ")
                .resizable()
                .scaledToFit()
                .frame(width: UISW * 0.76)
                .opacity(selectedSection == nil ? 1 : 0)
            
            Text("Bienvenid@ a ACORU,")
                .font(.custom("Poppins", size: 25).bold())
                .foregroundColor(Color.brownMainColor)
                .position(x: UISW * 0.22, y: UISH * 0.2)
                .opacity(selectedSection == nil ? 1 : 0)
            
            Text("¿qué deseas hacer hoy?")
                .font(.custom("Poppins", size: 25))
                .foregroundColor(Color.brownMainColor)
                .position(x: UISW * 0.23, y: UISH * 0.25)
                .opacity(selectedSection == nil ? 1 : 0)

            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
                .frame(width: UISW * 0.15, height: UISH * 0.1)
                .overlay {
                    HStack{
                        ZStack{
                            Circle()
                                .fill(Color.frameColor)
                                .frame(width: UISW * 0.06)
                            Image("BIPO")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UISW * 0.06)


                        }
                        VStack(spacing: -5){

                            Text("BIPO")
                                .font(.custom("Poppins", size: 25).bold())
                                .foregroundColor(.grayColor)
                            HStack{
                                Text("Activo")
                                    .font(.custom("Poppins", size: 15))
                                    .foregroundColor(.grayColor)

                                Circle()
                                    .fill(Color.green)
                                    .frame(width: UISW * 0.01)

                            }

                        }
                    }
                }
                .position(x: UISW * 0.9, y: UISH * 0.1)
                .opacity(selectedSection == nil ? 1 : 0)
            
            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
                .frame(width: UISH * 0.1, height: UISH * 0.1)
                .overlay {
                    HStack{
                        ZStack{
                            Circle()
                                .fill(Color.frameColor)
                                .frame(width: UISW * 0.06)
                            Image("chat")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UISW * 0.03)


                        }
                    }
                }
                .position(x: UISW * 0.94, y: UISH * 0.9)
                .opacity(selectedSection == nil ? 1 : 0)
            
            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
                .frame(width: UISH * 0.1, height: UISH * 0.1)
                .overlay {
                    HStack{
                        ZStack{
                            Circle()
                                .fill(Color.frameColor)
                                .frame(width: UISW * 0.06)
                            Image("noti")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UISW * 0.03)


                        }
                        
                    }
                }
                .position(x: UISW * 0.06, y: UISH * 0.1)
                .opacity(selectedSection == nil ? 1 : 0)



            if let section = selectedSection {
                switch section {
                case "Viviendas":
                    ViviendasViewVV(onClose: {
                        withAnimation (.easeOut(duration: 0.001)){
                            selectedSection = nil
                            isBackgroundChanged = false // Vuelve al gradiente
                        }
                    })
                    .transition(.move(edge: .top))

                case "Riesgo":
                    zonasViewZR(onClose: {
                        withAnimation (.easeOut(duration: 0.001)){
                            selectedSection = nil
                            isBackgroundChanged = false // Vuelve al gradiente
                        }
                    })
                    .transition(.move(edge: .top))

                case "Agrosil":
                    agrosilViewAS(onClose: {
                        withAnimation (.easeOut(duration: 0.001)){
                            selectedSection = nil
                            isBackgroundChanged = false // Vuelve al gradiente
                        }
                    })
                    .transition(.move(edge: .top))

                default:
                    EmptyView()
                }
            } else {
                CirclesView(selectedSection: $selectedSection, isExpanded: $isExpanded, circleScale: $circleScale, UISW: UISW, UISH: UISH)
                    .opacity(isBackgroundChanged ? 0 : 1) // Oculta al navegar
            }
        }
        .onChange(of: selectedSection) { newValue in
            if newValue != nil {
                // Cambia el fondo al `frameColor` con un retraso de 1 segundo antes de la transición
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    withAnimation {
                        isBackgroundChanged = true
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.6), value: selectedSection)
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
            CircleButton(
                label: "Viviendas",
                color: Color.brownMainColor,
                iconImage: "viviendasIconG",
                direction: .right,
                rectWidth: 220,
                rectHeight: 70,
                circleSize: 70,
                labelOffset: 100,
                enterAction: { selectSection("Viviendas") }
            )
            .position(x: UISW * 0.8, y: UISH * 0.3)

            CircleButton(
                label: "Zonas de Riesgo",
                color: Color.brownMainColor,
                iconImage: "zonasIconG",
                direction: .left,
                rectWidth: 260,
                rectHeight: 70,
                circleSize: 70,
                labelOffset: 105,
                enterAction: { selectSection("Riesgo") }
            )
            .position(x: UISW * 0.3, y: UISH * 0.4)

            CircleButton(
                label: "Agrosilvicultura",
                color: Color.brownMainColor,
                iconImage: "agroIconG",
                direction: .right,
                rectWidth: 250,
                rectHeight: 70,
                circleSize: 70,
                labelOffset: 100,
                enterAction: { selectSection("Agrosil") }
            )
            .position(x: UISW * 0.67, y: UISH * 0.8)
        }
    }

    func selectSection(_ section: String) {
        withAnimation {
            selectedSection = section
        }
    }
}

struct CircleButton: View {
    var label: String
    var color: Color
    var iconImage: String
    var direction: Direction
    var rectWidth: CGFloat
    var rectHeight: CGFloat
    var circleSize: CGFloat
    var labelOffset: CGFloat
    var enterAction: () -> Void

    @State private var isPressed = false

    enum Direction {
        case left, right
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 90)
                .fill(color)
                .frame(width: isPressed ? rectWidth : circleSize * 1.25, height: rectHeight)
                .overlay(
                    HStack {
                        if isPressed {
                            if direction == .right {
                                Text(label)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .offset(x: labelOffset)
                            } else {
                                Text(label)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .offset(x: -labelOffset)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: direction == .right ? .leading : .trailing)
                )
                .offset(x: isPressed ? (direction == .right ? rectWidth / 2.5 : -rectWidth / 2.5) : (direction == .right ? rectWidth / 45 : -rectWidth / 45))
                .animation(.easeInOut(duration: 0.3), value: isPressed)

            Button(action: {
                if isPressed {
                    enterAction()
                } else {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPressed = true
                    }
                }
            }) {
                Circle()
                    .fill(color)
                    .frame(width: circleSize, height: circleSize)
                    .overlay(
                        Group {
                            if isPressed {
                                Image(systemName: "arrow.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: circleSize * 0.4, height: circleSize * 0.4)
                                    .foregroundColor(.white)
                            } else {
                                Image(iconImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: circleSize * 1.2)
                            }
                        }
                    )
            }
        }
    }
}

#Preview {
    MainView()
}
