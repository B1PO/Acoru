import SwiftUI

struct agrosilViewAS: View {
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height

    @State private var expandFrame = false
    @State private var showPopup = false
    @State private var showTexts = true
    var onClose: () -> Void // Función para regresar a la vista principal

    @State private var temperature: Int = Int.random(in: 20...23)
    @State private var humidity: Int = Int.random(in: 69...71)
    @State private var precipitation: Int = Int.random(in: -5...1)

    var body: some View {
        ZStack {
            // Gradiente de fondo
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 167/255, green: 215/255, blue: 203/255), Color(red: 112/255, green: 196/255, blue: 203/255)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: UISW, height: UISH * 0.4)
            .edgesIgnoringSafeArea(.all)
            .position(x: UISW * 0.5, y: UISH * 0.1)
            
            Image("tierra3x")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.1)
                .position(x: UISW * 0.5, y: UISH * 0.16)
            
            // Botón de regresar
            Button(action: {
                withAnimation {
                    expandFrame = false
                    showPopup = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        showTexts = true
                    }
                    onClose() // Llama a onClose() después de las animaciones
                }
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 15)
                    .position(x: UISW * 0.05, y: UISH * 0.05)
            }
            .opacity(expandFrame ? 0 : 1)
            .animation(.easeInOut, value: expandFrame)
            .ignoresSafeArea()
            
            // Marco blanco con contenido que se expande
            RoundedRectangle(cornerRadius: expandFrame ? 0 : 20)
                .fill(Color.frameColor)
                .frame(width: expandFrame ? UISW : UISW, height: expandFrame ? UISH : UISH)
                .position(x: expandFrame ? UISW * 0.5 : UISW * 0.5, y: expandFrame ? UISH * 0.5 : UISH * 0.79)
                .animation(.easeInOut(duration: 1), value: expandFrame)
                .ignoresSafeArea()
            
            // Elementos visibles cuando el frame no está expandido
            if !expandFrame && showTexts {
                VStack(alignment: .leading) {
                    Text("Agrosilvicultura")
                        .font(.custom("Poppins", size: 35))
                        .bold()
                    
                    Text("Gestiona tu experiencia agrícola")
                        .font(.custom("Poppins", size: 15))
                        .foregroundColor(.black)
                        .offset(y: 20)
                        .opacity(0.8)
                }
                .position(x: UISW * 0.16, y: UISH * 0.13)
                .animation(.easeInOut, value: expandFrame)
            }
            
            Image("inspectorAS")
                .resizable()
                .frame(width: UISW * 0.255, height: UISH * 0.13)
                .position(x: UISW * 0.155, y: UISH * 0.375)
                .opacity(expandFrame ? 0 : 1)
                .animation(.easeInOut, value: expandFrame)
                        
            Text("Maneja tu terreno")
                .bold()
                .font(.custom("Poppins", size: 15))
                .position(x: UISW * 0.1, y: UISH * 0.5)
                .opacity(expandFrame ? 0 : 1)
                .animation(.easeInOut, value: expandFrame)
            
            // Tarjetas con los datos
            generateInfoCard(iconName: "Termo", value: "\(temperature)°C", label: "Temperatura")
                .position(x: UISW * 0.365, y: UISH * 0.375)
                .opacity(expandFrame ? 0 : 1)

            generateInfoCard(iconName: "Humedad", value: "\(humidity)%", label: "Humedad")
                .position(x: UISW * 0.510, y: UISH * 0.375)
                .opacity(expandFrame ? 0 : 1)

            generateInfoCard(iconName: "Precipitacion", value: "\(precipitation) mm", label: "Precipitación")
                .position(x: UISW * 0.655, y: UISH * 0.375)
                .opacity(expandFrame ? 0 : 1)

            // Otros elementos de la vista...
            Image("agroASTImage")
                .resizable()
                .frame(width: UISW * 0.6775, height: UISH * 0.4)
                .cornerRadius(50)
                .position(x: UISW * 0.37, y: UISH * 0.745)
                .opacity(expandFrame ? 0 : 1)
                .animation(.easeInOut, value: expandFrame)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.6))
                .frame(width: UISW * 0.6775, height: UISH * 0.4)
                .cornerRadius(50)
                .overlay(
                    Text("Visualiza tus plantaciones digitales dentro del terreno ACORU")
                        .font(.custom("Poppins", size: 17.5))
                        .foregroundColor(.white)
                        .padding(.top, UISW * 0.22)
                        .padding(.trailing, UISW * 0.14)
                )
                .overlay(content: {
                    HStack {
                        Image("sectionIconAS")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Terreno ACORU")
                            .font(.custom("Poppins", size: 25).bold())
                            .foregroundColor(.white)
                    }
                    .offset(x: -UISW * 0.2, y: -UISH * 0.13)
                })
                .position(x: UISW * 0.37, y: UISH * 0.745)
                .opacity(expandFrame ? 0 : 1)
                .animation(.easeInOut, value: expandFrame)
            
            Image("WHEAT FULL")
                .resizable()
                .scaledToFit()
                .frame(width: UISW * 0.21, height: UISH * 0.64)
                .position(x: UISW * 0.867, y: UISH * 0.63)
                .opacity(expandFrame ? 0 : 1)
                .animation(.easeInOut, value: expandFrame)

            // Botón de "Comenzar"
            Button(action: {
                withAnimation {
                    expandFrame = true
                    showTexts = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showPopup = true
                }
            }) {
                HStack {
                    Text("Comenzar")
                    Image(systemName: "arrow.right")
                }
                .font(.custom("Poppins", size: 15))
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.celesteBtnColor)
                .foregroundColor(.white)
                .cornerRadius(25)
            }
            .position(x: UISW * 0.625, y: UISH * 0.9)
            .opacity(expandFrame ? 0 : 1)
            .animation(.easeInOut, value: expandFrame)

            // Mostrar popup después de 1 segundo
            if showPopup {
                terrenoPopupAS(onClose: {
                    withAnimation {
                        expandFrame = false
                        showPopup = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            withAnimation {
                                showTexts = true
                            }
                        }
                    }
                })
                .transition(.opacity)
            }
        }
        .onAppear {
            // Actualiza los valores cada 30 segundos
            Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
                temperature = Int.random(in: 20...26)
                humidity = Int.random(in: 69...75)
                precipitation = Int.random(in: -5...1)
            }
        }
    }
    
    // Función para generar una tarjeta de información
    private func generateInfoCard(iconName: String, value: String, label: String) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .frame(width: UISW * 0.12, height: UISH * 0.13)
            .overlay(
                VStack {
                    // Ícono circular
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                
                        )
                        .offset(x:-35, y:5)
                    
                    // Valor numérico
                    Text(value)
                        .font(.custom("Poppins", size: 22))
                        .bold()
                        .foregroundColor(.black)
                    
                    // Etiqueta
                    Text(label)
                        .font(.custom("Poppins", size: 15))
                        .foregroundColor(.black)
                        .opacity(0.8)
                }
            )
    }
}

// Vista previa para el archivo
#Preview {
    agrosilViewAS(onClose: {})
}
