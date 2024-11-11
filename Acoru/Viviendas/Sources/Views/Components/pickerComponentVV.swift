//
//  pickerComponentVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 17/10/24.
//

import SwiftUI

// Modelo para representar un ícono con su id y nombre
struct Icon: Identifiable {
    let id: Int
    let name: String
    let themeColor: ColorVariant
}

// Componente Picker dinámico horizontal
struct PickerComponent: View {

    // Propiedades
    @State private var selectedIconId: Int  // ID del icono seleccionado
    @State private var hStackColor: UIColor
    @State private var backgroundOffset: CGFloat = 8  // Posición del fondo
    let icons: [Icon]  // Lista de iconos
    let onIconSelected:
        (
            Int
        ) -> Void  // Callback que se ejecuta cuando se selecciona un icono
    @Binding var isExpanded: Bool
    // Inicializador del componente, recibiendo la lista de iconos y el callback
    @State private var maxWidth: CGFloat = 230
    
    init(
        icons: [Icon],
        selectedIconId: Int = 0,
        isExpanded: Binding<Bool>,  // Cambiado a `Binding<Bool>`
        onIconSelected: @escaping (Int) -> Void
    ) {
        self.icons = icons
        _selectedIconId = State(initialValue: selectedIconId)
        _hStackColor = State(
            initialValue:
                icons
                .first(
                    where: {
                        $0.id == selectedIconId
                    })?.themeColor.normal ?? UIColor.gray
        )
        self._isExpanded = isExpanded  // Asigna el Binding al nuevo atributo
        self.onIconSelected = onIconSelected

    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(
                alignment: .leading
            ) {
                HStack(
                    spacing: 10
                ) {  // Contenedor horizontal con espacio entre íconos
                    ForEach(
                        icons.filter { !isExpanded || $0.id == selectedIconId }
                    ) { icon in
                        GeometryReader { buttonGeometry in
                            Button(
                                action: {
                                    withAnimation(
                                        .easeInOut(duration: 0.7)
                                    ) {
                                        selectedIconId = icon.id
                                        onIconSelected(icon.id)
                                        // Cambiamos la posición del fondo según el botón seleccionado
                                        // Calcular la nueva posición del fondo en función de la posición del botón
                                        backgroundOffset =
                                            buttonGeometry
                                            .frame(
                                                in: .global
                                            ).minX
                                            - geometry
                                            .frame(in: .global).minX
                                    }
                                    //imprimir el backgroundoffset
                                    
                                    
                                    // Segunda animación: cambiar el fondo del HStack después de la animación de los botones
                                    DispatchQueue.main
                                        .asyncAfter(
                                            deadline: .now() + 0.2
                                        ) {
                                            withAnimation(
                                                .easeInOut(
                                                    duration: 0.3
                                                )
                                            ) {
                                                hStackColor =
                                                    icon.themeColor.normal
                                            }
                                        }
                                }) {
                                    // Contenido del botón
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 32, height: 32)
                                        .opacity(
                                            selectedIconId == icon.id ? 1 : 0.8
                                        )
                                }

                                .buttonStyle(
                                    PlainButtonStyle()
                                )  // Evitar que el botón cambie de estilo por defecto
                                .frame(
                                    width: 64,
                                    height: 64
                                )  // Botón de 64x64
                                .background(Color.clear)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 18)
                                )
                                .position(
                                    x: buttonGeometry.size.width / 2,
                                    y: buttonGeometry.size.height / 2
                                )
                        }
                        .frame(
                            width: 64,
                            height: 64
                        )  // Asegura que GeometryReader no ocupe más espacio
                    }
                }
                .padding(.vertical, 8)
                .padding(.leading, 8)
                .padding(.trailing, isExpanded ? 10 : 8)
                .background(Color(hStackColor))
                .clipShape(RoundedRectangle(cornerRadius: 18))
                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(
                        width: 64,
                        height: 64
                    )  // Ajustar tamaño al de los botones
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18,
                            style: .continuous
                        )
                    )
                    .offset(x: backgroundOffset, y: 0)
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: backgroundOffset
                    )
            }
        }
        .frame(maxWidth: maxWidth, maxHeight: 80)
        .onChange(of: isExpanded) {
            if isExpanded {
                // Si `isExpanded` cambia a `true`, establecemos `backgroundOffset` en `8`
                backgroundOffset = 8
                maxWidth = 81
            }else {
                maxWidth = 230
                switch selectedIconId {
                    case 0:
                    backgroundOffset = 8
                    case 1:
                    backgroundOffset = 82
                case 2:
                    backgroundOffset = 156
                default:
                    backgroundOffset = 8
                }
             
            }
        }
    }
}
