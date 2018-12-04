//
//  user.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 29.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import Foundation

class User: Decodable {
    var name = String()
    var lastName = String()
    var eMail = String()
    var phone = String()
    var password = String()
    
    var schoolType = String()
    var schoolName = String()
    var city = String()
    var instagramUserName = String()
    var instaFollower = String()
    var interests = String()
    var isCompany = Int()
    
    
    init(name: String, lastName: String, eMail: String, password: String, phone: String) {
        self.name = name
        self.lastName = lastName
        self.eMail = eMail
        self.password = password
        self.phone = phone
    }
    init(schoolType: String, schoolName: String, city: String, instagramUserName: String, instaFollower: String, interests: String ) {
        self.schoolType = schoolType
        self.schoolName = schoolName
        self.city = city
        self.instagramUserName = instagramUserName
        self.instaFollower = instaFollower
        self.interests = interests
    }
    init(isCompany: Int) {
        self.isCompany = isCompany
    }
    
}

