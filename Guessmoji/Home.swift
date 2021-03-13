//
//  Home.swift
//  Guessmoji
//
//  Created by Alice Roncella on 13/03/21.
//

import SwiftUI
import Combine // !! ? wtf


struct Home: View {
    @State private var username = "VolpeAzzurra"
    @State private var userEmoji = "🦊"
    @State private var userBG = "lightBlue"
    
    func userIconRandom(){
        let usersBg: [[String]] = [["lightBlue", "Azzurro"], ["blue", "Blu"], ["yellow", "Giallo"], ["green", "Verde"], ["red", "Rosso"], ["pink", "Rosa"], ["purple", "Viola"], ["orange", "Arancio"]]
        let usersEmojis: [[String]] = [["🐶", "Cane"], ["🐱", "Gatto"],["🐭", "Topo"],["🐰", "Coni"], ["🦊", "Volpe"], ["🐻", "Orso"], ["🐼", "Panda"], ["🐨", "Koala"], ["🐯", "Tigre"], ["🦁", "Leone"], ["🐮", "Mucca"], ["🐷", "Porco"], ["🐸", "Rana"], ["🐔", "Pollo"], ["🦉", "Gufo"], ["🐺", "Lupo"], ["🦄", "Magia"], ["🐝", "Ape"], ["🐍", "Serpe"], ["🦖", "T-rex"], ["🦕", "Dino"], ["🦡", "Tasso"], ["🤖", "Robot"], ["🎃", "Zucca"], ["👽", "Ufo"], ["👻", "Buu"], ["🔥", "Fuoco"], ["☀️", "Sole"], ["🌝", "Luna"], ["🍄", "Fungo"], ["🌵", "Cactu"], ["🌮", "Tacos"], ["🍕", "Pizza"], ["🍔", "Pane"], ["🌭", "HDog"], ["🍟", "Chips"], ["🥝", "Kiwi"], ["🍓", "Frago"], ["🍎", "Mela"], ["🥥", "Cocco"], ["🎱", "Palla"], ["🎲", "Dado"], ["🎬", "Ciak"], ["🔮", "Sfera"], ["💊", "Pill"], ["🦠", "Virus"], ["🖋", "Penna"], ["🕹", "Stick"], ["💣", "Bomba"], ["💎", "Gemma"]]
        let emoji = usersEmojis.randomElement()
        userEmoji = (emoji?[0])! //!! percgè o meglio che fa ? e !
        
        let color = usersBg.randomElement()
        userBG = (color?[0])!
        username = (color?[1])! + (emoji?[1])!
    }
    var body: some View {
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

            VStack(alignment: .center, content: {
                HStack(alignment: .top,  content: {
                    Button(action: {
                    }) {
                        Text("⚙️")
                            .font(.system(size: 36))
                    }
                    .padding(.leading, 10)
                    Spacer()
                })
                Spacer()
                TextField("", text: $userEmoji)
                    .onReceive(Just(userEmoji)) { inputValue in
                        if inputValue.count > 1 {
                            userEmoji.removeLast()
                        }
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
                    .padding(.bottom, 20)
                    
                
                TextField("", text: $username)
                    .keyboardType(.asciiCapable) //no emoji in system keyboard
                    .textContentType(.username)
                    .multilineTextAlignment(.center)
                    .modifier(box())
                    .padding(.bottom, 100)
                    .foregroundColor(.black)
                    .onReceive(Just(username)) { inputValue in
                        if inputValue.count > 12 {
                            username.removeLast()
                        }
                    }
                
                Button(action: {
                }) {
                    Text("Nuova partita")
                        .modifier(button())
                }
                .padding(.bottom, 30)

                Button(action: {
                }) {
                    Text("Unisciti")
                        .modifier(button())
                }
                .padding(.bottom, 90)
                
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30, content: {
                    Button(action: {
                    }) {
                        Image("star").resizable().frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    Button(action: {
                    }) {
                        Image("help").resizable().frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    Button(action: {
                    }) {
                        Image("share").resizable().frame(width: 16, height: 16, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                })
                Spacer()
            })}.onAppear(perform: userIconRandom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
