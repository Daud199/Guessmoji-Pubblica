//
//  JoinGameView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 25/03/21.
//

import SwiftUI
import Combine // !! ? wtf

struct JoinGameView: View {
    @EnvironmentObject var set : Set
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    @State private var showAlertWrongCode = false
    @State private var oTCodeInput:String = "####"
    @State private var canEnter = false
    
    @State var oTCode = "4024"
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .center) {
                NavigationLink(destination: WaitingRoomView(oTCode: self.$oTCode), isActive: $canEnter) {}
                
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
                    
                    Group{
                        UserPic(size: "medium")
                        
                        Text(userObservableObject.username)
                            .modifier(box())
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        Text("Inserisci Codice:")
                            .frame(width: 280, height: 18, alignment: .center)
                            .font(Font
                                    .custom("Nunito-Bold", size: 18))
                            .foregroundColor(.black)

                        ZStack{
                            Text(oTCodeInput)
                                .tracking(10)
                                .frame(width: 220, height: 85, alignment: .center)
                                .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayLight")))
                                .font(Font
                                        .custom("Nunito-SemiBold", size: 38))
                                .foregroundColor(Color(userObservableObject.userBG))

                            TextField("", text: $oTCodeInput, onEditingChanged: {_ in
                                if oTCodeInput == "####"
                                {
                                    oTCodeInput = ""
                                }
                            })
                                .keyboardType(.numberPad)
                                .frame(width: 220, height: 85, alignment: .center)
                                .font(Font
                                        .custom("Nunito-SemiBold", size: 38))
                                .foregroundColor(Color.red.opacity(0))
                                .background(Color.clear)

                                .onReceive(Just(oTCodeInput)) { inputValue in
                                    if inputValue.count > 4 {
                                        oTCodeInput.removeLast()
                                    }
                                    if inputValue != oTCode && inputValue.count == 4 && inputValue != "####" {
                                        print("errato")
                                        showAlertWrongCode = true
                                    }
                                    if inputValue == oTCode {
                                        canEnter = true
                                    }
                                }
                                .alert(isPresented: $showAlertWrongCode) {
                                    Alert(title: Text("Codice errato"), dismissButton: .default(Text("Riprova")){                                oTCodeInput = ""
                                    })
                                }.padding(.leading, 18)
                                                        
                        }
                    })
                    
                    
                    Text("Chiedi all’amico che ha creato la partita di darti il codice invito")
                        .frame(width: 300, height: 70, alignment: .center)
                        .font(Font
                            .custom("Nunito-SemiBold", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayDark")))
                        .foregroundColor(.white)
                                  
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Esci")
                            .modifier(button())
                    }
                    .padding(.bottom, 90)
                    
                    Widgets().padding(.bottom, 90)
                    
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
                                    HelpJoinGameView()
                                }
                                Spacer()
                            }.padding(.bottom, 30)
                            Spacer()
                        }
                    }.background(Color.black.opacity(0.60)
                                    .edgesIgnoringSafeArea(.all)
                    )
                }
            }.onTapGesture {
                    UIApplication.shared.endEditing() //se tappi fuori qualsisi cosa è in primo piano lo chiude, esiste solo una UIapp, shared è una prorpietà statica che sa che deve puntare alla unica istanza presente di UI
                }
                .navigationBarHidden(true) //mi fa scomparire la barra, creata riga sopra
            //.padding(.top, 30) //soluzione alla bruta
            //.ignoresSafeArea(.keyboard)
        }.navigationBarHidden(true)
    }
}

struct JoinGameView_Previews: PreviewProvider {
    static var previews: some View {
        JoinGameView()
    }
}

struct HelpJoinGameView : View {
    @EnvironmentObject var userObservableObject: UserObservableObject

    var body: some View {
        VStack(alignment: .center, spacing: 40){
            Text("Per entrare in una partita esistente è necessario possedere il codice invito.")
                .font(Font
                        .custom("Nunito-SemiBold", size: 18))
                .foregroundColor(.black)
            Text("Il codice invito va richiesto all’utente che ha creato la partita.")
                .font(Font
                        .custom("Nunito-SemiBold", size: 18))
                .foregroundColor(.black)
                .padding(.bottom, 40)
            
            VStack(alignment: .center, spacing: 5){
                Text("Esci")
                    .modifier(button())
                Text("Abbandona la lobby e torna alla home")
                    .font(Font
                            .custom("Nunito-SemiBold", size: 18))
                    .foregroundColor(.black)
            }
        }
        .frame(width: 300, height: 360)
    }
}
