//
//  SettingsView.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 24.10.2021.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var states: States
    
    @State private var currentHeight: CGFloat = 250
    
    @State private var isDrugging: Bool = false
    @State private var prevDrugGesture: CGSize = .zero
    
    private let maxHeight: CGFloat = 375
    private let minHeight: CGFloat = 225
    
    var body: some View {
        ZStack(alignment: .bottom){
            if states.showSettingsView {
                backgroundColor
                settings
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea()
        .animation(.easeInOut,value: states.showSettingsView)
    }
    
    var settingsForm: some View {
        Form{
            Toggle("Help Mode (Beta)", isOn: $states.helpModeIsActive)
                .toggleStyle(SwitchToggleStyle(tint: Color("Pine")))
        }
        .onAppear{UITableView.appearance().backgroundColor = .clear}
    }
    
    var settings: some View{
        VStack{
            ZStack{
                Color.white.opacity(0.000001)
                Capsule()
                    .foregroundColor(Color("Forest"))
                    .frame(width: 40, height: 6)
            }
            .frame(maxWidth: .infinity, maxHeight: 30)
            .gesture(dragGesture)
                
            HStack{
                Spacer().frame(maxWidth: 20)
                Text("Settings")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(Color("Foggy"))
                    .lineLimit(1)
                Spacer()
            }
            .gesture(dragGesture)
            
            settingsForm
        }
        .frame(height: currentHeight)
        .background(Color("Pine"))
        .cornerRadius(15)
        .animation(.spring(), value: isDrugging)
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 5, coordinateSpace: .global)
            .onChanged { val in
                isDrugging = true
                let dragAmount = val.translation.height - prevDrugGesture.height
                if currentHeight > maxHeight || currentHeight < minHeight{
                    currentHeight -= dragAmount / 6
                } else {
                    currentHeight -= dragAmount
                }
                prevDrugGesture = val.translation
            }
            .onEnded { val in
                prevDrugGesture = .zero
                isDrugging = false
                if currentHeight > maxHeight{
                    currentHeight = maxHeight
                } else if currentHeight < minHeight {
                        currentHeight = minHeight
                }
            }
    }
    
    var backgroundColor: some View{
        Color("Foggy")
            .ignoresSafeArea()
            .opacity(0.25)
            .onTapGesture {
                states.showSettingsView = false
            }
    }
}
