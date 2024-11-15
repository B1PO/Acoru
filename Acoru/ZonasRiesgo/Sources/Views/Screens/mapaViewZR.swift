//
//  inspectorViewZR.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.

import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
} 
// Modelo de datos para las zonas
struct Zone: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
    let warning: String
    let coordinate: CLLocationCoordinate2D
}

// Administrador de ubicación para obtener la ubicación actual del usuario
@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        // Eliminamos el inicio de actualizaciones aquí para evitar redundancia
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        location = locations.first
        manager.stopUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation() // Iniciamos actualizaciones cuando hay permiso
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

// Vista principal
struct inspectorViewZR: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332), // Coordenadas iniciales
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @StateObject private var locationManager = LocationManager()
    @State private var panelOffset: CGFloat = 0
    @State private var isPanelVisible: Bool = true
    @State private var selectedZone: Zone?

    @Environment(\.presentationMode) var presentationMode // Para el botón "Back"

    // Datos de las zonas
    let zones: [Zone] = [
        Zone(
            title: "Rancho Don Pepe",
            subtitle: "Carretera estatal 52",
            warning: "Precaución zona de derrumbe",
            coordinate: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332)
        ),
        Zone(
            title: "La quebrada",
            subtitle: "Zona centro #32",
            warning: "Precaución zona de inundaciones",
            coordinate: CLLocationCoordinate2D(latitude: 19.4270, longitude: -99.1677)
        ),
        Zone(
            title: "Puente Cisneros",
            subtitle: "Salida Nuevo México",
            warning: "Precaución zona de derrumbe",
            coordinate: CLLocationCoordinate2D(latitude: 19.4350, longitude: -99.0900)
        )
    ]

    var body: some View {
        ZStack {
            // Vista del mapa
            Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: zones) { zone in
                MapAnnotation(coordinate: zone.coordinate) {
                    ZoneAnnotationView(zone: zone)
                        .onTapGesture {
                            withAnimation {
                                selectedZone = zone
                            }
                        }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .mapStyle(.standard(elevation: .realistic, emphasis: .automatic))

            // Botón de regreso en la esquina superior izquierda
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                            .padding()
                            .font(.largeTitle)
                    }
                    .accessibilityLabel("Regresar")
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 20)

            // Panel deslizante en el lado izquierdo
            SlidingPanelView(isPanelVisible: $isPanelVisible, panelOffset: $panelOffset, zones: zones)

            // Vista personalizada que se desliza desde el lado derecho
            if let zone = selectedZone {
                ZoneDetailView(zone: zone, selectedZone: $selectedZone)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut, value: selectedZone)
            }
        }
        .onAppear {
            // Actualizamos la región cuando se obtiene la ubicación
            if let location = locationManager.location?.coordinate {
                region.center = location
            }
        }
    }
}

// Vista para las anotaciones de las zonas en el mapa
struct ZoneAnnotationView: View {
    var zone: Zone

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 220, height: 70)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color.red.opacity(0.3))
                            .frame(width: 40, height: 40)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                    }
                    VStack(alignment: .leading) {
                        Text(zone.title)
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(zone.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(10)
            }
        }
    }
}

// Vista del panel deslizante en el lado izquierdo
struct SlidingPanelView: View {
    @Binding var isPanelVisible: Bool
    @Binding var panelOffset: CGFloat
    var zones: [Zone]

    let panelWidth: CGFloat = 450
    let hiddenOffset: CGFloat = -400

    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        // Botón para ocultar/mostrar el panel en la parte superior derecha
                        Button(action: {
                            withAnimation {
                                togglePanel()
                            }
                        }) {
                            Image(systemName: isPanelVisible ? "chevron.left" : "chevron.right")
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(Color.gray))
                                .padding(.top, 10)
                        }
                        .padding()
                        .accessibilityLabel(isPanelVisible ? "Ocultar panel" : "Mostrar panel")
                    }

                    if isPanelVisible {
                        ScrollView {
                            VStack(alignment: .leading) {
                                Text("Zonas recientes")
                                    .font(.system(size: 34, weight: .bold))
                                    .padding(.horizontal)
                                    .padding(.top, 30)

                                // Lista de zonas
                                ForEach(zones) { zone in
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text(zone.title)
                                            .font(.subheadline)
                                            .bold()
                                        Text(zone.subtitle)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        Divider()
                                        Text(zone.warning)
                                            .font(.footnote)
                                            .foregroundColor(.red)
                                            .bold()
                                    }
                                    .padding()
                                    .background(Color(UIColor.systemGray6))
                                    .cornerRadius(20)
                                    .padding(.horizontal)
                                }

                                // Botones
                                HStack {
                                    Button(action: {
                                        // Acción para "Ver más"
                                    }) {
                                        Text("Ver más")
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: 150)
                                            .background(Color(UIColor(red: 0.38, green: 0.76, blue: 0.93, alpha: 1.00)))
                                            .cornerRadius(30)
                                    }

                                    Button(action: {
                                        // Acción para "Comunidad ACORU"
                                    }) {
                                        Text("Comunidad ACORU")
                                            .foregroundColor(.white)
                                            .padding()
                                            .frame(maxWidth: 200)
                                            .background(Color(UIColor(red: 0.38, green: 0.76, blue: 0.93, alpha: 1.00)))
                                            .cornerRadius(30)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                    }
                }
                .frame(width: panelWidth, height: geometry.size.height * 0.9)
                .background(Color.white)
                .cornerRadius(40)
                .padding(.leading, 20)
                .padding(.top, 100)
                .offset(x: panelOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newOffset = value.translation.width
                            if newOffset < 0 {
                                panelOffset = max(hiddenOffset, newOffset)
                            } else {
                                panelOffset = 0
                            }
                        }
                        .onEnded { value in
                            if panelOffset < hiddenOffset / 2 {
                                withAnimation {
                                    panelOffset = hiddenOffset
                                    isPanelVisible = false
                                }
                            } else {
                                withAnimation {
                                    panelOffset = 0
                                    isPanelVisible = true
                                }
                            }
                        }
                )
            }
        }
    }

    func togglePanel() {
        panelOffset = isPanelVisible ? hiddenOffset : 0
        isPanelVisible.toggle()
    }
}

// Vista de detalle que se desliza desde el lado derecho
struct ZoneDetailView: View {
    var zone: Zone
    @Binding var selectedZone: Zone?
    @State private var isExpanded: Bool = false

    var body: some View {
        ZStack(alignment: .trailing) {
            // Fondo semitransparente para capturar el toque fuera de la vista de detalle
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        selectedZone = nil
                    }
                }

            // Contenido de la vista de detalle
            VStack(spacing: 20) {
                // Encabezado
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedZone = nil
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .frame(width: 32, height: 32)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Cerrar detalle")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.red.opacity(0.3))
                            .frame(width: 40, height: 40)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 20, height: 20)
                    }
                    .padding()
                    VStack(alignment: .leading) {
                        Text(zone.title)
                            .font(.title2)
                            .bold()
                        Text(zone.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        // Acción del botón "Votar"
                    }) {
                        HStack {
                            Text("Votar")
                            Image(systemName: "exclamationmark.triangle")
                        }
                        .padding(15)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    .accessibilityLabel("Votar por esta zona")
                }
                .padding()

                // Imagen principal
                Image("imagenMapaZR") // Reemplaza "imagenMapaZR" con el nombre de tu imagen
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.horizontal)
                HStack(spacing: 0) {
                    Text("Compartido por: ")
                    Text("mario.dev")
                        .foregroundColor(.blue)
                        .underline()
                }

                // Contenido de descripción
                VStack(alignment: .leading) {
                    ZStack {
                        // Rectángulo gris de fondo
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 350, height: 250) // Ajusta el tamaño según lo necesites

                        VStack(spacing: 20) {
                            // Rectángulo blanco con texto
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(width: 300, height: isExpanded ? 180 : 120)
                                .overlay(
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Tiene una casa principal de estilo rústico con techos de teja, porches amplios y un jardín lleno de flores silvestres. A menudo, hay corrales con caballos pastando y un establo de madera donde se guarda el heno y las herramientas. En un rincón del rancho, hay una zona de riesgo,...")
                                            .font(.body)
                                            .lineLimit(isExpanded ? nil : 3) // Expande o trunca el texto
                                            .foregroundColor(.black)
                                            .padding(.horizontal)

                                        // Botón de "Expandir"
                                        Button(action: {
                                            withAnimation {
                                                isExpanded.toggle()
                                            }
                                        }) {
                                            Text(isExpanded ? "Contraer" : "Expandir")
                                                .font(.subheadline)
                                                .foregroundColor(.blue)
                                                .padding(5)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.blue, lineWidth: 1)
                                                )
                                        }
                                        .padding(.trailing)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                    .padding()
                                )

                            // Botón en la parte inferior
                            Button(action: {
                                // Acción para "Comunidad ACORU"
                            }) {
                                Text("Comunidad ACORU")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: 200)
                                    .background(Color(UIColor(red: 0.38, green: 0.76, blue: 0.93, alpha: 1.00)))
                                    .cornerRadius(30)
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .padding()
            .frame(width: 400, height: .infinity) // Ancho fijo de 400 y altura infinita
            .background(Color.white)
            .cornerRadius(16)
            .transition(.opacity)
        }
        .animation(.easeInOut, value: selectedZone)
    }
}

// Vista de previsualización
struct inspectorViewZR_Previews: PreviewProvider {
    static var previews: some View {
        inspectorViewZR()
    }
}
