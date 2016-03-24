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
    let shapes = List<Shapes>()
    
    dynamic var isRusty = false
    
    let collins = List<Collins>()
    dynamic var createdAt = NSDate()
    
    override static func primaryKey() -> String? {
        return "word"
    }
}

class Shapes: Object {
    dynamic var type = ""
    dynamic var value = ""
}
 