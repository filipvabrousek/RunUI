//
//  CadenceView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 05/07/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct P {
    var x: Int = 0
    var y: Int = 0
}

// change point color when toggle is on
extension Color {
    init(_ hex: UInt32) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue)
    }
}


struct BorderField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 3.0))
    }
}



struct DrawView: View {

    var points = [P]()
    // @State var isHR = true

    init(points: [P]) {
        self.points.removeAll()

        for p in points {
            self.points.append(p)
        }
    }


    @State var isHR: Bool = true

    @State var name = ""
    @State var age = ""


    var body: some View {
        VStack {

            HStack {
                Text("Settings").font(.system(size: 36)).bold()
                Spacer()
            }.padding(.all, 20)

            Toggle(isOn: $isHR) {
                Text("Toggle:")
            }.offset(y: 10)
                .frame(width: 200)
            //  .border(Color(0xe67e22), width: 4, cornerRadius: 6)

            Group {
                TextField("Enter name", text: $name)
                    .modifier(BorderField())
                TextField("Enter age", text: $age)
                    .textContentType(.creditCardNumber)
                    .modifier(BorderField())

            }.padding()
                .padding(.top, 60)
                .frame(height: 90)



            Spacer()
            HStack {
                Text("Drawing").font(.system(size: 36)).bold()
                Spacer()
            }.padding(.all, 20)

            Path { path in
                for p in points {
                    path.addEllipse(in: .init(x: p.x, y: p.y, width: 23, height: 23))
                }
            }.fill()
            
            Spacer()
                


            /*  if isHR {
                self.background(Color.blue)
            } else {
                self.background(Color.green)
            }*/

        }
    }
}




struct CadenceView: View {
    let pw = DrawView(points: [P(x: 10, y: 10), P(x: 40, y: 70), P(x: 20, y: 37)])

    var body: some View {
        pw
    }
}

