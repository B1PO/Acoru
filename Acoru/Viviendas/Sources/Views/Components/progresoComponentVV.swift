import SwiftUI


struct ProgresoModel {
    let img: UIImage
    let fixedProgress: Double
}

struct ProgresoComponent: View {
    @Binding var themeColor: ColorVariant
    var progress: Binding<Double>?
    var fixedProgress: Double = 0.0
    @State var maxWidth: CGFloat = 300
    @State var maxHeight: CGFloat = 20
    
    
    var onActionTriggered: (() -> Void )? // Closure para manejar el evento
    var onActionLeftTriggered: (() -> Void)?
    var onActionRightTriggered: (() -> Void)?
    var activateDecorated: Bool = true

    var body: some View {
        HStack {
            if activateDecorated {
                Button(action: {
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
                    .animation(.easeInOut(duration: 0.5), value: currentProgress)

                if activateDecorated {
                    VStack {
                        Button(action: {
                            onActionTriggered?()
                        }) {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 50, height: 50)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .frame(maxWidth: maxWidth)
            
            if activateDecorated {
                Button(action: {
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

    // Computed property para manejar el progreso actual
    private var currentProgress: Double {
        progress?.wrappedValue ?? fixedProgress
    }
}

struct ProgresoComponent_Previews: PreviewProvider {
    @State static var themeColor = ColorPaletteVV.agua
    @State static var progressValue = 0.1

    static var previews: some View {
        Group {
            // Usando Binding
            ProgresoComponent(
                themeColor: $themeColor,
                progress: $progressValue,
                onActionTriggered: {},
                onActionLeftTriggered: {},
                onActionRightTriggered: {}
            )
            .previewDisplayName("Con Binding")

            // Usando un valor fijo
            ProgresoComponent(
                themeColor: $themeColor,
                fixedProgress: 0.7,
                onActionTriggered: {},
                onActionLeftTriggered: {},
                onActionRightTriggered: {}
            )
            .previewDisplayName("Con Valor Fijo")
        }
    }
}

