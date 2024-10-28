//
//  viviendasView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//

import SwiftUI

//enum Agua, Residuos, Electricidad
enum Service {
    case agua
    case residuos
    case electricidad
}

enum ServiceOptions {
    case none
    case evaluador
    case simulador
    case instalacion
}

struct ViviendasViewVV: View {
    let icons = [
        Icon(id: 0, name: "Gota", themeColor: ColorPaletteVV.residuos),
        Icon(id: 1, name: "Trash", themeColor: ColorPaletteVV.agua),
        Icon(
            id: 2, name: "Electricidad", themeColor: ColorPaletteVV.electricidad
        ),
    ]

    @State private var currentThemeColor: ColorVariant = ColorPaletteVV.residuos
    @State private var selectedService: Service = .agua
    @State private var viewSelected: ServiceOptions = .none
    @State private var isExpanded: Bool = false
    @State private var hStackOffset: CGFloat = 0
    @State private var opacity: Double = 1
 

    var onClose: () -> Void  // Función de cierre para regresar a la vista principal

    func viewManager(for service: Service, option: ServiceOptions) -> AnyView
    {
        switch option {
        case .evaluador:
            return AnyView(EvaluadorViewVV())
        case .simulador:
            return AnyView( EmptyView())
        case .instalacion:
            return AnyView( EmptyView())
        case .none:
            return AnyView( EmptyView())
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            // Fondo degradado
            Rectangle()
                .fill(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(
                                color: Color(currentThemeColor.normal),
                                location: 0.00),
                            Gradient.Stop(
                                color: lighterColor(
                                    color: Color(currentThemeColor.normal),
                                    percentage: 0.3), location: 0.25),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                )
                .foregroundColor(.clear)

            VStack(alignment: .leading, spacing: 40) {
                // Flecha de regreso
                if !isExpanded {
                    HStack {
                        Button(action: {
                            onClose()  // Acción para regresar a la pantalla principal
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 20)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Título y subtítulo
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Viviendas Sostenibles")
                            .font(
                                customFont(
                                    "Poppins", size: 34, weight: .bold)
                            )
                            .foregroundColor(.black)
                        Text(
                            "Descubre cómo construir tu hogar ideal con nuestras herramientas"
                        )
                        .font(
                            customFont("Poppins", size: 14, weight: .medium)
                        )
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 60)
                    .opacity(opacity)
                }

                // Recuadro blanco con bordes redondeados
                ZStack(alignment: .top) {

                    Rectangle()
                        .fill(Color(red: 0.96, green: 0.97, blue: 0.99))
                        .cornerRadius(
                            isExpanded ? 0 : 50,
                            corners: [.topLeft, .topRight]
                        )
                    VStack(
                        alignment: .leading, spacing: 40
                    ) {
                        if isExpanded {
                            HStack {
                                Button(action: {

                                    // Restablece `isExpanded` con animación inversa
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        isExpanded = false
                                    }

                                    DispatchQueue.main.asyncAfter(
                                        deadline: .now() + 0.1
                                    ) {
                                        withAnimation(
                                            .bouncy
                                        ) {
                                            hStackOffset = .zero
                                        }
                                    }
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .padding(.horizontal)
                                        .padding(.top, 20)
                                }
                            }
                            .padding(.horizontal, -40)

                        }
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                if !isExpanded {
                                    HStack(spacing: 0) {
                                        Text("Elige un ")
                                            .font(
                                                customFont(
                                                    "Poppins", size: 14,
                                                    weight: .medium)
                                            )
                                            .foregroundColor(.black)
                                        Text("Servicio")
                                            .font(
                                                customFont(
                                                    "Poppins", size: 14,
                                                    weight: .bold)
                                            )
                                            .foregroundColor(.black)
                                    }
                                    .offset(x: hStackOffset)
                                }

                                // Picker para seleccionar el ícono
                                HStack(alignment: .top, spacing: 20) {
                                    PickerComponent(
                                        icons: icons, isExpanded: $isExpanded
                                    ) {
                                        selectedId in
                                        // Cambiar el color del tema según el ícono seleccionado
                                        switch selectedId {
                                        case 0:
                                            currentThemeColor =
                                                ColorPaletteVV.residuos
                                            selectedService = .agua
                                        case 1:
                                            currentThemeColor =
                                                ColorPaletteVV.agua
                                            selectedService = .residuos
                                        case 2:
                                            currentThemeColor =
                                                ColorPaletteVV.electricidad
                                            selectedService = .electricidad
                                        default:
                                            currentThemeColor =
                                                ColorPaletteVV.agua
                                        }
                                    }
                                    if isExpanded {
                                        VStack(alignment: .leading) {
                                            Text("Evaluador")
                                                .font(
                                                    customFont(
                                                        "Poppins", size: 34,
                                                        weight: .bold)
                                                )
                                                .foregroundColor(.black)
                                            Text(
                                                "Descubre cómo construir tu hogar ideal con nuestras herramientas"
                                            )
                                            .font(
                                                customFont(
                                                    "Poppins", size: 14,
                                                    weight: .medium)
                                            )
                                            .foregroundColor(
                                                Color(currentThemeColor.normal)
                                            )
                                        }
                                        .transition(.move(edge: .leading))

                                    }
                                }

                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            if !isExpanded {
                                VStack(alignment: .trailing, spacing: 30) {
                                    Text("Instalaciones hechas ")
                                        .font(
                                            customFont(
                                                "Poppins", size: 14,
                                                weight: .medium)
                                        )
                                        .foregroundColor(.black)

                                    ProgresoComponent(
                                        themeColor: $currentThemeColor,
                                        progress: 0.5,
                                        onActionTriggered: {},
                                        onActionLeftTriggered: {},
                                        onActionRightTriggered: {}
                                    )
                                }
                                .frame(
                                    maxWidth: .infinity, alignment: .trailing
                                )
                                .offset(x: hStackOffset * -1)
                            }
                        }
                        if !isExpanded {
                            HStack(spacing: 40) {
                                // Tarjetas de opciones con sus acciones correspondientes
                                CartaComponentVV(
                                    titulo: "Evaluador",
                                    descripcion:
                                        "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                    themeColor: $currentThemeColor,
                                    cardPosition: .right,
                                    onActionTriggered: {
                                        withAnimation(.easeInOut(duration: 0.9))
                                        {
                                            hStackOffset = -UIScreen.main.bounds
                                                .width
                                        }

                                        // Desplazar el HStack hacia la izquierda con un retardo
                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.2
                                        ) {
                                            withAnimation(
                                                .bouncy
                                            ) {
                                                isExpanded = true
                                            }
                                        }
                                        
                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.4
                                        ) {
                                            //
                                            viewSelected = .evaluador
                                        }

                                    }
                                )

                                CartaComponentVV(
                                    titulo: "Simulador",
                                    descripcion:
                                        "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                    themeColor: $currentThemeColor,
                                    cardPosition: .center,
                                    onActionTriggered: {
                                        //                                        path.append("SimuladorView")
                                    }
                                )

                                CartaComponentVV(
                                    titulo: "Instalación",
                                    descripcion:
                                        "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                    themeColor: $currentThemeColor,
                                    cardPosition: .left,
                                    onActionTriggered: {
                                        withAnimation(.easeInOut(duration: 0.9))
                                        {
                                            hStackOffset = -UIScreen.main.bounds
                                                .width
                                        }

                                        // Desplazar el HStack hacia la izquierda con un retardo
                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.1
                                        ) {
                                            withAnimation(
                                                .bouncy
                                            ) {
                                                isExpanded = true
                                            }
                                        }

                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.4
                                        ) {
                                            //                                            path.append("InstaladorView")
                                        }
                                    }
                                )
                            }
                            .transition(
                                .asymmetric(
                                    insertion: .move(edge: .bottom),
                                    removal: .opacity.combined(
                                        with: .move(edge: .leading))))
                        }else{
                            viewManager(
                                for: selectedService,
                                option: viewSelected
                            )
                        }
                    }
                    .padding(.horizontal, 60)
                    .padding(.bottom, 50)
                    .padding(.top, isExpanded ? 10 : 50)
                }
            }
            .padding(.top, isExpanded ? 0 : 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        }
        .ignoresSafeArea()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViviendasViewVV(onClose: {})
    }
}
