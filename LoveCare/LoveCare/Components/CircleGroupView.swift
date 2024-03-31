//
//  CircleGroupView.swift
//  LoveCare
//
//  Created by Mohamed Kelany on 31/03/2024.
//

import SwiftUI

struct CircleGroupView: View {
    var circleGroupColor: Color = .red
    
    @State var isAnimating: Bool = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(circleGroupColor.opacity(0.2), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(circleGroupColor.opacity(0.2), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }//:ZStack
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeInOut(duration: 1), value: isAnimating)
        .onAppear{
            isAnimating.toggle()
        }
    }
}

#Preview {
    CircleGroupView()
}
