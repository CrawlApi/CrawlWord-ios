//
//  DBUtil.swift
//  Word
//
//  Created by marquis on 16/3/21.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import RealmSwift

class DBUtil {
    class func inset(data: Object?) {
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(data!)
        }
    }
    
    class func delete(key: String) {
        let realm = try! Realm()
        
        var word: Word!
        
        word = realm.objectForPrimaryKey(Word.self, key: key)
        
        if word != nil {
            try! realm.write{
                realm.delete(word)
            }
        }
    }
    
    class func update() {
        
    }
}
