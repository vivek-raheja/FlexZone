//
//  GymRealApp.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/10/23.
//

import SwiftUI
import FirebaseCore

@main
struct GymRealApp: App {
   
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init(){
        UITextView.appearance().backgroundColor = .clear
    }
  
    
    var body: some Scene { 
        WindowGroup {
            MainView().environmentObject(AuthenticationViewModel.shared)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
}
