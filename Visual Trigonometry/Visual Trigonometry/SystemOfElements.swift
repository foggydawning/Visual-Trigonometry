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
    
    var size: CGFloat
    var center: CGPoint {
        CGPoint(x: size/2, y: size/2)
    }
    
    /// Radius of the main circle
    private var mainRadiusLenght: CGFloat{
        size/2 - 2
    }
    
    var body: some View{
        ZStack{
            CoordunateSystem(size: size, center: center)
            Circle(radius: mainRadiusLenght, center: center)
                .stroke(lineWidth: 4)
            PointsOnMainCicrle(size: size, center: center).getView()
            if userAngle != nil{
                Circle(
                    radius: 20,
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
                    )
                Radius(
                    size: mainRadiusLenght,
                    userAngle: userAngle!,
                    helpsLineOpticaly: helpsLineOpticaly
                ).getRadiusView()
                
                // cosLine
                
                BasicLine(size: abs(cos(userAngle!.radians)*mainRadiusLenght),
                          width: 4)
                    .getLine()
                    .position(x: size/2 + abs(cos(userAngle!.radians))*mainRadiusLenght/2,
                              y: size/2)
                    .foregroundColor(Color.purple)
                    .opacity(helpsLineOpticaly)
                    .animation(
                        .spring()
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                    )
                    .rotationEffect(
                        (cos(userAngle!.radians)>=0) ? Angle(degrees: 0) : Angle(degrees: 180)
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
    var size: CGFloat
    var center: CGPoint
    var body: some View{
        ZStack{
            Arrow(size: size).getView().position(x: size-size*0.04, y: size/2)
            Arrow(size: size).getView()
                .rotationEffect(Angle(degrees: -90.0))
                .position(x: size/2, y: size*0.04)
            BasicLine(size: size).getLine().position(x: size/2, y: size/2)
            BasicLine(size: size).getLine()
                .position(x: size/2, y: size/2)
                .rotationEffect(Angle(degrees: 90.0))
        }
    }
}
