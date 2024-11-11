//
//  mapaViewZR.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
import SwiftUI
import MapKit

// Modelo de datos para las zonas

struct Zone: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let warning: String
    let coordinate: CLLocationCoordinate2D
}

// Administrador de ubicación para obtener la ubicación actual del usuario
class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
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
            manager.startUpdatingLocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

struct mapViewZR: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332), // Coordenadas iniciales (Ciudad de México)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @StateObject private var locationManager = LocationManager()
    @State private var panelOffset: CGFloat = 0
    @State private var isPanelVisible: Bool = true
    @State private var selectedZone: Zone?

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
                    VStack {
//                        Image(systemName: "mappin.circle.fill")
//                            .foregroundColor(.red)
//                            .font(.title)
//                            .onTapGesture {
//                                selectedZone = zone
//                            }
//                        Text(zone.title)
//                            .font(.caption)
//                            .fixedSize()
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .frame(width: 220, height: 70)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                       
                                )
                                .onTapGesture {
                                    selectedZone = zone
                                }
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
            .edgesIgnoringSafeArea(.all)
            .mapStyle(.standard(elevation: .realistic, emphasis: .automatic))
            
            VStack {
                    HStack {
                        Button(action: {
                                
                        }) {
                            Image(systemName: "chevron.backward")
                                     .foregroundColor(.black)
                                     .padding()
                                     .font(.largeTitle)
                            
                                     
                            }
                             Spacer()
                         }
                         Spacer()
                     }
                     .padding(.top, 10)
                     .padding(.leading, 20)

            // Panel deslizante en el lado izquierdo
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
                               }

                        if isPanelVisible {
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
                                    Spacer()
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
                    .frame(width: 450, height: 700)
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
                                    panelOffset = max(-260, newOffset)
                                } else {
                                    panelOffset = 0
                                }
                            }
                            .onEnded { value in
                                if panelOffset < -150 {
                                    withAnimation {
                                        panelOffset = -260
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
        .sheet(item: $selectedZone) { zone in
            VStack(spacing: 20) {
                Text(zone.title)
                    .font(.title)
                Text(zone.subtitle)
                    .font(.subheadline)
                Text(zone.warning)
                    .font(.body)
                    .foregroundColor(.red)
                Button("Cerrar") {
                    selectedZone = nil
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            // Configurar la región inicial al ubicarse en la posición actual del usuario
            if let location = locationManager.location?.coordinate {
                region.center = location
            }
        }
    }

    // Función para ocultar/mostrar el panel
    func togglePanel() {
        if isPanelVisible {
            panelOffset = -400
        } else {
            panelOffset = 0
        }
        isPanelVisible.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        mapViewZR()
    }
}


