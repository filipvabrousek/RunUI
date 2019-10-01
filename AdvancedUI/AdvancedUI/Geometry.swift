//
//  Geometry.swift
//  AdvancedUI
//
//  Created by Filip Vabroušek on 30/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct GProxy: View {

    @State var progress: CGFloat = 0.0
    @State var text: String = "Set progress"

    var body: some View {
        VStack {
            Text("GeometryProxy").bold().edgesIgnoringSafeArea(.top).padding(13.0)

            Spacer()

            Button(text) {
                withAnimation {
                    if self.progress > 0.0 {
                        self.progress = 0.0
                        self.text = "Set progress"
                    } else {
                        self.progress += 0.33
                        self.text = "Reset"

                    }
                }
            }.frame(width: UIScreen.main.bounds.width)

            Spacer()
            BarView(value: $progress)
            Spacer()
        }
    }
}


struct BarView: View {
    @Binding var value: CGFloat
    
    var body: some View {
        GeometryReader { g in
            VStack() {
                Text("\(Int(self.value * 100)) %")
               // Text(self.formatTime())
                    .edgesIgnoringSafeArea(.leading)
                    .edgesIgnoringSafeArea(.trailing)
                    .padding()

                ZStack(alignment: .leading) {
                    Rectangle().opacity(0.1).clipShape(RoundedRectangle(cornerRadius: 6.0))
                    Rectangle().background(Color(0x1abc9c)).frame(minWidth: 0, idealWidth: self.getWidth(proxy: g),
                        maxWidth: self.getWidth(proxy: g))

                    //  .overlay(RoundedRectangle(cornerRadius: 6.0).background(Color(0x1abc9c)))

                        .clipShape(RoundedRectangle(cornerRadius: 6.0))

                    // After clip shape

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



struct GeometryEf: View {
    @State var offset: CGFloat = 0.0
    @State var skew: CGFloat = 0.0
    @State var skewed: Bool = false

    var body: some View {
        VStack {
            Text("GeometryEffect").bold().frame(width: 200).edgesIgnoringSafeArea(.top).padding(.top, 13.0)
            Spacer()

            Text("Skewed")
                .font(.system(size: 40, weight: .heavy, design: .default))
                .background(Color.green)
                .padding(10)
                .modifier(Skew(offset: offset, skew: skew))

            Spacer()

            Button("Skew") {
                withAnimation {
                    if self.skewed {
                        self.offset = 0.0
                        self.skew = 0.0
                        self.skewed.toggle()
                    } else {
                        self.offset = 0.6
                        self.skew = 0.4
                        self.skewed.toggle()
                    }
                }
            }
            Spacer()
        }
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
