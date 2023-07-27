//
//  EditProfile.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/12/23.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @State var fullname: String
    @State var username: String
    @State var bio: String
    @State var location: String
    @State var width = UIScreen.main.bounds.width
    
    
    @Environment(\.dismiss) var dismiss
    
    let currentUser: User
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State var imagePickerPresented = false
    
    @State private var selectedImage: UIImage?
    
    @State var profileImage: Image?

    init(currentUser: User){
        self.currentUser = currentUser
        self._fullname = State(initialValue: currentUser.name)
        self._bio = State(initialValue: currentUser.bio ?? "")
        self._username = State(initialValue: currentUser.username ?? "")
        self._location = State(initialValue: currentUser.location ?? "")
    }
    
    
    var body: some View {
        VStack{
            ZStack{
                Color(red: 204/255, green: 61/255, blue: 52/255)
                    .ignoresSafeArea()
                
                VStack{
                    ZStack{
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()

                            Button {
                                Task{ await saveData() }
                                dismiss()
                            } label: {
                                Text("Save")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.horizontal, width * 0.05)
                        
                        Text("Edit Profile")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    HStack{
                        Spacer()
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.7)
                    }
                    
                    Spacer()
                }
                
                VStack{
                    VStack{
                        Button {
                            self.imagePickerPresented.toggle()
                        } label: {
                            ZStack(alignment: .bottomTrailing){
                                
    //                            Image("pp")
    //                                .resizable()
    //                                .scaledToFit()
    //                                .frame(width: 120, height: 120)
    //                                .cornerRadius(60)
                                
                                if currentUser.profileImageUrl != nil && profileImage == nil {
                                    if let profileImageUrl = currentUser.profileImageUrl {
                                        KFImage(URL(string: profileImageUrl))
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .cornerRadius(60)
                                    }
                                }
                                
                                else if let image = profileImage{
                                    image
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                }
                                else{
                                    Circle()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(60)
                                        .foregroundColor(Color(red: 152/255, green: 163/255, blue: 16/255))
                                        .overlay(
                                            Text(viewModel.currentUser!.name.prefix(1).uppercased())
                                                .foregroundColor(.white)
                                                .font(.system(size: 55))
                                        )
                                    
                                }
                                
                                ZStack{
                                    ZStack{
                                        Circle()
                                            .frame(width: 34, height: 34)
                                            .foregroundColor(.black)
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.white)
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.black)
                                            .opacity(0.1)
                                    }
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16))
                                        .shadow(color: .white, radius: 1, x: 1, y: 1)
                                }
                            }

                        }
                        .sheet(isPresented: $imagePickerPresented) {
                            loadImage()
                        } content: {
                            ImagePicker(image: $selectedImage)
                        }
                    }
                    
                    // MENU
                    VStack{
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack{
                            HStack{
                                Text("Full Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .frame(width: width * 0.22)
                            
                            HStack{
                                TextField("", text: $fullname)
                                    .font(.system(size: 15))
                                    .placeholder(when: fullname.isEmpty) {
                                        Text(viewModel.currentUser!.name).foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, width * 0.05)
                                Spacer()
                            }
                            .frame(width: width * 0.63)
                        }
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack{
                            HStack{
                                Text("Username")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .frame(width: width * 0.22)
                            
                            HStack{
                                TextField("", text: $username)
                                    .font(.system(size: 15))
                                    .placeholder(when: username.isEmpty) {
                                        Text("vivekraheja").foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, width * 0.05)
                                Spacer()
                            }
                            .frame(width: width * 0.63)
                        }
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack(alignment: .top){
                            HStack{
                                Text("Bio")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .padding(.leading, -4)
                            .frame(width: width * 0.2)
                            
                            if #available(iOS 16, *){
                                TextEditor(text: $bio)
                                    .foregroundColor(.white)
                                    .background(Color(red: 204/255, green: 61/255, blue: 52/255))
                                    .scrollContentBackground(.hidden)
                                    .frame(height: 100)
                                    .padding(.leading, width * 0.05)
                                    .overlay(
                                    
                                        
                                        VStack{
                                            HStack{
                                                if currentUser.bio == "" {
                                                    Text("Bio")
                                                        .foregroundColor(.gray)
                                                        .font(.system(size: 16))
                                                        .zIndex(1)
                                                        .padding(.top, 8)
                                                        .padding(.leading, 24)
                                                }
                                                Spacer()
                                            }
                                            Spacer()

                                        }
                                    )
                                    .padding(.top, -8)
                                    .frame(width: width * 0.63)

                            }
                        }
                        Rectangle()
                            .frame(width: width * 0.9, height: 0.7)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        HStack{
                            HStack{
                                Text("Location")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16))
                                Spacer()
                            }
                            .frame(width: width * 0.22)
                            
                            HStack{
                                TextField("", text: $location)
                                    .font(.system(size: 15))
                                    .placeholder(when: location.isEmpty) {
                                        Text("Location").foregroundColor(.gray)
                                            .font(.system(size: 16))
                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, width * 0.05)
                                Spacer()
                            }
                            .frame(width: width * 0.63)
                        }
                    }
                    .padding(.horizontal, width * 0.05)
                    .padding(.top, 24)
                    
                    Spacer()
                }
                .padding(.top, UIScreen.main.bounds.height * 0.08)
                
            }
        }
    }
    
    func saveData() async {
        if viewModel.currentUser!.name != self.fullname && !self.fullname.isEmpty {
            viewModel.currentUser!.name = self.fullname
            await viewModel.saveUserData(data: ["name": self.fullname])
        }
        if viewModel.currentUser!.username != self.username && !self.username.isEmpty {
            viewModel.currentUser!.username = self.username
            await viewModel.saveUserData(data: ["username" : self.username])
        }
        if viewModel.currentUser!.bio != self.bio && !self.bio.isEmpty {
            viewModel.currentUser!.bio = self.bio
            await viewModel.saveUserData(data: ["bio" : bio])
        }
        if viewModel.currentUser!.location != self.location && !self.location.isEmpty {
            viewModel.currentUser!.location = self.location
            await viewModel.saveUserData(data: ["loaction" : location])
        }
        
        if selectedImage != nil {
            viewModel.uploadProfileImage(image: selectedImage!) { url in
                do{
                    Task{
                        viewModel.currentUser!.profileImageUrl = url
                        await viewModel.saveUserData(data: ["profileImageUrl" : url])
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
}


//struct EditProfile_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProfileView()
//    }
//}
