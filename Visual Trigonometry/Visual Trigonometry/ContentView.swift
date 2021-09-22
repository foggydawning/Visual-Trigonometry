//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer(minLength: geometry.size.width*0.025)
                VStack(alignment: .center){
                    Spacer().frame(height: 25.0)
                    Trigonometry_view(size: geometry.size.width*0.95).background(Color.red)
                    Spacer(minLength: geometry.size.height - geometry.size.width*0.95 - 25.0)
                }
                Spacer(minLength: geometry.size.width*0.025)
            }
        }
        
    }
}

struct Trigonometry_view: View{
    var size: CGFloat
    var center: CGPoint {
        CGPoint(x: size/2, y: size/2)
    }
    var body: some View{
        ZStack{
            CoordunateSystem(size: size, center: center)
            Circle(radius: size/2, center: center)
                .stroke(lineWidth: 4)
                .fill(Color.black)
        }
    }
}

struct Circle: Shape {
    var radius: CGFloat
    var center: CGPoint
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        path.addArc(center: self.center, radius: self.radius,
                    startAngle: Angle(degrees: 0.0),
                    endAngle: Angle(degrees: 360.0),
                    clockwise: true)
        return path
    }
}

struct CoordunateSystem: View {
    var size: CGFloat
    var center: CGPoint
    var body: some View{
        ZStack{
            LineX(from: CGPoint(x: 0.0, y: size/2), to: CGPoint(x: size, y: size/2))
                .fill(Color.black)
            LineY(from: CGPoint(x: size/2, y: size), to: CGPoint(x: size/2, y: 0.0) )
                .fill(Color.black)
            Circle(radius: 5, center: center)
                .fill(Color.black)
            Arrow(size: size).getArrow().position(x: size-size*0.04, y: size/2)
            Arrow(size: size).getArrow()
                .rotationEffect(Angle(degrees: -90.0))
                .position(x: size/2, y: size*0.04)
        }
    }
}

class Arrow {
    var size: CGFloat
    
    init(size: CGFloat){
        self.size = size
    }
    
    var width: CGFloat {self.size*0.07}
    var height: CGFloat {self.size*0.04}
    
    func getArrow() -> some View{
        var path = Path()
        path.move(to: CGPoint(x: width, y: height/2))
        path.addLine(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: height))
        path.addLine(to: CGPoint(x: width, y: height/2))
        return path.frame(width: width, height: height)
    }
}

struct LineX: Shape {
    var from: CGPoint
    var to: CGPoint
    
    init(from: CGPoint, to: CGPoint){
        self.from = from
        self.to = to
    }
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: CGPoint(x: self.from.x, y: self.from.y-1.5))
        path.addLine(to: CGPoint(x: self.from.x, y: self.from.y+1.5))
        path.addLine(to: CGPoint(x: self.to.x, y: self.to.y+1.5))
        path.addLine(to: CGPoint(x: self.to.x, y: self.to.y-1.5))
        return path
    }
}

struct LineY: Shape {
    var from: CGPoint
    var to: CGPoint
    
    init(from: CGPoint, to: CGPoint){
        self.from = from
        self.to = to
    }
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: CGPoint(x: self.from.x-1.5, y: self.from.y))
        path.addLine(to: CGPoint(x: self.from.x+1.5, y: self.from.y))
        path.addLine(to: CGPoint(x: self.to.x+1.5, y: self.to.y))
        path.addLine(to: CGPoint(x: self.to.x-1.5, y: self.to.y))
        return path
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
