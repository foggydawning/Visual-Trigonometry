//
//  SystemOfElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI
import Foundation

struct TrigonometryView: View{
    @Binding var userAngle: Angle?
    @Binding var helpsLineOpticaly: Double
    
    var size: Double
    var center: CGPoint {
        CGPoint(x: size/2, y: size/2)
    }
    
    /// Radius of the main circle
    private var mainRadiusLenght: CGFloat{
        size/2 - 2
    }
    
    var body: some View{
        ZStack{
            CoordunateSystem(size: size)
            
            // mainCircle
            Circle(radius: mainRadiusLenght, center: center)
                .stroke(lineWidth: 5)
                .foregroundColor(Color("Forest"))
            
            //0, 30, 45, 90, 120, 135, 150, 180, ...
            PointsOnMainCicrle(lenghtOfRadius: size/2)
                .foregroundColor(Color("Forest"))
                .opacity(0.6)
            
            if userAngle != nil{
                
                // angle
                Circle(
                    radius: 17,
                    center: center,
                    end: Angle(
                        degrees: userAngle!
                            .degrees
                            .truncatingRemainder(dividingBy: 360.0)
                    )
                )
                    .stroke(lineWidth: 4)
                    .foregroundColor(Color("Lime"))
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                
                // radius
                Line(startPoint: center, lenght: size/2, width: 5)
                    .foregroundColor(Color("Stone Wall"))
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                    .rotationEffect(userAngle!)
                
                // cosLine
                Line(startPoint: center,
                     lenght: abs(cos(userAngle!.radians)*mainRadiusLenght),
                     width: 5)
                    .foregroundColor(Color("Biscotti"))
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                    .rotationEffect(
                        (cos(userAngle!.radians)>=0) ? .zero : .degrees(180)
                    )
                
                // sinLine
                Line(startPoint: .init(x: center.x + cos(userAngle!.radians)*mainRadiusLenght,
                                       y: center.y),
                     lenght: abs(sin(userAngle!.radians)*mainRadiusLenght),
                     width: 5.5)
                    
                    .foregroundColor(Color("Honey"))
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                    .rotationEffect(
                        (sin(userAngle!.radians)>=0) ? .degrees(90) : .degrees(270),
                        anchor: .init(x: (center.x + cos(userAngle!.radians)*mainRadiusLenght)/size,
                                          y: center.y/size)
                    )
                
                // mainPoint
                mainPoint()
                    .rotationEffect(userAngle!)
                    .foregroundColor(Color("Terracotta"))
                    .animation(.spring(response: 1.5), value: userAngle)
            }
            Circle(radius: 5, center: center)
                .fill(Color("Forest"))
        }.frame(height: size)
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
                .rotation(Angle(degrees: 90))
        }.foregroundColor(Color("Forest"))
    }
}


struct ErrorString: View {
    @EnvironmentObject var states: States
    var body: some View {
        HStack{
            Text(states.errorString)
                .fontWeight(.light)
                .foregroundColor(.red)
                .font(.footnote)
                .multilineTextAlignment(.trailing)
                .animation(.spring(), value: states.errorString)
            Spacer()
        }
    }
}


struct AngleTextFieldAndGoButton: View {
    @EnvironmentObject var states: States
    
    @Binding var handledUserInput: Angle?
    @Binding var helpsLineOpticaly: Double
    
    var body: some View {
        HStack{
            userTextField()
            GoButton(
                handledUserInput: $handledUserInput,
                helpsLineOpticaly: $helpsLineOpticaly
            )
        }
        
    }
}
