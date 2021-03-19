//
//  EditProfileView.swift14
//  Guessmoji
//
//  Created by Alice Roncella on 16/03/21.
//

import SwiftUI
import Combine
import UIKit


struct EditProfileView: View {
    var uMV = userModelView()
    
    @State private var showAlertEmoji = false
    let bgValues: [[String]] = [["red", "orange", "yellow", "green"], ["pink", "purple", "blue", "lightBlue"]]
    @EnvironmentObject var userObservableObject: UserObservableObject
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    Image("bg").frame(minWidth: 0,
                                      maxWidth: .infinity,
                                      minHeight: 0,
                                      maxHeight: .infinity,
                                      alignment: .center
                              )
                    .opacity(0.03)
                        .background(Color.white)
                }
                
                VStack(alignment: .center, spacing: nil, content: {
                    HStack(alignment: .top, content: {
                        Spacer()
                        TextField("", text: self.$userObservableObject.userEmoji)
//                            .onAppear{UIApplication.shared.startEditing()}
                            .onReceive(Just(userObservableObject.userEmoji)) {
                                inputValue in
                                if inputValue != "" && inputValue.containsOnlyEmoji == false {
                                    print("no emoji")
                                    userObservableObject.userEmoji.removeLast()
                                    showAlertEmoji = true
                                }
                                if inputValue.count > 1 {
                                    userObservableObject.userEmoji.removeFirst() //meglio di Apple :D non devi più cancellare un'emoji per aggiungerne un'altra, ma come selezione basta cliccarne in continuo un'altra e questa cambierà
                                    print(userObservableObject.userEmoji)
                                }
                            }
                            .alert(isPresented: $showAlertEmoji) {
                                    Alert(title: Text("Inserisci solo Emoji"), message: Text("Se non le vedi, vai in Impostazioni > Generali > Tastiera > Tastiere > Aggiungi nuova tastiera (Emoji)"), dismissButton: .default(Text("Chiudi")))
                            }
                            .font(.system(size: 72))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .frame(width: 110, height: 110, alignment: .center)
                            .background(
                                Circle()
                                    .stroke(Color("grayLight"), lineWidth: 6)
                                    .background(Circle().foregroundColor(Color(userObservableObject.userBG)))
                            )
                        
                        Button(action: {
                            uMV.iconRandom(userObservableObject: self.userObservableObject)
                        }, label: {
                            Text("🔄")
                                .font(.system(size: 36))
                        })
                        
                        Spacer()
                    })
                    .padding(.leading, 55)
                    
                    //ContentViewBtn(bgValue: "red", userBG: $userBG)
                    
                    ForEach(self.bgValues, id: \.self) { row in
                        HStack (alignment: .center, spacing: nil, content: {
                            ForEach (row, id: \.self) { bgValue in
                                Button(action: {
                                    print(bgValue)
                                    userObservableObject.userBG = bgValue
                                }) {
                                    Circle()
                                        .frame(width: 80, height: 80, alignment: .center)
                                        .foregroundColor(Color(bgValue))
                                }
                            }
                        }).padding(.trailing, 30)
                        .padding(.leading, 30)
                    }
                    Spacer()
                })
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing() //se tappi fuori qualsisi cosa è in primo piano lo chiude, esiste solo una UIapp, shared è una prorpietà statica che sa che deve puntare alla unica istanza presente di UI
        }        
    }
}
