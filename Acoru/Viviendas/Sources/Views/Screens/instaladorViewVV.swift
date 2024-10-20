//
//  instaladorView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

struct InstalacionesPasos {
    let id: Int
    let nombre: String
    let descripcion: String
    let imagen: String
    let completado: Bool
}

struct Instalaciones{
    let id: Int
    let nombre: String
    let descripcion: String
    let imagen: String
    let pasos: [InstalacionesPasos] = []
}

import SwiftUI

struct InstaladorView: View{
    @Binding var path: NavigationPath // Pila de navegación
    @Binding var themeColor: ColorVariant
    @State private var openInstalaciones: Bool = true
    
    @State var instalaciones: [Instalaciones] = [
        Instalaciones(
            id: 1,
            nombre: "Instalacion 1",
            descripcion: "Descripcion instalacion 1",
            imagen: ""
        ),
        Instalaciones(
            id: 2,
            nombre: "Instalacion 1",
            descripcion: "Descripcion instalacion 1",
            imagen: ""
        ),
        Instalaciones(
            id: 3,
            nombre: "Instalacion 1",
            descripcion: "Descripcion instalacion 1",
            imagen: ""
        ),
    ]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color:
                                            Color(themeColor.normal)
                                          , location: 0.00),
                            Gradient
                                .Stop(
                                    color: lighterColor(
                                        color:
                                            Color(
                                                themeColor.normal
                                            )
                                        ,
                                        percentage: 0.5
                                    ),
                                    location: 0.25
                                )
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .foregroundColor(.clear)
            HStack{
                VStack{
                    HStack{
                        Button(
                            action: {
                                path.removeLast()
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(themeColor.dark))
                                    .clipShape(Circle())
                            }
                            .frame(maxWidth: .infinity, alignment:.leading)
                        Text("1/9")
                            .font(
                                customFont(
                                    "Poppins",
                                    size: 32,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(.black)
                            .padding(.leading, openInstalaciones ? -220 : 0)
                            .frame(maxWidth: .infinity)
                        if(!openInstalaciones){
                            Button(
                                action: {
                                    withAnimation(.bouncy(extraBounce: 0.2)){
                                        openInstalaciones.toggle()
                                    }
                                }) {
                                    HStack(spacing: 30){
                                        Image(systemName: "chevron.left")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color(themeColor.dark))
                                            .clipShape(Circle())
                                        Text("Instalaciones")
                                            .font(
                                                customFont(
                                                    "Poppins",
                                                    size: 24,
                                                    weight: .bold
                                                )
                                            )
                                            .foregroundColor(.black)
                                    }
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 20)
                                    .background(Color(themeColor.normal))
                                    .clipShape(
                                        RoundedRectangle(cornerRadius:20)
                                    )
                                }
                                .frame(maxWidth: .infinity, alignment:.trailing)
                        }
                    }
                    .padding(.horizontal,20)
                    
                    VStack(spacing: 10){
                        Circle()
                            .fill(Color(themeColor.dark))
                            .frame(width: .infinity)
                        ProgresoComponent(
                            themeColor: $themeColor,
                            progress: 0.5,
                            maxWidth: 500
                        )
                    }
                    VStack(spacing: 10){
                        Button(
                            action: {
                            }) {
                                Text("Continuar instalando?")
                                    .font(
                                        customFont(
                                            "Poppins",
                                            size: 20,
                                            weight: .bold
                                        )
                                    )
                                    .foregroundColor(.black)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color(themeColor.normal))
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 15)
                                    )
                            }
                        Text("Mantenimiento del terreno")
                            .font(
                                customFont(
                                    "Poppins",
                                    size: 20,
                                    weight: .medium
                                )
                            )
                            .foregroundColor(.black)
                    }
                    .padding(.top, 20)
                }
                .frame(maxHeight: .infinity)
                .padding(.vertical, 20)
                if (openInstalaciones) {
                    VStack(){
                        Button(
                            action: {
                                //animacion de escalera
                                withAnimation(.easeOut){
                                    //quitar una por una instalacioncard
                                    openInstalaciones.toggle()
                                }
                                
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color(themeColor.dark))
                                    .clipShape(Circle())
                            }
                            .position(x: -195, y: 30)
                            .frame(width: 0, height: 0)
                        Text("Instalaciones para mejorar el hogar")
                            .font(
                                customFont(
                                    "Poppins",
                                    size: 26,
                                    weight: .bold
                                )
                            )
                            .foregroundColor(
                                Color.black
                            )  // Color del texto
                            .multilineTextAlignment(.center)
                            .padding(.top, 100)
                        Rectangle()
                            .fill(Color(themeColor.dark))
                            .frame(maxHeight: 10)
                            .padding(.bottom, 40)
                        //for each con instalaciones
                        ScrollView{
                            ForEach(instalaciones, id: \.id) { instalacion in
                                InstalacionCard(themeColor: $themeColor, instalacion: instalacion,
                                                onActionTriggered: { instalacion in
                                    withAnimation(.easeOut){
                                        //quitar una por una instalacioncard
                                        openInstalaciones.toggle()
                                    }
                                })
                                .padding(.bottom, 10)
                            }
                        }
                        
                    }
                    .frame(maxWidth: 330,maxHeight: .infinity, alignment: .top)
                    .padding(30)
                    .background(Color.white)
                    .border(Color(themeColor.normal).opacity(0.5), width: 1)
                }
            }
            
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

struct Instalador_Previews: PreviewProvider {
    static var previews: some View {
        InstaladorView(path: .constant(
            NavigationPath()
            //convertir a binding esto ColorPaletteVV.agua
        ), themeColor: .constant(ColorPaletteVV.residuos))
    }
}
