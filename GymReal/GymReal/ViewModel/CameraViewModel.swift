//
//  CameraViewModel.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/26/23.
//

import Foundation
import Firebase
import FirebaseFirestore

class CameraViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func takePhoto(backImage: UIImage, frontImage: UIImage, completion: @escaping(String, String) -> Void) {
        ImageUploader.uploadImage(image: backImage, type: .post) { urlBackImage in
            ImageUploader.uploadImage(image: frontImage, type: .post) { urlFrontImage in
                completion(urlBackImage, urlFrontImage)
            }
        }
    }
    
    func postGymReal(frontImageUrl: String, backImageUrl: String) async {
        let db = Firestore.firestore()
        let date = Date.now
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yy"
        
        let dateString = formatter.string(from: date)
        print(dateString)
        
        do {
            try await db.collection("posts").document("\(dateString)").collection("gymreals").document(user.id!)
                .setData([
                    "frontImageUrl" : frontImageUrl,
                    "backImageUrl" : backImageUrl,
                    "userId" : user.id,
                    "username" : user.name
                ])
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
}
