//
//  SidesView.swift
//  AdvancedUI
//
//  Created by Filip Vabroušek on 30/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct SidesView: View {
    @State var sides = 3.0
    @State var duration = 3.0
    @State var color = Color(0x1abc9c)

    var body: some View {
        VStack {
            Text("Shape morph").bold().edgesIgnoringSafeArea(.top).padding(13.0)
            Spacer()
            Polygon(sides: self.sides)
                .stroke(lineWidth: 6.0)
                .foregroundColor(color)
                .frame(width: 100, height: 100)
                .animation(.easeInOut(duration: duration))
                .layoutPriority(1.0)
                .transition(.asymmetric(insertion: .slide, removal: .scale))

            Spacer()

            HStack {
                Button("Change sides") {
                    if self.sides == 3 {
                        self.duration = self.animationTime(before: Double(self.sides), after: 13.0)
                        self.sides = 13
                        self.color = Color(0x3498db)
                    } else {
                        self.duration = self.animationTime(before: Double(self.sides), after: 3.0)
                        self.sides = 3
                        self.color = Color(0x1abc9c)
                    }
                }
                    .font(Font.body.bold())
            }
            
            Spacer()
        }
    }

    func animationTime(before: Double, after: Double) -> Double {
        // Calculate an animation time that is
        // adequate to the number of sides to add/remove.
        return abs(before - after) * (1 / abs(before - after))
    }
}
