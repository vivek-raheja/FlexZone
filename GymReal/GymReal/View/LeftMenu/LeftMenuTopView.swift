//
//  LeftMenuTopView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/13/23.
//

import SwiftUI

struct LeftMenuTopView: View {
    
    @State var text = ""
    @State var isEditing = false
    
    @Binding var mainMenu: String
    
    
    var body: some View {
        VStack{
            ZStack{
                HStack{
                    
                    Spacer()
                    Button {
                        withAnimation{
                            self.mainMenu = "feed"
                        }
                    } label: {
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.white)
                    }

                }
                Text("GymReal.")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                
            }
            
            SearchBar(text: $text, isEditing: $isEditing)
            Spacer()
        }
        
    }
}

struct LeftMenuTopView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuTopView(mainMenu: .constant("left"))
    }
}
