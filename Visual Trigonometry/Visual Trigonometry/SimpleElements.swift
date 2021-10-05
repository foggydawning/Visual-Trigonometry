//
//  SimpleElements.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI
import Foundation

class BasicPoint{
    var size: CGFloat
    var center: CGPoint
    
    init(size: CGFloat, center: CGPoint){
        self.size = size
        self.center = center
    }
}

struct PointsOnMainCicrle: Shape{
     
    let lenghtOfRadius: Double
    var angles: [Double] = { () -> [Double] in
        var list : [Double] = []
        for angle in stride(from: 0.0, to: 331.0, by: 30.0){
            list.append(angle)
        }
        for angle in stride(from: 45.0, to: 316.0, by: 90.0){
            list.append(angle)
        }
        return list
    }()
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius: Double  = 6
        for angleInDegrees in self.angles{
            let angleInRadians : Double = Angle(degrees: angleInDegrees).radians
            let x: Double = rect.midX + cos(angleInRadians)*lenghtOfRadius
            let y: Double = rect.midY + sin(angleInRadians)*lenghtOfRadius
            let centre : CGPoint = .init(x: x, y: y)
            let startPoint : CGPoint = .init(x: x + radius, y: y)
            
            path.move(to: startPoint)
            path.addArc(center: centre,
                        radius: radius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360),
                        clockwise: false)
            path.closeSubpath()
        }
        return path
    }
}


struct mainPoint: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.maxX, y: rect.midY),
                    radius: 7,
                    startAngle: .zero,
                    endAngle: .degrees(360),
                    clockwise: false)
        return path
    }
}


struct Circle: Shape {
    var radius: CGFloat
    var center: CGPoint
    var start: Angle = Angle(degrees: 0)
    var end: Angle = Angle(degrees: 360)
    
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        path.addArc(center: self.center, radius: self.radius + 2,
                    startAngle: start,
                    endAngle: end,
                    clockwise: (end.degrees >= 0) ? false : true )
        return path
    }
}


struct Arrow: Shape {
    var size: Double
    var endPoint: CGPoint
    
    var lenght: Double {self.size*0.07}
    var halfHeight: Double {self.size*0.02}
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: endPoint)
        path.addLine(to: CGPoint(x: endPoint.x - lenght, y: endPoint.y - halfHeight))
        path.addLine(to: CGPoint(x: endPoint.x - lenght, y: endPoint.y + halfHeight))
        path.addLine(to: endPoint)
        return path
    }
}


struct userTextField: View {
    @Binding var userText: String
    var body: some View {
        TextField("Input your angle here", text: $userText)
            .multilineTextAlignment(.center)
            .frame(alignment: .center)
            .padding(.all, 15)
            .background(Color("Pine")
                            .opacity(0.2)
                            .cornerRadius(30))
            .foregroundColor(.white)
            .font(.headline)
            .lineLimit(1)
            .keyboardType(.numbersAndPunctuation)
            .disableAutocorrection(true)
            .accentColor(.white)
    }
}

/// Create horizontal line as rect
struct Line: Shape {
    
    var startPoint: CGPoint
    var lenght: Double
    var width: Double = 3
    
    private var halfWidth: Double { width / 2 }
    
    func path(in rect: CGRect) -> Path {
        
        var lineRect: CGRect {
            CGRect(x: startPoint.x,
                   y: startPoint.y - self.halfWidth,
                   width: lenght,
                   height: width)
        }
        
        var path = Path()
        
        path.addRect(lineRect)
        return path
    }
}


struct GoButton: View {
    
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
                .foregroundColor(Color("Forest"))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color("Forest"), lineWidth: 3)
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

