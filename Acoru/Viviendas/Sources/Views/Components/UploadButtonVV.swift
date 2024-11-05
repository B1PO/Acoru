//
//  UploadButtonVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 04/11/24.
//

import SwiftUI

struct UploadButtonSection: View {
    @Binding var showPhotoPicker: Bool
    @Binding var currentThemeColor: ColorVariant
    @Binding var path: NavigationPath

    var body: some View {
        HStack(spacing: 20) {
            ButtonEvaluador(
                title: "Subir fotos",
                icon: Image(systemName: "camera.viewfinder"),
                currentThemeColor: $currentThemeColor
            ) {
                withAnimation(.bouncy) {
                    showPhotoPicker = true
                }
            }
            ButtonEvaluador(
                title: "Abrir cámara",
                icon: Image(systemName: "camera.viewfinder"),
                currentThemeColor: $currentThemeColor
            ) {
                path.append("Camara")
            }
        }
        .frame(maxWidth: 400, maxHeight: 240)
        .background(Color(ColorPaletteVV.gris.normal))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
