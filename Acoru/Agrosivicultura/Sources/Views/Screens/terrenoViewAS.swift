import SwiftUI

var UISW: CGFloat = UIScreen.main.bounds.width
var UISH: CGFloat = UIScreen.main.bounds.height

struct DragAndDropView: View {
    struct Punto: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var ocupado: Bool = false
    }
    
    struct ImagenDraggable: Identifiable {
        let id = UUID()
        var imageName: String
        var position: CGPoint
        var initialPosition: CGPoint
        var zIndex: Double
        var anclada: Bool = false
        var isSelected: Bool = false
    }
    
    @State private var puntos: [Punto] = []
    @State private var imagenes: [ImagenDraggable] = [
        ImagenDraggable(imageName: "pasto2x", position: CGPoint(x: UISW * 0.9, y: UISH * 0.3), initialPosition: CGPoint(x: UISW * 0.9, y: UISH * 0.3), zIndex: 0),
        ImagenDraggable(imageName: "seca2x", position: CGPoint(x: UISW * 0.9, y: UISH * 0.4), initialPosition: CGPoint(x: UISW * 0.9, y: UISH * 0.4), zIndex: 0),
        ImagenDraggable(imageName: "tierra-seca2x", position: CGPoint(x: UISW * 0.9, y: UISH * 0.5), initialPosition: CGPoint(x: UISW * 0.9, y: UISH * 0.5), zIndex: 0),
        ImagenDraggable(imageName: "tierra-trabajada2x", position: CGPoint(x: UISW * 0.9, y: UISH * 0.6), initialPosition: CGPoint(x: UISW * 0.9, y: UISH * 0.6), zIndex: 0),
        ImagenDraggable(imageName: "tierra2x", position: CGPoint(x: UISW * 0.9, y: UISH * 0.7), initialPosition: CGPoint(x: UISW * 0.9, y: UISH * 0.7), zIndex: 0)
    ]
    
    @State private var isSaved = false
    @State private var showMenu = false
    @State private var selectedImageType: String = ""
    @State private var selectedImagePosition: CGPoint = .zero
    @State private var plantedImages: [CGPoint: (imageName: String, size: CGSize, offset: CGSize)] = [:]
    @State private var selectedPlantedImagePosition: CGPoint? = nil

    private let numFilas = 18
    private let puntoSize: CGFloat = 15
    private let distanciaHorizontal: CGFloat = 100
    private let distanciaVertical: CGFloat = 25

    init() {
        var puntosTemp: [Punto] = []
        let offsetX: CGFloat = UIScreen.main.bounds.width * 0.45
        let offsetY: CGFloat = UIScreen.main.bounds.height * 0.3
        
        for i in 0..<numFilas {
            let numPuntosEnFila = i < numFilas / 2 ? i + 1 : numFilas - i - 1
            let xOffset = CGFloat(numPuntosEnFila - 1) * distanciaHorizontal / 2
            for j in 0..<numPuntosEnFila {
                let xPos = offsetX - xOffset + CGFloat(j) * distanciaHorizontal
                let yPos = offsetY + CGFloat(i) * distanciaVertical
                puntosTemp.append(Punto(x: xPos, y: yPos))
            }
        }
        
        _puntos = State(initialValue: puntosTemp)
    }
    
    var body: some View {
        ZStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 167/255, green: 215/255, blue: 203/255), Color(red: 112/255, green: 196/255, blue: 203/255)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: UISW, height: UISH)
                .edgesIgnoringSafeArea(.all)

                if !isSaved {
                    Color.frameColor
                        .frame(width: UISW * 0.075, height: UISH * 0.55)
                        .cornerRadius(50.0)
                        .position(x: UISW * 0.9, y: UISH * 0.5)
                }
                
                if !isSaved {
                    ForEach(puntos) { punto in
                        Circle()
                            .frame(width: puntoSize, height: puntoSize)
                            .foregroundColor(.white)
                            .position(x: punto.x, y: punto.y)
                    }
                }
                
                // Botón 1 (Agregar Bloques de Tierra)
                Button(action: {
                    print("Botón 1 presionado: Agregar Bloques de Tierra")
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "square.grid.2x2.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        )
                }
                .position(x: UISW * 0.05, y: UISH * 0.4)
                
                // Botón 2 (Agregar Plantas)
                Button(action: {
                    print("Botón 2 presionado: Agregar Plantas")
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 60, height: 60)
                        .overlay(
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        )
                }
                .position(x: UISW * 0.05, y: UISH * 0.5)
                
                ForEach($imagenes) { $imagen in
                    if !isSaved || imagen.anclada {
                        Image(imagen.imageName)
                            .resizable()
                            .frame(width: imagen.anclada ? 100 : 50, height: imagen.anclada ? 100 : 50)
                            .position(x: imagen.position.x, y: imagen.isSelected ? imagen.position.y - 15 : imagen.position.y)
                            .zIndex(imagen.zIndex)
                            .gesture(
                                TapGesture()
                                    .onEnded {
                                        if isSaved && imagen.anclada {
                                            withAnimation {
                                                for i in 0..<imagenes.count {
                                                    imagenes[i].isSelected = false
                                                }
                                                imagen.isSelected.toggle()
                                                selectedImageType = imagen.imageName
                                                selectedImagePosition = imagen.position
                                                showMenu = imagen.isSelected
                                                
                                                if imagen.isSelected && plantedImages.keys.contains(imagen.position) {
                                                    selectedPlantedImagePosition = imagen.position
                                                } else {
                                                    selectedPlantedImagePosition = nil
                                                }
                                            }
                                        }
                                    }
                            )
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if !imagen.anclada {
                                            imagen.position = value.location
                                            imagen.zIndex = 1000
                                        }
                                    }
                                    .onEnded { _ in
                                        if imagen.anclada {
                                            return
                                        }
                                        
                                        if let puntoCercano = puntos.min(by: {
                                            hypot($0.x - imagen.position.x, $0.y - imagen.position.y) < hypot($1.x - imagen.position.x, $1.y - imagen.position.y)
                                        }), hypot(puntoCercano.x - imagen.position.x, puntoCercano.y - imagen.position.y) < 40 {
                                            if !puntoCercano.ocupado {
                                                imagen.position = CGPoint(x: puntoCercano.x, y: puntoCercano.y)
                                                imagen.zIndex = Double(puntoCercano.y) * 1000 - Double(puntoCercano.x)
                                                imagen.anclada = true
                                                
                                                if let index = puntos.firstIndex(where: { $0.id == puntoCercano.id }) {
                                                    puntos[index].ocupado = true
                                                }
                                                
                                                imagenes.append(
                                                    ImagenDraggable(
                                                        imageName: imagen.imageName,
                                                        position: imagen.initialPosition,
                                                        initialPosition: imagen.initialPosition,
                                                        zIndex: 0
                                                    )
                                                )
                                            } else {
                                                imagen.position = imagen.initialPosition
                                                imagen.zIndex = 0
                                            }
                                        } else {
                                            imagen.position = imagen.initialPosition
                                            imagen.zIndex = 0
                                        }
                                    }
                            )
                    }
                }
            }
            
            PlantacionesView(plantedImages: $plantedImages, selectedPlantedImagePosition: $selectedPlantedImagePosition)
                .zIndex(3)
            
            if !isSaved {
                Button(action: {
                    withAnimation {
                        let xOffset = UISW * 0.5
                        let yOffset = UISH * 0.3
                        
                        for i in 0..<puntos.count {
                            puntos[i].x -= UISW * 0.45 - xOffset
                            puntos[i].y -= UISH * 0.3 - yOffset
                        }
                        
                        for i in 0..<imagenes.count {
                            if imagenes[i].anclada {
                                imagenes[i].position.x -= UISW * 0.45 - xOffset
                                imagenes[i].position.y -= UISH * 0.3 - yOffset
                            }
                        }
                        
                        isSaved = true
                    }
                }) {
                    HStack {
                        Text("Guardar")
                        Image(systemName: "circle.fill")
                    }
                    .font(.custom("Poppins", size: 25))
                    .bold()
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(30)
                }
                .position(x: UISW * 0.9, y: UISH * 0.9)
            }
            
            if showMenu {
                HStack(spacing: 20) {
                    ForEach(getMenuImages(for: selectedImageType), id: \.imageName) { image in
                        Button(action: {
                            plantedImages[selectedImagePosition] = (imageName: image.imageName, size: image.size, offset: image.offset)
                            showMenu = false
                            selectedPlantedImagePosition = nil
                            
                            for i in 0..<imagenes.count {
                                imagenes[i].isSelected = false
                            }
                        }) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 80, height: 80)
                                .overlay(
                                    Image(image.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                )
                        }
                    }
                }
                .padding()
                .padding(.horizontal)
                .background(Color.white.opacity(0.9))
                .cornerRadius(25)
                .position(x: UISW * 0.5, y: UISH * 0.85)
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
    
    private func getMenuImages(for type: String) -> [(imageName: String, size: CGSize, offset: CGSize)] {
        switch type {
        case "pasto2x":
            return [
                (imageName: "trigo3x", size: CGSize(width: 60, height: 70), offset: CGSize(width: 0, height: -55)),
                (imageName: "maiz2x", size: CGSize(width: 60, height: 70), offset: CGSize(width: 0, height: -55)),
                (imageName: "lechuga3x", size: CGSize(width: 50, height: 50), offset: CGSize(width: 0, height: -50))
            ]
        case "tierra-trabajada2x":
            return [
                (imageName: "maiz2x", size: CGSize(width: 60, height: 70), offset: CGSize(width: 0, height: -15)),
                (imageName: "tomate3x", size: CGSize(width: 60, height: 70), offset: CGSize(width: 0, height: -55)),
                (imageName: "zanahoria2x", size: CGSize(width: 50, height: 50), offset: CGSize(width: 0, height: -50))
            ]
        default:
            return []
        }
    }
}

// Vista para mostrar las plantaciones seleccionadas con tamaño y offset personalizados
struct PlantacionesView: View {
    @Binding var plantedImages: [CGPoint: (imageName: String, size: CGSize, offset: CGSize)]
    @Binding var selectedPlantedImagePosition: CGPoint?

    var body: some View {
        ForEach(plantedImages.keys.sorted(by: { $0.y > $1.y }), id: \.self) { position in
            if let imageInfo = plantedImages[position] {
                Image(imageInfo.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageInfo.size.width, height: imageInfo.size.height)
                    .position(position)
                    .zIndex(3)
                    .offset(imageInfo.offset)
                    .offset(y: selectedPlantedImagePosition == position ? -15 : 0)
            }
        }
    }
}

#Preview {
    DragAndDropView()
}
