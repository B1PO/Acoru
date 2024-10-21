//
//  ContentView.swift
//  Acoru
//
//  Created by Pedro Prado on 18/09/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: GoogleSignInViewModel

    var body: some View {
        Group {
           
            if authViewModel.isAuthenticated {
                ViviendasViewVV()
            } else {
                LoginView()
            }
        }
        .onAppear {
            authViewModel.signOut()
            authViewModel.checkAuthentication()
        }
    }
}
