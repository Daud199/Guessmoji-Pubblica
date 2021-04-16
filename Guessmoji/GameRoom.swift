//
//  GameRoom.swift
//  Guessmoji
//
//  Created by Alice Roncella on 11/04/21.
//

import SwiftUI
import Combine // !! ? wtf

class MessagesSent: ObservableObject {
    @Published var msg:[[String]] = [["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"], ["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"], ["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"], ["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"], ["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"], ["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"], ["Edo", "🐀", "green", "sento un gufo"], ["Ro", "🐇", "lightBlue", "è il mio stoghisdfgh sjnasd defo"]]
}

struct GameRoomView: View {
    @StateObject var messagesSent = MessagesSent()
    @State private var showAlertTextLength = false
    @EnvironmentObject var set : Set
    
    @StateObject var usersJoined = UsersJoined()
    @State var roundPerPlayer:Int = 1 // quanti round per player es. 2 round pp = 10 round total
    @State var roundTotal:Int = 0 //round in tutta la partita
    @State var roundActual:Int = 1 // round attuale
    @State var emoji1:String = "🤔"
    @State var emoji2:String = "🤔"
    @State var emoji3:String = "🤔"
    @State var emoji4:String = "🤔"
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    @State private var timeRoundTotal:Int = 30
    @State private var barPercentageSpent:Int = 0
    @State private var barColor:String = "green"
    @State private var msgToSend:String = ""
    @State private var showBar:Bool = false
    
    //time
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timePassed:Int = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var startEmoji = "🏁"
    
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center) {
                VStack(alignment: .center, spacing: nil) {
                    BGView()
                }
                
                VStack(alignment: .center, content: {
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 14).fill(Color("gray"))
                            .frame(width: UIScreen.main.bounds.width, height: 180, alignment: .center)
                            .ignoresSafeArea()
                        
                        VStack(alignment: . leading){
                            Rectangle().fill(Color("grayLight"))
                                .frame(width: UIScreen.main.bounds.width, height: 160, alignment: .center)
                            
                            if showBar {
                                RoundedRectangle(cornerRadius: 14).fill(Color(barColor))
                                    .frame(width: (UIScreen.main.bounds.width - 20) * (1 - CGFloat(self.barPercentageSpent) / 100), height: 8, alignment: .center)
                                    .padding(.leading, 10)
                                    .padding(.trailing, 10)
                            }
                            
                        }.frame(width: UIScreen.main.bounds.width, height: 148)
                        .ignoresSafeArea()
                        
                        
                        HStack(alignment: .top,  content: {
                            Button(action: {
                                self.set.showSettings.toggle()
                            }) {
                                Text("⚙️")
                                    .font(.system(size: 36))
                            }
                            .padding(.leading, 10)
                            
                            if !self.set.start {
                                HStack(alignment: .center){
                                    Spacer()
                                    HStack(alignment: .center, spacing: 10){
                                        ForEach(0 ..< 4){ _ in
                                            Text(self.startEmoji)
                                                .font(.system(size: 35))
                                                .foregroundColor(.black)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                                )
                                        }
                                    }
                                    
                                    Spacer()
                                    Text("🎲")
                                        .font(.system(size: 35))
                                        .foregroundColor(.black)
                                        .frame(width: 60, height: 60, alignment: .center)
                                        .background(
                                            Circle()
                                                .stroke(Color("gray"), lineWidth: 3)
                                                .background(Circle().foregroundColor(Color("red")))
                                        )
                                        .padding(.trailing, 10)
                                }.padding(.top, 20)
                            }
                            else {
                                HStack(alignment: .top){
                                    Spacer()
                                    
                                    VStack(alignment: .center) {
                                        
                                        Text("È il turno di \(self.usersJoined.users[self.roundActual - 1][0])")
                                            .frame(width: 200, height: 30, alignment: .center)
                                            .font(Font
                                                    .custom("Nunito-SemiBold", size: 16))
                                            .foregroundColor(.black)
                                        
                                        HStack(alignment: .center, spacing: 10){
                                            Text(self.emoji1)
                                                .font(.system(size: 35))
                                                .foregroundColor(.black)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                                )
                                            Text(self.emoji2)
                                                .font(.system(size: 35))
                                                .foregroundColor(.black)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                                )
                                            Text(self.emoji3)
                                                .font(.system(size: 35))
                                                .foregroundColor(.black)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                                )
                                            Text(self.emoji4)
                                                .font(.system(size: 35))
                                                .foregroundColor(.black)
                                                .frame(width: 50, height: 50, alignment: .center)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                                )
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .center){
                                        Text("👑")
                                            .font(.system(size: 30))
                                            .padding(.bottom, -20)
                                            .zIndex(2)
                                            .padding(.trailing, 10)
                                        
                                        Text(self.usersJoined.users[self.roundActual - 1][1])
                                            .font(.system(size: 35))
                                            .foregroundColor(.black)
                                            .frame(width: 60, height: 60, alignment: .center)
                                            .background(
                                                Circle()
                                                    .stroke(Color("gray"), lineWidth: 3)
                                                    .background(Circle().foregroundColor(Color(self.usersJoined.users[self.roundActual - 1][2]))
                                                    )
                                            ).padding(.trailing, 10)
                                    }.padding(.trailing, 10)
                                }
                                
                            }
                            
                        })
                    }
                    
                    ScrollView(.vertical, showsIndicators: false){
                        ScrollViewReader { value in
                            ForEach(self.messagesSent.msg, id: \.self) { value in
                                HStack (alignment: .center, spacing: nil, content: {
                                    MessageBoxView(messageData: value)
                                }).padding(.trailing, 30)
                                .padding(.leading, 30)
                            }
                            .onAppear{
                                value.scrollTo(messagesSent.msg[messagesSent.msg.endIndex - 1], anchor: .bottom)
                            }
                            .onChange(of: messagesSent.msg.count) { _ in
                                value.scrollTo(messagesSent.msg[messagesSent.msg.endIndex - 1], anchor: .bottom)
                            }
                        }
                    }
                    
                    HStack {
                        TextField("Scrivi qualcosa...", text: self.$msgToSend)
                            .frame(width: UIScreen.main.bounds.width - 70, height: 40, alignment: .center)
                            .font(Font
                                    .custom("Nunito-SemiBold", size: 18))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayLight")))
                            .multilineTextAlignment(.leading)
                            .onReceive(Just(self.msgToSend)) { inputValue in
                                if inputValue.count > 64 {
                                    self.msgToSend.removeLast()
                                    showAlertTextLength = true
                                }
                            }
                            .alert(isPresented: $showAlertTextLength) {
                                Alert(title: Text("Max 64 caratteri"), dismissButton: .default(Text("Chiudi")))
                            }
                        
                        Button(action: {
                            print(messagesSent.msg.count)
                            if msgToSend != "" {
                                messagesSent.msg.append([userObservableObject.username, userObservableObject.userEmoji, userObservableObject.userBG, self.msgToSend])
                                self.msgToSend = ""
                            }
                        }) {
                            Image("send").resizable().frame(width: 25, height: 25, alignment: .center).foregroundColor(Color("yellow"))
                        }
                    }.padding(.leading, 10)
                    .padding(.trailing, 10)
                    
                    
                }
                )
                
                if self.set.showSettings {
                    GeometryReader { _ in
                        VStack(alignment: .center){
                            Spacer()
                            HStack(alignment: .center){
                                Spacer()
                                SettingsView(leave: true)
                                Spacer()
                            }.padding(.bottom, 30)
                            Spacer()
                        }
                    }.background(Color.black.opacity(0.60)
                                    .edgesIgnoringSafeArea(.all)
                    )
                }
            }
            .onAppear{
                self.startTimer()
                self.isTimerRunning = true
            }
            .onTapGesture {
                UIApplication.shared.endEditing() //se tappi fuori qualsisi cosa è in primo piano lo chiude, esiste solo una UIapp, shared è una prorpietà statica che sa che deve puntare alla unica istanza presente di UI
            }
            .navigationBarHidden(true)
            .onReceive(timer) { time in
                if !self.set.start && self.isTimerRunning {
                    giveTurn()
                }
                else {
                    print("inside bar changing")
                    print(self.barPercentageSpent)
                    self.barPercentageSpent = (self.timePassed * 100) / self.timeRoundTotal
                    if self.barPercentageSpent < 50 {
                        barColor = "green"
                    }
                    else if self.barPercentageSpent < 75 {
                        barColor = "orange"
                    }
                    else {
                        barColor = "red"
                    }
                }
                self.timePassed = Int(Date().timeIntervalSince(self.startTime))
            }
        }.navigationBarHidden(true)
        
    }
    
    func giveTurn() {
        if self.timePassed == 0 {
            self.startEmoji = "🏁"
        }
        else if self.timePassed == 1 {
            self.startEmoji = "🔴"
            messagesSent.msg.append(["GameMaster", "🎲", "red", "*rullo di tamburi*"])
        }
        else if self.timePassed == 2 {
            self.startEmoji = "🟠"
        }
        else if self.timePassed == 3 {
            self.startEmoji = "🟡"
        }
        else if self.timePassed == 4 {
            self.startEmoji = "🟢"
            self.roundTotal = self.usersJoined.users.count * self.roundPerPlayer
            
            messagesSent.msg.append(["GameMaster", "🎲", "red", "È il turno di... \(self.usersJoined.users[self.roundActual - 1][0])!"])
        }
        else if self.timePassed == 5 {
            self.stopTimer()
            self.set.start = true
            print("ended prestart: \(self.set.start)")
            self.startTimer()
            self.showBar = true
        }
    }
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.startTime = Date()
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.isTimerRunning = true
        
    }
    
}

struct GameRoomView_Preview: PreviewProvider {
    static var previews: some View {
        GameRoomView()
    }
}

struct MessageBoxView: View {
    @EnvironmentObject var userObservableObject: UserObservableObject
    var messageData:Array<String> //[0 -> "nome", 1 -> "emoji", 2 -> "colore", 3 -> "msg"]]
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Text(messageData[1])
                .font(.system(size: 35))
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                .background(
                    Circle()
                        .stroke(Color("grayLight"), lineWidth: 0)
                        .background(Circle().foregroundColor(Color(messageData[2])))
                )
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
            Text("\(self.messageData[0]):").font(Font.custom("Nunito-Bold", size: 16)).foregroundColor(.black) + Text(" \(self.messageData[3])").font(Font.custom("Nunito-SemiBold", size: 16)).foregroundColor(.black)
            
            
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 18).fill(Color("grayLight")).frame(width: 350, height: 70, alignment: .center))
        .frame(width: 350, height: 70, alignment: .center)
        .zIndex(1)
        .padding(.bottom, 10)
    }
}
