//
//  notifiacionViewG.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//


import SwiftUI

struct NotificationWidget: View {
    let icon: String
    let descriptionText: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            
            Text(descriptionText)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .frame(maxWidth: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 2)
    }
}

struct NotificationWidget_Previews: PreviewProvider {
    static var previews: some View {
        NotificationWidget(icon: "bell.fill", descriptionText: "Este es un ejemplo de una notificación que se adapta al contenido. Puedes agregar la cantidad de texto que necesites.")
    }
}
