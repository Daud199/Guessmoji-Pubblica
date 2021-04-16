//
//  GuessmojiApp.swift
//  Guessmoji
//
//  Created by Alice Roncella on 13/03/21.
//

import SwiftUI

class UserObservableObject: ObservableObject {
    @Published var username:String = "VolpeAzzurra"
    @Published var userEmoji:String = "🦊"
    @Published var userBG:String = "lightBlue"
}

class Set: ObservableObject {
    static let shared = Set()
    @Published var musicOn:Bool = true
    @Published var soundOn:Bool = true
    @Published var showSettings:Bool = false
    @Published var showHelp:Bool = false
    @Published var isShareSheetShowing:Bool = false
    @Published var isHelpSheetShowing:Bool = false
    @Published var start:Bool = true
}

@main
struct GuessmojiApp: App {
    @StateObject var userObservableObject: UserObservableObject = UserObservableObject()
    @StateObject var set: Set = Set()

    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(self.userObservableObject)
                .environmentObject(self.set)
                .environment(\.multilineTextAlignment, .center)

                .onAppear(perform: {
                            userModelView().iconRandom(userObservableObject: userObservableObject)
                })
        }
    }
}
