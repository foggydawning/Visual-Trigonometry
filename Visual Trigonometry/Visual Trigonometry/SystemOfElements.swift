//
//  SystemOfElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI

struct TrigonometryView: View{
    @Binding var userAngle: Angle?
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
                mainPoint(size: size, center: center, angle: userAngle!).getView().animation(.spring(response: 1.5))
            } 
        }
    }
}


struct CoordunateSystem: View {
    var size: CGFloat
    var center: CGPoint
    var body: some View{
        ZStack{
            Circle(radius: 6, center: center)
                .fill(Color.black)
            Arrow(size: size).getArrow().position(x: size-size*0.04, y: size/2)
            Arrow(size: size).getArrow()
                .rotationEffect(Angle(degrees: -90.0))
                .position(x: size/2, y: size*0.04)
            Line(size: size).getLine().position(x: size/2, y: size/2)
            Line(size: size).getLine()
                .rotationEffect(Angle(degrees: 90.0))
                .position(x: size/2, y: size/2)
        }
    }
}
