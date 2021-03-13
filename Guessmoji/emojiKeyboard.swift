//
//  emojiKeyboard.swift
//  Guessmoji
//
//  Created by Alice Roncella on 30/12/20.
//

import Foundation
import SwiftUI


struct EmojiTF: View {

    @State var emojiText = ""


    var body: some View {
        VStack(spacing: 10) {
            Text("Emoji Pad:")
                .font(.body)
                .foregroundColor(.gray)

            TextFieldWrapperView(text: self.$emojiText)
                .background(Color.gray)
                .frame(width: 200, height: 50)
        }
        .frame(height: 40)
    }
}


struct TextFieldWrapperView: UIViewRepresentable {

    @Binding var text: String

    func makeCoordinator() -> TFCoordinator {
        TFCoordinator(self)
    }
}

extension TextFieldWrapperView {
    func makeUIView(context: UIViewRepresentableContext<TextFieldWrapperView>) -> UITextField {
        let textField = EmojiTextField()
        textField.delegate = context.coordinator
        return textField
    }


    func updateUIView(_ uiView: UITextField, context: Context) {

    }
}

class TFCoordinator: NSObject, UITextFieldDelegate {
    var parent: TextFieldWrapperView

    init(_ textField: TextFieldWrapperView) {
        self.parent = textField
    }
}


class EmojiTextField: UITextField {

    // required for iOS 13
    override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}

struct EmojiTF_Previews: PreviewProvider {
    static var previews: some View {
        EmojiTF()
    }
}
