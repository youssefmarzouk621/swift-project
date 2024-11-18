//
//  SplashScreenView.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive = false
        @State private var size = 0.8
        @State private var opacity = 0.5
        var body: some View {
            ZStack {
                if isActive {
                    AuthentificationView()
                } else {
                    ZStack {
                        VStack {
                            Image("logo")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width * 0.5,
                                       height: UIScreen.main.bounds.width * 0.5)
                                .scaleEffect(size)
                                .opacity(opacity)
                                .onAppear {
                                    withAnimation(.easeIn(duration: 1.2)) {
                                        self.size = 0.9
                                        self.opacity = 1.0
                                    }
                                }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
                }
            }
            .background(CustomColors.C2)
        }
}

#Preview {
    SplashScreenView()
}
