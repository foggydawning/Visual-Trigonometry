//
//  Errors.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI

enum InputTextError: Error{
    case invalidText
    case tooManySeparators
    case emptyString
}
