//
//  OnBoardingView.swift
//  LoveCare
//
//  Created by Mohamed Kelany on 31/03/2024.
//

import SwiftUI

struct OnBoardingView: View {
    //Properties
    @AppStorage("isOnBoarding") var isOnBoarding: Bool = true
    @State var isAnimating: Bool = false
    @State var imageOffset: CGSize = CGSize(width: 0.0, height: 0.0)
    @State var buttonOffset: CGFloat = 0.0
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 80
    let feedback = UINotificationFeedbackGenerator()
    //Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            
            VStack {
                //MARK: - Header
                VStack {
                    Text(abs(imageOffset.width) > 0 ? "Care." : "Love.")
                        .font(.system(size: 60.0))
                        .fontWeight(.heavy)
                        .foregroundStyle(.white)
                    
                    Text("Life doesn't come with a manual, it comes with a mother")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                }//:VStack
                .offset(y: isAnimating == true ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                Spacer()
                //MARK: - Center
                ZStack {
                    CircleGroupView(circleGroupColor: .white)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width)/5, opaque: false)
                    Image("happy-pregnant")
                        .resizable()
                        .scaledToFit()
                        .offset(x: imageOffset.width, y: 0)
                        .scaleEffect(isAnimating ? 1.0 : 0.8)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .rotationEffect(.degrees(imageOffset.width / 15))
                        .shadow(color: .black.opacity(0.5), radius: 8, x: 3, y: 30)
                        .overlay (
                            Image(systemName: "arrow.left.and.right.circle")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .opacity(abs(imageOffset.width) > 0 ? 0 : 1)
                            , alignment: .bottom
                        )
                        .frame(width: 300, alignment: .center)
                        .gesture(DragGesture()
                            .onChanged({ gesture in
                                if abs(gesture.translation.width) <= 150 {
                                    imageOffset =  gesture.translation
                                }
                            })
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        imageOffset = CGSize(width: 0.0, height: 0.0)
                                    }
                                    
                                })
                        )
                }//: ZStack
                Spacer()
                //MARK: - Footer
                ZStack {
                    //1. Background
                    Capsule()
                        .fill(.white.opacity(0.2))
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8.0)
                    //2. Text
                    Text("Start")
                        .font(.system(size: 30,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    //3. capsule Circle
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80 + buttonOffset)
                        Spacer()
                    }//: HStack (end of capsule Circle)
                    
                    //4. Dragat Circle
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.2))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                        }//: ZStack (end of Dragat Circle)
                        .frame(width: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(DragGesture()
                            .onChanged({ gesture in
                                if gesture.translation.width >= 0.0 && buttonOffset <= buttonWidth - 80 {
                                    buttonOffset = gesture.translation.width
                                }
                            })
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        if buttonOffset >= buttonWidth/2 {
                                            isOnBoarding = false
                                            playSound(soundFile: "chimeup", soundType: "mp3")
                                            feedback.notificationOccurred(.success)
                                        } else {
                                            buttonOffset = 0.0
                                            feedback.notificationOccurred(.error)
                                        }
                                    }
                                })
                        )
                        Spacer()
                    }//: HStack (end of Dragat Circle)
                    
                    
                }//ZStack (end of Footer)
                .frame(height: 80, alignment: .center)
                .padding(.horizontal, 40)
                .offset(y: isAnimating == true ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
            }//VStack
        }//ZStack
        .onAppear{
            isAnimating.toggle()
        }
        
        
        
    }
}

#Preview {
    OnBoardingView()
}
