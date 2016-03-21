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
    dynamic var sentence = NSData()
    
    dynamic var owner: Word?
}
