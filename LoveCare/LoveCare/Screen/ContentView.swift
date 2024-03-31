//
//  ContentView.swift
//  LoveCare
//
//  Created by Mohamed Kelany on 31/03/2024.
//

import SwiftUI

struct ContentView: View {
    //Properties
    @AppStorage("isOnBoarding") var isOnBoarding: Bool = true
    //Body
    var body: some View {
        if isOnBoarding {
            OnBoardingView()
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
