//
//  CameraViewvv.swift
//  Acoru
//
//  Created by Jose Alejandro Perez Chavez on 29/10/24.
//

import SwiftUI

struct CameraViewVV: View {

    @State private var isNotification: Bool = false
    @State private var descriptionNotification: String =
        "Toma las fotos necesarias de tu instalación"

    var UISW: CGFloat = UIScreen.main.bounds.width
    var UISH: CGFloat = UIScreen.main.bounds.height

    @Binding var path: NavigationPath
    @Binding var capturedPhotos: [UIImage]

    var body: some View {
        ZStack(alignment: .topLeading) {
            CameraControllerVV(capturedPhotos: $capturedPhotos)
            VStack(alignment: .trailing, spacing: 40) {
                // Flecha de regreso
                HStack {
                    Button(
                        action: {
                            path.removeLast()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 20)

                        }
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                // Scroll vertical en el lado izquierdo para mostrar las fotos en landscape
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(capturedPhotos, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 250, height: 200)  // Tamaño fijo para landscape
                                .rotationEffect(.degrees(-90))  // Rotación para mostrar en landscape
                        }
                    }
                }

            }
            .padding(.top, 10)
            .frame(
                maxWidth: .infinity, maxHeight: .infinity)
            NotificationWidget(
                descriptionText: descriptionNotification,
                isVisible: $isNotification

            )
            .position(x: UISW * 0.75, y: UISH * 0.17)
        }
        .onChange(of: capturedPhotos) {
            // Oculta la notificación cuando se agrega una nueva foto
            if !capturedPhotos.isEmpty {
                isNotification = false
                descriptionNotification =
                    "Listo! Agregaste una foto, puedes regresar y evaluarlas"
                isNotification.toggle()

            }

        }

        .task {
            // Espera 0.3 segundos antes de mostrar la notificación
            try? await Task.sleep(nanoseconds: 300_000_000)  // 0.3 segundos en nanosegundos
            isNotification = true

            // Puedes agregar otras acciones aquí si las necesitas
            // capturedPhotos.append(UIImage(systemName: "house.fill")!)
            // capturedPhotos.append(UIImage(systemName: "camera.fill")!)
        }

        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.all)

    }
}
