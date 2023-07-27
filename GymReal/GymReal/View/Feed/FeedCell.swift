//
//  FeedCell.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/10/23.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    var gymreal: GymReal
    var blur: Bool
    
    @ObservedObject var viewModel: FeedCellViewModel
    
    init(gymreal: GymReal, blur: Bool, viewModel: FeedCellViewModel) {
        self.gymreal = gymreal
        self.blur = blur
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack{
            Color(red: 204/255, green: 61/255, blue: 52/255)
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                //username and profile picture
                HStack{
                    
                    if let userUrl = viewModel.gymReal.user?.profileImageUrl {
                        KFImage(URL(string: userUrl))
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                    }
                    else{
                        Circle()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                            .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                            .overlay(
                                
                                Text(viewModel.gymReal.username.prefix(1).uppercased())
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                    
                            )
                    }
                    
                    VStack(alignment: .leading) {
                        if let user = viewModel.gymReal.user{
                            Text(user.name)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 16))
                        }
                        Text("Naperville • 7 hr late")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                    }
                    
                    Spacer()
                    
                    ThreeDots(size: 4, color: .gray)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading){
                    ZStack{
                        ZStack{
                            
                            
                            VStack{
                                Spacer()
                                HStack{
                                    Spacer()
                                    VStack{
                                        // smiling face and comment icon
                                        Image(systemName: "bubble.left.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                            .shadow(color: .black, radius: 3, x: 1, y: 1)
                                        Image(systemName: "face.smiling.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 25))
                                            .shadow(color: .black, radius: 3, x: 1, y: 1)
                                            .padding(.top, 15)
                                    }
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 50)

                                }
                            }
                            .zIndex(1)
                            
                            VStack (alignment: .leading){
                                // display front and "add a comment"
                                
                                KFImage(URL(string: gymreal.backImageUrl))
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .scaledToFit()
                                    .cornerRadius(20)
                                

                                
                               

                            }

                            GeometryReader { g in
                                VStack{
                                    HStack{
                                        KFImage(URL(string: gymreal.frontImageUrl))
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(8)
                                            .frame(height: 160)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(.black, lineWidth: 3)
                                            )
                                            .padding(.leading)
                                        
                                        Spacer()
                                    }
                                    .padding(.top, 18)
                                    
                                    Spacer()
                                }
                            }
                        }
                        .blur(radius: blur ? 8 : 0)
                        
                        if blur {
                            VStack{
                                Image(systemName: "eye.slash.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                Text("Post to view")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                Text("To view your friends' GymReal, share yours with them.")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                                    .padding(.top, -4)
                                
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.white)
                                    .frame(width: 180, height: 40)
                                    .overlay(
                                        Text("Post a GymReal")
                                            .foregroundColor(.black)
                                            .font(.system(size: 12))
                                    )
                                    .padding(.top, 6)
                            }
                        }
                        
                    }
                    Text(blur ? "" : "Add a comment...")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 600)
        }
    }
}

//struct FeedCell_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCell()
//    }
//}
