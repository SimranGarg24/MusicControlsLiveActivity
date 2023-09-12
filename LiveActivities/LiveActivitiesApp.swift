//
//  LiveActivitiesApp.swift
//  LiveActivities
//
//  Created by ChicMic on 10/08/23.
//

import SwiftUI
import AVFoundation

@main
struct LiveActivitiesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    //    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        AVMusicPlayer.shared.configureAudioSession()
//        UIApplication.shared.beginReceivingRemoteControlEvents()
        return true
    }
    
    //    func applicationDidEnterBackground(_ application: UIApplication) {
    //        backgroundTask = application.beginBackgroundTask { [weak self] in
    //            // Clean up or finish any tasks here
    //            application.endBackgroundTask(self?.backgroundTask ?? UIBackgroundTaskIdentifier.invalid)
    //            self?.backgroundTask = UIBackgroundTaskIdentifier.invalid
    //        }
    //    }
}
