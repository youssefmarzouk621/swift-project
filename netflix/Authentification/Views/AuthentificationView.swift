//
//  AuthentificationView.swift
//  netflix
//
//  Created by Youssef on 17/11/2024.
//

import SwiftUI

struct AuthentificationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    private var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
    
    @StateObject var presenter:AuthentificationPresenter = AuthentificationPresenter(interactor: AuthentificationInteractor(apiManager: ApiManager(environment: AppConfig.apiEnvironment)))
    
    var body: some View {
        ZStack{
            
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.3,height: UIScreen.main.bounds.width * 0.3)
                Text("Authentification")
                    .boldTextStyle(fontSize: UIScreen.main.bounds.width * 0.06, color: CustomColors.C3)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("login_string2")
                    
                        .boldTextStyle(fontSize: 14, color:CustomColors.C3 )
                    
                    TextField("login_string3"+, text: $email)
                    
                        .accessibilityIdentifier("IdentifiantTextField")
                    
                        .padding(.vertical, 5)
                    
                        .foregroundColor(CustomColors.C3)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .padding(.top, 35)
                                .foregroundColor(CustomColors.C3)
                        )
                    
                }
                .frame(width: UIScreen.main.bounds.width * 0.85)
                .padding()
                
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("login_string4")
                        .boldTextStyle(fontSize: 14, color: CustomColors.C3)
                    HStack {
                        if isPasswordVisible {
                            TextField("login_string5"+, text: $password)
                                .padding(.vertical, 5)
                                .foregroundColor(CustomColors.C3)
                        } else {
                            SecureField("login_string5"+, text: $password)
                                .padding(.vertical, 5)
                                .foregroundColor(CustomColors.C3)
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(CustomColors.C3)
                        }
                    }
                    .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(CustomColors.C3), alignment: .bottom)
                    
                }
                .frame(width: UIScreen.main.bounds.width * 0.85)
                
                StandardButton(action: {
                    print("login action")
                    presenter.authentification(email: email, password: password)
                    
                }, text: "login_string7"+, isEnabled: isFormValid, width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.06)
                
                .padding(.top, UIScreen.main.bounds.height * 0.05)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(CustomColors.C2)
    }
}

#Preview {
    AuthentificationView()
}
