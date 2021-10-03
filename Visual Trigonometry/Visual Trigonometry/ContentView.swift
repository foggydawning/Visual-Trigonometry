//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userText: String = ""
    @State private var handledUserInput: Angle? = nil
    @State private var errorString: String = " "
    @State private var helpsLineOpticaly: Double = 0
    
    var merginFromEdges = 0.05
    
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
                        .frame(height: widthOfWorkPlace )
                    Spacer()
                    HStack{
                        Text(errorString)
                            .fontWeight(.light)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .multilineTextAlignment(.trailing)
                            .animation(.spring())
                        Spacer()
                    }
                    HStack{
                        userTextField(userText: $userText)
                        mainButton(
                            handledUserInput: $handledUserInput,
                            userText: $userText,
                            errorString: $errorString,
                            helpsLineOpticaly: $helpsLineOpticaly
                        )
                    }
                    Spacer()
                }
                Spacer(minLength: geometry.size.width*merginFromEdges)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
