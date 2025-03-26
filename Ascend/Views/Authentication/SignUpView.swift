////
////  SignUpView.swift
////  Ascend
////
////  Created by Tyler Pavay on 2/25/25.
////
//import SwiftUI
//
//struct SignUpView: View {
//    // Get the auth service from the environment
//    //@Environment(\.authService) private var authService: AuthService
//    @State private var viewModel: SignUpViewModel?
//    
//    init() {
//        // Initialize with placeholder because the Auth Service environment var isnt available
//        // on initialization
//        //self._viewModel = State(initialValue: SignUpViewModel(authService: AuthService()))
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                // Title
//                VStack() {
//                    (Text("Hello\nThere")
//                    + Text(".")
//                        .foregroundStyle(.accentPrimary))
//                    .font(.system(size: 64, weight: .heavy))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.top, 100)
//                    .padding(.bottom, 75)
//                        
//                }
//                
//                // Email and password
//                VStack(spacing: 36) {
//                    VStack {
//                        Text("EMAIL")
//                            .font(.callout)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.gray)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        TextField("example@gmail.com", text: $viewModel.email)
//                            .fontWeight(.semibold)
//                        Rectangle().frame(height: 1)
//                    }
//                    VStack {
//                        Text("Password")
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                        SecureField("", text: $viewModel.password)
//                        Rectangle().frame(height: 1)
//                    }
//                    Text("Forgot Password")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.accentPrimary)
//                        .padding(.top, -15)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                }
//                .padding(.bottom, 36)
//                
//                VStack {
//    //                Button {
//    //                    authService.toggleAuthState()
//    //                } label: {
//    //                    Text("LOGIN")
//    //                        .fontWeight(.bold)
//    //                        .frame(maxWidth: .infinity)
//    //                        .frame(height: 55)
//    //                        .foregroundStyle(.white)
//    //                        .background(.accentPrimary)
//    //                        .cornerRadius(40)
//    //                }
//    //                .padding(.bottom, 20)
//                    NavigationLink(destination: HomeMainView()) {
//                        Text("LOGIN")
//                            .fontWeight(.bold)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 55)
//                            .foregroundStyle(.white)
//                            .background(.accentPrimary)
//                            .cornerRadius(40)
//                    }
//                    HStack {
//                        Rectangle()
//                            .frame(height: 1)
//                        Text("Or")
//                        Rectangle()
//                            .frame(height: 1)
//                    }
//                    HStack {
//                        Button {
//                            authService.toggleAuthState()
//                            
//                        } label: {
//                            Label("Apple", image: "AppleIcon")
//                                .foregroundStyle(.black)
//                                .fontWeight(.bold)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 55)
//                                .background(RoundedRectangle(cornerRadius: 40).stroke(.black, lineWidth: 4))
//                                .padding(.horizontal)
//                                
//                        }
//                        Button {
//                            authService.toggleAuthState()
//                        } label: {
//                            Label("Google", image: "GoogleIcon")
//                                .foregroundStyle(.black)
//                                .fontWeight(.bold)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 55)
//                                .background(RoundedRectangle(cornerRadius: 40).stroke(.black, lineWidth: 4))
//                                .padding(.horizontal)
//                                
//                        }
//                    }
//                }
//                
//                
//            }
//            .padding(.horizontal, 36)
//            .onAppear {
//                // The environment variable is available in onAppear
//                // So replace the placeholder with the real service
//                viewModel = SignUpViewModel(authService: authService)
//            }
//        }
//        
//    }
//}
//
//#Preview {
//    SignUpView()
//        .environment(AuthService())
//}
