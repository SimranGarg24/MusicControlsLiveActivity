//
//  Song Model.swift
//  LiveActivities
//
//  Created by Saheem Hussain on 08/09/23.
//

import Foundation

struct Song {
    var songName: String
    var songImage: String
    var singername: String
    var duration: TimeInterval
    var songFile: String
    
    static func getData() -> [Song] {
        
        let songArray = [
            Song(songName: "How Far", songImage: "song", singername: "Saimie Bower,laddy gaga, katty perry", duration: AVMusicPlayer.shared.getSongDuration(songFile: "song"), songFile: "song"),
            Song(songName: "Unstopable", songImage: "song1", singername: "Sia", duration: AVMusicPlayer.shared.getSongDuration(songFile: "guitar"), songFile: "guitar")
        ]
        
        return songArray
    }
}
