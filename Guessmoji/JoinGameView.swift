//
//  JoinGameView.swift
//  Guessmoji
//
//  Created by Alice Roncella on 25/03/21.
//

import SwiftUI
import Combine // !! ? wtf
import BJOTPViewController

struct JoinGameView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userObservableObject: UserObservableObject
    @State private var showAlertWrongCode = false
    @State private var oTCodeInput:String = ""
    var oTCode = "4024"
    
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
                    
                    Text(userObservableObject.userEmoji)
                        .font(.system(size: 72))
                        .foregroundColor(.black)
                        .frame(width: 110, height: 110, alignment: .center)
                        .background(
                            Circle()
                                .stroke(Color("grayLight"), lineWidth: 6)
                                .background(Circle().foregroundColor(Color(self.userObservableObject.userBG)))
                        )
                        .padding(.bottom, 20)

                    Text(userObservableObject.username)
                        .multilineTextAlignment(.center)
                        .modifier(box())
                        .padding(.bottom, 100)
                        .foregroundColor(.black)
                    
                    
                    TextField("", text: $oTCodeInput)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 220, height: 85, alignment: .center)
                        .font(Font
                            .custom("Nunito-SemiBold", size: 8))
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayLight")))
                        .padding(.bottom, 100)
                        .foregroundColor(Color(userObservableObject.userBG))
                        .onReceive(Just(oTCodeInput)) { inputValue in
                            if inputValue.count > 4 {
                                oTCodeInput.removeLast()
                            }
                            if inputValue != oTCode && inputValue.count == 4 {
                                showAlertWrongCode = true
                            }
                        }
                        .alert(isPresented: $showAlertWrongCode) {
                            Alert(title: Text("Codice errato"), dismissButton: .default(Text("Riprova")))
                        }

                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Esci")
                            .modifier(button())
                    }
                    .padding(.bottom, 90)
                    
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
                    Spacer()
                }
            )}.onTapGesture {
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
