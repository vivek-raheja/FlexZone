//
//  ContactUsView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/14/23.
//

import SwiftUI

struct ContactUsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack{
                    
                    ZStack{
                        Text("How can we help you?")
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
                    VStack(spacing: 28){
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 45)
                                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                            HStack{
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.white)
                                Text("Ask a Question")
                            }
                            .foregroundColor(.white)
                            
                        }
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 45)
                                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                            HStack{
                                Image(systemName: "ladybug")
                                    .foregroundColor(.white)
                                Text("Report a Problem")
                            }
                            .foregroundColor(.white)
                            
                        }
                        ZStack(alignment: .center){
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 45)
                                .foregroundColor(Color(red: 28/255, green: 28/255, blue: 30/255))
                            HStack{
                                Image(systemName: "atom")
                                    .foregroundColor(.white)
                                Text("Become Beta Tester")
                            }
                            .foregroundColor(.white)
                            
                        }


                        
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 80)
            }
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
