import SwiftUI

// Componente que maneja tanto la lógica como la vista
struct cartaComponentVV<Destination: View>: View {
    @State private var isActive: Bool = true  // Estado del componente (si la barra está visible o no)
    var textBarra: String  // Texto personalizado para la barra
    var destinationView: Destination  // Vista de destino a donde redirige el botón
    var textCarta: String //Texto para adentro de la carta

    var body: some View {
        ZStack(alignment: .bottom) {  // Alineamos hacia abajo la capa inferior
            // Fondo blanco del rectángulo
            Rectangle()
                .fill(Color.blue)
                .frame(width: 300, height: 350)
                .cornerRadius(40)
                .shadow(radius: 5)
                .contentShape(Rectangle())  // Define el área táctil para todo el fondo
            
            VStack{
                Text(textCarta).foregroundColor(.white)
                    .padding(.leading, 15).font(.callout)
                
                // Botón de navegación
                NavigationLink(destination: destinationView) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .padding(.trailing, 10)
                    
                }
            }.position(x: 295, y: 550).opacity(isActive ? 0 : 1)
            
            // Barra azul que cubre el botón cuando está activa
            if isActive {
                VStack {
                                        ZStack {
                                            // Fondo blanco con esquinas redondeadas
                                            Rectangle()
                                                .fill(Color.white)
                                                .frame(width: 300, height: 110)
                                                .clipShape(esquinasRedondeadasComponentVV(radius: 40, corners: [.bottomLeft, .bottomRight]))
                                                .overlay(
                                                    HStack {
                                                        Text(textBarra)
                                                            .foregroundColor(.black)
                                                            .padding(.leading, 15)
                                                            .font(.callout)
                                                        Spacer()
                                                    }
                                                )
                                        }
                                        
                                        // Botón verde dentro del recuadro blanco
                                        Button(action: {
                                            toggleState()
                                        }) {
                                            Text("Presiona aquí")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color.green)
                                                .cornerRadius(15)
                                                .shadow(radius: 5)  // Sombra suave
                                        }
                                        .padding(.top, -45)  // Ajusta el espacio para colocarlo mejor debajo del texto
                                    }  // Animación para la barra azul
            }
          
                
            
        }
        .onTapGesture {
            // Solo cambiar el estado si el usuario no ha tocado el botón de navegación
            toggleState()  // Cambia el estado con animación
        }.onAppear {
            isActive = true  // Vuelve a mostrar la barra al regresar a esta vista
        }
    }

    // Método para alternar el estado con animación
    private func toggleState() {
        withAnimation {
            isActive.toggle()  // Cambia el estado de isActive
        }
    }
    
    
}



