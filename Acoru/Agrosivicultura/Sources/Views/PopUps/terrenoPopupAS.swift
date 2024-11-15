import SwiftUI

struct terrenoPopupAS: View {
    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height
    
    @State private var navigateToTerrenoView = false
    @State private var showRightFrame = false // Estado para controlar la vista derecha
    var onClose: () -> Void
    
    var body: some View {
        ZStack {
            // El RoundedRectangle de "Terreno ACORU" siempre está visible
            RoundedRectangle(cornerRadius: 30.0)
                .fill(.white)
                .frame(width: UISW * 0.35, height: UISH * 0.15)
                .position(x: UISW * 0.125, y: UISH * 0.175)
                .overlay {
                    HStack {
                        Image("sectionIconAS")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, alignment: .leading)
                        Text("Terreno ACORU")
                            .font(.custom("Poppins", size: 25).bold())
                    }
                    .position(x: UISW * 0.15, y: UISH * 0.175)
                }
                .onTapGesture {
                    withAnimation {
                        showRightFrame.toggle()
                    }
                }
                .zIndex(2)
            
            if showRightFrame {
                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                    .frame(width: UISW * 0.5, height: UISH)
                                    .position(x: UISW * 0.75, y: UISH * 0.5)
                                    .zIndex(4)
                
                InfoPanelView()
                    .frame(width: UISW * 0.5, height: UISH)
                    .position(x: UISW * 0.75, y: UISH * 0.5)
                    .zIndex(4)
            }


            if navigateToTerrenoView {
                // Vista que simula el terreno digital
                DragAndDropView()
                    .ignoresSafeArea()
                    .background(Color.black.opacity(0.5)) // Fondo semitransparente
                    .transition(.opacity)
                    .zIndex(1) // Colocado detrás del rectángulo de "Terreno ACORU"

                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 15)
                    .position(x: UISW * 0.05, y: UISH * 0.05)
                    .onTapGesture {
                        onClose()
                    }
                    .zIndex(5) // Asegura que el botón de cierre esté en la parte superior
            } else {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                    .zIndex(3) // Color con opacidad sobre el fondo

                Image(systemName: "chevron.left")
                    .resizable()
                    .scaledToFit()
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 15)
                    .position(x: UISW * 0.05, y: UISH * 0.05)
                    .onTapGesture {
                        onClose()
                    }
                    .zIndex(4)

                // Cuerpo principal del popup
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.white)
                        .frame(width: UISW * 0.7, height: UISH * 0.5)
                    

                    Image("popupASTImage")
                        .resizable()
                        .cornerRadius(30)
                        .frame(width: UISW * 0.65, height: UISH * 0.225)
                        .position(x:UISW * 0.5, y: UISH * 0.4)
                    
                        Text("Bienvenido a tu terreno ACORU")
                        .font(.custom("Poppins", size: 25).bold())
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .position(x:UISW * 0.34, y: UISH * 0.55)


                        Text("Representa digitalmente espacios agricolas y gestionalos de manera inteligente con esta herramienta.")
                        .font(.custom("Poppins", size: 25))
                            .foregroundColor(.gray)
                            .frame(width: UISW * 0.65)
                            .position(x:UISW * 0.5, y: UISH * 0.635)

                    
                }
                .position(x: UISW * 0.5, y: UISH * 0.45)
                .zIndex(5) // Popup principal sobre el color de opacidad

                // Botón "Iniciar" para navegar a DragAndDropView
                Button(action: {
                    withAnimation {
                        navigateToTerrenoView = true
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                            .frame(width: 120, height: 60)
                        Text("Iniciar")
                            .font(.custom("Poppins", size: 25).bold())
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .position(x: UISW * 0.5, y: UISH * 0.7)
                .zIndex(6)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    terrenoPopupAS(onClose: {})
}
