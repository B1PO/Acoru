
//
//  carruselZR.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

struct CarruselComponentZR: View {

    let items = [
        CarruselItem(imageName: "imagen1", text: "Texto del tutorial 1"),
        CarruselItem(imageName: "imagen2", text: "Texto del tutorial 2"),
        CarruselItem(imageName: "imagen3", text: "Texto del tutorial 3")
    ]
    
    //para controlar el índice actual del carrusel
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            // Vista principal del carrusel
            TabView(selection: $currentIndex) {
                ForEach(0..<items.count, id: \.self) { index in
                    HStack {
                       
                        Image(items[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 300)
                            .background(Color.black)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(items[index].text)
                                .font(.body)
                                .foregroundColor(.gray)
                                .padding(.top, 10)
                        }
                        .padding(.leading, 16)
                    }
                    .tag(index)
                    .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // para poder ocultar los puntos predeterminados
            .gesture(DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 {
                        next()
                    } else if value.translation.width > 0 {
                        previous()
                    }
                }
            )
            
            
            // Botones
            HStack {
                Button(action: previous) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                .disabled(currentIndex == 0) // Deshabilitar si es el primer item
                
                Button(action: next) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
                .disabled(currentIndex == items.count - 1) // Deshabilitar si es el último item
            }
        }
    }
        
    
    // Funciones para ir al siguiente o anterior item
    func next() {
        if currentIndex < items.count - 1 {
            currentIndex += 1
        }
    }
    
    func previous() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
}


struct CarruselItem {
    let imageName: String
    let text: String
}

#Preview {
    CarruselComponentZR()
}
