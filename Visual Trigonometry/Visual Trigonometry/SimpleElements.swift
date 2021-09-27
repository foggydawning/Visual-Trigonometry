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


struct mainButton: View {
    
    @Binding var handledUserInput: Angle?
    @Binding var userText: String
    @Binding var errorString: String
    
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
                handledUserInput = Angle(degrees: 0)
            })
            .onEnded({ _ in
                let handler = Handler(userText: userText)
                handler.handle()
                handledUserInput = handler.handledUserInput
                errorString = handler.errorString
            })
        )
    }
}
