//
//  DownLoadWordVoiceService.swift
//  Word
//
//  Created by marquis on 16/3/23.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import Alamofire

class DownloadWordVoiceService {
    
    var voiceURL: NSURL?
    
    init(voiceURL: String){
        self.voiceURL = NSURL(string: voiceURL)
    }
    
}

// MARK: - Download Voice
extension DownloadWordVoiceService{

    func downloadWordVoice() -> NSURL{
//        Alamofire.download(.GET, voiceURL!) { temporaryURL, response in
//            let fileManager = NSFileManager.defaultManager()
//            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
//            let pathComponent = response.suggestedFilename
//            let completeURL = directoryURL.URLByAppendingPathComponent(pathComponent!)
//            self.voiceURL = completeURL
//
//            return completeURL
//            }.response { request, response, data, error in
//                if error != nil {
//                    print("Download Error: \(error)")
//                }
//        }
        return self.voiceURL!
    }
}
