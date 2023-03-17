//
//  LoginView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 23/2/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var account:AccountObservableObject
//    @ObservedObject var account:AccountObservableObject
    
    @State var showLostPassword = false
    @State var email = ""
    @State var password:String = ""
    
    var body: some View {
        
        Group {
            if account.authenticationState == .authenticating {
                ProgressView()
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Text("Login".localized)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.random)
                    GroupBox {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Email".localized)
                                .font(.headline)
                            TextField("Introduce your email".localized, text:$email)
                                .textContentType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                            Text("Password".localized)
                                .font(.headline)
                            SecureField("Introduce your Password".localized, text: $password)
                            
                            Button(action:login, label: {
                                Text("Entry".localized)
                            })
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            Button {
                                showLostPassword.toggle()
                            } label: {
                                Text("Have you forgotten the password?".localized)
                            }
                            

                        }
                    } label: {
                        Text("Trantor library entry".localized)
                            .bold()
                            .padding(.bottom)
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    if !account.errorMsg.isEmpty {
                        Text(account.errorMsg)
                            .foregroundColor(.white)
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.red)
                            }
                    }
                }
                .frame(maxWidth:.infinity, maxHeight:.infinity)

                .padding()
            }

        }
        .background(.random)
        .ignoresSafeArea()
        .sheet(isPresented: $showLostPassword) {
            lostPassword
        }
    }
    
    var lostPassword: some View {
        VStack {
            Text("Lost Password".localized)
                .font(.largeTitle)
                .bold()
            GroupBox {
                Text("Usuario a recuperar")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Introduzca el email", text: $email)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Button {
                    showLostPassword.toggle()
                } label: {
                    Text("Recover password".localized)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .textFieldStyle(.roundedBorder)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .background(.random)
        .ignoresSafeArea()
    }
    
    func login() {
        Task {
            await account.login(email: email, pass: password)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AccountObservableObject(networkClient: NetworkClient()))
    }
}
