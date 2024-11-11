//
//  inspectorComponentZR.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//
import SwiftUI

struct zonasViewZR: View {
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
                .fill(Color.white)
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
            .position(x: UISW * 0.16, y: UISH * 0.145)
            
            // Componentes adicionales
          
            
            Text("Marcar zona")
                .bold()
                .font(.custom("Poppins", size: 18))
                .position(x: UISW * 0.1, y: UISH * 0.33)
            
            // Botón de "Monitorear"
            Button(action: {
                // Acción de monitoreo
            }) {
                HStack {
                    Text("Rancho Don Pepe")
                    
                }
                .font(.custom("Poppins", size: 15))
                .bold()
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.teal)
                .foregroundColor(.black)
                .cornerRadius(15)
                
                                
            }
            .position(x: UISW * 0.125, y: UISH * 0.42)
           
            
            // Rectángulos adicionales con textos
            ZStack {
                
               
                RoundedRectangle(cornerRadius: 20)
                   // .fill(Color.gray.opacity(0.2)) // Fondo semitransparente encima de la imagen
                    .frame(width: UISW * 0.425, height: UISH * 0.567)
                    .overlay(
                        Text("Localiza zonas de riesgo")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding()
                    )
            }
                .position(x: UISW * 0.24, y: UISH * 0.658)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.brown)
                    .frame(width: UISW * 0.47, height: UISH * 0.16)
                    .overlay(
                        Text("Inspector")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .bold()
                    )
                    .position(x: UISW * 0.720, y: UISH * 0.43)
            }
            Text("Tutorial basado en el reglamento")
                .bold()
                .font(.custom("Poppins", size: 18))
                .position(x: UISW * 0.63, y: UISH * 0.54)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .frame(width: UISW * 0.47, height: UISH * 0.38)
                .overlay(
                    Text("tutorial")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                )
                .position(x: UISW * 0.720, y: UISH * 0.758)
        }
    }
}

// Vista previa para el archivo
#Preview {
    zonasViewZR(onClose: {})
    zonasViewZR(onClose: {})
}

