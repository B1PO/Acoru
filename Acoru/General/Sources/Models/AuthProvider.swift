import Foundation
//
//  AuthProvider.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 25/10/24.
//


enum AuthProvider: Equatable {
    case google
    case email(email: String, password: String)

    // Conformidad a Equatable para comparar los casos con propiedades asociadas
    static func ==(lhs: AuthProvider, rhs: AuthProvider) -> Bool {
        switch (lhs, rhs) {
        case (.google, .google):
            return true
        case (.email(let email1, let password1), .email(let email2, let password2)):
            return email1 == email2 && password1 == password2
        default:
            return false
        }
    }
}
