//
//  instaladorView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//


import SwiftUI

struct InstaladorView: View{
    @Binding var path: NavigationPath // Pila de navegación
    var body: some View {
        ZStack {
        }
        .background(Color.red.opacity(0.5))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InstaladorView(path: .constant(NavigationPath()))
}
