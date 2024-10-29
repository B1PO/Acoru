import SwiftUI

struct NotificationWidget: View {
    let icon: String = "info.circle.fill"
    let descriptionText: String
    @Binding var isVisible: Bool  // Binding para controlar la visibilidad desde fuera

    @State private var isOnScreen = false  // Estado interno para animación

    var body: some View {
        if isVisible {
            ZStack(alignment: .topTrailing) {
                HStack(alignment: .center, spacing: 16) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)

                    Text(descriptionText)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    withAnimation(.easeIn(duration: 0.5)) {
                        isOnScreen = false  // Desplazamiento de salida
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isVisible = false  // Cambiar la visibilidad después de la animación
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 24))
                }
                .padding([.top, .trailing], 10)
            }
            .frame(maxWidth: 450)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 16)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.yellow, lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 10)
            .offset(x: isOnScreen ? 0 : UIScreen.main.bounds.width)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    isOnScreen = true  // Animación de entrada desde la derecha
                }
                
                // Desaparecer automáticamente después de 15 segundos
                                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                    if isVisible {  // Verifica si sigue visible antes de iniciar la animación de salida
                                        withAnimation(.easeIn(duration: 0.5)) {
                                            isOnScreen = false
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            isVisible = false
                                        }
                                    }
                                }
            }
        }
    }
}

struct NotificationWidgetPreviewWrapper: View {
    @State private var isVisible: Bool = true
    
    var body: some View {
        NotificationWidget(
            descriptionText: "Para empezar, sube una foto de la instalación o toma una foto del área que deseas evaluar",
            isVisible: $isVisible
        )
    }
}

struct NotificationWidget_Previews: PreviewProvider {
    static var previews: some View {
        NotificationWidgetPreviewWrapper()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

