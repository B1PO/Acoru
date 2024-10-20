//
//  instaladorView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//
import SwiftUI

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
    let imagen: Color
    let pasos: [InstalacionesPasos] = []
}


struct InstaladorView: View{
    @Binding var path: NavigationPath // Pila de navegación
    @Binding var themeColor: ColorVariant
    @State private var openInstalaciones: Bool = false
    @State private var openTutorial: Bool = false
    
    @State var instalaciones: [Instalaciones] = [
        Instalaciones(
            id: 1,
            nombre: "Instalacion 1",
            descripcion: "Descripcion instalacion 1",
            imagen: .red
        ),
        Instalaciones(
            id: 2,
            nombre: "Instalacion 2",
            descripcion: "Descripcion instalacion 2",
            imagen: .blue
        ),
        Instalaciones(
            id: 3,
            nombre: "Instalacion 3",
            descripcion: "Descripcion instalacion 3",
            imagen: .green
        ),
    ]
    
    @State var instalacionesEnCurso: [Instalaciones] = [
    ]
    
    
    @State var instalacionesAux: [Instalaciones] = [
    ]
    
    
    @State var instalacionIndex = 0
    
    private func findInstalacionInProgress(id: Int) -> Bool {
        instalacionesEnCurso.first(where: { $0.id == id }) != nil
    }
    
    private func nextLeft() {
        if(instalacionIndex > 0){
            instalacionIndex -= 1
        }else{
            instalacionIndex = instalacionesAux.count - 1
        }
        
        scrollProxy?.scrollTo(instalacionIndex, anchor: .top)
        
    }
    
    private func nextRight() {
        if(instalacionIndex < instalacionesAux.count - 1){
            instalacionIndex += 1
        }else{
            instalacionIndex = 0
        }
        scrollProxy?.scrollTo(instalacionIndex, anchor: .top)
    }
    
    @State private var scrollProxy: ScrollViewProxy? = nil
    
    
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
                    ZStack{
                        Text(
                            instalacionesAux.isEmpty ? "Instalaciones" : instalacionesAux[instalacionIndex].nombre
                        )
                        .font(
                            customFont(
                                "Poppins",
                                size: 32,
                                weight: .bold
                            )
                        )
                        .foregroundColor(.black)
                        
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
                                
                    
                            if(
                                !instalacionesEnCurso.isEmpty && !openInstalaciones
                            ){
                                Button(
                                    action: {
                                        withAnimation(
                                            .bouncy(extraBounce: 0.2)
                                        ){
                                            openInstalaciones.toggle()
                                        }
                                    }) {
                                        HStack(spacing: 30){
                                            Image(systemName: "chevron.left")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(
                                                    Color(themeColor.dark)
                                                )
                                                .clipShape(Circle())
                                            Text("Instalaciones")
                                                .font(
                                                    customFont(
                                                        "Poppins",
                                                        size: 24,
                                                        weight: .medium
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
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment:.trailing
                                    )
                            }
                        }
                        .padding(.horizontal,20)
                    }
                    
                    VStack(){
                        ZStack{
                            ScrollViewReader { proxy in
                                ScrollView(
                                    .horizontal,
                                    showsIndicators: false
                                ) {
                                    HStack(spacing: 0) {
                                        ForEach(
                                            0..<instalacionesAux.count,
                                            id: \.self
                                        ) { index in
                                            Circle()
                                                .fill(
                                                    instalacionesAux.isEmpty ? Color.gray : instalacionesAux[index].imagen
                                                )
                                                .padding(.vertical, 10)
                                                .shadow(radius: 5, x: 5, y: 5)
                                                .frame(
                                                    width: UIScreen.main.bounds.width
                                                )
                                                .scrollTransition {
                                                    content,
                                                    phase in
                                                    content
                                                        .opacity(
                                                            phase.isIdentity ? 1 : 0.5
                                                        ) // Animación de opacidad
                                                        .scaleEffect(
                                                            phase.isIdentity ? 1 : 0.4
                                                        ) // Animación de escala
                                                }
                                        }
                                    }
                                    .scrollTargetLayout() // Alinear el contenido con la vista

                                }
                                .scrollTargetBehavior(.viewAligned)
                                .frame(maxWidth: .infinity)
                                .onAppear {
                                    scrollProxy = proxy // Guardamos la referencia del proxy cuando aparezca
                                }
                            }
                            HStack(spacing: 400){
                                if(instalacionesEnCurso.isEmpty){
                                    HStack{
                                        Button(
                                            action: {
                                                withAnimation(.easeInOut){
                                                    nextLeft()
                                                }
                                            }) {
                                                Image(
                                                    systemName: "chevron.left"
                                                )
                                                .font(
                                                    .system(
                                                        size: 52,
                                                        weight: .bold
                                                    )
                                                )
                                                .foregroundColor(
                                                    Color(themeColor.normal)
                                                )
                                                .padding(20)
                                                .clipShape(Circle())
                                            }
                                            
                                    }
                                    .frame(maxWidth: .infinity)
                                        
                                }
                                
                                if (instalacionesEnCurso.isEmpty) {
                                    HStack{
                                        Button(
                                            action: {
                                                withAnimation(.easeInOut){
                                                    nextRight()
                                                }
                                            }) {
                                                Image(
                                                    systemName: "chevron.right"
                                                )
                                                .font(
                                                    .system(
                                                        size: 52,
                                                        weight: .bold
                                                    )
                                                )
                                                .foregroundColor(
                                                    Color(themeColor.normal)
                                                )
                                                .padding(20)
                                                .clipShape(Circle())
                                            }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        
                            
                        if !instalacionesEnCurso.isEmpty {
                            ProgresoComponent(
                                themeColor: $themeColor,
                                progress: 0.5,
                                maxWidth: 500,
                                onActionTriggered: {
                                    
                                },
                                onActionLeftTriggered: {
                                    nextLeft()
                                },
                                onActionRightTriggered: {
                                    nextRight()
                                }
                            )
                        }
                    }
                    VStack(spacing: 10){
                        Button(
                            action: {
                            }) {
                                Text(
                                    instalacionesEnCurso.isEmpty ?"Empezar instalacion" : "Continuar instalando?"
                                )
                                .font(
                                    customFont(
                                        "Poppins",
                                        size: 20,
                                        weight: .bold
                                    )
                                )
                                .foregroundColor(.black)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 20)
                                .background(Color(themeColor.normal))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 15)
                                )
                            }
                        if !openTutorial {
                            Text(
                                instalacionesAux.isEmpty ? "Cargando.." : instalacionesAux[instalacionIndex].descripcion
                            )
                            .font(
                                customFont(
                                    "Poppins",
                                    size: 20,
                                    weight: .medium
                                )
                            )
                            .foregroundColor(.black)
                        }
                    }
                    .padding(.top, 20)
                }
                .frame(maxHeight: .infinity)
                .padding(.vertical, 40)
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
                                InstalacionCard(
                                    themeColor: $themeColor,
                                    instalacion: instalacion,
                                    onActionTriggered: { instalacion in

                                        if(
                                            !findInstalacionInProgress(
                                                id: instalacion.id
                                            )
                                        ){
                                            instalacionesEnCurso
                                                .append(instalacion)
                                        }
                                        
                                        let index = instalacionesAux.firstIndex(
                                            where: { $0.id == instalacion.id
                                            })!
                                        
                                        instalacionIndex = index
                                    
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
        .onAppear{
            
            
            if(instalacionesEnCurso.isEmpty){
                instalacionesAux = instalaciones
            }else{
                instalacionesAux = instalacionesEnCurso
            }
        }
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
