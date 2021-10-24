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
    
    var body: some View{
        VStack{
            Spacer().frame(maxHeight: 80)
            ZStack{
                CoordunateSystem(size: states.widthOfWorkSpace)
                
                // mainCircle
                Circle(radius: mainRadiusLenght, center: center)
                    .stroke(lineWidth: 5)
                    .foregroundColor(Color("Forest"))
                
                //0, 30, 45, 90, 120, 135, 150, 180, ...
                PointsOnMainCicrle(lenghtOfRadius: states.widthOfWorkSpace/2)
                    .foregroundColor(Color("Forest"))
                    .opacity(0.6)
                
                if states.handledUserInput != nil{

                    // Help Mode
                    if states.helpModeIsActive{
                        ZStack{
                            // 1 text
                            HStack(alignment: .top){
                                    Spacer()
                                        .padding()
                                        .frame(maxWidth: states.widthOfWorkSpace/2)
                                    Text("1")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Stone Wall"))
                            }
                                .padding(.bottom)
                                .rotationEffect(states.handledUserInput!)

                            // cos text
                            HStack(alignment: .top){
                                    Spacer()
                                        .padding()
                                    .frame(maxWidth: abs(cos(states.handledUserInput!.radians)*mainRadiusLenght)+3.0)
                                Text("cos")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Biscotti"))
                            }
                                .padding(.bottom)
                                .rotationEffect(
                                    (cos(states.handledUserInput!.radians)>=0) ? .zero : .degrees(180)
                                )
                        }
                        .opacity(states.helpsLineOpticaly)
                    }
                    
                    // radisu
                    Line(startPoint: center, lenght: states.widthOfWorkSpace/2, width: 5)
                        .foregroundColor(Color("Stone Wall"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(
                                .spring(response: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
                                .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7),
                                value: states.helpsLineOpticaly
                        )
                        .rotationEffect(states.handledUserInput!)
                    
                    // sinLine
                    Line(startPoint: .init(x: center.x + cos(states.handledUserInput!.radians)*mainRadiusLenght,
                                           y: center.y),
                         lenght: abs(sin(states.handledUserInput!.radians)*mainRadiusLenght),
                         width: 5.5)
                        
                        .foregroundColor(Color("Honey"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(
                                .spring(response: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
                                .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7)
                            ,value: states.helpsLineOpticaly
                        )
                        .rotationEffect(
                            (sin(states.handledUserInput!.radians)>=0) ? .degrees(90) : .degrees(270),
                            anchor: .init(
                                x: (center.x + cos(states.handledUserInput!.radians)*mainRadiusLenght)/states.widthOfWorkSpace,
                                y: center.y/states.widthOfWorkSpace)
                        )
                    
                    // cosLine
                    Line(startPoint: center,
                             lenght: abs(cos(states.handledUserInput!.radians)*mainRadiusLenght)+3.0,
                             width: 5)
                        .foregroundColor(Color("Biscotti"))
                        .opacity(states.helpsLineOpticaly)
                        .animation(
                                .spring(response: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
                                .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7),
                                    value: states.helpsLineOpticaly
                        )
                        .rotationEffect(
                            (cos(states.handledUserInput!.radians)>=0) ? .zero : .degrees(180)
                        )
                    
                    
                    // angle
                    Circle(
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
                        .animation(
                                .spring(response: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
                                .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7)
                            ,value: states.helpsLineOpticaly
                        )
                    
                    
                    // mainPoint
                    mainPoint()
                        .rotationEffect(states.handledUserInput!)
                        .foregroundColor(Color("Terracotta"))
                        .animation(.spring(response: 1.5), value: states.handledUserInput)
                }
                Circle(radius: 5, center: center)
                    .fill(Color("Forest"))
            }.frame(height: states.widthOfWorkSpace)
            Spacer()
        }
        
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
                .rotation(.degrees(90))
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
    @EnvironmentObject var states: States
    
    var body: some View {
        HStack{
            userTextField()
            GoButton(
                handledUserInput: $states.handledUserInput,
                helpsLineOpticaly: $states.helpsLineOpticaly)
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
