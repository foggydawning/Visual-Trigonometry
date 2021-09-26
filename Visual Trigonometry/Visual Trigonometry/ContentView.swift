//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var userText: String = ""
    @State var handledUserInput: Angle? = nil
    @State var errorString: String = " "
    
    var merginFromEdges = 0.05
    
    var widthOfWorkPlace: CGFloat {CGFloat((1 - 2*merginFromEdges)*UIScreen.main.bounds.width)}
    
    var body: some View {
        GeometryReader{ geometry in
            HStack{
                Spacer(minLength: geometry.size.width*merginFromEdges)
                VStack(alignment: .center){
                    Spacer()
                    TrigonometryView(
                        userAngle: handledUserInput,
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
                            errorString: $errorString
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
