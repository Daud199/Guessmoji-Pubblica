//
//  Extensions.swift
//  Guessmoji
//
//  Created by Alice Roncella on 16/03/21.
//

import UIKit

extension Character {
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }

    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }

    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) //manda un azione al responder che gestisce cosa c'è inprimo piano e gli dice di chiudere la cosa
    }
}

//extension UIApplication {
//    func startEditing() {
//        sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
