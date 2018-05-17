//
//  BackGroundMusicManger.swift
//  SIT305GroupProject
//
//  Created by JOHN YU on 17/5/18.
//  Copyright © 2018 SIT305. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class BackGroundMusicManger: NSObject {
    
    static let shareManger = BackGroundMusicManger();
    
    var audioPlayer: AVAudioPlayer?
    
    public func setupMusicPlayer() {
        let path = Bundle.main.path(forResource: "bgMusic", ofType: "mp3")
        let pathURL = NSURL.init(fileURLWithPath: path!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: pathURL as URL)
        } catch {
            audioPlayer = nil
        }
        
        if audioPlayer != nil {
            audioPlayer?.prepareToPlay();
        }
    }
    
    public func playMusic() {
        audioPlayer?.play();
    }
    
    public func stopMusic() {
        audioPlayer?.stop();
    }
    
}
