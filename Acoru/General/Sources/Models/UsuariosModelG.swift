import Foundation
import FirebaseFirestore
//
//  UsuariosModelG.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 20/10/24.
//

struct Usuario: Identifiable, Codable {
    @DocumentID var id: String?           // ID del usuario en Firebase
      var correo: String                    // Correo electrónico del usuario
      var nombre: String?                 // Nombre completo del usuario
      var ubicacion: GeoPoint?              // Ubicación del usuario (Firebase GeoPoint)
      var temasInteres: [String] = []          // Lista de temas de interés del usuario
      var contadorVisitas: [String: Int] = [:]   // Contador de visitas por módulo (ej: ["Viviendas": 5])
      var luzElectrica: Bool = false              // Indica si el usuario tiene luz eléctrica
      var zonaRiesgo: [String] = []           // Lista de desastres naturales comunes (ej: ["temblores"])
      var fotoPerfil: String?                // Emoji del perfil del usuario (usando Swift Avatars)
}
