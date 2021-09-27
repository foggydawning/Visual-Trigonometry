//
//  SystemOfElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI

struct TrigonometryView: View{
    @Binding var userAngle: Angle?
    @Binding var helpsLineOpticaly: Double
    
    var size: CGFloat
    var center: CGPoint {
        CGPoint(x: size/2, y: size/2)
    }
    
    var body: some View{
        ZStack{
            CoordunateSystem(size: size, center: center)
            Circle(radius: size/2-2, center: center)
                .stroke(lineWidth: 4)
            PointsOnMainCicrle(size: size, center: center).getView()
            if userAngle != nil{
                Radius(
                    size: size,
                    userAngle: userAngle!,
                    helpsLineOpticaly: helpsLineOpticaly
                ).getRadiusView()
                    
                mainPoint(
                    size: size,
                    center: center,
                    angle: userAngle!
                )
                    .getView()
                
                Circle(
                    radius: 20,
                    center: center,
                    end: Angle(
                        degrees: userAngle!
                            .degrees
                            .truncatingRemainder(dividingBy: 360.0)
                    )
                )
                    .stroke(lineWidth: 4.5)
                    .foregroundColor(.green)
                    .opacity(helpsLineOpticaly)
                    .animation(
                        .spring(response: (helpsLineOpticaly == 0) ? 0 : 1.5)
                            .delay((helpsLineOpticaly == 0) ? 0 : 1.7)
                    )
                    
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
                .rotationEffect(Angle(degrees: 90.0))
                .position(x: size/2, y: size/2)
        }
    }
}
