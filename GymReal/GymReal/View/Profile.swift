//
//  Profile.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/11/23.
//

import SwiftUI
import Kingfisher

struct Profile: View {
    
    @Binding var mainMenu: String
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        Button {
                            withAnimation{
                                self.mainMenu = "feed"
                            }
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.white)
                                .font(.system(size:20))
                        }

                        
                        Spacer()
                        
                        Text("Profile")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        NavigationLink {
                            SettingsView().navigationBarBackButtonHidden()
                        } label: {
                            ThreeDots(size: 4, color: .white)
                        }

                        
                        
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                VStack{
//                    Image("pp")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 130, height: 130)
//                        .cornerRadius(75)
                
                    
                    if let profileImageUrl = viewModel.currentUser!.profileImageUrl {
                        KFImage(URL(string: profileImageUrl))
                            .resizable()
                            .frame(width: 130, height: 130)
                            .cornerRadius(75)
                    }
                    else{
                        Circle()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                            .overlay(

                                Text(viewModel.currentUser!.name.prefix(1).uppercased())
                                    .foregroundColor(.white)
                                    .font(.system(size: 25))

                            )
                    }
                    
                    Text(viewModel.currentUser!.name)
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                    
                    Text(viewModel.currentUser!.username ?? viewModel.currentUser!.name.lowercased())
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    
                    HStack{
                        Text("Your Memories")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 20))
                        
                        Spacer()
                        
                        HStack(spacing: 4){
                            Image(systemName: "lock.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                            
                            Text("Only visible to you")
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 4)
                    
                    VStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(Color.white)
                                .opacity(0.2)
                                .frame(height: 230)
                            
                            VStack{
                                HStack{
                                    Text("Last 14 days")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                        .padding(.top, 8)
                                    
                                    Spacer()
                                }
                                .padding(.leading)
                                
                                // memory View
                                VStack{
                                    HStack(spacing: 4) {
                                        
                                        ForEach(1..<8){ x in
                                            
                                            MemoryView(day: x)
                                            
                                        }
                                        
                                    }
                                    HStack(spacing: 4) {
                                        
                                        ForEach(1..<8){ x in
                                            
                                            MemoryView(day: x+7)
                                            
                                        }
                                    }
                                    .padding(.top, -4)
                                    
                                }
                                .padding(.top, -4)
                                
                                
                                Text("View all my Memories")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 13))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.white, lineWidth: 2)
                                            .frame(width: 175, height: 20)
                                            .opacity(0.6)
                                    )
                                    .padding(.top, 4)
                                
                            }
                            .padding(.top, -15)
                        }
                    }
                    
                    Text("🔗 GymRe.al/vivekraheja")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .padding(.top, 8)
                    Spacer()
                }
                .padding(.top, 35)
            }
        }
    }
}
    struct Profile_Previews: PreviewProvider {
        static var previews: some View {
            Profile(mainMenu: .constant("profile"))
        }
    }

