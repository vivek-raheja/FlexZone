//
//  EnterNameView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/14/23.
//

import SwiftUI

struct EnterNameView: View {
    
    @Binding var name: String
    @State var buttonActive = false
    
    @Binding var nameButtonClicked: Bool
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
                    VStack (alignment: .center, spacing: 8){
                        Text("Let's get started, what's your name?")
                            .fontWeight(.heavy)
                            .font(.system(size: 16))
                        Text(name.isEmpty ? "Your name" : "")
                            .foregroundColor(Color(red: 70/255, green: 70/255, blue: 73/255))
                            .fontWeight(.heavy)
                            .font(.system(size: 40))
                            .frame(width: 210)
                            .overlay(
                                TextField("", text: $name)
                                    .font(.system(size: 40))
                                    .fontWeight(.heavy)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            )
                            .padding(.vertical, 10)
                        }
                    .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 50)
                
                VStack{
                    Spacer()
                    Button {
                        if buttonActive {
                            self.nameButtonClicked = true
                        }
                        else{
                            self.buttonActive = true
                        }
                    } label: {
                        WhiteButtonView(buttonActive: $buttonActive, text: "Continue")
                            .onChange(of: name) { newValue in
                                if !newValue.isEmpty{
                                    buttonActive = true
                                }
                                else if newValue.isEmpty{
                                    buttonActive = false
                                }
                    }

                }
                }
                
            }
        }
    }
}

//struct EnterNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        EnterNameView()
//    }
//}
