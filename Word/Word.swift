//
//  Word.swift
//  Word
//
//  Created by marquis on 16/3/21.
//  Copyright © 2016年 marquis. All rights reserved.
//

import RealmSwift

class Word: Object {
    dynamic var word = ""
    dynamic var speakUK = ""
    dynamic var speakUS = ""
    dynamic var rate = 0.0
    dynamic var n = ""
    dynamic var vt = ""
    dynamic var vi = ""
    dynamic var adj = ""
    dynamic var adv = ""
    dynamic var shapes = NSData()
    dynamic var createdAt = ""
    
    dynamic var isRusty = false
    
    override static func primaryKey() -> String? {
        return "word"
    }
    
    let collins = List<Collins>()
}
 