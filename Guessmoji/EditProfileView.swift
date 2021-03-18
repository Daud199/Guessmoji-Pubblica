//
//  EditProfileView.swift14
//  Guessmoji
//
//  Created by Alice Roncella on 16/03/21.
//

import SwiftUI
import Combine
import UIKit


struct EditProfileView: View {
    @Binding var username:String
    @Binding var userEmoji:String
    @Binding var userBG:String
    
    @State private var showAlertEmoji = false
    let bgValues: [[String]] = [["red", "orange", "yellow", "green"], ["pink", "purple", "blue", "lightBlue"]]
    
    func userIconRandom(){
        let usersBg: [[String]] = [["lightBlue", "Azzurro"], ["blue", "Blu"], ["yellow", "Giallo"], ["green", "Verde"], ["red", "Rosso"], ["pink", "Rosa"], ["purple", "Viola"], ["orange", "Arancio"]]
        let usersEmojis: [[String]] = [["🐶", "Cane"], ["🐱", "Gatto"],["🐭", "Topo"],["🐰", "Coni"], ["🦊", "Volpe"], ["🐻", "Orso"], ["🐼", "Panda"], ["🐨", "Koala"], ["🐯", "Tigre"], ["🦁", "Leone"], ["🐮", "Mucca"], ["🐷", "Porco"], ["🐸", "Rana"], ["🐔", "Pollo"], ["🦉", "Gufo"], ["🐺", "Lupo"], ["🦄", "Magia"], ["🐝", "Ape"], ["🐍", "Serpe"], ["🦖", "T-rex"], ["🦕", "Dino"], ["🦡", "Tasso"], ["🤖", "Robot"], ["🎃", "Zucca"], ["👽", "Ufo"], ["👻", "Buu"], ["🔥", "Fuoco"], ["☀️", "Sole"], ["🌝", "Luna"], ["🍄", "Fungo"], ["🌵", "Cactu"], ["🌮", "Tacos"], ["🍕", "Pizza"], ["🍔", "Pane"], ["🌭", "HDog"], ["🍟", "Chips"], ["🥝", "Kiwi"], ["🍓", "Frago"], ["🍎", "Mela"], ["🥥", "Cocco"], ["🎱", "Palla"], ["🎲", "Dado"], ["🎬", "Ciak"], ["🔮", "Sfera"], ["💊", "Pill"], ["🦠", "Virus"], ["🖋", "Penna"], ["🕹", "Stick"], ["💣", "Bomba"], ["💎", "Gemma"]]
        let emoji = usersEmojis.randomElement()
        userEmoji = (emoji?[0])! // sistema !?
        
        let color = usersBg.randomElement()
        userBG = (color?[0])!
        username = (color?[1])! + (emoji?[1])!
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    Image("bg").frame(minWidth: 0,
                                      maxWidth: .infinity,
                                      minHeight: 0,
                                      maxHeight: .infinity,
                                      alignment: .center
                              )
                    .opacity(0.03)
                        .background(Color.white)
                }.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: nil, content: {
                    HStack(alignment: .top, content: {
                        Spacer()
                        TextField("", text: $userEmoji)
                            //.onAppear() capire come afre comparire al load
                            .onReceive(Just(userEmoji)) {
                                inputValue in
                                if inputValue != "" && inputValue.containsOnlyEmoji == false {
                                    print("no emoji")
                                    userEmoji.removeLast()
                                    showAlertEmoji = true
                                }
                                if inputValue.count > 1 {
                                    userEmoji.removeFirst() //meglio di Apple :D non devi più cancellare un'emoji per aggiungerne un'altra, ma come selezione basta cliccarne in continuo un'altra e questa cambierà
                                    print(userEmoji)
                                }
                            }
                            .alert(isPresented: $showAlertEmoji) {
                                    Alert(title: Text("Inserisci solo Emoji"), message: Text("Se non le vedi, vai in Impostazioni > Generali > Tastiera > Tastiere > Aggiungi nuova tastiera (Emoji)"), dismissButton: .default(Text("Chiudi")))
                            }
                            .font(.system(size: 72))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 110, height: 110, alignment: .center)
                            .background(
                                Circle()
                                    .stroke(Color("grayLight"), lineWidth: 6)
                                    .background(Circle().foregroundColor(Color(userBG)))
                            )
                        
                        Button(action: userIconRandom) {
                            Text("🔄")
                                .font(.system(size: 36))
                        }
                        Spacer()
                    })
                    .padding(.leading, 55)
                    
                    //ContentViewBtn(bgValue: "red", userBG: $userBG)
                    
                    ForEach(self.bgValues, id: \.self) { row in
                        HStack (alignment: .center, spacing: nil, content: {
                            ForEach (row, id: \.self) { bgValue in
                                Button(action: {
                                    print(bgValue)
                                    self.userBG = bgValue
                                }) {
                                    Circle()
                                        .frame(width: 80, height: 80, alignment: .center)
                                        .foregroundColor(Color(bgValue))
                                }
                            }
                        }).padding(.trailing, 30)
                        .padding(.leading, 30)
                    }
                    Spacer()
                })
            }
        }
        
    }
}
