//
//  progresoComponent.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

struct ProgresoComponent : View {
    @Binding var themeColor: ColorVariant
    @State var progress: Double = 0.0
    @State var maxWidth: CGFloat = 300
    
    var body: some View {
        HStack{
            Button(action: {}){
                ZStack{
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            ZStack(alignment: .leading){
                //creame un progress bar
                // Fondo de la barra de progreso
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(themeColor.normal))
                    .frame(height: 22)
                               
                // Progreso
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(themeColor.dark))
                    .frame(
                        width: CGFloat(progress) * 300,
                        height: 20
                    )  // Cambia el ancho según el progreso
                    .animation(
                        .easeInOut(duration: 0.5),
                        value: progress
                    )  // Anima el cambio del progreso
                VStack(){
                    Button(action: {}){
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: maxWidth)
            Button(action: {}){
                ZStack{
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
        }
    }
}
