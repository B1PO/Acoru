import SwiftUI

struct InfoPanelView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            // Encabezado con espacio para la imagen de los tomates
            HStack(alignment: .center, spacing: 15) {
                ZStack {
                    Circle() // Espacio para la imagen de los tomates
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.gray.opacity(0.3))
                    Image("tomate3x")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text("Tomates")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.black)
                    Text("Cultivo de hortalizas")
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 20)

            VStack{
                
                HStack(spacing: 21) {
                    ForEach(0..<3) { _ in
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 10, height: 10)
                    }
                    ForEach(0..<2) { _ in
                        Circle()
                            .fill(Color.gray.opacity(0.4))
                            .frame(width: 10, height: 10)
                    }
                    
                    
                }
                
                Text("Dificultad de mantenimiento")
                    .font(.system(size: 14))
                    .foregroundColor(.orange)
                    .offset(x: 20)
            }

            // Secciones de información
            VStack(alignment: .leading, spacing: 15) {
                InfoSection(title: "Riego:",
                            description: [
                                "Regar de manera constante y profunda, evitando que el agua toque las hojas para prevenir enfermedades.",
                                "Es preferible un riego por goteo o directo al pie de la planta."
                            ])

                InfoSection(title: "Luz Solar:",
                            description: [
                                "Los tomates necesitan al menos 6-8 horas de luz solar directa al día.",
                                "Un buen acceso a la luz favorece un crecimiento saludable y una buena producción de frutos."
                            ])

                InfoSection(title: "Espacio:",
                            description: [
                                "Deja suficiente espacio entre las plantas (30-60 cm), para permitir una buena circulación de aire y evitar problemas de hongos."
                            ])
            }
            .padding(.horizontal, 10)
        }
        .padding()
    }
}

struct InfoSection: View {
    var title: String
    var description: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.orange)
            
            ForEach(description, id: \ .self) { line in
                Text("• " + line)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        
        
    }
}

#Preview {
    InfoPanelView()
}
