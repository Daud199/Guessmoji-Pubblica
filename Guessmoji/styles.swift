//
//  Styles.swift
//  Guessmoji
//
//  Created by Alice Roncella on 13/03/21.
//

import SwiftUI

struct box: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 220, height: 35, alignment: .center)
            .font(Font
                .custom("Nunito-SemiBold", size: 18))
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 14).fill(Color("grayLight")))
    }
}

struct button: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 180, height: 35, alignment: .center)
            .font(Font
                .custom("Nunito-SemiBold", size: 18))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 14).fill(Color("yellow")))
    }
}
