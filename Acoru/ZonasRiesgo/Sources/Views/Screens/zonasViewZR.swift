//
//  zonasViewZR.swift
//  Acoru
//
//  Created by Mario Moreno on 10/17/24.
//

import SwiftUI

struct zonasViewZR: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.7, blue: 0.9), Color(red: 0.4, green: 0.5, blue: 0.9)]),
                           startPoint: .top,
                           endPoint: .bottom)

            HStack {
                VStack(alignment: .leading) {
                    
                    Button(action: {}){ // back
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                            .font(.system(size: 25))
                            .padding(.leading, 50)
                            .padding(.top)
                            .padding(.bottom)
                    }
                    
                    Text("Zonas de riesgo")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 50)
                        .padding(.bottom)
                    Text("Gestiona tu experiencia agrícola")
                        .font(.title3)
                        .padding(.leading, 50)
                        .padding(.bottom)
                    
                    Spacer()
                    
                }
                Spacer()
                //aquí va a ir el RiveAnimation
                
            }
            
            VStack {
                Spacer()
                marcarZonaComponentZR()
            }
        
        } .ignoresSafeArea()
    }
}

#Preview {
    zonasViewZR()
}
