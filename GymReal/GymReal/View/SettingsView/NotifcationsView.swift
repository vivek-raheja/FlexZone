//
//  NotifcationsView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/14/23.
//

import SwiftUI

struct NotifcationsView: View {
    
    @State var mentions = false
    @State var comments = false
    @State var friendRequests = false
    @State var lateGymReal = false
    @State var realMojis = false
    
    @State var buttonActive = false
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack{
                    
                    ZStack{
                        
                        Text("Notifications")
                            .fontWeight(.semibold)
                            
                        
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .font(.system(size: 20))
                            }

                            
                            Spacer()
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .foregroundColor(.white)
                
                VStack{
                    VStack{
                        
                        HStack{
                            Text("On GymReal, you're in control of your push notifcations.")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        HStack{
                            Text("You can choose the type of notifications you want to recieve.")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    
                    VStack (spacing: 14){
                        VStack{
                            NotificationsButtonView(icon: "person.crop.square.filled.and.at.rectangle", text: "Mentions", toggle: $mentions)
                            
                            HStack{
                                Text("kishore.narayanan mentioned you on manavj72s GymReal")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    VStack (spacing: 14){
                        VStack{
                            NotificationsButtonView(icon: "bubble.left.fill", text: "Comments", toggle: $comments)
                            
                            HStack{
                                Text("ritziscol23 commented on your GymReal")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    VStack (spacing: 14){
                        VStack{
                            NotificationsButtonView(icon: "person.2.fill", text: "Friend requests", toggle: $friendRequests)
                            
                            HStack{
                                Text("manavj72 just sent you a friend request")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    VStack (spacing: 14){
                        VStack{
                            NotificationsButtonView(icon: "timer", text: "Late GymReal", toggle: $lateGymReal)
                            
                            HStack{
                                Text("scottyconner just posted late")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    VStack (spacing: 14){
                        VStack{
                            NotificationsButtonView(icon: "face.smiling.fill", text: "RealMojis", toggle: $realMojis)
                            
                            HStack{
                                Text("advinpalle just reacted to your GymReal")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                    }
                    .padding(.top, 8)
                    
                    Spacer()

                    
                }
                .padding(.horizontal)
                .padding(.top, 50)
                
                VStack{
                    Spacer()
                    WhiteButtonView(buttonActive: $buttonActive, text: "Save")
                        .onChange(of: mentions || comments || friendRequests || lateGymReal || realMojis) { _ in
                            self.buttonActive = true
                        }
                    
                }

            }
        }
    }
}

struct NotifcationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotifcationsView()
    }
}
