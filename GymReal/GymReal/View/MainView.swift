//
//  MainView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/18/23.
//

import SwiftUI

struct MainView : View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        Group {
            if viewModel.userSession == nil {
                MainAuthenticationView()
            }
            else{
                if let user = viewModel.currentUser {
                    ContentView()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
