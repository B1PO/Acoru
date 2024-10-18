//
//  fontLoader.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 17/10/24.
//
import SwiftUI

// Función para devolver el nombre de la fuente correcta en función del peso
    func customFont(_ baseName: String, size: CGFloat, weight: Font.Weight) -> Font {
        let fontName: String
        
        switch weight {
        case .bold:
            fontName = "\(baseName)-Bold"
        case .medium:
            fontName = "\(baseName)-Medium"
        case .light:
            fontName = "\(baseName)-Light"
        case .semibold:
            fontName = "\(baseName)-SemiBold"
        default:
            fontName = "\(baseName)-Regular"
        }
        
        return .custom(fontName, size: size)
    }
