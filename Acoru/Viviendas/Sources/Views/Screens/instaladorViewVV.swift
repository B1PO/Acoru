//
//  instaladorView.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 14/10/24.
//


import SwiftUI

struct InstaladorView: View, Hashable {
    var body: some View {
        VStack {
            Image("Gota")
                .resizable()
                .frame(width:200, height:200)
        }
        .background(Color.black.opacity(0.5))
    }
}

#Preview {
    InstaladorView()
}
