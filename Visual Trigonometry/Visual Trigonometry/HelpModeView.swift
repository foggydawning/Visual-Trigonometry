//
//  HelpModeView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 24.10.2021.
//

import SwiftUI

struct HelpModeView: View{
    @EnvironmentObject var states: States
    
    var mainRadiusLenght: CGFloat
    var center: CGPoint
    var trigonometricValues: [String: Double]?
    
    var body: some View{
        if trigonometricValues != nil{
            ZStack{
                // 1 text
                HStack(){
                    Spacer()
                        .frame(maxWidth: states.widthOfWorkSpace/2)
                    Text("1")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Stone Wall"))
                        .padding(.bottom, 30)
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .rotationEffect( trigonometricValues!["cos"]! > 0 ? .zero : .degrees(180))
                }
                .rotationEffect(states.handledUserInput ?? .degrees(0))

                // cos text
                HStack{
                    Spacer()
                        .frame(maxWidth: abs(trigonometricValues!["cos"]!)*mainRadiusLenght+3.0)
                    Text("cos")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Biscotti"))
                        .padding(.bottom, 35)
                        .opacity(states.helpsLineOpticaly)
                        .animation(animation, value: states.helpsLineOpticaly)
                        .animation(.easeInOut.delay(1), value: states.helpModeIsActive)
                        .rotationEffect(trigonometricValues!["cos"]! > 0 ? .zero : .degrees(180))
                }
                .rotationEffect(
                    trigonometricValues!["cos"]! > 0 ? .zero : .degrees(180)
                )
                
                // sin text
                VStack{
                    HStack{
                        if trigonometricValues!["sin"]! * trigonometricValues!["cos"]! >= 0{
                            Spacer()
                               .frame(maxWidth: abs(trigonometricValues!["sin"]!)*mainRadiusLenght)
                        }
                        Text("sin")
                            .fontWeight(.bold)
                            .foregroundColor(Color("Honey"))
                            .padding(.bottom, 30)
                            .opacity(states.helpsLineOpticaly)
                            .animation(animation, value: states.helpsLineOpticaly)
                            .animation(.easeInOut.delay(1), value: states.helpModeIsActive)
                            .rotationEffect(.zero)
                        if trigonometricValues!["sin"]! * trigonometricValues!["cos"]! < 0{
                            Spacer()
                               .frame(maxWidth: abs(trigonometricValues!["sin"]!)*mainRadiusLenght)
                        }
                    }
                    Spacer()
                       .frame(maxHeight: 2*abs(trigonometricValues!["cos"]!)*mainRadiusLenght+3.0)
                }
                .rotationEffect(
                    trigonometricValues!["cos"]! >= 0 ? .degrees(90) : .degrees(270)
                )
            }
        }
    }
    var animation: Animation{
        Animation
            .easeInOut(duration: (states.helpsLineOpticaly == 0) ? 0 : 1.5)
            .delay((states.helpsLineOpticaly == 0) ? 0 : 1.7)
    }
}

struct LinesOnPi3Pi4Pi6: View {
    let size: Double
    var radiusLenght: Double {size/2}
    let lineWidth: Double = 4
    let degree: Double
    private struct line: View {
        var lineWidth: Double
        var body: some View{
            RoundedRectangle(cornerRadius: 30).frame(width: lineWidth, height: 15)
        }
    }
    var body: some View{
        VStack{
            Spacer()
            HStack(spacing: 0){
                Spacer()
                    .frame(width: radiusLenght*(1 - pow(3, 0.5)/2) - lineWidth/2)
                if degree == 180 || degree == 90{
                    Spacer().frame(width: lineWidth)
                } else {
                    line(lineWidth: lineWidth)
                }
                Spacer()
                    .frame(width: radiusLenght*((pow(3, 0.5) - pow(2, 0.5))/2) - lineWidth)
                line(lineWidth: lineWidth)
                Spacer()
                    .frame(width: radiusLenght*((pow(2, 0.5) - 1)/2) - lineWidth)
                line(lineWidth: lineWidth)
                Spacer()
            }
            Spacer()
        }
        .rotationEffect(.degrees(degree))
        
    }
}

struct LinesOnCoordinateSystem: View {
    let size: Double
    let degrees: [Double] = [0,90,180,270]
    var body: some View{
        ZStack{
            ForEach(degrees, id: \.self){ degree in
                LinesOnPi3Pi4Pi6(size: size, degree: degree)
            }
        }
    }
}
