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
    let themeColor: UIColor
}

// Componente Picker dinámico horizontal
struct HorizontalIconPickerView: View {
    
    // Propiedades
    @State private var selectedIconId: Int // ID del icono seleccionado
    @State private var hStackColor: UIColor
    @State private var backgroundOffset: CGFloat = 16 // Posición del fondo
    let icons: [Icon] // Lista de iconos
    let onIconSelected: (
        Int
    ) -> Void // Callback que se ejecuta cuando se selecciona un icono

    // Inicializador del componente, recibiendo la lista de iconos y el callback
    init(
        icons: [Icon],
        selectedIconId: Int = 0,
        onIconSelected: @escaping (Int) -> Void
    ) {
        self.icons = icons
        _selectedIconId = State(initialValue: selectedIconId)
        _hStackColor = State(
            initialValue: icons
                .first(
                    where: { $0.id == selectedIconId
                    })?.themeColor ?? UIColor.gray
        )
        self.onIconSelected = onIconSelected
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(
                alignment: .leading
            ) {
                HStack(
                    spacing: 10
                ) { // Contenedor horizontal con espacio entre íconos
                    ForEach(icons) { icon in
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
                                        backgroundOffset = buttonGeometry
                                            .frame(
                                                in: .global
                                            ).minX - geometry
                                            .frame(in: .global).minX
                                    }
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
                                                hStackColor = icon.themeColor
                                            }
                                        }
                                }) {
                                    // Contenido del botón
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .opacity(
                                            selectedIconId == icon.id ? 1 : 0.4
                                        )
                                }
                                    
                                .buttonStyle(
                                    PlainButtonStyle()
                                ) // Evitar que el botón cambie de estilo por defecto
                                .frame(
                                    width: 70,
                                    height: 70
                                ) // Botón de 64x64
                                .background(Color.clear)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 18)
                                )
                                .position(
                                    x: buttonGeometry.size.width / 2,
                                    y: buttonGeometry.size.height / 2
                                ) // Alineación centrada
                        }
                        .frame(
                            width: 70,
                            height: 70
                        ) // Asegura que GeometryReader no ocupe más espacio
                    }
                }
                .padding()
                .background(Color(hStackColor))
                .clipShape(RoundedRectangle(cornerRadius: 18))

                Rectangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(
                        width: 70,
                        height: 70
                    ) // Ajustar tamaño al de los botones
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18,
                            style: .continuous
                        )
                    )
                    .offset(x: backgroundOffset) // Desplazamos el fondo
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: backgroundOffset
                    )
                    .onAppear {
                        DispatchQueue.main.async {
                            // Calculamos la posición inicial del primer botón
                            backgroundOffset = geometry
                                .frame(in: .global).minX
                            print(
                                "Posición inicial del fondo: \(backgroundOffset)"
                            )
                        }
                    }

                        
            }
        }
       
    }
}

// Ejemplo de uso
struct ContentView2: View {
    
    // Lista de iconos disponibles poner color #A1D79C en hexadecimal
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
        VStack {
            Text("Icon Picker")
                .font(.largeTitle)
            
            // Llamada al HorizontalIconPickerView con una lista de iconos y un callback
            HorizontalIconPickerView(icons: icons) { selectedId in
                // Aquí puedes manejar el icono seleccionado externamente
                print("Icono seleccionado con ID: \(selectedId)")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView2()
}
