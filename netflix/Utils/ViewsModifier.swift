//
//  ViewsModifier.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import Foundation
import SwiftUI

struct BoldTextStyle: ViewModifier {
    var fontSize: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("RedHatDisplay-Bold", size: fontSize))
            .foregroundColor(color)
    }
}
struct RegularTextStyle: ViewModifier {
    var fontSize: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom("RedHatDisplay-Regular", size: fontSize))
            .foregroundColor(color)
    }
}

struct StandardButton: View {
    var action: () -> Void
    var text: String
    var isEnabled: Bool = true
    var width: CGFloat
    var height: CGFloat
    var hasBackground: Bool = true
    var hasBorder: Bool = false
    var isBold: Bool = true


    var body: some View {
        Button(action: {
            action()
        }) {
            Text(text)
                .applyTextStyle(isBold: isBold, fontSize: 14, color: hasBackground ? CustomColors.C3 : CustomColors.C1)
                .frame(width: width, height: height)
                .background(hasBackground ? (isEnabled ? CustomColors.C1 : Color.gray) : Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(hasBorder ? CustomColors.C1 : Color.clear, lineWidth: hasBorder ? 2 : 0)
                )
                .cornerRadius(5)
        }
        .disabled(!isEnabled)
    }
}
