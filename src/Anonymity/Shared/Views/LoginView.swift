//
//  File Name     : LoginView.swift
//  Project Name  : Anonymity
//  Description   :
//
//  Swift Version : Using Swift 5.0
//  macOS Version : Developed on macOS 12.4
//  GitHub Page   : https://github.com/Steve-Xyh
//  -------------------------------------------------------
//  Created by Steve X on 2022/7/12 16:57.
//  Copyright © 2022 Steve X Software. All rights reserved.
//

import Firebase
import SwiftUI

struct LoginView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var showLoginPage: Bool

//    @State var createMode: Bool = false

    init(
        username: Binding<String> = .constant(""),
        password: Binding<String> = .constant(""),
        showLoginPage: Binding<Bool> = .constant(true)
    ) {
        _username = username
        _password = password
        _showLoginPage = showLoginPage
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .background(LinearGradient(
                    colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))

            VStack {
                Spacer()

                AvatarView(
                    avatarType: .nameCapital,
                    maxSize: 100,
                    firstName: username
                )
                .padding()

                TextField("USERNAME", text: $username)
                    .frame(width: 200, height: 10, alignment: .center)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(20)

                SecureField("PASSWORD", text: $password)
                    .frame(width: 200, height: 10, alignment: .center)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(20)

//                SecureField(createMode ? "PASSWORD AGAIN" : "", text: $password)
//                    .frame(width: 200, height: 10, alignment: .center)
//                    .padding()
//                    .background(.black.opacity(createMode ? 0.1 : 0))
//                    .cornerRadius(20)

                Spacer()

                Button(action: {
                    showLoginPage = false
                }) {
                    HStack {
                        Text("LOGIN")
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 20))
                    }
                }
                .frame(width: 200, height: 10)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(20)

                Button(action: {
//                    createMode.toggle()
                    createNewUser()
                }) {
                    HStack {
                        Text("Create an account")
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 20))
                    }
                }
                .frame(width: 200, height: 10)
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .cornerRadius(20)

                Spacer()
            }
        }
        .navigationTitle("Login")
    }
}

extension LoginView {
    private func createNewUser() {
        Auth.auth().createUser(withEmail: username, password: password) { result, err in
            if let err = err {
                print("Failed to create new user:", err)
                return
            }

            print("User created successfully: \(result?.user.uid ?? "")")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
