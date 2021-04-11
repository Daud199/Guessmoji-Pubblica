//
//  WaitingRoomView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 09/04/21.
//

import SwiftUI
import Combine // !! ? wtf


struct WaitingRoomView: View {
    @StateObject var usersJoined = UsersJoined()

    @Environment(\.presentationMode) var presentationMode
    @State private var showAlertTextLength = false
    @EnvironmentObject var userObservableObject: UserObservableObject
    
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
                )}.navigationBarHidden(true)
        }.navigationBarHidden(true)
    }
}

