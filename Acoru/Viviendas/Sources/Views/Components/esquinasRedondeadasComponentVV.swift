//
//  esquinasRedondeadasComponentVV.swift
//  Acoru
//
//  Created by Mauricio Betancourt Mora on 17/10/24.
//

import SwiftUI

// Estructura personalizada para redondear solo las esquinas específicas
struct esquinasRedondeadasComponentVV: Shape {
    var radius: CGFloat = 25.0
    var corners: UIRectCorner = [.allCorners]
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
