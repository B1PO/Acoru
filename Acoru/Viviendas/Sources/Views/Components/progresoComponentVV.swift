import SwiftUI

struct ProgresoModel {
    let img: UIImage
    let title: String
    let fixedProgress: Double
}

struct ProgresoComponent: View {
    @Binding var themeColor: ColorVariant
    var progress: Binding<Double>?
    var fixedProgress: Double = 0.0
    @State var maxWidth: CGFloat = 300
    @State var maxHeight: CGFloat = 20

    // Array de progreso adicional y el índice actual para navegar
    var progresoModels: [ProgresoModel] = []
    @State private var currentModelIndex: Int = 0

    var onActionTriggered: ((ProgresoModel) -> Void)?  // Closure para manejar el evento
    var onActionLeftTriggered: (() -> Void)?
    var onActionRightTriggered: (() -> Void)?
    var activateDecorated: Bool = true
    var hiddenActions: Bool = false

    var body: some View {
        HStack {
            if activateDecorated && !hiddenActions {
                Button(action: {
                    withAnimation(.easeInOut) {
                        if !progresoModels.isEmpty {
                            currentModelIndex =
                                currentModelIndex > 0
                                ? currentModelIndex - 1
                                : progresoModels.count - 1
                        }
                    }
                    onActionLeftTriggered?()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 30, height: 30)
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
            ZStack(alignment: .leading) {
                // Fondo de la barra de progreso
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(themeColor.normal))
                    .frame(height: maxHeight + 2)

                // Progreso
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(themeColor.dark))
                    .frame(
                        width: CGFloat(currentProgress) * maxWidth,
                        height: maxHeight
                    )
                    .animation(
                        .easeInOut(duration: 0.5), value: currentProgress)

                if activateDecorated {
                    VStack {
                        Button(action: {
                            if(!hiddenActions){
                                onActionTriggered?(model)
                            }
                        }) {
                            // Muestra la imagen actual del progresoModel si está disponible
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Circle()
                                            .stroke(
                                                Color(themeColor.normal),
                                                lineWidth: 2)  // Borde de color de currentThemeColor
                                    )
                                if let currentImage = currentImage {
                                    Image(uiImage: currentImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .frame(maxWidth: maxWidth)

            if activateDecorated && !hiddenActions {
                Button(action: {
                    withAnimation(.easeInOut) {
                        if !progresoModels.isEmpty {
                            currentModelIndex =
                                currentModelIndex < progresoModels.count - 1
                                ? currentModelIndex + 1 : 0
                        }
                    }
                    onActionRightTriggered?()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 30, height: 30)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }

    // Computed property para manejar el progreso actual, usando el array si está disponible
    private var currentProgress: Double {
        if progresoModels.isEmpty {
            return progress?.wrappedValue ?? fixedProgress
        } else {
            return progresoModels[currentModelIndex].fixedProgress
        }
    }

    // Computed property para manejar la imagen actual del array progresoModels
    private var currentImage: UIImage? {
        if progresoModels.isEmpty {
            return nil
        } else {
            return progresoModels[currentModelIndex].img
        }
    }
    
    //mandar el title
    private var model: ProgresoModel {
        if progresoModels.isEmpty {
            return ProgresoModel(img: UIImage(systemName: "house.fill")!,title: "Titulo"
                                 ,fixedProgress: 0.2)
        } else {
            return progresoModels[currentModelIndex]
        }
    }
}

//struct ProgresoComponent_Previews: PreviewProvider {
//    @State static var themeColor = ColorPaletteVV.agua
//    @State static var progressValue = 0.1
//    static var progresoModelsSample = [
//        ProgresoModel(img: UIImage(systemName: "house.fill")!, fixedProgress: 0.2),
//        ProgresoModel(img: UIImage(systemName: "camera.fill")!, fixedProgress: 0.5),
//        ProgresoModel(img: UIImage(systemName: "flame.fill")!, fixedProgress: 0.8)
//    ]
//
//    static var previews: some View {
//        Group {
//            // Usando Binding
//            ProgresoComponent(
//                themeColor: $themeColor,
//                progress: $progressValue,
//                onActionTriggered: {},
//                onActionLeftTriggered: {},
//                onActionRightTriggered: {}
//            )
//            .previewDisplayName("Con Binding")
//
//            // Usando un valor fijo
//            ProgresoComponent(
//                themeColor: $themeColor,
//                fixedProgress: 0.7,
//                onActionTriggered: {},
//                onActionLeftTriggered: {},
//                onActionRightTriggered: {}
//            )
//            .previewDisplayName("Con Valor Fijo")
//
//            // Usando array de progresoModels
//            ProgresoComponent(
//                themeColor: $themeColor,
//                progresoModels: progresoModelsSample,
//                onActionTriggered: {},
//                onActionLeftTriggered: {},
//                onActionRightTriggered: {}
//            )
//            .previewDisplayName("Con ProgresoModel Array")
//        }
//    }
//}
