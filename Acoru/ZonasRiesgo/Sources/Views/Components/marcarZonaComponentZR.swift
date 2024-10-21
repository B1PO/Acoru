//
//  marcarZonaComponentZR.swift
//  Acoru
//
//  Created by Mario Moreno on 10/17/24.
//

import SwiftUI

struct marcarZonaComponentZR: View {
    var body: some View {
        
        VStack {
            CarruselComponentZR()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 600)
                .background(Color.white)
                .cornerRadius(40)
                .shadow(radius: 10)
    }
}

#Preview {
    marcarZonaComponentZR()
}
