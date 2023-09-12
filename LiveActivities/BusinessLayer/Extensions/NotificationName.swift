//
//  NotificationName.swift
//  LiveActivities
//
//  Created by Saheem Hussain on 08/09/23.
//

import Foundation

extension Notification.Name {
    
    static var play: Notification.Name {
        return .init(rawValue: "play") }
    
    static var pause: Notification.Name {
        return .init(rawValue: "pause") }
    
    static var previous: Notification.Name {
        return .init(rawValue: "previous") }
    
    static var next: Notification.Name {
        return .init(rawValue: "next") }
    
    static var seek: Notification.Name {
        return .init(rawValue: "seek") }
}
