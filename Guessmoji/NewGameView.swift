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
    @StateObject var usersJoined = UsersJoined()

    @Environment(\.presentationMode) var presentationMode
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
                )}.navigationBarHidden(true)
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
