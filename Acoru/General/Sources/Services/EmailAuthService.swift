//
//  EmailAuthService.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 25/10/24.
//

import FirebaseAuth

class EmailAuthService {
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
}
