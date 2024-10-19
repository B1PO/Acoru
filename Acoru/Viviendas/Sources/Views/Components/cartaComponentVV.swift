import SwiftUI

enum CartaDirection {
    case left
    case right
    case center
}


struct CartaComponentVV: View {
    var titulo: String  // Texto personalizado para la barra
    var descripcion: String // Texto para adentro de la carta
    
    // Creamos un Binding externo del color
    @Binding var themeColor: ColorVariant
    @State var onExpand: Bool = false
    @State var colorText = Color.black
    @State var cartaDirection: CartaDirection;
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Circle()
                .fill(Color(themeColor.darkMedium))
                .frame(width: 340, height: 340)
                .position(x: 270, y: 250)
            Circle()
                .fill(Color(themeColor.dark))
                .frame(width: 340, height: 340)
                .position(x: 270, y: 250)
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
                        Text(titulo)
                            .font(customFont("Poppins", size: 26, weight: .bold))
                            .foregroundStyle(colorText)
                        if(onExpand){
                            Text(descripcion)
                                .font(
                                    customFont("Poppins", size: 12, weight: .medium)
                                )
                                .foregroundStyle(Color.white)
                                .fixedSize(horizontal: false, vertical: true)
                                
                        }
                        //boton que diga ver y que este outlined
                        if(onExpand){
                            VStack(){
                                Button(action: {}) {
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


