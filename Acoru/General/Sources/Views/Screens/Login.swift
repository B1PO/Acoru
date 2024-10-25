//
//  Login.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 19/10/24.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var authService: AuthService  // Cambiado a AuthService

    var body: some View {
        ZStack {
            Color(red: 161 / 255, green: 215 / 255, blue: 156 / 255).ignoresSafeArea()
            VStack {
                // Texto con imagen de fondo
                Text("ACORU")
                    .font(customFont("ZenDots", size: 100, weight: .regular))
                    .foregroundColor(.clear)
                    .background(
                        Image("fondoLetrasAcoru") // Reemplaza con el nombre de tu imagen
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: 65)
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
                    // Autenticación con Google
                    authService.signIn(with: .google)
                }) {
                    HStack {
                        Image("LoGoogle") // Icono de Google (asegúrate de que esté en tus assets)
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

