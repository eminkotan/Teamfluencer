//
//  Campaign.swift
//  TeamFluencer
//
//  Created by Emin Kotan on 1.12.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import Foundation

class Campaign: Decodable {
    var companyName =  String()
    var brief = String()
    var bütçe = String()
    var image = String()
    var kisiSayisi = String()
    var maxAge = String()
    var minAge = String()
    
    init(companyName: String, brief: String, bütçe: String, image: String, kisiSayisi: String, maxAge: String, minAge: String) {
        self.companyName = companyName
        self.brief = brief
        self.bütçe = bütçe
        self.image = image
        self.kisiSayisi = kisiSayisi
        self.maxAge = maxAge
        self.minAge = minAge
    }
}
