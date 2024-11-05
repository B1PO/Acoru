import SwiftUI

struct ButtonEvaluador: View {
    var title: String
    var icon: Image

    @State private var isOpen: Bool = false
    @State private var textOffset: CGFloat = -100  // Posición inicial del texto fuera de la vista
    @Binding var currentThemeColor: ColorVariant
    var callback: () -> Void

    var body: some View {
        VStack {
            Button(action: {
                callback()
            }) {
                VStack {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .padding(20)
                        .background(Color(currentThemeColor.normal))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(currentThemeColor.dark), lineWidth: 4)
                        )

                    if isOpen {
                        Text(title)
                            .font(customFont("Poppins", size: fontSizeForOffset(textOffset), weight: .bold))
                            .foregroundColor(Color(currentThemeColor.dark))
                            .offset(y: textOffset)
                            .onAppear {
                                // Animar el desplazamiento y el tamaño de la fuente del texto
                                withAnimation(.easeOut(duration: 0.5)) {
                                    textOffset = 0  // Mover el texto a su posición final
                                }
                            }
                    }
                }
            }
        }
        .onAppear {
            isOpen = true  // Activar isOpen cuando el VStack se renderiza
        }
    }
    
    // Función para calcular el tamaño de la fuente según el desplazamiento
    private func fontSizeForOffset(_ offset: CGFloat) -> CGFloat {
        // Mapea el desplazamiento de -100 a 0 en un tamaño de fuente de 10 a 20
        let minFontSize: CGFloat = 8
        let maxFontSize: CGFloat = 16
        let offsetRange: CGFloat = 100  // Rango de desplazamiento de -100 a 0
        
        // Calcula el tamaño de la fuente en función del desplazamiento
        return minFontSize + (maxFontSize - minFontSize) * (1 - (-offset / offsetRange))
    }
}


