//
//  AcoruApp.swift
//  Acoru
//
//  Created by Pedro Prado on 18/09/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        // Asegúrate de obtener el clientID
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No se pudo obtener el clientID de Firebase")
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}

@main
struct AcoruApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authService = AuthService() // Cambiamos a AuthService
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authService)
//            CameraViewVV()
//                .ignoresSafeArea()
        }
    }
}
