//
//  Geometry.swift
//  AdvancedUI
//
//  Created by Filip Vabroušek on 30/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct GProxy: View {
    var body: some View {
        VStack {
            Text("GeometryProxy").bold().edgesIgnoringSafeArea(.top).padding(13.0)
            BarView(value: 0.33)
        }
    }
}

struct GeometryEf: View {
    var body: some View {
        VStack {
            Text("GeometryEffect").bold().edgesIgnoringSafeArea(.top).padding(13.0)
            Spacer()
            Text("Skewed")
                .background(Color.green)
                .padding()
                .modifier(Skew(offset: 0.6, skew: 0.4))
            Spacer()
        }
    }
}

struct BarView: View {
    @State var value: CGFloat = 0.0

    var body: some View {
        GeometryReader { g in
            VStack(alignment: .trailing) {
                Text("Progress: \(self.value)").padding()

                ZStack(alignment: .leading) {
                    Rectangle().opacity(0.1).clipShape(RoundedRectangle(cornerRadius: 6.0))
                    Rectangle().frame(minWidth: 0, idealWidth: self.getWidth(proxy: g),
                        maxWidth: self.getWidth(proxy: g))
                        .background(Color(0x1abc9c)) // After clip shape
                    .clipShape(RoundedRectangle(cornerRadius: 6.0))

                }.frame(height: 10)

            }.frame(height: 10)
                .padding([.leading, .trailing], 10)
        }
    }

    func getWidth(proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .global)
        return frame.size.width * value
    }
}

// Skew using GeometryEffect
struct Skew: GeometryEffect {
    var offset: CGFloat
    var skew: CGFloat


    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(offset, skew) }

        set {
            offset = newValue.first
            skew = newValue.second
        }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(a: 1, b: 0, c: skew, d: 1, tx: offset, ty: 0))
    }
}
