//
//  SwiftUIView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/13/23.
//

import SwiftUI

struct LeftMenu: View {
    
    @State var width = UIScreen.main.bounds.width
    @State var menu = "suggestions"
    
    @Binding var mainMenu: String
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                LeftMenuTopView(mainMenu: $mainMenu)
                
                if menu == "suggestions"{
                    Suggestions()
                }
                else if menu == "friends"{
                    FriendsView()
                }
                else if menu == "requests"{
                    RequestsView()
                }
                
                VStack{
                    
                    Spacer()
                    
                    ZStack{
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 22)
                                    .frame(width: width * 0.7, height: 40)
                                    .foregroundColor(Color(red: 20/255, green: 20/255, blue: 20/255))
                                
                                HStack(spacing: 4){
                                    Capsule()
                                        .frame(width: 100, height: 28)
                                        .foregroundColor(Color(red: 46/255, green: 46/255, blue: 48/255))
                                    
                                        .opacity(menu == "suggestions" ? 1 : 0)
                                    
                                        .overlay(
                                            
                                            Text("Suggestions")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14))
                                            
                                        )
                                        .onTapGesture {
                                            self.menu = "suggestions"
                                        }
                                    Capsule()
                                        .frame(width: 70, height: 28)
                                        .foregroundColor(Color(red: 46/255, green: 46/255, blue: 48/255))
                                        .opacity(menu == "friends" ? 1 : 0)
                                        .overlay(
                                            
                                            Text("Friends")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14))
                                            
                                        ).onTapGesture {
                                            self.menu = "friends"
                                        }
                                    Capsule()
                                        .frame(width: 75, height: 28)
                                        .foregroundColor(Color(red: 46/255, green: 46/255, blue: 48/255))
                                        .opacity(menu == "requests" ? 1 : 0)
                                        .overlay(
                                            
                                            Text("Requests")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14))
                                            
                                        )
                                        .onTapGesture {
                                            self.menu = "requests"
                                        }
                                }
                            }
                        }
                        .zIndex(1)
                        LinearGradient(colors: [.black, .white.opacity(0)], startPoint: .bottom, endPoint: .top)
                            .ignoresSafeArea()
                            .frame(height: 60)
                            .opacity(0.8)
                    }
                }
            }
        }
    }
}

struct LeftMenu_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenu(mainMenu: .constant("left"))
    }
}
