//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    let spacer_20 = Spacer(minLength: UIScreen.main.bounds.height/20)
    
    var body: some View {
        HStack{
            Spacer(minLength: 15)
            VStack(alignment: .center){
                Spacer().frame(height: 25.0)
                ZStack{
                    Trigonometry_view()
                }
                Spacer()
            }
            Spacer(minLength: 15)
        }
    }
}

struct Trigonometry_view: View{
    var width: CGFloat = UIScreen.main.bounds.width - 30
    var height: CGFloat {
        width
    }
    var center: CGPoint {
        CGPoint(x: width/2, y: height/2)
    }
    
    var body: some View{
        ZStack{
            CoordunateSystem(width: width, center: center)
            Circle(radius: width/2, center: center)
                .stroke(lineWidth: 4)
                .frame(alignment: .center)
                .frame(width: width, height: height, alignment: .center)
        }
    }
}

struct Circle: Shape {
    var radius: CGFloat
    var center: CGPoint
    
    init(radius: CGFloat, center: CGPoint){
        self.radius = radius
        self.center = center
    }
    
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
    var width: CGFloat
    var center: CGPoint
    var body: some View{
        ZStack{
            LineX(from: CGPoint(x: 0.0, y: width/2), to: CGPoint(x: width, y: width/2) )
                .frame(width: width, height: width, alignment: .center)
            LineY(from: CGPoint(x: width/2, y: width), to: CGPoint(x: width/2, y: 0.0) )
                .frame(width: width, height: width)
            Circle(radius: 5, center: center)
                .frame(width: width, height: width)
            ArrowX(width: width)
                    .frame(width: width, height: width)
            ArrowY(width: width)
                        .frame(width: width, height: width)
        }
    }
}

struct ArrowX: Shape {
    var width: CGFloat
    var endPoint: CGPoint {CGPoint(x: width, y: width/2)}
    
    init(width: CGFloat){
        self.width = width
    }
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: endPoint)
        path.addLine(to: CGPoint(x: path.currentPoint!.x-20.0, y: path.currentPoint!.y-7.0))
        path.addLine(to: CGPoint(x: path.currentPoint!.x, y: path.currentPoint!.y+14.0))
        path.addLine(to: endPoint)
        return path
    }
}

struct ArrowY: Shape {
    var width: CGFloat
    var endPoint: CGPoint {CGPoint(x: width/2, y: 0.0)}
    
    init(width: CGFloat){
        self.width = width
    }
    func path(in rect: CGRect) -> Path{
        var path = Path()
        path.move(to: endPoint)
        path.addLine(to: CGPoint(x: path.currentPoint!.x-7.0, y: path.currentPoint!.y+20.0))
        path.addLine(to: CGPoint(x: path.currentPoint!.x+14.0, y: path.currentPoint!.y))
        path.addLine(to: endPoint)
        return path
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
