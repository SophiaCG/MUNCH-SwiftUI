//
//  MUNCH_SwiftUIApp.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI
import Firebase

@main
struct MUNCH_SwiftUIApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared

    @State var text: String = ""
    @State var isEditing: Bool = false

    let viewModel = LogInSignUpVM()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            SignUpView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let filePath = Bundle.main.path(forResource: "GoogleService-Info-Munch", ofType: "plist")!
        let options = FirebaseOptions(contentsOfFile: filePath)
        FirebaseApp.configure(options: options!)
        return true
    }
}
