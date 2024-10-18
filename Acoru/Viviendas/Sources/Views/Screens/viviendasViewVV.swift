//
//  viviendasView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

struct viviendasViewVV: View {
    let icons = [
        Icon(
            id: 0,
            name: "Gota",
            themeColor: UIColor(red: 0.63, green: 0.84, blue: 0.61, alpha: 1.00)
        ),
        Icon(
            id: 1,
            name: "Trash",
            themeColor: UIColor(red: 0.18, green: 0.65, blue: 0.87, alpha: 1.00)
        ),
        Icon(
            id: 2,
            name: "Electricidad",
            themeColor: UIColor(red: 0.99, green: 0.76, blue: 0.35, alpha: 1.00)
        )
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            // Fondo degradado
            Rectangle()
                .foregroundColor(.clear)
                .background(
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(
                                stops: [
                                    Gradient
                                        .Stop(
                                            color: Color(
                                                red: 0.42,
                                                green: 0.8,
                                                blue: 1
                                            ),
                                            location: 0.00
                                        ),
                                    Gradient
                                        .Stop(
                                            color: Color(
                                                red: 0.76,
                                                green: 0.91,
                                                blue: 1
                                            ),
                                            location: 0.25
                                        ),
                                ],
                                startPoint: UnitPoint(x: 0.5, y: 0),
                                endPoint: UnitPoint(x: 0.5, y: 1)
                            )
                        )
                )
            VStack(alignment: .leading, spacing: 40) {
                // Flecha de regreso
                HStack {
                    Button(
                        action: {
                            print(
                                "Regresar presionado"
                            )  // Acción del botón (ej. navegación)
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
                        .font(customFont("Poppins", size: 34, weight: .bold))
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
                        .fill(Color.white)
                        .cornerRadius(50, corners: [.topLeft, .topRight])
                        .shadow(radius: 10)
                    
                    VStack(){
                        HStack(){
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
                                    print(
                                        "Icono seleccionado con ID: \(selectedId)"
                                    )
                                }
                            }
                            VStack(){
                                
                            }
                        }
                        HStack(){
                            cartaComponentVV(
                                titulo: "Evaluador",
                                descripcion: "Revisa la compatibilidad de tu casa con la ecotecnología."
                            )
                            cartaComponentVV(
                                titulo: "Evaluador",
                                descripcion: "Revisa la compatibilidad de tu casa con la ecotecnología."
                            )
                            cartaComponentVV(
                                titulo: "Evaluador",
                                descripcion: "Revisa la compatibilidad de tu casa con la ecotecnología."
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
        .navigationTitle("Viviendas")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        viviendasViewVV()
    }
}
