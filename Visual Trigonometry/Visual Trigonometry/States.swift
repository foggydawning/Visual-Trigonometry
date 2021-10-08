//
//  States.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 08.10.2021.
//

import SwiftUI

class States: ObservableObject {
    @Published var userText: String = ""
    @Published var errorString: String = " "
    @Published var helpsLineOpticaly: Double = 0
    @Published var handledUserInput: Angle? = nil
}
