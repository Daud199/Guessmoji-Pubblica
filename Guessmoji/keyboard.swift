//
//  keyboard.swift
//  Guessmoji
//
//  Created by Alice Roncella on 13/03/21.
//

import UIKit

class emojiKB: UIButton, UIKeyInput {

    var hasText: Bool = true

    override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    func insertText(_ text: String) { print("\(text)") }

    func deleteBackward() {}

    override var canBecomeFirstResponder: Bool { return true }

    override var canResignFirstResponder: Bool { return true }

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}
