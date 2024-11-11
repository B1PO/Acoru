import Foundation
import FirebaseFirestore
//
//  PostModelG.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 25/10/24.
//

// MARK: - Post de Comunidad
struct Post: Identifiable, Codable {
    @DocumentID var id: String?           // ID del post en Firebase
    var autorId: String                   // ID del usuario que creó el post
    var likes: Int                        // Número de likes del post
    var fecha: Timestamp                  // Fecha de creación del post (Firebase Timestamp)
    var titulo: String                    // Título del post
    var descripcion: String               // Descripción del post
    var tema: String                      // Tema del post (ej: "Viviendas", "Agrosilvicultura")
    var ubicacion: GeoPoint?              // Ubicación donde se creó el post (Firebase GeoPoint)
    var encuesta: [String: Int]           // Encuesta de interés por tema (ej: ["Viviendas": 15])
}
