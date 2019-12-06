//
//  Testing.swift
//  wdefw
//
//  Created by Filip Vabroušek on 06/12/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI


struct Extensions: View {
    var body: some View {
        VStack {
            Image("whale")
                .size(150, 150)
            // .edge()



            Text("Text")
                .align(.leading)
                .font(16, .bold)
                .color(.blue)

            Button("Hello") {
                print("Now")
            }
                .bold()
                .color(.green)

            TextField("Hello", text: .constant("Hello"))
                .clip(Color.blue, 2, 4)
        }
    }
}

/*
struct aligned: ViewModifier {
    var al: TextAlignment
    func body(content: Content) -> some View {
        return content.multilineTextAlignment(al)
    }
}*/


extension Text {
    func align(_ al: TextAlignment) -> some View {
        return self.multilineTextAlignment(al)
    }
}


extension Button {
    func bold() -> some View {
        return self.font(Font.body.bold())
    }
}


enum CleanColor {
    case blue
    case green
}

extension View {
    func font(_ size: CGFloat, _ weight: Font.Weight? = .medium) -> some View {
        if weight == nil {
            return self.font(Font.system(size: size, weight: Font.Weight.regular, design: .default))
        } else {
            return self.font(Font.system(size: size, weight: weight!, design: .default))
        }
    }

    func color(_ c: CleanColor) -> some View {
        if c == .green {
            return self.foregroundColor(Color(0x1abc9c))
        } else {
            return self.foregroundColor(Color(0x3498db))
        }
    }


}





extension View {
    public func clip<S>(_ content: S, _ width: CGFloat = 1, _ radius: CGFloat) -> some View where S: ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: radius).strokeBorder(content, lineWidth: width))
    }
}


struct overlayd: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            content
            Text(text).fontWeight(.bold)
        }
    }
}

extension View {
    func overlayed(with: String) -> some View {
        return self.modifier(overlayd(text: with))
    }
}


struct OView: View {
    var body: some View {
        Image("whale")
            .frame(width: 200, height: 200)
            .overlayed(with: "Filip love SwiftUI!")
    }
}



struct XPrev: PreviewProvider {
    static var previews: some View {
        OView()
    }
}



/*
extension View {
    public func clip<S>(_ content: S, w: CGFloat = 1, radius: CGFloat) -> some View where S: ShapeStyle {
        return overlay(RoundedRectangle(cornerRadius: radius).strokeBorder(content, lineWidth: w))
    }
}*/

/*
extension View {
    func round<S>(_ content: S) -> some View where S: ShapeStyle {
        return clipShape(Circle())
    }
}*/

extension View {
    func round() -> some View {
        return self.clipShape(Circle())
    }

    func size(_ w: CGFloat, _ h: CGFloat) -> some View {
        return (self as! Image).resizable().frame(width: w, height: h)
    }
}


extension Image {
    func edge() -> some View {
        self.resizable()
            .scaledToFill()
            .clipped()
            .edgesIgnoringSafeArea(.all)
    }
}



/*
 extension Circle {
     func round() -> some View {
         self
             .fill(Color("InvertColor"))
             .frame(width: 90, height: 90)
     }
 }
 
 
 
 */


func hex(_ hex: String) -> UIColor {
    var cs = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cs.hasPrefix("#") {
        cs.remove(at: cs.startIndex)
    }

    if cs.count != 6 {
        return UIColor.black
    }

    var rgbv: UInt32 = 0
    Scanner(string: cs).scanHexInt32(&rgbv)

    return UIColor(red: CGFloat((rgbv & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbv & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat((rgbv & 0x0000FF)) / 255.0,
        alpha: CGFloat(1.0))
}



extension Color {
    init(_ hex: UInt32, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
