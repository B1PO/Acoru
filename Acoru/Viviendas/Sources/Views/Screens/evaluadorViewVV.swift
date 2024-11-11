import SwiftUI

struct EvaluadorViewVV: View {
    @Binding var currentThemeColor: ColorVariant
    @Binding var path: NavigationPath
    @Binding var capturedPhotos: [UIImage]
    @State private var resultModel: [EvaluadorVVModel] = []

    @State private var isLoading: Bool = false
    @State private var progress: Double = 0.3

    @State private var currentIndex: Int = 0
    @Binding var showPhotoPicker: Bool

    var body: some View {
        HStack {
            if !capturedPhotos.isEmpty {
                ImageCarouselView(
                    capturedPhotos: $capturedPhotos, currentIndex: $currentIndex
                )
            }

            ContentSectionView(
                capturedPhotos: $capturedPhotos,
                resultModel: $resultModel,
                progress: $progress,
                isLoading: isLoading,
                currentThemeColor: $currentThemeColor,
                showPhotoPicker: $showPhotoPicker,
                path: $path
            )
        }
        .onChange(of: capturedPhotos) {
            print(
                "Captured Photos Changed", capturedPhotos.count,
                resultModel.count)

            if capturedPhotos.count > resultModel.count {
                // Si se agregan fotos, inicia el proceso de carga
                print("Adding photos. Starting Loading")
                startLoading()
            } else if capturedPhotos.count < resultModel.count {
                // Si se eliminan fotos, ajusta resultModel para que coincida con capturedPhotos
                print("Removing photos. Adjusting resultModel size")
                resultModel = Array(resultModel.prefix(capturedPhotos.count))
            }
        }
    }

    private func startLoading() {
        isLoading = true
        progress = 0.3
        //crea dependiendo de la cantidad
        resultModel = Array(
            repeating: EvaluadorVVModel(), count: capturedPhotos.count)

        Task {
            while progress < 1.0 {
                try await Task.sleep(nanoseconds: 500_000_000)  // Espera 0.5 segundos
                withAnimation(.linear(duration: 0.5)) {
                    progress += 0.1
                }
            }

            // Una vez que el progreso llega a 1.0, rellena el `resultModel`
            for (index, photo) in capturedPhotos.enumerated() {
                if index < resultModel.count {
                    switch index {
                    case 0:
                        resultModel[index].image = photo
                        resultModel[index].description =
                            "Se detectaron grietas en el material y desgaste por el sol."
                        resultModel[index].percentage = 0.67
                        resultModel[index].etiqueta = .materiales
                    case 1:
                        resultModel[index].image = photo
                        resultModel[index].description =
                            "Se detectó que el depósito es de cemento y contiene algas o moho, el agua puede no ser potable."
                        resultModel[index].percentage = 0.52
                        resultModel[index].etiqueta = .materiales
                    case 2:
                        resultModel[index].image = photo
                        resultModel[index].description =
                            "Se detectó cierto color en el agua que indica la posible presencia de microorganismos dañinos."
                        resultModel[index].percentage = 0.74
                        resultModel[index].etiqueta = .materiales
                    case 3:
                        resultModel[index].image = photo
                        resultModel[index].description =
                            "El sistema de filtrado parece estar parcialmente obstruido, reduciendo la calidad del agua."
                        resultModel[index].percentage = 0.85
                        resultModel[index].etiqueta = .materiales
                    default:
                        resultModel[index].image = photo
                        resultModel[index].description =
                            "Evaluación completada para la imagen."
                        resultModel[index].percentage = Double.random(
                            in: 0.5...1.0)
                        resultModel[index].etiqueta = .zona
                    }
                }
            }

            isLoading = false
        }
    }
}

// Extensión para redondear un valor Double a un número específico de decimales
extension Double {
    func asPercentageInt() -> Int {
        return Int((self * 100).rounded())
    }
}

struct ResultItemView: View {
    @Binding var model: EvaluadorVVModel
    @Binding var currentThemeColor: ColorVariant
    @State private var loadingProgress: Double = 0.0
    @State private var timer: Timer?

    var body: some View {
        HStack(alignment: .top, spacing: 30) {

            if let modelImg = model.image {
                Image(uiImage: modelImg)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(
                                Color(currentThemeColor.normal), lineWidth: 2)
                    )
            } else {
                Rectangle()
                    .fill(Color(currentThemeColor.normal))
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }

            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    if let modelPorcentage = model.percentage {
                        ProgresoComponent(
                            themeColor: $currentThemeColor,
                            fixedProgress: modelPorcentage,
                            maxWidth: 150,
                            maxHeight: 10,
                            activateDecorated: false
                        )

                        Text("\(modelPorcentage.asPercentageInt())%")
                            .font(
                                customFont(
                                    "Poppins", size: 13, weight: .regular)
                            )
                    } else {
                        ProgresoComponent(
                            themeColor: $currentThemeColor,
                            progress: $loadingProgress,
                            maxWidth: 150,
                            maxHeight: 10,
                            activateDecorated: false
                        )
                    }
                    // Convierte el valor de porcentaje de 0.0 a 1.0 a un valor de 0% a 100% con dos decimales

                    if let modelEtiqueta = model.etiqueta {
                        HStack {
                            Circle()
                                .fill(Color(modelEtiqueta.color.normal))
                                .frame(width: 30, height: 30)

                            Text(modelEtiqueta.descripcion)
                                .font(
                                    customFont(
                                        "Poppins", size: 16, weight: .medium)
                                )
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    } else {
                        HStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))  // Placeholder para el texto
                                .frame(width: 100, height: 20)  // Ajusta el ancho y alto según sea necesario
                                .clipShape(RoundedRectangle(cornerRadius: 3))  // Bordes redondeados opcionales
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }

                }
                if let modelDescription = model.description {
                    Text(modelDescription)
                        .font(
                            customFont("Poppins", size: 16, weight: .regular)
                        )
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))  // Placeholder para el texto
                        .frame(height: 20)  // Ajusta la altura según sea necesario
                        .clipShape(RoundedRectangle(cornerRadius: 3))  // Bordes redondeados opcionales
                        .padding(.vertical, 4)  // Opcional: espacio alrededor del placeholder
                }

            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .onAppear {
            startLoading()
        }
        .onChange(of: model) {
            if model.description != nil {
                stopLoading()
            }
        }
    }

    private func startLoading() {
        loadingProgress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {
            _ in
            if loadingProgress < 1.0 {
                loadingProgress += 0.01
            }

            // Detiene el temporizador si el modelo ya no es nil
            if let description = model.description {
                stopLoading()
            }

        }
    }

    private func stopLoading() {
        timer?.invalidate()
        timer = nil
    }
}

struct EvaluadorView_Previews: PreviewProvider {
    @State static var themeColor = ColorPaletteVV.agua
    @State static var navigationPath = NavigationPath()
    @State static var photos: [UIImage] = [
        UIImage(systemName: "house.fill")!,
        UIImage(systemName: "camera.fill")!,
    ]

    static var previews: some View {
        EvaluadorViewVV(
            currentThemeColor: $themeColor,
            path: $navigationPath,
            capturedPhotos: $photos,
            showPhotoPicker: .constant(false)
        )
        .previewLayout(.sizeThatFits)
    }
}
