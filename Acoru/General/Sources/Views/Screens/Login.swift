//
//  Login.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 19/10/24.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Color(red: 60 / 255, green: 198 / 255, blue: 244 / 255).ignoresSafeArea()
            VStack {
                // Texto con imagen de fondo
               /* Text("ACORU")
                    .font(customFont("ZenDots", size: 100, weight: .regular))
                    .foregroundColor(.clear)
                    .background(
                        Image("fondoLetrasAcoru")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: 65)
                    )
                    .mask(
                        Text("ACORU")
                            .font(customFont("ZenDots", size: 100, weight: .regular))
                    )*/


                    // Texto
                    Text("INICIO DE SESIÓN")
                        .font(customFont("Poppins", size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal)

            

                // Campos de texto personalizados
                CustomTextField(placeholder: "Correo electrónico", text: $email)
                CustomTextField(placeholder: "Contraseña", text: $password, isSecure: true)

                Button(action: {
                    authService.signIn(with: .email(email: email, password: password))
                }) {
                    Text("INGRESAR")
                        .font(.system(size: 16, weight: .bold)) // Ajusta el tamaño y estilo de fuente
                        .foregroundColor(Color(red: 46 / 255, green: 166 / 255, blue: 222 / 255)) // Color del texto
                        .padding()
                        .frame(width: 200, height: 39) // Expande el botón horizontalmente
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color(red: 46 / 255, green: 166 / 255, blue: 222 / 255), lineWidth: 1.5)
                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 6)
                }.padding(.bottom, 30)
               
                HStack {
                    // Línea izquierda
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)

                    // Texto
                    Text("Ó")
                        .font(customFont("Poppins", size: 20, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal)

                    // Línea derecha
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 450)
                
                Text("Ingresa con:").font(customFont("Poppins", size: 20, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.horizontal)
                
                // Botones de Google y Apple
                HStack(spacing: 20) {
                    Button(action: {
                        authService.signIn(with: .google)
                    }) {
                        HStack {
                            Image("LoGoogle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 6)
                    }

                    Button(action: {
                    }) {
                        HStack {
                            Image("LoApple")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        ).shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 6)
                    }
                }
                .padding(.top, 5).padding(.bottom, 50)
                
                
                Text("¿No tienes cuenta?").font(customFont("Poppins", size: 20, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.horizontal)
                
                Button(action: {
                    
                }) {
                    Text("Registrate aquí")
                        .font(.system(size: 16, weight: .bold)) // Ajusta el tamaño y estilo de fuente
                        .foregroundColor(Color.white) // Color del texto
                        .padding()
                        .frame(width: 160, height: 39) // Expande el botón horizontalmente
                        .background(Color(red: 46 / 255, green: 166 / 255, blue: 222 / 255))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 1.5)
                        )
                }.padding(.bottom, 30)
            }
            .padding()
        }
    }
}

// Vista personalizada para TextField con estilo
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            // Borde del TextField
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 1)
                .frame(height: 50)
            
            VStack(alignment: .leading, spacing: 0) {
                // Label flotante
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 6 / 255, green: 53 / 255, blue: 75 / 255))
                    .background(Color(red: 60 / 255, green: 198 / 255, blue: 244 / 255))
                    .padding(.leading, 10)
                    .padding(.bottom, -5) // Posición para superponerlo al borde
            
                // Campo de entrada con padding interno
                if isSecure {
                    SecureField("", text: $text)
                        .padding(.horizontal, 10)
                        .frame(height: 50) // Asegura la altura del campo
                } else {
                    TextField("", text: $text)
                        .padding(.horizontal, 10)
                        .frame(height: 50) // Asegura la altura del campo
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .frame(width: 300) // Ajusta el ancho según sea necesario
    }
}

struct MiVista_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthService()) // Asegúrate de pasar tu servicio de autenticación
    }
}
