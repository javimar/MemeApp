//
//  AppDelegate.swift
//  JaviMarMemes
//
//  Created by Javi on 05/04/2020.
//  Copyright © 2020 JaviMar. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    // Compatibility for iOS 12 and below
    var window: UIWindow?
    
    // store meme struct in AppDelegate
    var memes = [Meme]()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
        
        
        let memes = [
            Meme(topTextField: "TOP", bottomTextField: "WORLD", originalImage: UIImage(named: "LaunchImage")!, memedImage: UIImage(named: "LaunchImage")!),
            Meme(topTextField: "JAVIER", bottomTextField: "MARTIN", originalImage: UIImage(named: "MemeGenerator_120 copy")!, memedImage: UIImage(named: "MemeGenerator_120 copy")!),
        ]
        
        for meme in memes {
            self.memes.append(meme)
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

