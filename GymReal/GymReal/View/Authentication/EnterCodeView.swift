//
//  EnterCodeView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/16/23.
//

import SwiftUI
import Combine

struct EnterCodeView: View {
    
    @State var otpCode = ""
    @State var buttonActive = false
    
    @State var timeRemaining = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                
                VStack{
                    HStack{
                        
                        Spacer()
                        
                        Text("GymReal.")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                        
                        Spacer()
                        
                    }
                    Spacer()
                }
                
                VStack{
                    VStack{
                        VStack(alignment: .center, spacing: 8){
                            Text("Enter the code we sent to +\(viewModel.country.phoneCode)\(viewModel.phoneNumber)")
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .font(.system(size: 16))
                            
                            Text("......")
                                .foregroundColor(viewModel.otpText.isEmpty ? .gray : Color(red: 204/255, green: 61/255, blue: 52/255))
                                .opacity(0.8)
                                .font(.system(size: 70))
                                .padding(.top, -40)
                                .overlay(
                                    TextField("", text: $viewModel.otpText)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 24))
                                        .fontWeight(.heavy)
                                        .keyboardType(.numberPad)
                                        .onReceive(Just(viewModel.otpText), perform: { _ in
                                            limitText(6)
                                        })
                                        .onReceive(Just(viewModel.otpText), perform: { newValue in
                                            let filtered = newValue.filter({
                                                Set("0123456789").contains($0)})
                                            if filtered != newValue {
                                                viewModel.otpText = filtered
                                            }
                                        })
                                )
                        }
                        .padding(.top, 50)
                        Spacer()
                        
                    }
                    
                    VStack{
                        
                        Text("Change the phone number")
                            .foregroundColor(.gray)
                            .fontWeight(.bold)
                            .font(.system(size: 14))
                        Button {
                            if buttonActive{
                                Task {
                                    await self.viewModel.verifyOtp()
                                }
                            }
                            
                        } label: {
                            WhiteButtonView(buttonActive: $buttonActive, text: viewModel.otpText.count == 6 ? "Continue" : "Resend in \(timeRemaining)s")
                        }
                        .disabled(buttonActive ? false : true)
                        .onChange(of: viewModel.otpText) { newValue in
                            if !newValue.isEmpty{
                                buttonActive = true
                            }
                            else if newValue.isEmpty {
                                buttonActive = false
                            }
                        }

                    }

                    
                }
            }
            .onReceive(timer){ time in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                else{
                    buttonActive = true
                }
            }
        }
    }
    
    func limitText(_ upper: Int){
        if viewModel.otpText.count > upper{
            viewModel.otpText = String(viewModel.otpText.prefix(upper))
        }
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}
