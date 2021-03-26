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


@main
struct GuessmojiApp: App {
    let userObservableObject: UserObservableObject = UserObservableObject()
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(self.userObservableObject)
                //.environment(\.multilineTextAlignment(.center), .foregroundColor(.black))
                .onAppear(perform: {
                            userModelView().iconRandom(userObservableObject: userObservableObject)
                })
        }
    }
}
