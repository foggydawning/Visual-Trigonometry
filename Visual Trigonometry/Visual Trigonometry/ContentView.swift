//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI
import Foundation


struct MainScreen: View {
    @StateObject var states = States()
    
    var body: some View {
        HStack{
            Spacer(minLength: states.merginFromEdges)
            VStack(alignment: .center){
                Spacer().frame(maxHeight: 80)
                TrigonometryView()
                Spacer()
                TrigonometricValues()
                ErrorString()
                AngleTextFieldAndGoButton()
                
                SettingsIcon()
            }
            Spacer(minLength: states.merginFromEdges)
        }
        .environmentObject(states)
        .background(Color("Foggy").opacity(0.15))
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
