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

    class func inset(data: Word?) -> Bool {
        let realm = try! Realm()
        
        try! realm.write{
            realm.add(data!)
        }
        
        return true
    }
    
    class func delete(key: String) -> Bool {
        let realm = try! Realm()
        
        var word: Word!
        word = realm.objectForPrimaryKey(Word.self, key: key)
        
        if word != nil {
            try! realm.write{
                realm.delete(word)
            }
            return true
        }else{
            return false
        }
    }
    
    class func update(key: String, isRusty: Bool) -> Bool {
        let realm = try! Realm()
        
        var word: Word!
        word = realm.objectForPrimaryKey(Word.self, key: key)
        
        if word != nil{
            try! realm.write{
                word.isRusty = isRusty
            }
            return true
        }else{
            return false
        }
    }
    
    class func wordDataByWord(word: String) -> Results<Word> {
        let realm = try! Realm()
    
        return realm.objects(Word).filter("word = '\(word)'").sorted("createdAt", ascending: false)
    }
    
    class func findByIsRusty(isRusty: Bool) -> Results<Word>{
        let realm = try! Realm()
        
        let predicate = NSPredicate(format: "isRusty == %@", NSNumber(bool: isRusty))
        return realm.objects(Word).filter(predicate).sorted("createdAt", ascending: false)
    }
    
}
