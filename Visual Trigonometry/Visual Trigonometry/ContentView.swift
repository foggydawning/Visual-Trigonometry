//
//  ContentView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 22.09.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var states = States()
    
    var body: some View {
        HStack{
            Spacer(minLength: states.merginFromEdges)
            VStack(alignment: .center){
                Spacer()
                TrigonometryView()
                Spacer()
                ErrorString()
                AngleTextFieldAndGoButton()
                Spacer()
            }
            Spacer(minLength: states.merginFromEdges)
        }
        .environmentObject(states)
        .background(Color("Foggy").opacity(0.15))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
