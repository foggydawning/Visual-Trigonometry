//
//  SystemOfElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI
import Foundation

struct TrigonometryView: View{
    @EnvironmentObject var states: States
    
    var center: CGPoint {
        CGPoint(x: states.widthOfWorkSpace/2, y: states.widthOfWorkSpace/2)
    }
    
    /// Radius of the main circle
    private var mainRadiusLenght: CGFloat{
        states.widthOfWorkSpace/2 - 2
    }
    
    var trigonometricValues: [String: Double]? {
        guard let handledUserInput: Angle = states.handledUserInput else {
            return nil
        }
        return [ "cos" : cos(handledUserInput.radians),
                 "sin" : sin(handledUserInput.radians)]
    }
    
    var body: some View{
        VStack{
            Spacer().frame(maxHeight: 80)
            ZStack{
                CoordunateSystem(size: states.widthOfWorkSpace)
                
                // mainCircle
                Circle()
                    .stroke(lineWidth: 5)
                    .foregroundColor(Color("Forest"))

                //0, 30, 45, 90, 120, 135, 150, 180, ...
                PointsOnMainCicrle(lenghtOfRadius: states.widthOfWorkSpace/2)
                    .foregroundColor(Color("Forest"))
                    .opacity(0.6)

                if trigonometricValues != nil{
                    
                    // radisu
                    Line(startPoint: center, lenght: states.widthOfWorkSpace/2, width: 5)
                        .foregroundColor(Color("Stone Wall"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .rotationEffect(states.handledUserInput!)
                    
                    // sinLine
                    Line(startPoint: .init(x: center.x + trigonometricValues!["cos"]!*mainRadiusLenght,
                                           y: center.y),
                         lenght: abs(trigonometricValues!["sin"]!)*mainRadiusLenght,
                         width: 5.5)

                        .foregroundColor(Color("Honey"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .rotationEffect(
                            trigonometricValues!["sin"]! >= 0 ? .degrees(90) : .degrees(270),
                            anchor: .init(
                                x: (center.x + trigonometricValues!["cos"]!*mainRadiusLenght)/states.widthOfWorkSpace,
                                y: center.y/states.widthOfWorkSpace)
                        )

                    // cosLine
                    Line(startPoint: center,
                             lenght: abs(trigonometricValues!["cos"]!)*mainRadiusLenght+3.0,
                             width: 5)
                        .foregroundColor(Color("Biscotti"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .rotationEffect(
                            (trigonometricValues!["cos"]!>=0) ? .zero : .degrees(180)
                        )

                    
                    // angle
                    MainAngle(
                        radius: 17,
                        center: center,
                        end: Angle(
                            degrees: states.handledUserInput!
                                .degrees
                                .truncatingRemainder(dividingBy: 360.0)
                        )
                    )
                        .stroke(lineWidth: 4)
                        .foregroundColor(Color("Lime"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                    
                    // Help Mode
                    if states.helpModeIsActive{
                        HelpModeView(mainRadiusLenght: mainRadiusLenght,
                                     center: center,
                                     trigonometricValues: trigonometricValues)
                    }
                    
                    // mainPoint
                    mainPoint()
                        .rotationEffect(states.handledUserInput!)
                        .foregroundColor(Color("Terracotta"))
                        .animation(.spring(response: 1.5), value: states.handledUserInput)
                }
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color("Forest"))
                
            }.frame(height: states.widthOfWorkSpace)
            Spacer()
        }
        
        
        
    }
    
    var animation: Animation{
        Animation
            .spring(response: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
            .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7)
    }
}


struct CoordunateSystem: View {
    var size: Double
    var body: some View{
        ZStack{
            Arrow(size: size, endPoint: CGPoint(x: size, y: size/2))
            Arrow(size: size, endPoint: CGPoint(x: size, y: size/2))
                .rotationEffect(Angle(degrees: -90))
            Line(startPoint: CGPoint(x: 0, y: size/2), lenght: size, width: 4)
            Line(startPoint: CGPoint(x: 0, y: size/2), lenght: size, width: 4)
                .frame(width: size, height: size)
                .rotationEffect(.degrees(90))
        }.foregroundColor(Color("Forest"))
    }
}


struct ErrorString: View {
    @EnvironmentObject var states: States
    var body: some View {
        if states.errorString != ""{
            HStack{
                Text(states.errorString)
                    .fontWeight(.light)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.trailing)
                    .animation(.spring(), value: states.errorString)
                Spacer()
            }.transition(.scale)
        }
    }
}


struct AngleTextFieldAndGoButton: View {
    var body: some View {
        HStack{
            userTextField()
            GoButton()
        }
        
    }
}


struct TrigonometricValues: View {
    @EnvironmentObject var states: States
    var body: some View{
        if states.showTrigonometryValues{
            GeometryReader{geometry in
                ZStack{
                    HStack{
                        Spacer(minLength: 5)
                        TrigonometricFuncAndValue("Sin")
                        Spacer(minLength: 20)
                        TrigonometricFuncAndValue("Cos")
                        Spacer(minLength: 20)
                        TrigonometricFuncAndValue("Tg")
                        Spacer(minLength: 20)
                        TrigonometricFuncAndValue("Ctg")
                        Spacer(minLength: 5)
                    }
                }
            }
            .frame(height: 40)
            .padding(14)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("Pine"), lineWidth: 4)
                )
            .transition(.opacity)
        }
    }
}
