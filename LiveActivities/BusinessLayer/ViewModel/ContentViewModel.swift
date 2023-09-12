//
//  ContentViewModel.swift
//  LiveActivities
//
//  Created by Saheem Hussain on 08/09/23.
//

import Foundation
import ActivityKit

class ContentViewModel: ObservableObject {
    
    @Published var activity: Activity<NotificationAttributes>?
    @Published var isPaused: Bool = true
    @Published var index = 0
    @Published var sliderValue : TimeInterval = 0.0
    
    let player = AVMusicPlayer.shared
    var song: [Song] = Song.getData()
    var timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    
    
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(playSong), name: .play, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pauseSong), name: .pause, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(previousTrack), name: .previous, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nextTrack), name: .next, object: nil)
    }
    
    @objc func playSong(_ notification: Notification) {
        isPaused = false
        playPauseSong()
    }
    
    @objc func pauseSong(_ notification: Notification) {
        isPaused = true
        playPauseSong()
    }
    
    @objc func previousTrack(_ notification: Notification) {
        previousSong()
    }
    
    @objc func nextTrack(_ notification: Notification) {
        nextSong()
    }
    
    func playPauseSong() {
        
        if !isPaused {
            startTimer()
            player.play()
            startActivity(data: song[index])
        } else {
            player.pause()
            stopActivity()
            stopTimer()
            
        }
        MediaPlayerNotification.shared.updateSeekBar()
    }
    
    func previousSong() {
        index = index <= 0  ?  0  : index - 1
        player.stop()
        stopTimer()
        changeSong()
    }
    
    func nextSong() {
        index = index >= song.count - 1 ?  song.count - 1 : index + 1
        player.stop()
        stopTimer()
        changeSong()
    }
    
    func changeSong() {
        sliderValue = 0.0
        update(data: song[index])
        player.setAVPlayer(songFile: song[index].songFile)
        MediaPlayerNotification.shared.setupNotificationView(song: song[index])
        isPaused  = false
        playPauseSong()
        
    }
    
    func changeSliderValue() {
        
        if !isPaused {
            if let currentTime = player.getCurrentTime() {
                
                if sliderValue != 0.0 && currentTime == 0.0 {
                    if index != song.count - 1 {
                        nextSong()
                    } else {
                        isPaused = true
                        playPauseSong()
                    }
                }
                
                sliderValue = currentTime
            }
        } else {
            stopTimer()
        }
        
    }
    
    func changeSongPosition() {
        
        player.setCurrentTime(time: sliderValue)
        
        if !isPaused {
            startTimer()
        }
    }
    
    func startTimer() {
        timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startActivity(data: Song) {
        
        let attribute = NotificationAttributes(name: "Rajan")
        let state = NotificationAttributes.notificationValue(songName: data.songName, songImage: data.songImage, singerName: data.singername, isPlay: isPaused, value: data.duration)
        
        activity =  try? Activity<NotificationAttributes>.request(attributes: attribute, contentState: state)
    }
    
    func stopActivity() {
        Task {
            for activity in Activity<NotificationAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
        
    }
    
    func update(data: Song) {
        Task{
            let state = NotificationAttributes.notificationValue(songName: data.songName, songImage: data.songImage, singerName: data.singername, isPlay: isPaused, value: data.duration)
//            let alertConfiguration = AlertConfiguration(title: "Song update", body: "\(data.songName)", sound: .default)
            await activity?.update(using:state,alertConfiguration: nil)
            
        }
    }
}
