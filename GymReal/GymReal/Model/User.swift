//
//  User.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/18/23.
//

import Firebase
import FirebaseFirestoreSwift

struct User: Decodable, Identifiable{
    @DocumentID var id: String?
    var username: String?
    var profileImageUrl: String?
    var name: String
    var date: String
    var bio: String?
    var location: String?
    var phone: String
    
    var isCurrentUser: Bool {
        return AuthenticationViewModel.shared.userSession?.uid == id
    }
    
}
