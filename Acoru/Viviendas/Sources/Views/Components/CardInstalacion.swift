import SwiftUI

struct ModelCardInstalacion {
    var id: UUID = UUID() // Identificador único para cada tarjeta
    var text: String
    var image: String
    var description: String
}

struct CardInstalacion: View {
    var model: ModelCardInstalacion
    @Binding var currentThemeColor: ColorVariant
    @Binding var selectedCardID: UUID?
    @Binding var selectedCardText: String?

    var body: some View {
        HStack {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            VStack(alignment: .leading, spacing: 10) {
                Text(model.text)
                    .font(customFont("Poppins", size: 16, weight: .bold))
                    .foregroundColor(
                        selectedCardID == model.id ?  Color.black : Color.white
                    )

                if selectedCardID == model.id {
                    Text(model.description)
                        .font(customFont("Poppins", size: 11, weight: .regular))
                        .foregroundColor(.black.opacity(0.5))
                        .transition(.opacity.combined(with: .move(edge: .leading)))
                        .animation(.easeIn(duration: 0.5), value: selectedCardID)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 140, alignment: .leading)
        .background(selectedCardID == model.id ? Color.white : Color(currentThemeColor.normal))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(selectedCardID == model.id ? Color(currentThemeColor.dark) : Color.clear, lineWidth: 2)
        )
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                if selectedCardID == model.id {
                    selectedCardID = nil
                    selectedCardText = nil
                } else {
                    selectedCardID = model.id
                    selectedCardText = model.text
                }
            }
        }
    }
}
