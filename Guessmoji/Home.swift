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
    @EnvironmentObject var set : Set
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    var body: some View {
        ZStack (alignment: .center) {
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
                        
                        
                        Button(action: {}) {
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
            if self.set.showSettings {
                GeometryReader { _ in
                    VStack(alignment: .center){
                        Spacer()
                        HStack(alignment: .center){
                            Spacer()
                            SettingsView()
                            Spacer()
                        }.padding(.bottom, 30)
                        Spacer()
                    }
                }.background(Color.black.opacity(0.60)
                                .edgesIgnoringSafeArea(.all)
                )
            }
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
        //SettingsView()
    }
}

struct SettingsView : View {
    @EnvironmentObject var set : Set
    var leave:Bool = true
    @State var bottomHeight:CGFloat = 445
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 40){
            
            HStack(alignment: .center, spacing: 10){
                Spacer()
                Button(action: {
                    self.set.showSettings.toggle()
                }) {
                    Image("close").resizable().frame(width: 20, height: 20, alignment: .center)
                }
            }.padding(.top, 10)
            
            Text("IMPOSTAZIONI")
                .font(Font
                        .custom("Nunito-SemiBold", size: 18))
                .padding(.top, -10)
            
            VStack(alignment: .leading, spacing: 20){
                HStack(alignment: .center, spacing: 20){
                    Image("music").resizable().frame(width: 22, height: 22, alignment: .center)
                    Text("Musica")
                        .font(Font
                                .custom("Nunito-SemiBold", size: 18))
                    Toggle("", isOn: self.$set.musicOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color.yellow))
                }
                HStack(alignment: .center, spacing: 20){
                    Image("sound").resizable().frame(width: 22, height: 22, alignment: .center)
                    Text("Suoni")
                        .font(Font
                                .custom("Nunito-SemiBold", size: 18))
                    Toggle("", isOn: self.$set.soundOn)
                        .toggleStyle(SwitchToggleStyle(tint: Color.yellow))
                }
                HStack(alignment: .center, spacing: 20){
                    Image("tutorial").resizable().frame(width: 22, height: 22, alignment: .center)
                    Text("Tutorial")
                        .font(Font
                                .custom("Nunito-SemiBold", size: 18))
                }
                HStack(alignment: .center, spacing: 20){
                    Button(action: {
                            shareBtn()                    }) {
                        Image("share").resizable().frame(width: 22, height: 22, alignment: .center).padding(.trailing, 10)
                        Text("Condividi")
                            .foregroundColor(.black)
                            .font(Font
                                    .custom("Nunito-SemiBold", size: 18))
                        
                    }
                    
                    
                }
                HStack(alignment: .center, spacing: 20){
                    Image("star").resizable().frame(width: 22, height: 22, alignment: .center)
                    Text("Valuta")
                        .font(Font
                                .custom("Nunito-SemiBold", size: 18))
                }
            }.frame(width: 200)
            
            if leave {
                Button(action: {}) {
                    NavigationLink(destination: Home()) {
                        Text("Abbandona")
                            .modifier(button(color: "gray"))
                    }
                }
            }
            Spacer()
        }.onAppear(){
            if !leave {
                bottomHeight = 370
            }
        }
        .frame(width: 250, height: bottomHeight)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        
    }
}

struct BGView: View {
    var body: some View {
        Image("bg")
            .resizable()
            .opacity(0.03)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
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
                        .stroke(Color("gray"), lineWidth: lineWidthBorder)
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
            if size == "small" {
                lineWidthBorder = 3
                fontSize = 35
                circleSize = 60
                paddingSize = 10
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
                shareBtn()
            }) {
                Image("share").resizable().frame(width: 16, height: 16, alignment: .center)
            }
        }).edgesIgnoringSafeArea(.all)
    }
    
    
}

func shareBtn(){
    Set.shared.isShareSheetShowing.toggle()
    
    let url = URL(string: "https://example.com")
    let av = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
    
    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
}
