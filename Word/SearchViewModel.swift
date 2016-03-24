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
    var collinsModel: Collins = Collins()
    
    var downloadWordVoiceService: DownloadWordVoiceService!
    
    init(wordDictionary: AnyObject){
        let wordDictionary = packageData(wordDictionary)
        wordModel.word = wordDictionary["word"]! as! String
        wordModel.rate = wordDictionary["rate"]! as! Double
        wordModel.speakUK = wordDictionary["speakUK"]! as! String
        wordModel.speakUS = wordDictionary["speakUS"]! as! String
        wordModel.n = wordDictionary["n"]! as! String
        wordModel.vt = wordDictionary["vt"]! as! String
        wordModel.vi = wordDictionary["vi"]! as! String
        wordModel.adj = wordDictionary["adj"]! as! String
        wordModel.adv = wordDictionary["adv"]! as! String
    }
}

extension SearchViewModel{
    func packageData(wordDictionary: AnyObject) -> NSDictionary{
        let wordDictionary = JSON(wordDictionary)
        let word = wordDictionary["word"].stringValue
        let rate = wordDictionary["rate"].doubleValue
        
        downloadWordVoiceService = DownloadWordVoiceService(voiceURL: wordDictionary["speakUK"].stringValue)
        let speakUK = downloadWordVoiceService.downloadWordVoice()
        downloadWordVoiceService = DownloadWordVoiceService(voiceURL: wordDictionary["speakUS"].stringValue)
        let speakUS = downloadWordVoiceService.downloadWordVoice()
        
        let n = wordDictionary["n"].stringValue
        let vt = wordDictionary["vt"].stringValue
        let vi = wordDictionary["vi"].stringValue
        let adj = wordDictionary["adj"].stringValue
        let adv = wordDictionary["adv"].stringValue
        
        let shapes = wordDictionary["shapes"].arrayValue
        //save shapes into word
        for shape in shapes {
            let shapes = Shapes(value: ["type": shape[0].stringValue, "value": shape[1].stringValue ])
            wordModel.shapes.append(shapes)
        }
        
        let collins = wordDictionary["WordCollins"].arrayValue
        //save collins into word
        for value in collins {
            let collins = Collins(value: ["category": value["category"].stringValue, "note": value["note"].stringValue])
            //save sentence into collins
            for sentence in value["sentence"].arrayValue {
                let sentence = Sentence(value: ["en": sentence["en"].stringValue, "zh": sentence["zh"].stringValue, "voice": sentence["voice"].stringValue])
                collins.sentence.append(sentence)
            }
            wordModel.collins.append(collins)
        }
        
        return [
            "word": word,
            "rate": rate,
            "speakUK": speakUK.absoluteString,
            "speakUS": speakUS.absoluteString,
            "n": n,
            "vt": vt,
            "vi": vi,
            "adj": adj,
            "adv": adv,
        ]
    }
}

protocol SearchViewDelegate: class{
}
