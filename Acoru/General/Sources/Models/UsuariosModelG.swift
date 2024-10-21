//
//  UsuariosModelG.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 20/10/24.
//

struct Usuario {
    let id: String // ID generado por Firebase Authentication
    let correo: String // Obtenido de Firebase Auth
    let nombre: String // Obtenido de Firebase Auth
    let apellidos: String // Obtenido de Firebase Auth
    let ubicacion: Coordenadas // Coordenadas de la ubicación del usuario
//    let temasInteres: [String] // Ej: ["Servicios básicos", "Agricultura"]
//    let contadorVistas: [String: Int] // Módulo y cantidad de veces que lo ha visto
//    let tipoZona: String // "Montañoso", "Árido", "Tropical"
//    let tieneLuzElectrica: Bool // Dependiendo de la respuesta, se mostrarán recomendaciones
//    let riesgos: [String: Bool] // Ej: ["Temblores": true, "Inundaciones": false]
    let fotoPerfilURL: String // URL de la foto de perfil almacenada en Firebase Storage
    let instalaciones: [Instalaciones]
}
