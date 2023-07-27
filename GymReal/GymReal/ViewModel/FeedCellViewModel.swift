//
//  FeedCellViewModel.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/26/23.
//

import SwiftUI
import Firebase

class FeedCellViewModel: ObservableObject {
    @Published var gymReal: GymReal
    
    
    init(gymReal: GymReal) {
        self.gymReal = gymReal
        fetchGymRealUser()
    }
    
    func fetchGymRealUser() {
        Firestore.firestore().collection("users").document(gymReal.userId).getDocument { snap, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            self.gymReal.user = try? snap?.data(as: User.self)
        }
    }
}
