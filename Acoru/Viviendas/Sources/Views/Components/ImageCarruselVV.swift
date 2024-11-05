//
//  ImageCarruselVV.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 04/11/24.
//
import SwiftUI

struct ImageCarouselView: View {
    @Binding var capturedPhotos: [UIImage]
    @Binding var currentIndex: Int

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentIndex) {
                ForEach(0..<capturedPhotos.count, id: \.self) { index in
                    ZStack {
                        Color(index % 2 == 0 ? .blue : .red)
                        Image(uiImage: capturedPhotos[index])
                            .resizable()
                            .scaledToFill()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .clipped()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .clipShape(RoundedRectangle(cornerRadius: 15))

            HStack(spacing: 8) {
                ForEach(0..<capturedPhotos.count, id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.black : Color.gray)
                        .frame(width: 20, height: 20)
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
