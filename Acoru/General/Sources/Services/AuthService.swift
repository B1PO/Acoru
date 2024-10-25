import SwiftUI
import FirebaseAuth

class AuthService: ObservableObject {
    @Published var isAuthenticated: Bool = false

    func signIn(with provider: AuthProvider) {
        switch provider {
        case .google:
            GoogleAuthService().signIn { [weak self] result in
                self?.handleAuthResult(result, provider: .google)
            }
        case .email(let email, let password):
            EmailAuthService().signIn(email: email, password: password) { [weak self] result in
                self?.handleAuthResult(result, provider: .email(email: email, password: password))
            }
        }
    }

    private func handleAuthResult(_ result: Result<User, Error>, provider: AuthProvider) {
        switch result {
        case .success(let user):
            UserService().saveUserDataIfNew(user, authProvider: provider) { [weak self] saveResult in
                switch saveResult {
                case .success:
                    self?.isAuthenticated = true
                case .failure(let error):
                    print("Error al guardar datos del usuario: \(error.localizedDescription)")
                    self?.isAuthenticated = false
                }
            }
        case .failure(let error):
            print("Error de autenticación: \(error.localizedDescription)")
            self.isAuthenticated = false
        }
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

