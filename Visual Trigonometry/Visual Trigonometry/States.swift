//
//  States.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 08.10.2021.
//

import SwiftUI
import Foundation

class States: ObservableObject {
    init(){}
    @Published var userText: String = ""
    @Published var errorString: String = " "
    @Published var helpsLineOpticaly: Double = 0
    @Published var handledUserInput: Angle? = nil
    @Published var merginFromEdges : Double = (UIScreen.main.bounds.width <= 375) ?
                                                0.08 * UIScreen.main.bounds.width :
                                                0.05 * UIScreen.main.bounds.width
    @Published var widthOfWorkSpace:  Double = (UIScreen.main.bounds.width <= 375) ?
                                                0.84 * UIScreen.main.bounds.width  :
                                                0.9 * UIScreen.main.bounds.width
    @Published var showTrigonometryValues: Bool = true
    @Published var helpModeIsActive: Bool = true
    @Published var showSettingsView: Bool = false
}
