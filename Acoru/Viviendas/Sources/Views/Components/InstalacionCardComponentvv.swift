//
//  InstalacionCardComponentvv.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 19/10/24.
//

import SwiftUI

struct InstalacionCard: View {
    @State private var onOpen: Bool = false
    @Binding var themeColor: ColorVariant
    @State var instalacion: Instalaciones
    var onActionTriggered: (Instalaciones) -> Void // Closure para manejar el evento
    var body: some View {
        VStack (spacing: 20){
            HStack(spacing: 20){
                Circle()
                    .fill(Color(themeColor.dark))
                    .frame(width: 60, height: 60)
                Text(instalacion.nombre)
                    .font(
                        customFont(
                            "Poppins",
                            size: 20,
                            weight: .medium
                        )
                    )
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if(onOpen){
                    Button(
                        action: {
                            onActionTriggered(instalacion)
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(themeColor.dark))
                                .clipShape(Circle())
                        }
                        .frame(maxWidth: 40, alignment: .trailing)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if(onOpen){
                Text(instalacion.descripcion)
                    .font(
                        customFont(
                            "Poppins",
                            size: 20,
                            weight: .regular
                        )
                    )
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
        .padding(.vertical,onOpen ? 20: 10)
        .padding(.horizontal,20)
        .background(Color(themeColor.normal))
        .clipShape(
            RoundedRectangle(cornerRadius: 15)
        )
        .onTapGesture {
            withAnimation(.easeInOut){
                onOpen.toggle()
            }
        }
    }
}

