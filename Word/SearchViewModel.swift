//
//  WordViewModel.swift
//  Word
//
//  Created by marquis on 16/3/21.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SearchViewModel {
    
    weak var delegate: SearchViewDelegate?
    var word: Word?
    
    init(wordDictionary: AnyObject){
        word!.word = ((packageData(wordDictionary) as NSDictionary)["word"] as! String)
    }
}

extension SearchViewModel{
    func packageData(wordDictionary: AnyObject) -> NSDictionary{
        let wordDictionary = JSON(wordDictionary)
        let word = wordDictionary["word"].stringValue
        
        return [
            "word": word
        ]
    }
}

protocol SearchViewDelegate: class{
}
