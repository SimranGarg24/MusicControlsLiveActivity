//
//  AVPlayer.swift
//  LiveActivities
//
//  Created by Saheem Hussain on 08/09/23.
//

import Foundation
import AVFoundation

class AVMusicPlayer {
    
    var player: AVAudioPlayer?
    static let shared = AVMusicPlayer()
    private init() {}
    
    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    func setAVPlayer(songFile: String, ofType: String = ".mp3") {
        guard let sound = Bundle.main.path(forResource: songFile, ofType: ofType) else {return}
        do {
            player =  try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
        } catch {
            print(error)
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.stop()
    }
    
    func getCurrentTime() -> TimeInterval? {
        return player?.currentTime
    }
    
    func setCurrentTime(time: TimeInterval) {
        player?.currentTime = time
        print(player?.currentTime ?? "")
    }
    
    func getSongDuration(songFile: String, ofType: String = ".mp3") -> TimeInterval {
        if let audioFilePath = Bundle.main.path(forResource: songFile, ofType: ofType) {
            let audioFileURL = URL(fileURLWithPath: audioFilePath)

            do {
                let audioAsset = AVURLAsset(url: audioFileURL)
                let durationInSeconds = CMTimeGetSeconds(audioAsset.duration)
                let duration = TimeInterval(durationInSeconds)
                
                // `duration` now contains the duration of the MP3 file in seconds
                print("Duration of the MP3 file: \(duration) seconds")
                return duration
            }
        } else {
            print("MP3 file not found in the project")
        }
        
        return 0.0
    }
    
}
