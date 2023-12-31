//
//  ThreeDots.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/11/23.
//

import SwiftUI

struct ThreeDots: View {
    var size: CGFloat
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .foregroundColor(color)
                .font(.system(size: size))
            
            Image(systemName: "circle.fill")
                .foregroundColor(color)
                .font(.system(size: size))
                .padding(.leading, -4)
            
            Image(systemName: "circle.fill")
                .foregroundColor(color)
                .font(.system(size: size))
                .padding(.leading, -4)
        }
    }
}

struct ThreeDots_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDots(size: 4, color: .black)
    }
}
