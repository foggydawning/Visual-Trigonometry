//
//  HelpModeView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 24.10.2021.
//

import SwiftUI

struct HelpModeView: View{
    @EnvironmentObject var states: States
    
    var mainRadiusLenght: CGFloat
    var center: CGPoint
    var trigonometricValues: [String: Double]?
    
    var body: some View{
        if trigonometricValues != nil{
            ZStack{
                // 1 text
                HStack(){
                    Spacer()
                        .frame(maxWidth: states.widthOfWorkSpace/2)
                    Text("1")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Stone Wall"))
                        .padding(.bottom, 25.0)
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .rotationEffect( trigonometricValues!["cos"]! > 0 ? .zero : .degrees(180))
                }
                .rotationEffect(states.handledUserInput ?? .degrees(0))

                // cos text
                HStack{
                    Spacer()
                        .frame(maxWidth: abs(trigonometricValues!["cos"]!)*mainRadiusLenght+3.0)
                    Text("cos")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Biscotti"))
                        .padding(.bottom, 25.0)
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .animation(.easeInOut.delay(1), value: states.helpModeIsActive)
                        .rotationEffect(trigonometricValues!["cos"]! > 0 ? .zero : .degrees(180))
                }
                .rotationEffect(
                    trigonometricValues!["cos"]! > 0 ? .zero : .degrees(180)
                )
                
                // sin text
                VStack{
                    HStack{
                        if trigonometricValues!["sin"]! * trigonometricValues!["cos"]! >= 0{
                            Spacer()
                               .frame(maxWidth: abs(trigonometricValues!["sin"]!)*mainRadiusLenght)
                        }
                        Text("sin")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Honey"))
                            .padding(.bottom, 25.0)
                            .opacity(states.helpsLineOpticaly)
                            .animation(animation, value: states.helpsLineOpticaly)
                            .animation(.easeInOut.delay(1), value: states.helpModeIsActive)
                            .rotationEffect(.zero)
                        if trigonometricValues!["sin"]! * trigonometricValues!["cos"]! < 0{
                            Spacer()
                               .frame(maxWidth: abs(trigonometricValues!["sin"]!)*mainRadiusLenght)
                        }
                    }
                    Spacer()
                       .frame(maxHeight: 2*abs(trigonometricValues!["cos"]!)*mainRadiusLenght+3.0)
                }
                .rotationEffect(
                    trigonometricValues!["cos"]! >= 0 ? .degrees(90) : .degrees(270)
                )
            }
        }
    }
    var animation: Animation{
        Animation
            .easeInOut(duration: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
            .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7)
    }
}

struct LinesOnCoordinateSystem: View {
    var size: Double
    var body: some View{
        ZStack{
            ZStack{
                Line(startPoint: CGPoint(x: size*3/4, y: size/2), lenght: 2.5, width: 10)
                    .frame(width: size, height: size)
                Line(startPoint: CGPoint(x: size/2+size*(pow(2, 0.5))/4.0, y: size/2), lenght: 2.5, width: 14)
                    .frame(width: size, height: size)
            }

            ZStack{
                Line(startPoint: CGPoint(x: size*3/4, y: size/2), lenght: 2.5, width: 10)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(90))
                Line(startPoint: CGPoint(x: size/2+size*(pow(2, 0.5))/4.0, y: size/2), lenght: 2.5, width: 14)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(90))
                Line(startPoint: CGPoint(x: size/2+size*(pow(3, 0.5))/4.0, y: size/2), lenght: 2.5, width: 14)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(90))
            }
          
            ZStack{
                Line(startPoint: CGPoint(x: size*3/4, y: size/2), lenght: 2.5, width: 10)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(180))
                Line(startPoint: CGPoint(x: size/2+size*(pow(2, 0.5))/4.0, y: size/2), lenght: 2.5, width: 14)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(180))
                Line(startPoint: CGPoint(x: size/2+size*(pow(3, 0.5))/4.0, y: size/2), lenght: 2.5, width: 14)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(180))
            }
            ZStack{
                Line(startPoint: CGPoint(x: size*3/4, y: size/2), lenght: 2.5, width: 10)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(270))
                Line(startPoint: CGPoint(x: size/2+size*(pow(2, 0.5))/4.0, y: size/2), lenght: 2.5, width: 14)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(270))
            }
        }
    }
}
