//
//  PlayVoice.swift
//  Word
//
//  Created by marquis on 16/3/25.
//  Copyright © 2016年 marquis. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation

class PlayVoiceService {
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
}

extension PlayVoiceService{
    func play(url: NSURL){
            self.player = AVPlayer(URL: url)
            player!.play()
    }
}