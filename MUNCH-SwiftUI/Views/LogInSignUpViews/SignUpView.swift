//
//  SignUpView.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/24/21.
//

import Foundation
import SwiftUI

//MARK: - Users enter their emails and passwords to Sign Up
struct SignUpView: View {
    
    @EnvironmentObject var viewModel: LogInSignUpVM
    
    var body: some View {
        
        VStack {
            NavigationView {
                
                if viewModel.isLoggedIn {
                    VStack {
                        ContentView()
                    }
                } else {
                    ZStack {
                        Color.black.edgesIgnoringSafeArea(.all)
                        VStack {
                            Text("Welcome!\nSign Up Below")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(50)
                                .multilineTextAlignment(.center)
                            
                            // Email text field
                            TextField("Email Address", text: $viewModel.email)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                                .foregroundColor(.white)
                                .padding(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20.0, style: .circular)
                                        .foregroundColor(Color(.secondarySystemFill))
                                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 70)
                                )
                            
                            // Email error message
                            TextField("", text: $viewModel.errorMessage)
                                .disabled(true)
                                .foregroundColor(.red)
                                .padding(.bottom, 10)
                                .padding(.leading, 40)
                                .font(.subheadline)

                            // Password text field
                            SecureField("Password", text: $viewModel.password)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20.0, style: .circular)
                                        .foregroundColor(Color(.secondarySystemFill))
                                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 70)
                                )
                            
                            // Password error message
                            TextField("", text: $viewModel.errorMessage2)
                                .disabled(true)
                                .foregroundColor(.red)
                                .padding(.bottom, 10)
                                .padding(.leading, 40)
                                .font(.subheadline)
                            
                            // Button that leads to Log In page
                            NavigationLink(destination: LogInView()) {
                                Text("Already have an account? Login here!")
                            }
                            
                            // Sign Up button
                            Button(action: {
                                guard !viewModel.email.isEmpty, !viewModel.password.isEmpty else {
                                    return
                                }
                                
                                viewModel.signUp(email: viewModel.email, password: viewModel.password)
                            }, label: {
                                Text("Sign Up")
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(width: 150, height: 50, alignment: .center)
                                    .background(Color.green)
                                    .cornerRadius(30)
                                    .padding(30)
                            })
                            
                            Spacer()
                            
                        }
                        .navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                    }
                }
            }.onAppear() {
                viewModel.loggedIn = viewModel.isLoggedIn
            }
        }
        
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
