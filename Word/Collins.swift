//
//  Collins.swift
//  Word
//
//  Created by marquis on 16/3/21.
//  Copyright © 2016年 marquis. All rights reserved.
//

import RealmSwift

class Collins: Object {
    dynamic var category = ""
    dynamic var note = ""
    let sentence = List<Sentence>()
    
    dynamic var owner: Word?
}

class Sentence: Object {
    dynamic var en = ""
    dynamic var zh = ""
    dynamic var voice = ""
}
