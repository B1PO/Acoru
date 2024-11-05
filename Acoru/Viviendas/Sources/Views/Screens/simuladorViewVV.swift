import SwiftUI

struct simuladorViewVV: View {
    @State private var isInsideSimuladorPresented = false // Variable de estado para controlar la presentación de la vista
    @Binding var currentTheme: ColorVariant

    var body: some View {
        VStack(spacing: 0) {
            // Encabezados de los pasos
            HStack(spacing: 15) {
                           PasoHeader(title: "Paso 1", themeColor: currentTheme)
                           PasoHeader(title: "Paso 2", themeColor: currentTheme)
                           PasoHeader(title: "Paso 3", themeColor: currentTheme)
                       }
            
            // Contenido de los pasos
            HStack(spacing: 15) {
                           PasoContent(content: "Verifica que la cámara funcione correctamente", iconName: "camera.on.rectangle.fill", themeColor: currentTheme)
                           PasoContent(content: "Selecciona entre las instalaciones la que sea de tu interés", iconName: "hand.tap.fill", themeColor: currentTheme)
                           PasoContent(content: "Lee los consejos de colocación y explora las posibilidades", iconName: "captions.bubble.fill", themeColor: currentTheme)
                       }
            
            // Botón de comenzar
            Button(action: {
                // Cambia el estado para presentar la vista de InsideSimuladorVV
                isInsideSimuladorPresented = true
            }) {
                HStack {
                    Text("Comenzar")
                    Image(systemName: "arrow.right")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(currentTheme.normal))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color(currentTheme.dark), lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 6)
            }
            .padding(.top, 16)
            .padding(.leading, 900)
            .fullScreenCover(isPresented: $isInsideSimuladorPresented) {
                InsideSimuladorVV() // Abre InsideSimuladorVV como pantalla completa
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

struct PasoHeader: View {
    var title: String
    var themeColor: ColorVariant // Color temático recibido desde simuladorViewVV
    
    var body: some View {
        Text(title)
            .font(customFont("Poppins", size: 28, weight: .bold))
            .frame(width: 300, height: 50, alignment: .center)
            .padding()
            .background(Color(themeColor.normal))
            .foregroundColor(.white)
            .clipShape(esquinasRedondeadasComponentVV(radius: 25, corners: [.topLeft, .topRight]))
    }
}

struct PasoContent: View {
    var content: String
    var iconName: String
    var themeColor: ColorVariant // Color temático recibido desde simuladorViewVV

    var body: some View {
        VStack(alignment: .leading) {
            Text(content)
                .font(customFont("Poppins", size: 18, weight: .medium))
                .frame(maxWidth: 230, alignment: .leading)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .padding(.top, 29)
            
            Spacer()
            
            // Botón simulado con color temático
            ZStack {
                RoundedRectangle(cornerRadius: 17)
                    .stroke(Color(themeColor.dark), lineWidth: 3)
                    .background(
                        RoundedRectangle(cornerRadius: 17)
                            .fill(Color(themeColor.normal))
                    )
                    .frame(width: 80, height: 80) // Tamaño del botón

                Image(systemName: iconName)
                    .foregroundColor(.white)
                    .font(.system(size: 32))
            }
            .padding(.leading, 75)
            .padding(.bottom, 50)
        }
        .frame(width: 300, height: 300, alignment: .top)
        .padding()
        .background(Color.gray.opacity(0.1))
        .clipShape(esquinasRedondeadasComponentVV(radius: 24, corners: [.bottomLeft, .bottomRight]))
    }
}




