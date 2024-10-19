//
//  LoginController.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 19/10/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

class GoogleSignInViewModel: ObservableObject {
    
    @Published var isAuthenticated: Bool = false

    func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        // Obtener la escena activa para acceder al rootViewController
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("No se pudo obtener el rootViewController")
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
            guard error == nil else {
                print("Error al iniciar sesión con Google: \(error!.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            // Autenticación con Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error al autenticar con Firebase: \(error.localizedDescription)")
                    return
                }
                // Actualizar el estado si la autenticación fue exitosa
                self.isAuthenticated = true
            }
        }
    }


    func checkAuthentication() {
        self.isAuthenticated = Auth.auth().currentUser != nil
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isAuthenticated = false
        } catch let signOutError as NSError {
            print("Error al cerrar sesión: \(signOutError.localizedDescription)")
        }
    }
}
