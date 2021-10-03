//
//  SimpleElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI

class BasicPoint{
    var size: CGFloat
    var center: CGPoint
    
    init(size: CGFloat, center: CGPoint){
        self.size = size
        self.center = center
    }
}

class PointsOnMainCicrle: BasicPoint{
    var angles: [Double]
    
    override init(size: CGFloat, center: CGPoint){
        self.angles = []
        super.init(size: size, center: center)
    }
    
    func setAngles(){
        for angle in stride(from: 0.0, to: 331.0, by: 30.0){
            angles.append(angle)
        }
        for angle in stride(from: 45.0, to: 316.0, by: 90.0){
            angles.append(angle)
        }
    }
    
    func getView() -> some View {
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

class mainPoint: BasicPoint{
    var angle: Angle
    
    init(size: CGFloat, center: CGPoint, angle: Angle){
        self.angle = angle
        super.init(size: size, center: center)
    }
    
    func getView() -> some View{
        Circle(
            radius: 7,
            center: CGPoint(
                        x: self.size-2,
                        y: self.size/2
                    )
        )   .rotationEffect(angle)
            .foregroundColor(.red)
            .animation(.spring(response: 1.5))
    }
}


struct Circle: Shape {
    var radius: CGFloat
    var center: CGPoint
    var start: Angle = Angle(degrees: 0)
    var end: Angle = Angle(degrees: 360)
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        path.addArc(center: self.center, radius: self.radius,
                    startAngle: start,
                    endAngle: end,
                    clockwise: (end.degrees >= 0) ? false : true )
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
    
    func getView() -> some View{
        var path = Path()
        path.move(to: CGPoint(x: width, y: height/2))
        path.addLine(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: height))
        path.addLine(to: CGPoint(x: width, y: height/2))
        return path.frame(width: width, height: height)
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
            .lineLimit(1)
            .keyboardType(.numbersAndPunctuation)
    }
}


class BasicLine {
    var width: CGFloat
    var size: CGFloat
    init(size: CGFloat, width: CGFloat = 3){
        self.size = size
        self.width = width
    }
    func getLine() -> some View{
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.size, y: 0))
        path.addLine(to: CGPoint(x: self.size, y: self.width))
        path.addLine(to: CGPoint(x: 0, y: self.width))
        return path.frame(width: self.size, height: self.width)
    }
}

class Radius: BasicLine {
    var userAngle: Angle
    var helpsLineOpticaly: Double
    
    init(size: CGFloat, userAngle: Angle, helpsLineOpticaly: Double){
        self.userAngle = userAngle
        self.helpsLineOpticaly = helpsLineOpticaly
        super.init(size: size, width: 3.25)
    }
    
    func getRadiusView() -> some View {
        let view: some View = super.getLine()
        let radiusView: some View = view
            .position(x: self.size*1.5, y: self.size+2)
            .foregroundColor(.blue)
            .opacity(self.helpsLineOpticaly)
            .animation(
                .spring(response: (self.helpsLineOpticaly == 0) ? 0 : 1.5)
                    .delay((self.helpsLineOpticaly == 0) ? 0 : 1.7)
            )
            .rotationEffect(self.userAngle)
        return radiusView
    }
}


struct mainButton: View {
    
    @Binding var handledUserInput: Angle?
    @Binding var userText: String
    @Binding var errorString: String
    @Binding var helpsLineOpticaly: Double
    
    var body: some View {
        Button(action: {
            
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
        .simultaneousGesture(
        DragGesture(minimumDistance: 0)
            .onChanged({ _ in
                helpsLineOpticaly = 0
                handledUserInput = Angle(degrees: 0)
            })
            .onEnded({ _ in
                let handler = Handler(userText: userText)
                handler.handle()
                handledUserInput = handler.handledUserInput
                errorString = handler.errorString
                helpsLineOpticaly = 1
            })
        )
    }
}
