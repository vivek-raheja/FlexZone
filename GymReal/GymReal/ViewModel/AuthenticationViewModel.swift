//
//  AuthenticationViewModel.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/16/23.
//

import SwiftUI
import Firebase

class AuthenticationViewModel: ObservableObject{
    
    @Published var name = ""
    @Published var year = Year(day: "", month: "", year: "")
    @Published var country: Country = Country(isoCode: "US")
    @Published var phoneNumber = ""
    
    @Published var otpText = ""
    
    @Published var navigationTag: String?
    
    @Published var isLoading: Bool = false
    
    @Published var verificationCode: String = ""
    
    @Published var errorMessage = ""
    @Published var showAlert = false
    
    @Published var userSession: Firebase.User?
    @Published var currentUser: User?
    
    static let shared = AuthenticationViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    
    
    func sendOTP() async {
        if isLoading {
            return
        }
        do {
            isLoading = true
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("+\(country.phoneCode)\(phoneNumber)", uiDelegate: nil)
            DispatchQueue.main.async {
                self.isLoading = false
                self.verificationCode = result
                self.navigationTag = "VERIFICATION"
            }
        }
        catch {
            handleError(error: error.localizedDescription )
            print("ERROR: ")
            print(error.localizedDescription)
        }
        
    }
    
    func handleError(error: String){
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = error
            self.showAlert.toggle()
        }
    }
    
    
    func verifyOtp()async {
        do {
            isLoading = true
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationCode, verificationCode: otpText)
            let result = try await Auth.auth().signIn(with: credential)
            let db = Firestore.firestore()
            
            db.collection("users").document(result.user.uid).setData([
                "fullname" : name,
                "date" : year.date,
                "id" : result.user.uid,
                "phone" : "+\(country.phoneCode)\(phoneNumber)"
                
            ]) { err in
              
                if let err = err{
                    print(err.localizedDescription)
                }
                
            }
            
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                let user = result.user
                self.userSession = user
                self.currentUser = User(name: name, date: year.date, phone: "+\(country.phoneCode)\(phoneNumber)")
                print(user.uid)
            }
        }
        catch {
            print("ERROR")
            handleError(error: error.localizedDescription)
        }
    }
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    func fetchUser(){
        guard let uid = userSession?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, err in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            
            guard let user = try? snapshot?.data(as: User.self) else {return}
            self.currentUser = user
            print("ERROR")
            print(user)
        }
    }
    
    func saveUserData(data: [String: Any]) async {
        guard let userId = userSession?.uid else { return }
        
        do {
            try await Firestore.firestore().collection("users").document(userId).updateData(data as [String: Any])
        }
        catch{
            handleError(error: error.localizedDescription)
        }
        
        
    }
    
    func uploadProfileImage(image: UIImage, completion: @escaping(String) -> Void) {
        ImageUploader.uploadImage(image: image, type: .profile) { url in
            completion(url)
        }
    }
    
}
