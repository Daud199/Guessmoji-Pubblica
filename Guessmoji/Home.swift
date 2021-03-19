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
            ZStack (alignment: .center){
                    Image("bg")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    .opacity(0.03)
                        .background(Color.red)
                    
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
                            TextField("", text: self.$userObservableObject.userEmoji)
                                .font(.system(size: 72))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .frame(width: 110, height: 110, alignment: .center)
                                .background(
                                    Circle()
                                        .stroke(Color("grayLight"), lineWidth: 6)
                                        .background(Circle().foregroundColor(Color(self.userObservableObject.userBG)))
                                )
                                .padding(.bottom, 20)
                                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) //per non far modificare il testo all'utente                                
                    })
                    
                    
                    TextField("", text: self.$userObservableObject.username)
                        .keyboardType(.asciiCapable) //no emoji in system keyboard
                        .textContentType(.username) //no change lang
                        .multilineTextAlignment(.center)
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
                        Text("Nuova partita")
                            .modifier(button())
                    }
                    .padding(.bottom, 30)

                    Button(action: {
                    }) {
                        Text("Unisciti")
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
            )}
                .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true) //mi fa scomparire la barra, creata riga sopra
            .ignoresSafeArea(.keyboard)
        }
        .onTapGesture {
            UIApplication.shared.endEditing() //se tappi fuori qualsisi cosa è in primo piano lo chiude, esiste solo una UIapp, shared è una prorpietà statica che sa che deve puntare alla unica istanza presente di UI
        }      
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
