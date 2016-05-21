//
//  Hero.swift
//  DotaLobby
//
//  Created by Kamal Dandamudi on 5/16/16.
//  Copyright © 2016 SillyApps. All rights reserved.
//

import Foundation


class Hero{
    var heroDotaName:String!
    var heroLocalizedName:String!
    var heroID:Int!
    var largeImageURL:String?
    var smallImageURL:String?
    var portraitImageURL:String?
    var heroSoundURL:String = ""
    init(heroDotaName:String,heroLocalizedName:String,heroID:Int,largeImageURL:String,smallImageURL:String,portraitImageURL:String){
        self.heroDotaName = heroDotaName
        self.heroLocalizedName = heroLocalizedName
        self.heroID = heroID
        self.largeImageURL = largeImageURL
        self.smallImageURL = smallImageURL
        self.portraitImageURL = portraitImageURL
    }
}