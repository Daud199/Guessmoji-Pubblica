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
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    @State private var timeTotal:CGFloat = 30.0
    @State private var timeRemaining:CGFloat = 30.0
    @State private var barPercentageSpent:CGFloat = 0.0
    @State private var barColor:String = "green"
    @State private var msgToSend:String = ""
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                            
                            RoundedRectangle(cornerRadius: 14).fill(Color(barColor))
                                .frame(width: UIScreen.main.bounds.width - 20 - (UIScreen.main.bounds.width * self.barPercentageSpent), height: 8, alignment: .center)
                                .padding(.leading, 10)
                                .padding(.trailing, 10)
                            
                        }.frame(width: UIScreen.main.bounds.width, height: 148)
                        .ignoresSafeArea()
                        
                        HStack(alignment: .top,  content: {
                            Button(action: {
                            }) {
                                Text("⚙️")
                                    .font(.system(size: 36))
                            }
                            .padding(.leading, 10)
                            
                            Spacer()
                            
                            VStack(alignment: .center) {
                                Text("È il turno di...")
                                    .frame(width: 100, height: 30, alignment: .center)
                                    .font(Font
                                            .custom("Nunito-SemiBold", size: 16))
                                    .foregroundColor(.black)
                                
                                HStack(alignment: .center, spacing: 10){
                                    Text("😋")
                                        .font(.system(size: 35))
                                        .foregroundColor(.black)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                        )
                                    Text("😋")
                                        .font(.system(size: 35))
                                        .foregroundColor(.black)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                        )
                                    Text("😋")
                                        .font(.system(size: 35))
                                        .foregroundColor(.black)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .background(
                                            RoundedRectangle(cornerRadius: 14).fill(Color.white)
                                        )
                                    Text("😋")
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
                                
                                UserPic(size: "small")
                            }.padding(.trailing, 10)
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
                )}.navigationBarHidden(true)
                .onReceive(timer) { time in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                        self.barPercentageSpent = 1 - self.timeRemaining / self.timeTotal
                        print(barPercentageSpent)
                        if self.barPercentageSpent < 0.5 {
                            barColor = "green"
                        }
                        else if self.barPercentageSpent < 0.75 {
                            barColor = "orange"
                        }
                        else {
                            barColor = "red"
                        }
                    }
                }
        }.navigationBarHidden(true)
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
            
            Text("\(self.messageData[0]):").font(Font.custom("Nunito-Bold", size: 16)) + Text(" \(self.messageData[3])").font(Font.custom("Nunito-SemiBold", size: 16)) //TODO: testo allineato a sx 
            
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 18).fill(Color("grayLight")).frame(width: 350, height: 70, alignment: .center))
        .frame(width: 350, height: 70, alignment: .center)
        .zIndex(1)
        .padding(.bottom, 10)
    }
}
