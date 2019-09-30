//
//  AlignView.swift
//  AdvancedUI
//
//  Created by Filip Vabroušek on 30/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct AlignView: View {
    var body: some View {
        VStack {
            Text("Alignment Guides").bold().edgesIgnoringSafeArea(.top).padding(13.0)
            Spacer()
           
            HStack(alignment: .mid) {
                VStack {
                    Text("Align").frame(width: 110).alignmentGuide(.mid) { d in d[.bottom] / 2 }
                    Text("Nice.")
                }.frame(width: 110)

                VStack {
                    Text("with me").alignmentGuide(.mid) { d in d[.bottom] / 2 }
                    Image("avocado")
                }.frame(width: 110)
            }
            
            Spacer()
        }
    }
}


extension VerticalAlignment {
    private enum MidAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[.bottom]
        }
    }

    static let mid = VerticalAlignment(MidAlign.self)
}
