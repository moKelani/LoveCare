//
//  HomeView.swift
//  LoveCare
//
//  Created by Mohamed Kelany on 31/03/2024.
//

import SwiftUI

struct HomeView: View {
    //Properties
    @AppStorage("isOnBoarding") var isOnBoarding: Bool = true
    @State var isAnimating: Bool = false
    let feedback = UINotificationFeedbackGenerator()
    //Body
    var body: some View {
        VStack(alignment: .center, spacing: 50) {
            //MARK: - Header
            ZStack {
                CircleGroupView(circleGroupColor: .gray)
                Image("baby-boy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, alignment: .center)
                    .offset(y: isAnimating == true ? 30 : -30)
                    .animation(.easeOut(duration: 2.5).repeatForever(autoreverses: true), value: isAnimating)
            }//: ZStack
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                    isAnimating.toggle()
                }
            }
            //MARK: - Center
            Text("Having children just puts the whole world into perspective. Everything else just disappears")
                .padding()
                .multilineTextAlignment(.center)
                .font(.title3)
                .foregroundColor(.gray)
            //MARK: - Footer
            Button {
                isOnBoarding.toggle()
                playSound(soundFile: "success", soundType: "m4a")
                feedback.notificationOccurred(.success)
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(size: 25,design: .rounded))
                    .fontWeight(.bold)
            }//: Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }//: VStack
        
    }
}

#Preview {
    HomeView()
}
