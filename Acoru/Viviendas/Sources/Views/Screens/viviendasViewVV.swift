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
    
    var progresoModelsSample = [
        ProgresoModel(img: UIImage(named:"captacion_agua")!, fixedProgress: 0.2),
        ProgresoModel(img: UIImage(named: "filtros_agua")!, fixedProgress: 0.5),
        ProgresoModel(img: UIImage(named:"riego_agua")!, fixedProgress: 0.8),
        ProgresoModel(img: UIImage(named:"tanques_agua")!, fixedProgress: 0.3)
    ]

    @State private var currentThemeColor: ColorVariant = ColorPaletteVV.residuos
    @State var capturedPhotos: [UIImage] = []
    @State private var selectedService: Service = .agua
    @State private var viewSelected: ServiceOptions = .none
    @State private var isExpanded: Bool = false
    @State private var hStackOffset: CGFloat = 0
    @State private var opacity: Double = 1
    @State private var path: NavigationPath = NavigationPath()
    @State private var showPhotoPicker = false

    //state de notificacion
    @State private var isNotification: Bool = false

    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height

    var onClose: () -> Void  // Función de cierre para regresar a la vista principal

    @State private var titlePantalla: String = "Evaluador"
    @State private var descripcionPantalla: String =
        "Descubre cómo construir tu hogar ideal con nuestras herramientas"

    func viewManager(for service: Service, option: ServiceOptions) -> AnyView {
        switch option {
        case .evaluador:
            return AnyView(
                EvaluadorViewVV(
                    currentThemeColor: $currentThemeColor, path: $path,
                    capturedPhotos: $capturedPhotos, showPhotoPicker: $showPhotoPicker)
            )
        case .simulador:

            return AnyView(EmptyView())
        case .instalacion:
            return AnyView(EmptyView())
        case .none:
            return AnyView(EmptyView())
        }
    }

    var body: some View {
        NavigationStack(path: $path) {

            ZStack(alignment: .top) {
                // Fondo degradado
                Rectangle()
                  .foregroundColor(.clear)
                  .background(
                    LinearGradient(
                      stops: [
                        Gradient.Stop(color: Color(red: 0.42, green: 0.8, blue: 1), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.76, green: 0.91, blue: 1), location: 1.00),
                      ],
                      startPoint: UnitPoint(x: 0.5, y: 0),
                      endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                  )
                  .frame(maxHeight: 300)
                Image("fondo_viviendas")
                    .resizable()
                    .scaledToFit() // Mantiene la proporción de la imagen
                    .frame(maxWidth: .infinity) // Ajusta el ancho al contenedor
                VStack(alignment: .leading, spacing: 40) {
                    // Flecha de regreso
                    if !isExpanded {
                        HStack {
                            Button(
                                action: {
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
                                        withAnimation(.easeInOut(duration: 0.5))
                                        {
                                            if capturedPhotos.isEmpty {
                                                capturedPhotos
                                                    .removeAll()
                                                isExpanded = false
                                            } else {
                                                capturedPhotos.removeAll()
                                            }
                                        }

                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 0.1
                                        ) {
                                            withAnimation(
                                                .bouncy
                                            ) {
                                                hStackOffset = .zero
                                                isNotification = false
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
                                            icons: icons,
                                            isExpanded: $isExpanded
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
                                                Text(titlePantalla)
                                                    .font(
                                                        customFont(
                                                            "Poppins", size: 34,
                                                            weight: .bold)
                                                    )
                                                    .foregroundColor(.black)
                                                Text(
                                                    descripcionPantalla
                                                )
                                                .font(
                                                    customFont(
                                                        "Poppins", size: 14,
                                                        weight: .medium)
                                                )
                                                .foregroundColor(
                                                    Color(
                                                        currentThemeColor.normal
                                                    )
                                                )
                                            }
                                            .transition(.move(edge: .leading))

                                            if !capturedPhotos.isEmpty {
                                                ZStack {
                                                    Button(action: {

                                                        withAnimation(
                                                            .easeInOut(
                                                                duration: 0.5)
                                                        ) {
                                                            capturedPhotos
                                                                .removeAll()
                                                            isExpanded = false

                                                        }

                                                        DispatchQueue.main
                                                            .asyncAfter(
                                                                deadline: .now()
                                                                    + 0.1
                                                            ) {
                                                                withAnimation(
                                                                    .bouncy
                                                                ) {
                                                                    hStackOffset =
                                                                        .zero
                                                                    isNotification =
                                                                        false
                                                                }
                                                            }
                                                    }) {
                                                        HStack(spacing: 5) {
                                                            Text("Finalizar")
                                                                .font(
                                                                    customFont(
                                                                        "Poppins",
                                                                        size:
                                                                            16,
                                                                        weight:
                                                                            .bold
                                                                    )
                                                                )
                                                                .foregroundColor(
                                                                    Color.white
                                                                )  // Color del texto
                                                                .padding(
                                                                    .vertical, 5
                                                                )
                                                            Image("Siguiente")
                                                                .resizable()
                                                                .frame(
                                                                    width: 20,
                                                                    height: 20)
                                                        }
                                                    }
                                                    .padding(.horizontal, 15)
                                                    .padding(.vertical, 4)
                                                    .background(
                                                        Color(
                                                            currentThemeColor
                                                                .normal)
                                                    )
                                                    .clipShape(
                                                        RoundedRectangle(
                                                            cornerRadius: 50
                                                        )
                                                    )
                                                }
                                                .frame(
                                                    maxWidth: .infinity,
                                                    alignment: .trailing)
                                            }
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
                                            progresoModels: progresoModelsSample,
                                            onActionTriggered: {},
                                            onActionLeftTriggered: {},
                                            onActionRightTriggered: {}
                                        )
                                    }
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .trailing
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
                                            withAnimation(
                                                .easeInOut(duration: 0.9)
                                            ) {
                                                hStackOffset = -UIScreen.main
                                                    .bounds
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

                                            DispatchQueue.main.asyncAfter(
                                                deadline: .now() + 0.5
                                            ) {
                                                //
                                                isNotification = true
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
                                            //
                                            titlePantalla = "Simulador"
                                            descripcionPantalla =
                                                "Adentrate en la realidad aumentada ACORU  y conoce soluciones sostenibles."
                                            withAnimation(
                                                .easeInOut(duration: 0.9)
                                            ) {
                                                hStackOffset = -UIScreen.main
                                                    .bounds
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
                                                viewSelected = .simulador
                                            }

                                            DispatchQueue.main.asyncAfter(
                                                deadline: .now() + 0.5
                                            ) {
                                                //
                                                isNotification = true
                                            }
                                        }
                                    )

                                    CartaComponentVV(
                                        titulo: "Instalación",
                                        descripcion:
                                            "Revisa la compatibilidad de tu casa con la ecotecnología.",
                                        themeColor: $currentThemeColor,
                                        cardPosition: .left,
                                        onActionTriggered: {

                                            withAnimation(
                                                .easeInOut(duration: 0.9)
                                            ) {
                                                hStackOffset = -UIScreen.main
                                                    .bounds
                                                    .width
                                                isNotification = true
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
                                                viewSelected = .instalacion
                                            }

                                        }
                                    )
                                }
                                .transition(
                                    .asymmetric(
                                        insertion: .move(edge: .bottom),
                                        removal: .opacity.combined(
                                            with: .move(edge: .leading))))
                            } else {
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
                NotificationWidget(
                    descriptionText:
                        "Para empezar, sube una foto de la instalación o toma una foto del área que deseas evaluar",
                    isVisible: $isNotification

                )
                .position(x: UISW * 0.75, y: UISH * 0.17)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            .sheet(isPresented: $showPhotoPicker) {
                        PhotoPicker(selectedPhotos: $capturedPhotos)  // Presenta el selector de fotos
                    }
            .navigationDestination(for: String.self) { id in
                if id == "Camara" {
                    CameraViewVV(path: $path, capturedPhotos: $capturedPhotos)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ViviendasViewVV(onClose: {})
    }
}
