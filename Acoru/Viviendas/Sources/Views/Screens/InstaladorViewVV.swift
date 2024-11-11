//
//  InstaladorViewVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 10/11/24.
//

import SwiftUI

struct InstaladorViewVV: View {
    @Binding var currentThemeColor: ColorVariant
    @Binding var path: NavigationPath
    
    

    var body: some View {
        ZStack {
           
        }
    }

}

struct InstaladorView_Previews: PreviewProvider {
    @State static var themeColor = ColorPaletteVV.agua
    @State static var navigationPath = NavigationPath()
    @State static var photos: [UIImage] = [
        UIImage(systemName: "house.fill")!,
        UIImage(systemName: "camera.fill")!,
    ]

    static var previews: some View {
        InstaladorViewVV(
            currentThemeColor: $themeColor,
            path: $navigationPath
        )
        .previewLayout(.sizeThatFits)
    }
}
