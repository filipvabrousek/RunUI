//
//  CircleView.swift
//  AdvancedUI
//
//  Created by Filip Vabroušek on 30/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct CircleView: View {
    @State var show = true
    @State var to: CGFloat = 0
    @State var progress: CGFloat = 0.0

    var body: some View {
        VStack {
            Text("Slider Animation").bold().edgesIgnoringSafeArea(.top).padding(13.0)
            if show == true {
                Spacer()

                ZStack(alignment: .center) {
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color(0x3498db), style: StrokeStyle(lineWidth: 30, lineCap: CGLineCap.round))
                        .frame(width: 230, height: 230)


                    Circle()
                        .trim(from: 0, to: progress / 1.5)
                        .stroke(Color(0xf1c40f), style: StrokeStyle(lineWidth: 30, lineCap: CGLineCap.round))
                        .frame(width: 230, height: 230)

                    Circle()
                        .trim(from: 0, to: progress / 3.0)
                        .stroke(Color(0x2ecc71), style: StrokeStyle(lineWidth: 30, lineCap: CGLineCap.round))
                        .frame(width: 230, height: 230)
                }

            }

            Spacer()

            Slider(value: $progress).padding([.leading, .trailing], 20)
            Spacer()
        }
    }
}


// https://swiftui-lab.com/swiftui-animations-part1/
// https://swiftui-lab.com/advanced-transitions/
// .transition(.moveAndScale)









extension Color {
    init(_ hex: UInt32) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue)
    }
}


struct Polygon: Shape {
    var sides: Double

    var animatableData: Double {
        get { return sides }
        set { self.sides = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height))

        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)

        var path = Path()

        let extra: Int = Double(sides) != Double(Int(sides)) ? 1 : 0

        for i in 0..<Int(sides) + extra {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180

            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))

            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
        }

        path.closeSubpath()

        return path
    }
}
