//
//  ContentView.swift
//  Acoru
//
//  Created by Pedro Prado on 18/09/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authService: AuthService
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        Group {
            if authService.isAuthenticated {
                MainView()
            } else {
                LoginView()
                    .onAppear {
                        authService.signOut() // Desconectar al inicio, si es necesario
                    }
                    .onReceive(authService.$isAuthenticated) { isAuthenticated in
                        if isAuthenticated {
                            saveUserIfNew()
                        }
                    }
            }
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func saveUserIfNew() {
        guard let user = Auth.auth().currentUser else {
            self.errorMessage = "No se pudo obtener el usuario actual."
            self.showError = true
            return
        }

        let authProvider: AuthProvider = user.providerData.contains(where: { $0.providerID == "google.com" }) ? .google : .email(email: user.email ?? "", password: "")
        UserService().saveUserDataIfNew(user, authProvider: authProvider) { result in
            switch result {
            case .success:
                // Si se guarda exitosamente, redirigir a MainView
                authService.isAuthenticated = true
            case .failure(let error):
                // Si hay un error al guardar, mostrar el mensaje de error
                self.errorMessage = error.localizedDescription
                self.showError = true
                authService.isAuthenticated = false
            }
        }
    }
}
