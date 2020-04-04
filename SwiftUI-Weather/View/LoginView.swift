//
//  LoginView.swift
//  SwiftUI-Weather
//
//  Created by Andrey Antropov on 01.01.2020.
//  Copyright © 2020 Antropov. All rights reserved.
//

import SwiftUI
import Combine

struct LoginView: View {
    @State private var login = ""
    @State private var password = ""
    @State private var keyboardHeight: CGFloat = 0
    @State private var showIncorrectCredentialsWarning = false
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("sunny_weather")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
            ScrollView(showsIndicators: false) {
                VStack {
                    Text("Weather App ")
                        .font(.largeTitle)
                        .padding(.top, 32)
                    VStack {
                        HStack {
                            Text("Login:")
                            Spacer()
                            TextField("", text: $login)
                                .frame(maxWidth: 150)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        HStack {
                            Text("Password:")
                            Spacer()
                            SecureField("", text: $password)
                                .frame(maxWidth: 150)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }.frame(maxWidth: 250)
                        .padding(.top, 50)
                    Button(action: verifyLoginData) {
                        Text("Log in")
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                    .disabled(login.isEmpty || password.isEmpty)
                }
            }.keyboardAdaptive()
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }.alert(isPresented: $showIncorrectCredentialsWarning, content: { () -> Alert in
            Alert(title: Text("Error"), message: Text("Incorrect Login/Password was entered"))
        })
    }
    
    private func verifyLoginData() {
        if login == "bar" && password == "foo" {
            isUserLoggedIn = true
        } else {
            showIncorrectCredentialsWarning = true
        }
        password = ""
    }
}
