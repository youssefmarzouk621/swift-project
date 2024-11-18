//
//  Extensions.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import Foundation
import SwiftUI

extension View {
    func boldTextStyle(fontSize: CGFloat, color: Color) -> some View {
        self.modifier(BoldTextStyle(fontSize: fontSize, color: color))
    }
    func regularTextStyle(fontSize: CGFloat, color: Color) -> some View {
        self.modifier(RegularTextStyle(fontSize: fontSize, color: color))
    }
    func applyTextStyle(isBold: Bool, fontSize: CGFloat, color: Color) -> some View {
        if isBold {
            return AnyView(self.boldTextStyle(fontSize: fontSize, color: color))
        } else {
            return AnyView(self.regularTextStyle(fontSize: fontSize, color: color))
        }
    }
}

postfix operator +
postfix func + (left: String) -> String {
    return NSLocalizedString(left, comment: left)
}

struct ValidationUtils{
    
    static func validatePasswordInputs(password: String) -> String? {
        
        if password.isEmpty {

            return "validate_string5"+
            
        }
        
        if password.count < 8 {
            return "validate_string4"+
        }
        
        let uppercaseRegex = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        
        let lowercaseRegex = NSPredicate(format: "SELF MATCHES %@", ".*[a-z]+.*")
        
        let numberRegex = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        
        if !uppercaseRegex.evaluate(with: password) || !lowercaseRegex.evaluate(with: password) ||  !numberRegex.evaluate(with: password){
            return "validate_string6"+
        }
        
    
        return nil
        
        
    }
}
