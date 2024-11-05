//
//  EvaluadorVVModel.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 03/11/24.
//

//creame un enum que sea etique evaluador : zona, materiales y recursos naturales

import SwiftUI

enum EvaluadorVV: String, CaseIterable {
    case zona
    case materiales
    case recursosNaturales

    // Propiedad calculada para una descripción personalizada
    var descripcion: String {
        switch self {
        case .zona:
            return "Zona"
        case .materiales:
            return "Materiales"
        case .recursosNaturales:
            return "Recursos Naturales"
        }
    }

    // Propiedad calculada para el color asociado a cada caso
    var color: ColorVariant {
        switch self {
        case .zona:
            return ColorPaletteVV.zonas
        case .materiales:
            return ColorPaletteVV.materiales
        case .recursosNaturales:
            return ColorPaletteVV.recursosNaturales
        }
    }
}

struct EvaluadorVVModel: Hashable {
    var image: UIImage?
    var description: String?
    var percentage: Double?
    var etiqueta: EvaluadorVV?
}
