//
//  ForegroundImageModifier.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 20/10/24.
//

import SwiftUI

// Modificador personalizado para poner una imagen de fondo en texto
struct ForegroundImageModifier: ViewModifier {
    let image: Image

    func body(content: Content) -> some View {
        image
            .resizable()
            .scaledToFill() // Escala la imagen para que cubra las letras
            .overlay(content.mask(content)) // Aplica el recorte del texto
    }
}

extension View {
    func foregroundImage(_ image: Image) -> some View {
        self.modifier(ForegroundImageModifier(image: image))
    }
}
