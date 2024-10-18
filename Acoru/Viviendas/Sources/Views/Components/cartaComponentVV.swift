import SwiftUI

// Componente que maneja tanto la lógica como la vista
struct cartaComponentVV: View {
    var titulo: String  // Texto personalizado para la barra
    var descripcion: String //Texto para adentro de la carta
    //crea un binding externo del tema
    


    var body: some View {
        ZStack() {  // Alineamos hacia abajo la capa inferior
            Circle()
                .fill(Color.white)
                .frame(width: .infinity, height: (148))
                
        }
    }
    
}


