import SwiftUI

struct InstalacionPopUp: View {
    @Binding var currentThemeColor: ColorVariant
    @Binding var isVisible: Bool  // Estado para mostrar/ocultar el popup
    @State private var isOnScreen = false  // Estado interno para la animación de entrada/salida
    @State private var selectedCardID: UUID? = nil  // Identificador de la tarjeta seleccionada
    @State private var selectedCardText: String? = nil  // Nombre de la instalación seleccionada
    @Binding var path: NavigationPath
    var callback: () -> Void

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
                        Task {
                            try? await Task.sleep(nanoseconds: 100_000_000)  // Espera 0.1 segundos
                            isVisible = false  // Oculta el popup después de la animación
                            callback()
                        }
                    }
                    .transition(.opacity)
            }

            // Contenido del popup
            if isVisible {
                VStack(spacing: 0) {
                    VStack {
                        VStack(spacing: 20) {
                            HStack(spacing: 20) {
                                CardInstalacion(
                                    model: ModelCardInstalacion(
                                        text: "Captación de Agua",
                                        image: "captacion_agua",
                                        description:
                                            "Sistema de captación de agua de lluvia para asegurar el acceso a recursos hídricos en zonas rurales."
                                    ),
                                    currentThemeColor: $currentThemeColor,
                                    selectedCardID: $selectedCardID,
                                    selectedCardText: $selectedCardText
                                )
                                CardInstalacion(
                                    model: ModelCardInstalacion(
                                        text: "Filtro de Agua",
                                        image: "filtros_agua",
                                        description:
                                            "Implementación de filtros de agua para mejorar la calidad y potabilidad del agua en comunidades rurales."
                                    ),
                                    currentThemeColor: $currentThemeColor,
                                    selectedCardID: $selectedCardID,
                                    selectedCardText: $selectedCardText
                                )
                            }
                            HStack(spacing: 20) {
                                CardInstalacion(
                                    model: ModelCardInstalacion(
                                        text: "Riego de Agua",
                                        image: "riego_agua",
                                        description:
                                            "Sistemas de riego eficientes para apoyar la agricultura sostenible y la autosuficiencia alimentaria."
                                    ),
                                    currentThemeColor: $currentThemeColor,
                                    selectedCardID: $selectedCardID,
                                    selectedCardText: $selectedCardText
                                )
                                CardInstalacion(
                                    model: ModelCardInstalacion(
                                        text: "Tanques de Agua",
                                        image: "tanques_agua",
                                        description:
                                            "Almacenamiento de agua en tanques seguros para asegurar un suministro estable y reducir la escasez en épocas de sequía."
                                    ),
                                    currentThemeColor: $currentThemeColor,
                                    selectedCardID: $selectedCardID,
                                    selectedCardText: $selectedCardText
                                )
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(20)
                    }
                    .frame(maxWidth: 600)
                    .background(Color(currentThemeColor.dark))
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
                        if let installationName = selectedCardText {
                        
                            let formattedName =
                                "instalacion_\(installationName)"
                            path.append(formattedName)  // Pasar el nombre de la instalación con el patrón especificado
                            isVisible = false  // Cerrar el popup después de navegar
                        }
                    }) {
                        Text("Iniciar")
                            .font(
                                customFont("Poppins", size: 22, weight: .bold)
                            )
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color(currentThemeColor.normal))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                    .offset(y: isOnScreen ? -15 : UIScreen.main.bounds.height)  // Animación de entrada/salida del botón
                    .animation(.easeInOut(duration: 0.3), value: isOnScreen)  // Agrega animación al botón también
                }
            }
        }
        .animation(.easeInOut, value: isVisible)  // Animación para mostrar/ocultar
    }
}
