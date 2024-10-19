//
//  viviendasView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

struct ViviendasViewVV: View {
    let icons = [
        Icon(
            id: 0,
            name: "Gota",
            themeColor: ColorPaletteVV.agua
        ),
        Icon(
            id: 1,
            name: "Trash",
            themeColor: ColorPaletteVV.residuos
        ),
        Icon(
            id: 2,
            name: "Electricidad",
            themeColor: ColorPaletteVV.electricidad
        )
    ]
    
    @State private var currentThemeColor: ColorVariant = ColorPaletteVV.agua
    @State private var path = NavigationPath() // Controlar la pila de navegación
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .top) {
                // Fondo degradado
                Rectangle()
                    .fill(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color:
                                                Color(currentThemeColor.normal)
                                              , location: 0.00),
                                Gradient
                                    .Stop(
                                        color: lighterColor(
                                            color:
                                                Color(
                                                    currentThemeColor.normal
                                                )
                                            ,
                                            percentage: 0.3
                                        ),
                                        location: 0.25
                                    )
                            ],
                            startPoint: UnitPoint(x: 0.5, y: 0),
                            endPoint: UnitPoint(x: 0.5, y: 1)
                        )
                    )
                    .foregroundColor(.clear)
                VStack(alignment: .leading, spacing: 40) {
                    // Flecha de regreso
                    HStack {
                        Button(
                            action: {
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                    .padding(.top, 20)
                            }
                    }
                    .padding(.horizontal,20)
                    // Título y subtítulo
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Viviendas Sostenibles")
                            .font(
                                customFont("Poppins", size: 34, weight: .bold)
                            )
                        //family
                            .foregroundColor(.black)
                        Text(
                            "Descubre cómo construir tu hogar ideal con nuestras herramientas"
                        )
                        .font(
                            customFont("Poppins", size: 14, weight: .medium)
                        )
                        //family
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal,60)
                    // Recuadro blanco con bordes redondeados
                    ZStack() {
                        Rectangle()
                            .fill(Color(red: 0.96, green: 0.97, blue: 0.99))
                            .cornerRadius(50, corners: [.topLeft, .topRight])
                            .shadow(radius: 10)
                        
                        VStack(
                            alignment: .leading,
                            spacing: 40
                        ){
                            HStack(alignment: .top){
                                VStack(alignment: .leading){
                                    HStack(spacing: 0){
                                        Text("Elige un ")
                                            .font(
                                                customFont(
                                                    "Poppins",
                                                    size: 14,
                                                    weight: .medium
                                                )
                                            )
                                            .foregroundColor(.black)
                                        Text("Servicio")
                                            .font(
                                                customFont(
                                                    "Poppins",
                                                    size: 14,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundColor(.black)
                                    }
                                    PickerComponent(icons: icons){ selectedId in
                                        // Aquí puedes manejar el icono seleccionado externamente
                                        //dependiendo
                                        switch(selectedId){
                                        case 0:
                                            currentThemeColor = ColorPaletteVV.agua
                                            break;
                                        case 1:
                                            currentThemeColor = ColorPaletteVV.residuos
                                            break;
                                        case 2:
                                            currentThemeColor = ColorPaletteVV.electricidad
                                            break;
                                        default :
                                            currentThemeColor = ColorPaletteVV.agua
                                        }
                                        
                                    }
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                                VStack(alignment: .trailing, spacing: 30){
                                    Text("Instalaciones hechas ")
                                        .font(
                                            customFont(
                                                "Poppins",
                                                size: 14,
                                                weight: .medium
                                            )
                                        )
                                        .foregroundColor(.black)
                                    ProgresoComponent(
                                        themeColor: $currentThemeColor
                                    )
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )
                                
                            }
                            HStack(
                                spacing: 40
                            ){
                                CartaComponentVV(
                                    titulo: "Evaluador",
                                    descripcion: "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                    themeColor: $currentThemeColor,
                                    cardPosition: .right,
                                    onActionTriggered: {}
                                )
                                
                                CartaComponentVV(
                                    titulo: "Simulador",
                                    descripcion: "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                    themeColor: $currentThemeColor,
                                    cardPosition: .center,
                                    onActionTriggered: {
                                    }
                                )
                                CartaComponentVV(
                                    titulo: "Instalación",
                                    descripcion: "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                    themeColor: $currentThemeColor,
                                    cardPosition: .left,
                                    onActionTriggered: {
                                        //console
                                        path.append("si")
                                    }
                                )
                                
                            }
                        }
                        .padding(.horizontal, 60)
                        .padding(.vertical, 50)
                        
                    }
                }
                //padding left y right
                .padding(.top, 10)
            }
            .ignoresSafeArea()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViviendasViewVV()
    }
}
