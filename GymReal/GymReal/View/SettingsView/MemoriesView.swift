//
//  MemoriesView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/14/23.
//

import SwiftUI

struct MemoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack{
                    ZStack{
                        Text("Memories")
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
                            
                            Image(systemName:  "questionmark.circle")
                                .foregroundColor(.white)
                                .font(.system(size: 16))
                            
                            

                        }
                    }
                    Spacer()
                }
                
                VStack{
                    VStack{
                        HStack{
                            Text("Your memories are activated")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 20))
                            Spacer()
                        }
                        Text("All your GymReal are automatically added to your Memories and only visible by you.")
                            .foregroundColor(.white)
                            .padding(.top, -2)
                        
                    }
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 210)
                            .foregroundColor(.black)
                            .opacity(0.7)
                            .overlay(
                                
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.blue, lineWidth: 1)
                                
                            )
                        
                        VStack(alignment: .leading){
                            HStack{
                                Text("Deactivate and Delete Memories")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                
                                Spacer()
                            }
                            VStack{
                                HStack{
                                    Text("If you deactivate your Memories, all your GymReal will be permanently deleted and unrecoverable.")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                                HStack{
                                    Text("All your future GymReal won't be saved in Memories and will be automatically deleted as well.")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                    Spacer()
                                }
                            }
                            .padding(.top, -6)
                            
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: UIScreen.main.bounds.width * 0.5, height: 40)
                                .foregroundColor(Color(red: 44/255, green: 44/255, blue: 46/255))
                                .overlay(
                                    Text("Deactivate Memories")
                                        .foregroundColor(.red)
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                )
                                .padding(.top, 8)
                            
                        }
                        .padding(.leading)
                    }
                    .padding(.top, 22)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 50)
            }
        }
    }
}

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView()
    }
}
