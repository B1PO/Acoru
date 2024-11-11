import SwiftUI

struct agrosilViewAS: View {
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height
    
    var onClose: () -> Void // Función para regresar a la vista principal

    var body: some View {
        ZStack {
            // Gradiente de fondo
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.46, green: 0.76, blue: 0.87), Color(red: 0.85, green: 0.95, blue: 0.97)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: UISW, height: UISH * 0.4)
            .edgesIgnoringSafeArea(.all)
            .position(x: UISW * 0.5 ,y: UISH * 0.1)
            
            // Botón de regresar
            Button(action: {
                onClose() // Llamada a la función para cerrar la vista
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 15)
                    .position(x: UISW * 0.05, y: UISH * 0.05)
            }
            
            // Marco blanco con contenido
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.frameColor)
                .frame(width: UISW, height: UISH)
                .position(x: UISW * 0.5, y: UISH * 0.76)
            
            // Texto del header
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
            .position(x: UISW * 0.16, y: UISH * 0.145)
            
            // Componentes adicionales
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.brown)
                .frame(width: UISW * 0.255, height: UISH * 0.13)
                .overlay(
                    Text("Inspector")
                        .foregroundColor(.white)
                        .font(.footnote)
                        .bold()
                )
                .position(x: UISW * 0.155, y: UISH * 0.375)
            
            Text("Maneja tu terreno")
                .bold()
                .font(.custom("Poppins", size: 15))
                .position(x: UISW * 0.1, y: UISH * 0.5)
            
            // Botón de "Monitorear"
            Button(action: {
                // Acción de monitoreo
            }) {
                HStack {
                    Text("Monitorear")
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
            .position(x: UISW * 0.625, y: UISH * 0.9) // Posicionando el botón de monitoreo
            
            // Cuadrados de plantaciones
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: UISW * 0.12, height: UISH * 0.13)
                .position(x: UISW * 0.365, y: UISH * 0.375)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: UISW * 0.12, height: UISH * 0.13)
                .position(x: UISW * 0.510, y: UISH * 0.375)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: UISW * 0.12, height: UISH * 0.13)
                .position(x: UISW * 0.655, y: UISH * 0.375)
            
            // Rectángulos adicionales con textos
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .frame(width: UISW * 0.6775, height: UISH * 0.4)
                .overlay(
                    Text("Visualiza tus plantaciones con el terreno digital de ACORU")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                )
                .position(x: UISW * 0.37, y: UISH * 0.745)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .frame(width: UISW * 0.21, height: UISH * 0.64)
                .overlay(
                    Text("WHEAT")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                )
                .position(x: UISW * 0.867, y: UISH * 0.63)
        }
    }
}

// Vista previa para el archivo
#Preview {
    agrosilViewAS(onClose: {})
}
