//
//  Modifiers.swift
//  RunFun
//
//  Created by Filip Vabroušek on 26/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct Start: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(Color(0x1abc9c))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .font(Font.body.bold())

    }
}

struct Stop: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(Color(0xe74c3c))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .font(Font.body.bold())

    }
}


struct PostSecondary: ViewModifier {
    func body(content: Content) -> some View {
        content
           .font(.system(.body))
            .foregroundColor(Color.gray)
            .font(.system(size: 12))

    }
}

struct Send: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .foregroundColor(Color(0x3498db))
            .font(Font.body.bold())

    }
}
