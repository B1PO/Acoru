//
//  InstalacionStep.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 10/11/24.
//

import SwiftUI

let icons = [
    Icon(id: 0, name: "Gota", themeColor: ColorPaletteVV.residuos),
    Icon(id: 1, name: "Trash", themeColor: ColorPaletteVV.agua),
    Icon(
        id: 2, name: "Electricidad", themeColor: ColorPaletteVV.electricidad
    ),
]

struct Material {
    var icon: String  // Nombre del ícono en los assets o SF Symbol
    var description: String
}

// Estructura para representar una instalación con su nombre y materiales asociados
struct Instalacion {
    var name: String
    var materials: [Material]  // Lista de materiales que componen la instalación
}

// Ejemplo de datos para las instalaciones

let instalaciones = [
    Instalacion(
        name: "Captación de Agua",
        materials: [
            Material(
                icon: "pipe.and.drop",
                description: "Canaletas de PVC o metal (para dirigir el agua)"),
            Material(
                icon: "mesh.fill",
                description:
                    "Filtro de malla gruesa (para evitar el paso de hojas y residuos grandes)"
            ),
            Material(
                icon: "tank",
                description:
                    "Contenedor de plástico o cisterna (para almacenar el agua)"
            ),
            Material(icon: "pipe", description: "Tubos de PVC para conducción"),
            Material(
                icon: "cover",
                description: "Tapa para evitar la entrada de contaminantes"),
        ]
    ),
    Instalacion(
        name: "Filtro de Agua",
        materials: [
            Material(
                icon: "sand",
                description: "Arena fina y grava (para filtrar el agua)"),
            Material(
                icon: "carbon",
                description:
                    "Carbón activado (para eliminar impurezas y mejorar el sabor)"
            ),
            Material(
                icon: "container",
                description:
                    "Contenedor plástico con salida inferior (para sostener las capas de filtro)"
            ),
            Material(
                icon: "fine.mesh",
                description:
                    "Mallas finas (para mantener el filtro en su lugar)"),
            Material(icon: "faucet", description: "Grifo o válvula de salida"),
        ]
    ),
    Instalacion(
        name: "Riego de Agua",
        materials: [
            Material(
                icon: "pipe.branch",
                description:
                    "Tubos de PVC o mangueras perforadas (para distribución)"),
            Material(
                icon: "pipe.connector",
                description:
                    "Conexiones en T y codos de PVC (para formar ramificaciones)"
            ),
            Material(
                icon: "pump",
                description:
                    "Contenedor elevado o bomba manual (para crear presión)"),
            Material(
                icon: "tape", description: "Cinta selladora (para evitar fugas)"
            ),
        ]
    ),
    Instalacion(
        name: "Tanques de Agua",
        materials: [
            Material(
                icon: "tank",
                description: "Tanque de plástico o concreto con tapa"),
            Material(
                icon: "filter.mesh",
                description:
                    "Malla o colador de tela (para filtrar el agua al entrar)"),
            Material(
                icon: "pipe",
                description: "Tubos de PVC para llenar y extraer agua"),
            Material(
                icon: "support",
                description:
                    "Soporte o estructura (si el tanque necesita estar elevado)"
            ),
        ]
    ),
]

func getIcon(for title: String) -> UIImage {
    switch title {
    case "Captación de agua":
        return UIImage(named: "captacion_agua") ?? UIImage()
    case "Filtro de agua":
        return UIImage(named: "filtros_agua") ?? UIImage()
    case "Instalacion de riego":
        return UIImage(named: "riego_agua") ?? UIImage()
    case "Tanque de agua":
        return UIImage(named: "tanques_agua") ?? UIImage()
    default:
        return UIImage(systemName: "questionmark") ?? UIImage() // Icono de fallback
    }
}

var progresoModelsSample = [
    ProgresoModel(
        img: UIImage(named: "captacion_agua")!, title: "Captación de agua",
        fixedProgress: 0.3),
    ProgresoModel(
        img: UIImage(named: "filtros_agua")!, title: "Filtro de agua",
        fixedProgress: 0.5),
    ProgresoModel(
        img: UIImage(named: "riego_agua")!,
        title: "Instalacion de riego",
        fixedProgress: 0.8),
    ProgresoModel(
        img: UIImage(named: "tanques_agua")!,
        title: "Tanque de agua", fixedProgress: 0.3
    ),
]

struct InstalacionStep: View {
    var id: String
    var id_type: Int
    var callback: (() -> Void)
    @Binding var path: NavigationPath
    @Binding var currentThemeColor: ColorVariant
    @State var progresoModel = ProgresoModel(
        img: getIcon(for: "Captación de agua"),
        title: "Captación de agua",
        fixedProgress: 0.3
    )

    // Filtrar los íconos basados en id_type
    var filteredIcons: [Icon] {
        return icons.filter { $0.id == id_type }
    }

    // Obtener los materiales de la instalación actual
    var currentMaterials: [Material] {
        instalaciones.first { $0.name == id }?.materials ?? []
    }

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(
                    0,
                    corners: [.topLeft, .topRight]
                )
            HStack{
                VStack(
                    alignment: .leading, spacing: 40
                ) {
                    HStack {
                        Button(action: {
                            callback()
                            path.removeLast()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .padding(.top, 20)
                        }
                    }
                    .padding(.horizontal, -40)
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            // Picker para seleccionar el ícono
                            HStack(alignment: .center, spacing: 20) {
                                PickerComponent(
                                    icons: filteredIcons,
                                    isExpanded: .constant(true),
                                    onIconSelected: { selectedId in
                                        print("Seleccionado: \(selectedId)")
                                        // Maneja la selección si es necesario
                                    }
                                )
                                .frame(width: 90)
                                VStack(alignment: .leading) {
                                    Text("Instalación: \(id)")
                                        .font(
                                            customFont(
                                                "Poppins", size: 24,
                                                weight: .bold)
                                        )
                                        .foregroundColor(.black)
                                }
                                .transition(.move(edge: .leading))

                            }

                            VStack {
                                Text("Materiales")
                                    .font(
                                        customFont(
                                            "Poppins", size: 24,
                                            weight: .regular)
                                    )
                                    .foregroundColor(.black)
                                    .padding(.top, 40)
                                ScrollView {
                                    VStack(spacing: 20) {
                                        ForEach(currentMaterials, id: \.description)
                                        { material in
                                            HStack(spacing: 20) {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color.gray.opacity(0.3))
                                                    .frame(width: 80, height: 80)

                                                Text(material.description)
                                                    .font(.subheadline)
                                                    .foregroundColor(.black)
                                            }
                                            .frame(
                                                maxWidth: .infinity, maxHeight: 120, alignment: .leading
                                            )
                                            .padding(.horizontal,20)
                                            .background(Color.white)
                                            .clipShape(
                                                RoundedRectangle(cornerRadius: 10)
                                            )
                                        }
                                    }
                                    .padding(.horizontal, 30)
                                    .frame(height: 700)
                                }
                               
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color(ColorPaletteVV.gris.normal))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 10)
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        
                    }
                }
                .padding(.leading, 60)
                .padding(.trailing, 40)
                .padding(.bottom, 50)
                .padding(.top, 10)
                
                VStack {
                    ProgresoComponent(
                        themeColor: $currentThemeColor,
                        maxWidth: .init(450),
                        progresoModels: [
                            progresoModel
                        ],
                        onActionTriggered: {
                            model in
                        },
                        onActionLeftTriggered: {},
                        onActionRightTriggered: {},
                        hiddenActions: true
                    )
                    
                    Text("Paso 1: Revisión de materiales")
                        .font(
                            customFont(
                                "Poppins", size: 26,
                                weight: .regular)
                        )
                        .foregroundColor(.black)
                        .padding(.top,60)
                    
                    Circle()
                        .fill(Color(ColorPaletteVV.residuos.normal))
                        .frame(width: 280, height: 280)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    Button(action: {
                        // Cambia el estado para presentar la vista de InsideSimuladorVV
                    }) {
                        HStack {
                            Text("Siguiente")
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(currentThemeColor.normal))
                        .cornerRadius(25)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .padding(.vertical, 40)
                .background(Color(ColorPaletteVV.gris.normal))
            }
            
        }

        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)
    }
}

struct InstalacionStep_Previews: PreviewProvider {
    @State static var path = NavigationPath()
    @State static var currentThemeColor = ColorPaletteVV.residuos

    static var previews: some View {
        InstalacionStep(
            id: "Captación de Agua",
            id_type: 0,
            callback: {
                print("Botón de regreso presionado")
            },
            path: $path,
            currentThemeColor: $currentThemeColor
        )
    }
}
