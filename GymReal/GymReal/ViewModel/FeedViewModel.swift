//
//  FeedViewModel.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/26/23.
//

import SwiftUI
import Firebase

class FeedViewModel: ObservableObject {
    
    @Published var gymreals = [GymReal]()
    
    @Published var gymreal = GymReal(username: "", frontImageUrl: "", backImageUrl: "", userId: "")
    
    @Published var blur = true
    
    let user: User
    
    init(user: User) {
        let date = Date.now
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        let dateString = formatter.string(from: date)
        
        self.user = user
        
        Task{
            
            if let userId = AuthenticationViewModel.shared.currentUser?.id {
                await fetchOwnPost(date: dateString, userId: userId)
            }
            
            
            await fetchData(date: dateString)
        }
    }
    
    func fetchData(date: String) async {
        let db = Firestore.firestore()
        
        
        do {
            let data = try await db.collection("posts").document(date).collection("gymreals").getDocuments()
            
            self.gymreals = data.documents.compactMap({ try? $0.data(as: GymReal.self)})
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchOwnPost(date: String, userId: String) async {
        let db = Firestore.firestore()
        
        do {
            let data = try await db.collection("posts").document(date).collection("gymreals").document(userId).getDocument()
            self.gymreal = try data.data(as: GymReal.self)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}

