//
//  GymReal.swift
//  GymReal
//
//  Created by Vivek Raheja on 7/26/23.
//

import Foundation


struct GymReal: Decodable {
    var username: String
    var frontImageUrl: String
    var backImageUrl: String
    var userId: String
    var user: User?
}
