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
    var wordModel: Word = Word()
    
    init(wordDictionary: AnyObject){
        let wordDictionary = packageData(wordDictionary)
        wordModel.word = wordDictionary["word"]! as! String
        wordModel.rate = wordDictionary["rate"]! as! Double
    }
}

extension SearchViewModel{
    func packageData(wordDictionary: AnyObject) -> NSDictionary{
        let wordDictionary = JSON(wordDictionary)
        let word = wordDictionary["word"].stringValue
        let rate = wordDictionary["rate"].intValue
        
        return [
            "word": word,
            "rate": rate
        ]
    }
}

protocol SearchViewDelegate: class{
}
