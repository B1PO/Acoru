//
//  ContentSectionVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 04/11/24.
//

import SwiftUI

struct ContentSectionView: View {
    @Binding var capturedPhotos: [UIImage]
    @Binding var resultModel: [EvaluadorVVModel]
    @Binding var progress: Double
    var isLoading: Bool
    @Binding var currentThemeColor: ColorVariant
    @Binding var showPhotoPicker: Bool
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 30) {
            Text(
                capturedPhotos.isEmpty
                    ? "Captura inicial de la instalación"
                    : isLoading ? "Evaluando..." : "Resultados"
            )
            .font(customFont("Poppins", size: 26, weight: .bold))
            .foregroundColor(.black)

            if progress < 0.9 && !capturedPhotos.isEmpty {
                ProgresoComponent(
                    themeColor: $currentThemeColor,
                    progress: $progress,
                    activateDecorated: false
                )
                .padding(.bottom, 10)
            }

            if !capturedPhotos.isEmpty {
                ResultsListView(
                    resultModel: $resultModel,
                    currentThemeColor: $currentThemeColor
                )
                .padding(30)
                .frame(maxWidth: .infinity, maxHeight: 424.43)
                .background(Color(ColorPaletteVV.gris.normal))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            if capturedPhotos.isEmpty {
                UploadButtonSection(
                    showPhotoPicker: $showPhotoPicker,
                    currentThemeColor: $currentThemeColor, path: $path)
            }
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
