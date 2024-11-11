//
//  inspectorViewZR.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

struct ZonasDeRiesgoView: View {
    let UISW = UIScreen.main.bounds.width
    let UISH = UIScreen.main.bounds.height

    var body: some View {
        ZStack {
            // Fondo azul degradado
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
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
            .position(x: UISW * 0.16, y: UISH * 0.1)
            
            // Frame blanco con contenido
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: UISW, height: UISH)
                .position(x: UISW * 0.5, y: UISH * 0.76)
            
            // Componente de mapa
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.2))
                .frame(width: UISW * 0.53, height: UISH * 0.5)
                .overlay(
                    VStack(alignment: .leading) {
                        HStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 12, height: 12)
                            
                            VStack(alignment: .leading) {
                                Text("Rancho don Pepe")
                                    .font(.custom("Poppins", size: 15))
                                    .bold()
                                Text("912, 1203A")
                                    .font(.custom("Poppins", size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        
                        Spacer()
                        
                        Text("Localiza zonas de riesgo")
                            .font(.custom("Poppins", size: 12))
                            .foregroundColor(.gray)
                    }
                    .padding()
                )
                .position(x: UISW * 0.4, y: UISH * 0.55)
            
            // Componente "Inspector"
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.brown)
                .frame(width: UISW * 0.27, height: UISH * 0.15)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.white)
                            .font(.title2)
                        Text("Inspector")
                            .foregroundColor(.white)
                            .font(.custom("Poppins", size: 15))
                            .bold()
                    }
                )
                .position(x: UISW * 0.8, y: UISH * 0.38)
            
            // Componente "Tutorial"
            VStack(alignment: .leading) {
                Text("Tutorial basado en el reglamento")
                    .bold()
                    .font(.custom("Poppins", size: 15))
                    .padding(.bottom, 10)
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: UISH * 0.35)
                    .overlay(
                        VStack(alignment: .leading) {
                            Text("Detalles del tutorial aquí.")
                                .foregroundColor(.gray)
                                .font(.footnote)
                                .padding()
                        }
                    )
            }
            .frame(width: UISW * 0.27, height: UISH * 0.5)
            .position(x: UISW * 0.8, y: UISH * 0.65)
        }
    }
}

struct ZonasDeRiesgoView_Previews: PreviewProvider {
    static var previews: some View {
        ZonasDeRiesgoView()
    }
}
