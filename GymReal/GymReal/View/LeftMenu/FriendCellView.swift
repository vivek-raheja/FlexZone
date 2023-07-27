//
//  FriendCellView.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/13/23.
//

import SwiftUI

struct FriendCellView: View {
    var body: some View {
        HStack{
            Image("pp")
                .resizable()
                .scaledToFit()
                .frame(width: 65, height: 65)
                .cornerRadius(65/2)
            
            VStack(alignment: .leading){
                Text("Kishore")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text("kishore.narayanan")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .font(.system(size: 16))
                .padding(.leading, 6)
            
        }
        .padding(.horizontal)
    }
}

struct FriendCellView_Previews: PreviewProvider {
    static var previews: some View {
        FriendCellView()
    }
}
