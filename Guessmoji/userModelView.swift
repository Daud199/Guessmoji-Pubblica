//
//  userModelView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 19/03/21.
//

import Foundation

struct userModelView {
    
    func iconRandom(userObservableObject: UserObservableObject){
        let usersBg: [[String]] = [["lightBlue", "Azzurro"], ["blue", "Blu"], ["yellow", "Giallo"], ["green", "Verde"], ["red", "Rosso"], ["pink", "Rosa"], ["purple", "Viola"], ["orange", "Arancio"]]
        let usersEmojis: [[String]] = [["🐶", "Cane"], ["🐱", "Gatto"],["🐭", "Topo"],["🐰", "Coni"], ["🦊", "Volpe"], ["🐻", "Orso"], ["🐼", "Panda"], ["🐨", "Koala"], ["🐯", "Tigre"], ["🦁", "Leone"], ["🐮", "Mucca"], ["🐷", "Porco"], ["🐸", "Rana"], ["🐔", "Pollo"], ["🦉", "Gufo"], ["🐺", "Lupo"], ["🦄", "Magia"], ["🐝", "Ape"], ["🐍", "Serpe"], ["🦖", "T-rex"], ["🦕", "Dino"], ["🦡", "Tasso"], ["🤖", "Robot"], ["🎃", "Zucca"], ["👽", "Ufo"], ["👻", "Buu"], ["🔥", "Fuoco"], ["☀️", "Sole"], ["🌝", "Luna"], ["🍄", "Fungo"], ["🌵", "Cactu"], ["🌮", "Tacos"], ["🍕", "Pizza"], ["🍔", "Pane"], ["🌭", "HDog"], ["🍟", "Chips"], ["🥝", "Kiwi"], ["🍓", "Frago"], ["🍎", "Mela"], ["🥥", "Cocco"], ["🎱", "Palla"], ["🎲", "Dado"], ["🎬", "Ciak"], ["🔮", "Sfera"], ["💊", "Pill"], ["🦠", "Virus"], ["🖋", "Penna"], ["🕹", "Stick"], ["💣", "Bomba"], ["💎", "Gemma"]]
        let emoji = usersEmojis.randomElement()
        userObservableObject.userEmoji = (emoji?[0])! // sistema !?
        
        let color = usersBg.randomElement()
        userObservableObject.userBG = (color?[0])!
        userObservableObject.username = (color?[1])! + (emoji?[1])!
    }
    
}
