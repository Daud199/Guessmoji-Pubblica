//
//  NewGameView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 25/03/21.
//

import SwiftUI
import Combine // !! ? wtf

struct NewGameView: View {
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
                    
                    ScrollView(.vertical, showsIndicators: true){
                        UserBoxView()
                        UserBoxView()
                        UserBoxView()
                        UserBoxView()
                        UserBoxView()
                        UserBoxView()
                        UserBoxView()
                        UserBoxView()
                    }
                    
                    
                    Group{
                        Button(action: {
                        }) {
                            Text("Ciak si gira!")
                                .modifier(button())
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
                )}
                .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
    }
}

struct NewGameView_Preview: PreviewProvider {
    static var previews: some View {
        NewGameView()
    }
}

struct UserBoxView: View {
    @EnvironmentObject var userObservableObject: UserObservableObject
    //emoji bg e username chiesti in home
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            UserPic(size: "small")
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
            Text(userObservableObject.username)
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
