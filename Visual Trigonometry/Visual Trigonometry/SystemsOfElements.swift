//
//  SystemOfElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI

struct TrigonometryView: View{
    @EnvironmentObject var states: States
    
    var center: CGPoint {
        CGPoint(x: states.widthOfWorkSpace/2, y: states.widthOfWorkSpace/2)
    }
    
    /// Radius of the main circle
    private var mainRadiusLenght: CGFloat{
        states.widthOfWorkSpace/2
    }
    
    var trigonometricValues: [String: Double]? {
        guard let handledUserInput: Angle = states.handledUserInput else {
            return nil
        }
        return  ["cos" : cos(handledUserInput.radians),
                 "sin" : sin(handledUserInput.radians)]
    }
    
    var body: some View{
        VStack{
            Spacer().frame(maxHeight: UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width == 16/9 ? 40 : 80 )
            ZStack{
                
                // mainCircle
                Circle()
                    .stroke(lineWidth: 10)
                    .foregroundColor(Color("Stone Wall"))
                    .shadow(radius: 1.5)
                
                CoordunateSystem(size: states.widthOfWorkSpace)

                //0, 30, 45, 90, 120, 135, 150, 180, ...
                PointsOnMainCicrle(lenghtOfRadius: states.widthOfWorkSpace/2)
                    .foregroundColor(Color("Forest"))
                    .opacity(0.6)
                    .shadow(color: Color.black.opacity(0.5), radius: 4, x: -3, y: 3)

                if states.helpModeIsActive{
                    LinesOnCoordinateSystem(size: states.widthOfWorkSpace)
                }
                
                if trigonometricValues != nil{
                    let trigonometricValues = trigonometricValues!
                    
                    // radius
                    Rectangle()
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .frame(width: mainRadiusLenght, height: 6)
                        .cornerRadius(30)
                        .position(x: center.x + mainRadiusLenght/2,
                                  y: center.y)
                        .rotationEffect(states.handledUserInput!)
                        .foregroundColor(Color("Stone Wall"))
                        .shadow(radius: 1.5)
                    
                    // sinLine
                    Rectangle()
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .frame(width: 8, height: abs(trigonometricValues["sin"]!)*mainRadiusLenght)
                        .cornerRadius(30)
                        .position(x: center.x + (trigonometricValues["cos"]!*mainRadiusLenght),
                                  y: center.y - abs(trigonometricValues["sin"]!)*mainRadiusLenght/2)
                        .rotationEffect(
                            trigonometricValues["sin"]! >= 0 ? .degrees(180) : .degrees(0),
                            anchor: .init(
                                x: (center.x + trigonometricValues["cos"]!*mainRadiusLenght)/states.widthOfWorkSpace,
                                y: center.y/states.widthOfWorkSpace)
                        )
                        .foregroundColor(Color("Honey"))
                        .shadow(radius: 1.5)
                    
                    
                    // cosLine
                    Rectangle()
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        
                        .frame(width: abs(trigonometricValues["cos"]!)*mainRadiusLenght+6, height: 8)
                        .cornerRadius(30)
                        .position(x: center.x+(abs(trigonometricValues["cos"]!)*mainRadiusLenght)/2, y: center.y)
                        
                        .foregroundColor(Color("Biscotti"))
                        .rotationEffect(
                            (trigonometricValues["cos"]!>=0) ? .zero : .degrees(180)
                        )
                        .shadow(radius: 1.5)

                    
                    // angle
                    MainAngle(
                        radius: 30,
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
                        .shadow(color: .black.opacity(0.5), radius: 1.5)
                    
                    // Help Mode
                    if states.helpModeIsActive{
                        HelpModeView(mainRadiusLenght: mainRadiusLenght,
                                     center: center,
                                     trigonometricValues: trigonometricValues)
                    }
                    
                    // mainPoint
                    Circle()
                        .frame(width: 24, height: 24)
                        .position(x: center.x+mainRadiusLenght, y: center.y)
                        .rotationEffect(states.handledUserInput!)
                        .foregroundColor(Color("Terracotta"))
                        .animation(.spring(response: 1.5), value: states.handledUserInput)
                        .shadow(color: .gray.opacity(0.4), radius: 1, x: -1, y: 2)
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
    var lineWidth: Double = 9
    let degrees: [Double] = [0,-90]
    var body: some View{
        ForEach(degrees, id: \.self){ degree in
            ZStack{
                Rectangle()
                    .frame(width: size-25, height: lineWidth)
                    .cornerRadius(30)
                    .position(x: size/2, y: size/2)
                    .shadow(radius: 1.5)
                    .rotationEffect(.degrees(degree))
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Arrow(size: size)
                            .frame(width: size*0.10, height: size*0.065)
                            .cornerRadius(300)
                    }
                    Spacer()
                }.rotationEffect(.degrees(degree))
            }
        }
        .foregroundColor(Color("Forest"))
        .shadow(color: .black.opacity(0.5), radius: 5, x: -2, y: 3)
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


struct TrigonometricValuesView: View {
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
                    .stroke(Color("Pine"), lineWidth: 5)
                )
            .transition(.opacity)
            .shadow(radius: 1.5)
        }
    }
}
