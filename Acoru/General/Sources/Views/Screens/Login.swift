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
        VStack {
            Text("Iniciar sesión con Google")
            Button(action: {
                authViewModel.signIn()
            }) {
                Text("Iniciar sesión")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
