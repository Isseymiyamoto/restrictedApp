//
//  AppDelegate.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/10.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        //データベースの定義
        let db = Firestore.firestore()
        
        
        //以下tabbarに関する記述
        //tabに設定するViewControllerのインスタンス作成
//        let myFirstTab: UIViewController = HomeViewController()
//        let mySecondTab: UIViewController = RankingViewController()
//        let myThirdTab: UIViewController = RecordViewController()
//
//        //タブを要素に持つArrayの.を作成する
//        let myTabs = NSArray(objects: myFirstTab,mySecondTab,myThirdTab)
//
//        //UITabControllerを作成する
//        let myTabBarController: UITabBarController = UITabBarController()
//
//        //ViewControllerを設定する
//        myTabBarController.setViewControllers(myTabs as? [UIViewController], animated: false)
//
//        //RootViewControllerに設定する
//        window!.rootViewController = myTabBarController
//
//        //windowを表示する
//        window!.makeKeyAndVisible()
//
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

