//
//  InstalacionModel.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 20/10/24.
//
import SwiftUI

struct Instalaciones{
    let id: Int
    let nombre: String
    let descripcion: String
    let imagen: Color
    let pasos: [InstalacionesPasos] = []
}

struct InstalacionesPasos {
    let id: Int
    let nombre: String
    let descripcion: String
    let imagen: String
    let completado: Bool
}
