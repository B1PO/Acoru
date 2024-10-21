//
//  zonasViewZR.swift
//  Acoru
//
//  Created by Mario Moreno on 10/17/24.
//

import SwiftUI

struct zonasViewZR: View {
    var onClose: () -> Void // Función para regresar a la vista principal

    var body: some View {
        ZStack {
            // Fondo con gradiente
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.7, blue: 0.9), Color(red: 0.4, green: 0.5, blue: 0.9)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                VStack(alignment: .leading) {
                    // Botón para regresar
                    Button(action: {
                        onClose() // Acción para regresar a la pantalla principal
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 25))
                            .padding(.leading, 50)
                            .padding(.top)
                            .padding(.bottom)
                    }
                    
                    // Título de la vista
                    Text("Zonas de riesgo")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 50)
                        .padding(.bottom)
                    
                    // Subtítulo
                    Text("Gestiona tu experiencia agrícola")
                        .font(.title3)
                        .padding(.leading, 50)
                        .padding(.bottom)
                    
                    Spacer()
                }
                Spacer()
                // Aquí se puede añadir una animación Rive si es necesario
            }
            
            // Componente adicional de la vista (por ejemplo, marcar una zona)
            VStack {
                Spacer()
                marcarZonaComponentZR() // Componente personalizado
            }
        }
    }
}

// Vista previa para el archivo
#Preview {
    zonasViewZR(onClose: {})
}
