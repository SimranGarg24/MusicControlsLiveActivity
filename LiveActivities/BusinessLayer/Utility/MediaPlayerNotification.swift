////
////  MediaPlayerNotification.swift
////  LiveActivities
////
////  Created by Saheem Hussain on 07/09/23.
////
//
import SwiftUI
import Foundation
import MediaPlayer

class MediaPlayerNotification {
    
    var nowPlayingInfo = [String: Any]()
    static let shared = MediaPlayerNotification()
    
    private init() {
        //        registerTargetForRemoteCommands()
        addActionsToControlCenter()
//        NotificationCenter.default.addObserver(self, selector: #selector(updateSeekbar), name: .seek, object: nil)
    }
    
    //    func registerTargetForRemoteCommands() {
    //         MPRemoteCommandCenter.shared().togglePlayPauseCommand.addTarget(handler: togglePlayPause)
    //    }
    //
    //    func togglePlayPause(event: MPRemoteCommandEvent) -> MPRemoteCommandHandlerStatus {
    //         // Handle remote event by updating your app's state here
    //         return .success // or .commandFailed
    //    }
    // Change to .playing if the music is currently playing
    func addActionsToControlCenter() {
        
        let commandCenter = MPRemoteCommandCenter.shared()
        
        commandCenter.playCommand.addTarget {event in
            // Handle play command (e.g., start playback)
            //            MPNowPlayingInfoCenter.default().playbackState = .playing
            NotificationCenter.default.post(name: .play, object: nil)
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { event in
            // Handle pause command (e.g., pause playback)
            //            MPNowPlayingInfoCenter.default().playbackState = .paused
            NotificationCenter.default.post(name: .pause, object: nil)
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { event in
            NotificationCenter.default.post(name: .previous, object: nil)
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { event in
            NotificationCenter.default.post(name: .next, object: nil)
            return .success
        }
        
        commandCenter.changePlaybackPositionCommand.addTarget { event in
//            NotificationCenter.default.post(name: .seek, object: nil)
            return .success
        }
    }
    
    func setupNotificationView(song: Song) {
        
        nowPlayingInfo = [
            MPMediaItemPropertyTitle: song.songName,
            MPMediaItemPropertyArtist: song.singername,
            MPMediaItemPropertyPlaybackDuration: song.duration,
        ]
        
        if let img = UIImage(named: song.songImage) {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: img.size, requestHandler: { (size) -> UIImage in
                return img
            })
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        
        // Set up playback state (playing or paused)
        //        MPNowPlayingInfoCenter.default().playbackState = .playing // Change to .playing if the music is currently playing
    }
    
//    @objc func updateSeekbar(_ notification: Notification) {
//        updateSeekBar()
//    }
    
    func updateSeekBar() {
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = AVMusicPlayer.shared.getCurrentTime()
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 1
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
