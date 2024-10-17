//
//  viviendasView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

struct viviendasViewVV: View {
    var body: some View {
        NavigationView{
            ZStack(alignment: .top) {
                // Fondo degradado
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()  // Expande el fondo a toda la pantalla
                
                VStack(alignment: .leading) {
                    // Flecha de regreso
                    HStack {
                        Button(action: {
                            print("Regresar presionado")  // Acción del botón (ej. navegación)
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()  // Empuja el contenido a la izquierda
                    }
                    
                    // Título y subtítulo
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Viviendas sostenibles")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Descubre cómo construir tu hogar ideal con nuestras herramientas")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 50)  // Espaciado horizontal
                    .padding(.bottom, 50)  // Separación inferior
                    
                    Spacer()  // Empuja el contenido hacia arriba
                    
                    // Recuadro blanco con bordes redondeados
                    ZStack(){
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .frame(height: 600)  // Altura del recuadro blanco
                            .shadow(radius: 10)  // Sombra suave
                            .padding(.horizontal)
                        HStack(spacing: -40){
                            
                            cartaComponentVV(textBarra: "Pene", destinationView: simuladorViewVV(), textCarta: "Aquí estamos")
                            cartaComponentVV(textBarra: "Pene2", destinationView: simuladorViewVV(), textCarta: "Porque acá")
                            cartaComponentVV(textBarra: "Pene3", destinationView: simuladorViewVV(), textCarta: "Fue donde nos puso la vida")
                           
                        }.position(x: 605, y: 170)
                    }
                }
                .padding(.top, 20)  // Espacio superior para evitar la barra de estado
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        viviendasViewVV()
    }
}
