//
//  Home.swift
//  Guessmoji
//
//  Created by Alice Roncella on 13/03/21.
//

import SwiftUI
import Combine // !! ? wtf

struct Home: View {
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
                    Spacer()
                    
                    NavigationLink(
                        destination: EditProfileView(),
                        label: {
                            UserPic()
                        })
                    
                    
                    TextField("", text: self.$userObservableObject.username)
                        .keyboardType(.asciiCapable) //no emoji in system keyboard
                        .textContentType(.username) //no change lang
                        .modifier(box())
                        .padding(.bottom, 100)
                        .foregroundColor(.black)
                        .onReceive(Just(self.userObservableObject.username)) { inputValue in
                            if inputValue.count > 12 {
                                self.userObservableObject.username.removeLast()
                                showAlertTextLength = true
                            }
                        }
                        .alert(isPresented: $showAlertTextLength) {
                            Alert(title: Text("Max 12 caratteri"), dismissButton: .default(Text("Chiudi")))
                        }
                    
                    
                    Button(action: {
                    }) {
                        NavigationLink(destination: NewGameView()) {
                            Text("Nuova partita")
                                .modifier(button())
                        }
                    }
                    .padding(.bottom, 30)
                    
                    
                    Button(action: {
                    }) {
                        NavigationLink(destination: JoinGameView()) {
                            Text("Unisciti")
                                .modifier(button())
                        }
                    }
                    .padding(.bottom, 90)
                    
                    Widgets()
                    
                    Spacer()
                }
                )}.onTapGesture {
                    UIApplication.shared.endEditing() //se tappi fuori qualsisi cosa è in primo piano lo chiude, esiste solo una UIapp, shared è una prorpietà statica che sa che deve puntare alla unica istanza presente di UI
                }
                .navigationBarTitle("indietro", displayMode: .inline)
                .navigationBarHidden(true) //mi fa scomparire la barra, creata riga sopra
            //.padding(.top, 30) //soluzione alla bruta
            //.ignoresSafeArea(.keyboard)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct BGView: View {
    var body: some View {
        Image("bg")
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .opacity(0.03)
            .background(Color.white)
    }
}

struct UserPic: View {
    var size = "big"
    @State var lineWidthBorder:CGFloat = 6
    @State var fontSize:CGFloat = 72
    @State var circleSize:CGFloat = 110
    @State var paddingSize:CGFloat = 20
    
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    
    var body: some View {
        VStack{
            Text(userObservableObject.userEmoji)
                .font(.system(size: fontSize))
                .foregroundColor(.black)
                .frame(width: circleSize, height: circleSize, alignment: .center)
                .background(
                    Circle()
                        .stroke(Color("grayLight"), lineWidth: lineWidthBorder)
                        .background(Circle().foregroundColor(Color(self.userObservableObject.userBG)))
                )
                .padding(.bottom, paddingSize)
        }
        .onAppear(){
            if size == "medium" {
                lineWidthBorder = 4
                fontSize = 50
                circleSize = 80
                paddingSize = 10
            }
            if size == "small"{
                lineWidthBorder = 0
                fontSize = 35
                circleSize = 50
                paddingSize = 0
            }
        }
    }
}

struct Widgets: View {
    var body: some View {
        HStack(alignment: .center, spacing: 30, content: {
            Button(action: {
            }) {
                Image("star").resizable().frame(width: 16, height: 16, alignment: .center)
            }
            Button(action: {
            }) {
                Image("help").resizable().frame(width: 16, height: 16, alignment: .center)
            }
            Button(action: {
            }) {
                Image("share").resizable().frame(width: 16, height: 16, alignment: .center)
            }
        })
    }
}
