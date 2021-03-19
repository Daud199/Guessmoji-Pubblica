//
//  GuessmojiApp.swift
//  Guessmoji
//
//  Created by Alice Roncella on 13/03/21.
//

import SwiftUI

class UserObservableObject: ObservableObject {
    @Published var username = "VolpeAzzurra"
    @Published var userEmoji = "🦊"
    @Published var userBG = "lightBlue"
}


@main
struct GuessmojiApp: App {
    let userObservableObject: UserObservableObject = UserObservableObject()
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(self.userObservableObject)
                .onAppear(perform: {
                            userModelView().iconRandom(userObservableObject: userObservableObject)
                })
        }
    }
}
