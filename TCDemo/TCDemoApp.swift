//
//  TCDemoApp.swift
//  TCDemo
//
//  Created by Abdelhakim SAID on 23/05/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct TCDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var modelData = ModelData()

    init()
    {
        TCExample.initTCServerSide()
        TCExample.initTCConsent(callback: TCExample())
    }
    
    var body: some Scene {
        WindowGroup {                                        
            ContentView()
                .environmentObject(modelData)
        }
    }
}
