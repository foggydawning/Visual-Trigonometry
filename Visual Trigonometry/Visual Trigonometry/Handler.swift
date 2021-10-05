//
//  Handler.swift
//  Visual Trigonometry
//
//  Created by Илья Чуб on 26.09.2021.
//

import SwiftUI

class Handler{
    
    var userText: String
    private var correctNumbers: String = "-0123456789."
    
    init(userText: String){
        self.userText = userText.replacingOccurrences(of: ",", with: ".")
    }
    
    var errorString: String = " "
    var handledUserInput: Angle? = nil
    func handle(){
        do {
            try self.handleError()
            self.handledUserInput = Angle(degrees: self.getDouble()*(-1.0))
        } catch InputTextError.tooManySeparators{
            self.errorString = "Too many separators"
        } catch InputTextError.invalidText{
            self.errorString = "Invalid characters in the input"
        } catch InputTextError.emptyString{
            self.errorString = "Empty string"
        } catch {
            self.errorString = "???"
        }
    }
    
    func handleError() throws {
        if self.userText.count == 0{
            throw InputTextError.emptyString
        }
        var numberOfSeparatos: Int = 0
        for symbol in self.userText{
            if correctNumbers.contains(symbol) == false{
                throw InputTextError.invalidText
            } else if symbol == "."{
                numberOfSeparatos += 1
            }
        }
        
        if numberOfSeparatos > 1{
            throw InputTextError.tooManySeparators
        }
    }
    
    func getDouble() -> Double{
        Double(self.userText)!
    }
}
