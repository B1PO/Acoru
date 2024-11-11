import FirebaseFirestore
import FirebaseAuth

class UserService {
    private let db = Firestore.firestore()

    func saveUserDataIfNew(_ user: User, authProvider: AuthProvider, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let email = user.email, !email.isEmpty else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "El correo es obligatorio y no puede estar vacío."])))
            return
        }

        let userRef = db.collection("Usuarios").document(user.uid)

        userRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let document = document, document.exists {
                print("Usuario existente, no se guarda nuevamente.")
                completion(.success(()))
            } else {
                let usuario = Usuario(
                    id: user.uid,
                    correo: email,
                    nombre: authProvider == .google ? user.displayName : nil
                )
                
                do {
                    try userRef.setData(from: usuario) { error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(()))
                        }
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

