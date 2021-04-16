//
//  WaitingRoomView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 09/04/21.
//

import SwiftUI
import Combine // !! ? wtf


struct WaitingRoomView: View {
    @EnvironmentObject var set : Set
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userObservableObject: UserObservableObject

    @StateObject var usersJoined = UsersJoined()
    @State private var showAlertTextLength = false

    @Binding var oTCode:String
    
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
                
                        UserPic(size: "medium")
                        
                        Text(userObservableObject.username)
                            .frame(width: 150, height: 25, alignment: .center)
                            .font(Font
                                    .custom("Nunito-SemiBold", size: 16))
                            .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayLight")))
                            .foregroundColor(.black)
                            .padding(.bottom, 15)
                        
                        Text(oTCode)
                            .tracking(10)
                            .frame(width: 220, height: 45, alignment: .center)
                            .font(Font
                                    .custom("Nunito-Bold", size: 25))
                            .background(RoundedRectangle(cornerRadius: 18).fill(Color(userObservableObject.userBG)))
                            .foregroundColor(.white)
                            .padding(.bottom, 1)
                        
                        Text("Aspettando che l'host inizi la partita ")
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
                                    HelpWaitingRoomView()
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
    }
}

struct HelpWaitingRoomView : View {
    @EnvironmentObject var userObservableObject: UserObservableObject

    var body: some View {
        VStack(alignment: .center, spacing: 40){
            Text("Attendi che l’organizzatore avvii la partita")
                .font(Font
                        .custom("Nunito-SemiBold", size: 18))
                .padding(.bottom, 40)
            
            VStack(alignment: .center, spacing: 5){
                Text("Esci")
                    .modifier(button())
                Text("Abbandona la lobby e torna alla home")
                    .font(Font
                            .custom("Nunito-SemiBold", size: 18))
            }
        }
        .frame(width: 300, height: 250)
    }
}

