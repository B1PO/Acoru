import SwiftUI

enum CartaCirclesPosition {
    case left
    case right
    case center
}

struct CartaCircles {
    var basePositions: [CartaCirclesPosition: CGPoint]
    var expandedPositions: [CartaCirclesPosition: CGPoint]
    var baseWidth: [CartaCirclesPosition: CGFloat]
    var expandedWidth: [CartaCirclesPosition: CGFloat]
}

func cardAlignment(_ position: CartaCirclesPosition) -> HorizontalAlignment {
    switch position {
    case .left:
        return .trailing
    case .right:
        return .leading
    case .center:
        return .center
    }
}

func cardAlignmentText(_ position: CartaCirclesPosition) -> TextAlignment {
    switch position {
    case .left:
        return .trailing
    case .right:
        return .leading
    case .center:
        return .center
    }
}



struct CartaComponentVV: View {
    var titulo: String  // Texto personalizado para la barra
    var descripcion: String // Texto para adentro de la carta
    
    // Creamos un Binding externo del color
    @Binding var themeColor: ColorVariant
    @State var onExpand: Bool = false
    @State var colorText = Color.black
    @State var cardPosition: CartaCirclesPosition
    var onActionTriggered: () -> Void // Closure para manejar el evento
    
    @State var circlesPositions: [CartaCircles] = [
        CartaCircles(
            basePositions: [
                .left: CGPoint(x: 200, y: 260),
                .center: CGPoint(x: 320, y: 180),
                .right: CGPoint(x: 320, y: 100)
            ],
            expandedPositions: [
                .left: CGPoint(x: 320, y: 240),
                .center: CGPoint(x: 320, y: 160),
                .right: CGPoint(x: 340, y: 100)
            ],
            baseWidth: [
                .left: 200,
                .right: 200,
                .center: 200
            ],
            expandedWidth: [
                .left: 200,
                .center: 200,
                .right: 200
            ]
        ),
        CartaCircles(
            basePositions: [
                .left: CGPoint(x: 50, y: 250),
                .center: CGPoint(x: 165, y: 260),
                .right: CGPoint(x: 270, y: 250)
            ],
            expandedPositions: [
                .left: CGPoint(x: 140, y: 340),
                .center: CGPoint(x: 170, y: 300),
                .right: CGPoint(x: 200, y: 340)
            ],
            baseWidth: [
                .left: 340,
                .right: 340,
                .center: 300
            ],
            expandedWidth: [
                .left: 450,
                .center: 400,
                .right: 500
            ]
        ),
        CartaCircles(
            basePositions: [
                .left: CGPoint(x: 290, y: 0),
                .center: CGPoint(x: 15, y: 220),
                .right: CGPoint(x: 15, y: 220)
            ],
            expandedPositions: [
                .left: CGPoint(x: 290, y: 0),
                .center: CGPoint(x: 30, y: 320),
                .right: CGPoint(x: 15, y: 320)
            ],
            baseWidth: [
                .left: 80,
                .right: 80,
                .center: 80
            ],
            expandedWidth: [
                .left: 160,
                .center: 100,
                .right: 100
            ]
        )
    ]
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Circle()
                .stroke(Color(themeColor.darkMedium), lineWidth: 40)
                .frame(
                    width: onExpand ? circlesPositions[0]
                        .expandedWidth[cardPosition]! : circlesPositions[0]
                        .baseWidth[cardPosition]!,
                    height: onExpand ? circlesPositions[0]
                        .expandedWidth[cardPosition]!  : circlesPositions[0]
                        .baseWidth[cardPosition]!
                )
                .position(
                    onExpand ? circlesPositions[0]
                        .expandedPositions[cardPosition]! : circlesPositions[0]
                        .basePositions[cardPosition]!
                )
            Circle()
                .fill(Color(themeColor.dark))
                .frame(
                    width: onExpand ? circlesPositions[1]
                        .expandedWidth[cardPosition]!: circlesPositions[1]
                        .baseWidth[cardPosition]!,
                    height: onExpand ? circlesPositions[1]
                        .expandedWidth[cardPosition]! : circlesPositions[1]
                        .baseWidth[cardPosition]!
                )
                .position(
                    onExpand ? circlesPositions[1]
                        .expandedPositions[cardPosition]! : circlesPositions[1]
                        .basePositions[cardPosition]!
                )
            Circle()
                .stroke(Color.white, lineWidth: 4)
                .frame(
                    width: onExpand ? circlesPositions[2]
                        .expandedWidth[cardPosition]! : circlesPositions[2]
                        .baseWidth[cardPosition]!,
                    height: onExpand ? circlesPositions[2]
                        .expandedWidth[cardPosition]! : circlesPositions[2]
                        .baseWidth[cardPosition]!
                )
                .position(
                    onExpand ? circlesPositions[2]
                        .expandedPositions[cardPosition]! : circlesPositions[2]
                        .basePositions[cardPosition]!
                )
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .padding(30)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                HStack() {
                    VStack(alignment: .leading, spacing: 20){
                        VStack(alignment: cardAlignment(cardPosition)){
                            Text(titulo)
                                .font(
                                    customFont(
                                        "Poppins",
                                        size: 26,
                                        weight: .bold
                                    )
                                )
                                .foregroundStyle(colorText)
                            
                            if(onExpand){
                                Text(descripcion)
                                    .font(
                                        customFont(
                                            "Poppins",
                                            size: 12,
                                            weight: .medium
                                        )
                                    )
                                    .foregroundStyle(Color.white)
                                    .multilineTextAlignment(
                                        cardAlignmentText(cardPosition)
                                    )
                            }
                        }
                        //boton que diga ver y que este outlined
                        if(onExpand){
                            VStack(){
                                Button(action: {
                                    onActionTriggered()
                                }) {
                                    HStack(spacing: 5) {
                                        Text("Iniciar")
                                            .font(
                                                customFont(
                                                    "Poppins",
                                                    size: 16,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundColor(
                                                Color.white
                                            )  // Color del texto
                                            .padding(.vertical,5)
                                        Image("Siguiente")
                                            .resizable()
                                            .frame(width:20, height:20)
                                    }
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 4)
                                .background(Color.white.opacity(0.3))
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 50
                                    )
                                )
                            }
                            .frame(
                                maxWidth: .infinity,
                                alignment: .trailing
                            )
                        }else{
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    onExpand.toggle()
                                    colorText = onExpand ? Color.white : Color.black
                                }
                            }) {
                                Text("Ver")
                                    .font(
                                        customFont(
                                            "Poppins",
                                            size: 18,
                                            weight: .medium
                                        )
                                    )
                                    .foregroundColor(
                                        Color(themeColor.normal)
                                    )  // Color del texto
                                    .padding(.horizontal,20)
                                    .padding(.vertical,4)
                            }
                            .background(Color.clear)  // Fondo transparente
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        Color(themeColor.normal),
                                        lineWidth: 2
                                    )  // Contorno verde
                            )
                        }
                    }
                    .padding(.vertical,20)
                    .padding(.horizontal,30)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: onExpand ? .infinity : 130,
                    alignment: .topLeading
                )
                .background(
                    onExpand ? Color.clear : Color.white
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // Mueve hacia arriba o abajo con la animación
        }
        .background(Color(themeColor.normal))
        .clipShape(
            RoundedRectangle(
                cornerRadius: 40,
                style: .continuous
            )
        )
        .onTapGesture {
            //animacion para abajo
            withAnimation(.easeInOut) {
                onExpand.toggle()
                colorText = onExpand ? Color.white : Color.black
            }
            
        }
        
    }
}


