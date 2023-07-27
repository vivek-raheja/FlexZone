//
//  HelpView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/14/23.
//

import SwiftUI

struct HelpView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Text("Help")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }

                            
                            Spacer()
                        }
                    }
                    Spacer()
                }
                
                VStack{
                    
                    VStack(spacing: 16){
                        
                        NavigationLink {
                            ContactUsView().navigationBarBackButtonHidden()
                        } label: {
                            ChevronButtonView(icon: "envelope", text: "Contact us")

                        }

                        ChevronButtonView(icon: "questionmark.circle", text: "Help Center")
                        
                        Spacer()
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 50)
                    
                }
                
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
