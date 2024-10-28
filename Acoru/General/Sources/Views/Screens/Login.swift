//
//  Login.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 19/10/24.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var authViewModel: GoogleSignInViewModel
    
    var body: some View {
        ZStack{
            Color(red: 161 / 255, green: 215 / 255, blue: 156 / 255).ignoresSafeArea()
            VStack {
                // Texto con imagen de fondo
                            Text("ACORU")
                    .font(customFont("ZenDots", size: 100, weight: .regular)).foregroundColor(.clear)
                    .background(
                        Image("fondoLetrasAcoru") // Replace with your image name
                            .resizable()
                            .aspectRatio(contentMode: .fill).offset(y: 65)
                    )
                    .mask(
                        Text("ACORU")
                            .font(customFont("ZenDots", size: 100, weight: .regular))
                    )
                HStack {
                                   // Línea izquierda
                                   Rectangle()
                                       .frame(height: 1)
                                       .foregroundColor(.black)
                                   
                                   // Texto
                                   Text("INICIO DE SESIÓN")
                        .font(customFont("ZenDots", size: 20, weight: .regular))
                                       .foregroundColor(.black)
                                       .padding(.horizontal)
                                   
                                   // Línea derecha
                                   Rectangle()
                                       .frame(height: 1)
                                       .foregroundColor(.black)
                               }
                               .padding(.horizontal, 50)
                               
                
                               // Botón de Google
                               Button(action: {
                                   // Acción de autenticación
                                   authViewModel.signIn()
                               }) {
                                   HStack {
                                       Image("LoGoogle") // Icono de Google (debe estar en tus assets)
                                           .resizable()
                                           .frame(width: 30, height: 30)
                                       Text("Continuar con Google")
                                           .font(Font.custom("Montserrat", size: 18))
                                           .foregroundColor(.black)
                                   }
                                   .padding()
                                   .background(Color.white)
                                   .cornerRadius(10)
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 10)
                                           .stroke(Color.black, lineWidth: 1)
                                   )
                                   .padding(.horizontal, 100)
                               }
                           }
            }
           
        }
    }



struct MiVista_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
