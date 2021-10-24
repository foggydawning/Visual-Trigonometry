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
        ZStack{
            HStack{
                Spacer(minLength: states.merginFromEdges)
                VStack(alignment: .center){
                    TrigonometryView()
                    TrigonometricValues()
                    ErrorString()
                    AngleTextFieldAndGoButton()
                    SettingsIcon()
                }
                Spacer(minLength: states.merginFromEdges)
            }
            
            
            SettingsView()
            
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
