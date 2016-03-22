//
//  WordDataService.swift
//  Word
//
//  Created by marquis on 16/3/21.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WordDataService {
    
    var baseURL = NSString(string: wordApi)
    var completeURL: NSURL?
    
    weak var delegate: WordDataDelegate?
    
    init(delegate: WordDataDelegate, word: String){
        self.delegate = delegate
        self.completeURL = NSURL(string: (baseURL as String) + "\(word)")
    }
}

extension WordDataService{
    func getWordData() -> Void {
        Alamofire.request(.GET, completeURL!, encoding: .JSON)
            .responseJSON { response in
                if response.result.isSuccess {
                    if let wordDate = response.result.value{
                        //解析JSON
                        let searchViewModel = SearchViewModel(wordDictionary: wordDate)
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.delegate?.showInSearch(searchViewModel)
                            self.delegate?.loadingDialog(true, msg: "success")
                        })
                    }
                }else{
                    print("\(response.result.error)")
                    self.delegate?.loadingDialog(false, msg: "api error")
                }
        }
    }
}

protocol WordDataDelegate: class{
    func showInSearch(searchViewModel: SearchViewModel)
    func loadingDialog(isShow:Bool, msg: String)
}
