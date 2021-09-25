//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var userText: String = ""
    @State var mainButtonWasTapped: Bool = false
    
    let merginFromEdges = 0.05
    var widthOfWorkPlace: CGFloat {CGFloat((1 - 2*merginFromEdges)*UIScreen.main.bounds.width)}
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer(minLength: geometry.size.width*merginFromEdges)
                VStack(alignment: .center){
                    Spacer()
                    Trigonometry_view(
                        mainButtonWasTapped: $mainButtonWasTapped,
                        userAngle: Angle(degrees: Double("-\(userText)") ?? 0.0),
                        size: widthOfWorkPlace
                    )
                        .frame(height: widthOfWorkPlace)
                    Spacer()
                    HStack{
                        userTextField(userText: $userText)
                        mainButton(mainButtonWasTapped: $mainButtonWasTapped)
                    }
                    
                    Spacer()
                }
                Spacer(minLength: geometry.size.width*merginFromEdges)
            }
        }
    }
}


struct Trigonometry_view: View{
    @Binding var mainButtonWasTapped: Bool
    var userAngle: Angle
    var size: CGFloat
    var center: CGPoint {
        CGPoint(x: size/2, y: size/2)
    }
    var body: some View{
        ZStack{
            CoordunateSystem(size: size, center: center)
            Circle(radius: size/2-2, center: center)
                .stroke(lineWidth: 4)
            Points(size: size, center: center).getPoints()
            if mainButtonWasTapped == true{
                mainPoint(size: size, center: center, angle: userAngle).getPoint()
            }
        }
    }
}


class mainPoint{
    var size: CGFloat
    var center: CGPoint
    var angle: Angle
    
    init(size: CGFloat, center: CGPoint, angle: Angle){
        self.size = size
        self.center = center
        self.angle = angle
    }
    
    func getPoint() -> some View{
        Circle(
            radius: 7,
            center: CGPoint(
                        x: self.size-2,
                        y: self.size/2
                    )
        )   .rotationEffect(angle)
            .foregroundColor(.red)
    }
}


class Points{
    var size: CGFloat
    var center: CGPoint
    var angles: [Double]
    
    init(size: CGFloat, center: CGPoint){
        self.size = size
        self.center = center
        self.angles = []
    }
    
    func setAngles(){
        for angle in stride(from: 0.0, to: 331.0, by: 30.0){
            angles.append(angle)
        }
        for angle in stride(from: 45.0, to: 316.0, by: 90.0){
            angles.append(angle)
        }
    }
    
    func getPoints() -> some View{
        self.setAngles()
        let stack = ZStack{
            ForEach(angles, id: \.self) { angle in
                Circle(radius: 5, center: CGPoint(x: self.size-2, y: self.size/2))
                    .rotationEffect(Angle(degrees: angle))
            }
        }.opacity(0.6)
        return stack
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

class Line {
    var size: CGFloat
    init(size: CGFloat){
        self.size = size
    }
    func getLine() -> some View{
        var path = Path()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: size, y: 0))
        path.addLine(to: CGPoint(x: size, y: 3))
        path.addLine(to: CGPoint(x: 0, y: 3))
        return path.frame(width: size, height: 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct userTextField: View {
    @Binding var userText: String
    var body: some View {
        TextField("Input your angle here, bro", text: $userText)
            .multilineTextAlignment(.center)
            .accentColor(.black)
            .frame(alignment: .center)
            .padding(.all, 15)
            .background(Color.gray.opacity(0.4).cornerRadius(30))
            .foregroundColor(.white)
            .font(.headline)
            .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            .keyboardType(.numbersAndPunctuation)
    }
}

struct mainButton: View {
    @Binding var mainButtonWasTapped: Bool
    var body: some View {
        Button(action: {
            mainButtonWasTapped = true
        })  {
            Text("Gooo!")
                .fontWeight(.bold)
                .padding(14)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 3)
                )
        }
    }
}
