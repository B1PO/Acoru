import SwiftUI

struct ProgresoPopUp: View {
    @Binding var currentThemeColor: ColorVariant
    @Binding var model: ProgresoModel
    @Binding var isVisible: Bool  // Estado para mostrar/ocultar el popup
    @State private var isOnScreen = false  // Estado interno para la animación de entrada/salida

    var body: some View {
        ZStack {
            // Fondo opaco cuando el popup está visible
            if isVisible {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            isOnScreen = false  // Animación de salida
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isVisible = false  // Oculta el popup tras la animación
                        }
                    }
                    .transition(.opacity)
            }

            // Contenido del popup
            if isVisible {
                VStack(spacing: 0) {
                    VStack {
                        // Botón de cerrar
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    isOnScreen = false  // Animación de salida
                                }
                                DispatchQueue.main.asyncAfter(
                                    deadline: .now() + 0.3
                                ) {
                                    isVisible = false  // Oculta el popup tras la animación
                                }
                            }) {
                                Image(systemName: "xmark")
                                    .font(.title)
                                    .foregroundColor(
                                        Color(currentThemeColor.dark))
                            }
                        }
                        .padding([.top, .trailing], 30)

                        VStack {
                            Image(uiImage: model.img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(
                                            Color(currentThemeColor.dark),
                                            lineWidth: 4)
                                )

                            Text(model.title)
                                .font(
                                    customFont(
                                        "Poppins", size: 28, weight: .bold)
                                )
                                .foregroundColor(.black)
                                .padding(.top, 10)

                            VStack (spacing: 10){
                                Text("Pasos completados")
                                    .font(
                                        customFont(
                                            "Poppins", size: 22, weight: .bold)
                                    )
                                    .foregroundColor(
                                        Color(currentThemeColor.dark))

                                HStack(alignment: .center) {
                                    ProgresoComponent(
                                        themeColor: $currentThemeColor,
                                        fixedProgress: model.fixedProgress,
                                        activateDecorated: false
                                    )
                                    .padding(.leading, 40)

                                    Text(currentStepText())  // Mostrar el texto de progreso
                                        .font(
                                            customFont(
                                                "Poppins", size: 20,
                                                weight: .bold)
                                        )
                                        .foregroundColor(.gray.opacity(0.5))
                                }
                            }
                        }
                        .padding(.bottom, 50)  // Espacio para el botón
                    }
                    .frame(maxWidth: 600, maxHeight: 400)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
                    .offset(y: isOnScreen ? 0 : UIScreen.main.bounds.height)  // Animación de entrada/salida desde abajo
                    .animation(.easeInOut(duration: 0.3), value: isOnScreen)
                    .onAppear {
                        withAnimation(.easeOut(duration: 0.3)) {
                            isOnScreen = true  // Animación de entrada
                        }
                    }

                    // Botón verde fuera del popup
                    Button(action: {
                        // Acción del botón
                    }) {
                        Text("Continuar instalación")
                            .font(
                                customFont("Poppins", size: 24, weight: .regular)
                            )
                            .foregroundColor(.white)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 15)
                            .background(
                                Color(red: 0.49, green: 0.76, blue: 0.46)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(radius: 5)
                    }
                    .offset(y: isOnScreen ? -30 : UIScreen.main.bounds.height)  // Animación de entrada/salida del botón
                    .animation(.easeInOut(duration: 0.3), value: isOnScreen)  // Agrega animación al botón también
                }
            }
        }
        .animation(.easeInOut, value: isVisible)  // Animación para mostrar/ocultar
    }

    // Función para calcular el paso actual y el número máximo en base al progreso
    private func currentStepText() -> String {
        guard model.fixedProgress > 0 && model.fixedProgress <= 1 else {
            return "0/0"
        }

        let maxSteps = Int(1 / model.fixedProgress)
        let currentStep = Int(model.fixedProgress * Double(maxSteps))
        return "\(currentStep)/\(maxSteps)"
    }
}
