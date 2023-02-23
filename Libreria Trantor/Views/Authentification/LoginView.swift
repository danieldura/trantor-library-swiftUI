//
//  LoginView.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 23/2/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm:UserViewModel
    @State var showLostPassword = false
    var body: some View {
        
        Group {
            if vm.authenticationState == .authenticating {
                
                ProgressView()
                    .frame(maxWidth:.infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Text("Login".localized)
                        .font(.largeTitle)
                        .bold()
                    GroupBox {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Email".localized)
                                .font(.headline)
                            TextField("Email", text:$vm.user.email)
                                .textContentType(.emailAddress)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                            Text("Password".localized)
                                .font(.headline)
                            SecureField("Password".localized, text: $vm.password)
                            
                            Button {
                                vm.login()
                            } label: {
                                Text("Entry".localized)
                            }
                            .buttonStyle(.borderedProminent)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            Button {
                                showLostPassword.toggle()
                            } label: {
                                Text("¿Has perdido la clave?")
                            }
                            

                        }
                    } label: {
                        Text("Trantor library entry".localized)
                            .bold()
                            .padding(.bottom)
                    }
                    .textFieldStyle(.roundedBorder)
                    
                    if !vm.errorMsg.isEmpty {
                        Text(vm.errorMsg)
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
            Text("Lost Password")
                .font(.largeTitle)
                .bold()
            GroupBox {
                Text("Usuario a recuperar")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Introduzca el email", text: $vm.user.email)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Button {
                    showLostPassword.toggle()
                } label: {
                    Text("Recuperar clave")
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(vm:UserViewModel(user: .test))
    }
}
