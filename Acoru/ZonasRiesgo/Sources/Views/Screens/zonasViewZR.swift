import SwiftUI

struct zonasViewZR: View {
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height
    var onClose: () -> Void // Función para regresar a la vista principal

    @State private var showMapView = false // Estado para controlar la presentación de la pantalla completa

    var body: some View {
        ZStack {
            // Gradiente de fondo
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 116/255, green: 140/255, blue: 146/255), Color(red: 141/255, green: 226/255, blue: 250/255)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: UISW, height: UISH * 0.4)
            .edgesIgnoringSafeArea(.all)
            .position(x: UISW * 0.5, y: UISH * 0.1)
            
            Image("zonasHeader")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.1)
                .position(x: UISW * 0.5, y: UISH * 0.183)
            
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
                Text("Zonas de riesgo")
                    .font(.custom("Poppins", size: 35))
                    .bold()
                
                Text("Previene, aprende y contribuye")
                    .font(.custom("Poppins", size: 15))
                    .foregroundColor(.black)
                    .offset(y: 20)
                    .opacity(0.8)
            }
            .position(x: UISW * 0.16, y: UISH * 0.13    )
            
            // Texto adicional
            Text("Marcar zona")
                .bold()
                .font(.custom("Poppins", size: 18))
                .position(x: UISW * 0.1, y: UISH * 0.33)

            // Imagen "imagenMapaZR" que abre la pantalla completa con la vista del mapa
            Button(action: {
                showMapView = true
            }) {
                Image("imagenMapaZR")
                    .resizable()
                    .frame(width: UISW * 0.425, height: UISH * 0.567)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .position(x: UISW * 0.24, y: UISH * 0.658)
            .fullScreenCover(isPresented: $showMapView) {
                inspectorViewZR() // Muestra la vista del mapa en pantalla completa
            }
            
            VStack {
                Image("inspectorZRImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UISW * 0.47, height: UISH * 0.16)
                    .position(x: UISW * 0.720, y: UISH * 0.43)
            }
            Text("Tutorial basado en el reglamento")
                .bold()
                .font(.custom("Poppins", size: 18))
                .position(x: UISW * 0.63, y: UISH * 0.54)
            
            Image("CardsZR")
                .resizable()
                .scaledToFit()
                .frame(width: UISW * 0.47, height: UISH * 0.38)
                .position(x: UISW * 0.720, y: UISH * 0.758)
        }
    }
}

// Vista previa para el archivo
#Preview {
    zonasViewZR(onClose: {})
}
