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
            Circle(radius: mainRadiusLenght, center: center)
                .stroke(lineWidth: 4)
            PointsOnMainCicrle(lenghtOfRadius: size/2)
                .opacity(0.6)
                
            if userAngle != nil{
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
                    .foregroundColor(.green)
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                
                // radius
                Line(startPoint: center, lenght: size/2, width: 4)
                    .foregroundColor(.blue)
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                    .rotationEffect(userAngle!)
                
                // sinLine
                Line(startPoint: .init(x: center.x + cos(userAngle!.radians)*mainRadiusLenght,
                                       y: center.y),
                     lenght: abs(sin(userAngle!.radians)*mainRadiusLenght),
                     width: 4)
                    
                    .foregroundColor(Color.red)
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
                    
                // cosLine
                Line(startPoint: center,
                     lenght: abs(cos(userAngle!.radians)*mainRadiusLenght),
                     width: 4)
                    .foregroundColor(Color.purple)
                    .opacity(helpsLineOpticaly)
                    .animation(
                            .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                        ,value: helpsLineOpticaly
                    )
                    .rotationEffect(
                        (cos(userAngle!.radians)>=0) ? .zero : .degrees(180)
                    )
                

                
                
                

                
                mainPoint(
                    size: size,
                    center: center,
                    angle: userAngle!
                )
                    .getView()
            }
            Circle(radius: 6, center: center)
                .fill(Color.black)
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
            Line(startPoint: CGPoint(x: 0, y: size/2), lenght: size)
            Line(startPoint: CGPoint(x: 0, y: size/2), lenght: size)
                .rotation(Angle(degrees: 90))
        }
    }
}
