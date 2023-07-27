//
//  Feed.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/10/23.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    
    @Binding var mainMenu: String
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @ObservedObject var feedModel: FeedViewModel
    
    @State var cameraViewPresented = false
    
    init(feedModel: FeedViewModel, menu: Binding<String>){
        self.feedModel = feedModel
        self._mainMenu = menu
    }
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                ZStack{
                    
                    ScrollView{
                        VStack{
                            
                            if !feedModel.blur {
                                VStack{
                                    VStack{
                                        ZStack{
                                            VStack(alignment: .leading){
                                                
                                                KFImage(URL(string: feedModel.gymreal.backImageUrl))
                                                    .resizable()
                                                    .scaledToFit()
                                                    .cornerRadius(5)
                                                
                                                     
                                            }
                                            VStack{
                                                HStack{
                                                    
                                                    KFImage(URL(string: feedModel.gymreal.frontImageUrl))
                                                        .resizable()
                                                        .scaledToFit()
                                                        .border(.black)
                                                        .cornerRadius(2)
                                                        .frame(width: 20, height: 40)
                                                        .padding(.leading)
                                                    Spacer()
                                                }
                                                .padding(.top, 18)
                                                Spacer()
                                            }
                                        }
                                        .frame(width: 100)
                                    }
                                    VStack{
                                        Text("Add a Caption")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                        Text("View Comment")
                                            .foregroundColor(.gray)
                                        HStack{
                                            Text("Naperville, Illinois • 7 hr late ")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 12))
                                            ThreeDots(size: 3, color: .gray)
                                        }
                                    }
                                }
                            }
                            
                            
                            ForEach(self.feedModel.gymreals, id: \.backImageUrl){ gymreal in
                                FeedCell(gymreal: gymreal, blur: feedModel.blur, viewModel: FeedCellViewModel(gymReal: gymreal))
                                    .onAppear{
                                        guard let userId = AuthenticationViewModel.shared.currentUser?.id else {return}
                                        
                                        if (self.feedModel.blur == true){
                                            if (gymreal.userId == userId){
                                                self.feedModel.blur = false
                                            }
                                            else{
                                                self.feedModel.blur = true
                                            }
                                        }
                                    }
                            }
                            
                        }
                        .padding(.top, 80)
                    }
                    
                    
                    VStack{
                        VStack{
                            HStack{
                                Button {
                                    withAnimation{
                                        self.mainMenu = "left"
                                    }
                                } label: {
                                    Image(systemName: "figure.run")
                                        .foregroundColor(.white)
                                }

                                
                                Spacer()
                                
                                Text("GymReal.")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .font(.system(size: 22))
                                
                                Spacer()
                                
                                Button {
                                    withAnimation{
                                        self.mainMenu = "profile"
                                    }
                                } label: {
                                    if let profileImageUrl = viewModel.currentUser!.profileImageUrl {
                                        KFImage(URL(string: profileImageUrl))
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .cornerRadius(17.5)
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
    //                                Image("pp")
    //                                    .resizable()
    //                                    .frame(width:35, height: 35)
    //                                    .cornerRadius(17.5)
                                }

                            }
                            .padding(.horizontal)
                            
                            HStack{
                                Text("My Friends")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                
                                Text("Discovery")
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            if feedModel.blur {
                                HStack{
                                    VStack{
                                        Image(systemName: "circle")
                                            .font(.system(size: 80))
                                        Text("Post a late GymReal")
                                            .font(.system(size: 14))
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(.white)
                                    .padding(.bottom, 12)
                                    .onTapGesture {
                                        self.cameraViewPresented.toggle()
                                    }
                                }
                            }
                            
                        }
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 1)
                    }
                }
            }
            .onAppear{
                KingfisherManager.shared.cache.clearMemoryCache()
            }
            
        }.fullScreenCover(isPresented: $cameraViewPresented) {
            
        } content: {
            CameraView(viewModel: CameraViewModel(user: AuthenticationViewModel.shared.currentUser!))
        }

    }
}

//struct Feed_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView(mainMenu: .constant("feed"))
//    }
//}
