//
//  NewGameView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 25/03/21.
//

import SwiftUI
import Combine // !! ? wtf

class UsersJoined: ObservableObject {
    @Published var users:[[String]] = [["Edo", "🐀", "green"], ["Ro", "🐇", "lightBlue"]]
}

struct NewGameView: View {
    @EnvironmentObject var set : Set
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var usersJoined = UsersJoined()
    @State private var showAlertTextLength = false
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center) {
                VStack(alignment: .center, spacing: nil) {
                    BGView()
                }
                
                VStack(alignment: .center, content: {
                    HStack(alignment: .top,  content: {
                        Button(action: {
                            self.set.showSettings.toggle()
                        }) {
                            Text("⚙️")
                                .font(.system(size: 36))
                        }
                        .padding(.leading, 10)
                        Spacer()
                    })
                    
                    Group{
                        Text("👑")
                            .font(.system(size: 50))
                            .padding(.bottom, -25)
                            .zIndex(1)
                        
                        UserPic(size: "medium")
                        
                        Text(userObservableObject.username)
                            .frame(width: 150, height: 25, alignment: .center)
                            .font(Font
                                    .custom("Nunito-SemiBold", size: 16))
                            .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayLight")))
                            .foregroundColor(.black)
                            .padding(.bottom, 15)
                        
                        Text("ABCD")
                            .tracking(10)
                            .frame(width: 220, height: 45, alignment: .center)
                            .font(Font
                                    .custom("Nunito-Bold", size: 25))
                            .background(RoundedRectangle(cornerRadius: 18).fill(Color(userObservableObject.userBG)))
                            .foregroundColor(.white)
                            .padding(.bottom, 1)
                        
                        Text("Invita i tuoi amici ad unirsi alla partita con questo codice!")
                            .frame(width: 280, height: 55, alignment: .center)
                            .font(Font
                                    .custom("Nunito-SemiBold", size: 16))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(self.usersJoined.users, id: \.self) { userData in
                            HStack (alignment: .center, spacing: nil, content: {
                                UserBoxView(userData: userData)
                            }).padding(.trailing, 30)
                            .padding(.leading, 30)
                        }
                    }
                    
                    Group{
                        Button(action: {}) {
                            NavigationLink(destination: GameRoomView()) {
                                Text("Ciak si gira!")
                                    .modifier(button())
                            }
                        }
                        .padding(.bottom, -10)
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Esci")
                                .modifier(button())
                        }
                        
                        Widgets()
                        
                    }.padding(.bottom, 30)
                }
                )
                if self.set.showSettings {
                    GeometryReader { _ in
                        VStack(alignment: .center){
                            Spacer()
                            HStack(alignment: .center){
                                Spacer()
                                SettingsView(leave: false)
                                Spacer()
                            }.padding(.bottom, 30)
                            Spacer()
                        }
                    }.background(Color.black.opacity(0.60)
                                    .edgesIgnoringSafeArea(.all)
                    )
                }
                if self.set.showHelp {
                    GeometryReader { _ in
                        VStack(alignment: .center){
                            Spacer()
                            HStack(alignment: .center){
                                Spacer()
                                HelpView{
                                    HelpNewGameView()
                                }
                                Spacer()
                            }.padding(.bottom, 30)
                            Spacer()
                        }
                    }.background(Color.black.opacity(0.60)
                                    .edgesIgnoringSafeArea(.all)
                    )
                }
            }.navigationBarHidden(true)
        }.navigationBarHidden(true)
         // TODO: Workaround temporaneo bug SDK
    }
}

struct NewGameView_Preview: PreviewProvider {
    static var previews: some View {
        NewGameView()
    }
}

struct UserBoxView: View {
    @EnvironmentObject var userObservableObject: UserObservableObject
    var userData:Array<String> //[0 -> "nome", 1 -> "emoji", 2 -> "colore"]]
    
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Text(userData[1])
                .font(.system(size: 35))
                .foregroundColor(.black)
                .frame(width: 50, height: 50, alignment: .center)
                .background(
                    Circle()
                        .stroke(Color("grayLight"), lineWidth: 0)
                        .background(Circle().foregroundColor(Color(userData[2])))
                )
                .padding(.leading, 10)
                .padding(.trailing, 10)
        
            Text(self.userData[0])
                .multilineTextAlignment(.leading)
                .frame(width: 150, height: 25, alignment: .leading)
                .font(Font
                        .custom("Nunito-SemiBold", size: 16))
                .foregroundColor(.black)
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 18).fill(Color("grayLight"))                    .frame(width: 350, height: 70, alignment: .center))
        .frame(width: 350, height: 70, alignment: .center)
        .zIndex(1)
        .padding(.bottom, 10)
    }
}

struct HelpNewGameView : View {
    @EnvironmentObject var userObservableObject: UserObservableObject

    var body: some View {
        VStack(alignment: .center, spacing: 40){
            VStack(alignment: .center, spacing: 5){
                Text("ABCD")
                    .tracking(10)
                    .frame(width: 220, height: 45, alignment: .center)
                    .font(Font
                            .custom("Nunito-Bold", size: 25))
                    .background(RoundedRectangle(cornerRadius: 18).fill(Color(userObservableObject.userBG)))
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                Text("Invia questo codice invito ai tuoi amici")
                    .font(Font
                            .custom("Nunito-SemiBold", size: 18))
            }.padding(.bottom, 40)
            
            VStack(alignment: .center, spacing: 5){
                Text("Ciak si gira!")
                    .modifier(button())
                Text("Avvia la partita e comincia a giocare")
                    .font(Font
                            .custom("Nunito-SemiBold", size: 18))
            }
            
            VStack(alignment: .center, spacing: 5){
                Text("Esci")
                    .modifier(button())
                Text("Abbandona la lobby e torna alla home")
                    .font(Font
                            .custom("Nunito-SemiBold", size: 18))
            }

        }
        .frame(width: 300, height: 440)
    }
}
