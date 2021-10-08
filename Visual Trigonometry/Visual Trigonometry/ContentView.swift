//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var states = States()
    @State private var handledUserInput: Angle? = nil
    @State private var helpsLineOpticaly: Double = 0
    
    var merginFromEdges : Double = (UIScreen.main.bounds.width <= 375)
        ? 0.08 : 0.05
    
    var widthOfWorkPlace: CGFloat {CGFloat((1 - 2*merginFromEdges)*UIScreen.main.bounds.width)}
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer(minLength: geometry.size.width*merginFromEdges)
                VStack(alignment: .center){
                    Spacer()
                    TrigonometryView(
                        userAngle: $handledUserInput,
                        helpsLineOpticaly: $helpsLineOpticaly,
                        size: widthOfWorkPlace
                    )
                    Spacer()
                    ErrorString()
                    AngleTextFieldAndGoButton(
                        handledUserInput: $handledUserInput,
                        helpsLineOpticaly: $helpsLineOpticaly)
                    Spacer()
                }
                Spacer(minLength: geometry.size.width*merginFromEdges)
            }
            .environmentObject(states)
        }
        .background(Color("Foggy").opacity(0.15))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
