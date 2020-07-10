//
//  SceneDelegate.swift
//  AltStore
//
//  Created by Riley Testut on 7/6/20.
//  Copyright © 2020 Riley Testut. All rights reserved.
//

import UIKit

@available(iOS 13, *) @objc(SceneDelegate)
class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions)
    {
        // Use this method to optionally configure and attach the
        // UIWindow `window` to the provided UIWindowScene `scene`.
      
        // If using a storyboard, the `window` property will
        // automatically be initialized and attached to the scene.
      
        // This delegate doesn't imply the connecting scene or session are new
        // (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneWillEnterForeground(_ scene: UIScene)
    {
        // applicationWillEnterForeground is _not_ called when launching app,
        // whereas sceneWillEnterForeground _is_ called when launching.
        // As a result, DatabaseManager might not be started yet, so just return if it isn't
        // (since all these methods are called separately during app startup).
        guard DatabaseManager.shared.isStarted else { return }
        
        AppManager.shared.update()
        
        ServerManager.shared.startDiscovering()
        PatreonAPI.shared.refreshPatreonAccount()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene)
    {
        ServerManager.shared.stopDiscovering()
    }
}
