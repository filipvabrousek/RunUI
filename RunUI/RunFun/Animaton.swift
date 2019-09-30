//
//  Animaton.swift
//  RunFun
//
//  Created by Filip Vabroušek on 26/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct AnimationView: View {
    @State var show = true
    var body: some View {
        ZStack(alignment: .top) {
            MapView(loc2D: .init(latitude: 49.2, longitude: 17.6), isDetail: true)
                .edgesIgnoringSafeArea(.all)
            if show {
                CardView()
            }
        }
    }
}

struct CardView: View {
    @GestureState private var stater: DragState = .inactive //GestureState(initialValue: 230)
    @State var position: CardPosition = .middle
    @State var c = CustomGetter()

    var body: some View {
        let gesture = DragGesture()
            .updating($stater) { (drag, state, trans) in
                state = .dragging(translation: drag.translation)
                print("Hey")
            }
            .onEnded(onDragEnded)

        return CardContent()
            .offset(x: 0, y: position.rawValue + stater.translation.height)
            .animation(.spring())
            .gesture(gesture)
    }

    private func onDragEnded(drag: DragGesture.Value) {
        let post = CustomGetter()
        self.position = post.posy(position: self.position, drag: drag)
    }
}

struct CardContent: View {
    var body: some View {
        ZStack(alignment: .top) { // What is at the bottom, will be at the top :D

            Rectangle().fill(Color(.white))
                .edgesIgnoringSafeArea(.all)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            /* Text("Half Modal")
                           .bold()
                           .padding(.top, 40)*/

            // Rectangle().fill(Color.orange).frame(width: 100, height: 100)

            VStack {

                Spacer()
                HStack {
                    Spacer()
                    Text("Iceland")
                        .foregroundColor(.black)
                        .font(.system(size: 30, weight: .black, design: .default))
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Image("iceland").frame(width: 70, height: 70).clipShape(Circle())
                    Spacer()
                }

                Spacer()
                Spacer()

                Text("Reykjavík is the capital and largest city of Iceland. It is located in southwestern Iceland, on the southern shore of Faxaflói bay. Its latitude is 64°08' N, making it the world's northernmost capital of a sovereign state. With a population of around 128,793 (and 228,231 in the Capital Region),it is the center of Iceland's cultural, economic and governmental activity, and is a popular tourist destination.")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding([.trailing, .leading], 22)
                    .padding(.bottom, 60)

                HStack {
                    Spacer()
                    Spacer()
                    Button("Share") { }.modifier(MapDetail()).frame(width: 80)
                    Spacer()
                    Button("Save") { }.modifier(MapDetail()).frame(width: 80)
                    Spacer()
                    Button("Rate") { }.modifier(MapDetail()).frame(width: 80)
                    Spacer()
                    Spacer()
                }


                FSpacer(3)

                // YOU CANNOT INSERT MORE THAN 10 SPACERS !!!!!!!!!!!!
                // USE FSpacer



                /* Spacer()
                Spacer()*/
            }

        }
    }
}



struct MapDetail: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(Color(0x3498db))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .font(Font.body.bold())


    }
}



enum CardPosition: CGFloat {
    case top = 100
    case middle = 380
    case bottom = 600 // 850
}

class CustomGetter {
    var pos: CardPosition = .top

    // Thanks to: // https://www.mozzafiller.com/posts/swiftui-slide-over-card-like-maps-stocks
    func posy(position: CardPosition, drag: DragGesture.Value) -> CardPosition {

        var pos = position

        let vert = drag.predictedEndLocation.y - drag.location.y
        let topEdge = position.rawValue + drag.translation.height
        let above: CardPosition
        let below: CardPosition
        let closest: CardPosition

        if topEdge <= CardPosition.middle.rawValue {
            above = .top
            below = .middle
        } else {
            above = .middle
            below = .bottom
        }

        if (topEdge - above.rawValue) < (below.rawValue - topEdge) {
            closest = above
        } else {
            closest = below
        }

        if vert > 0 {
            pos = below
        } else if vert < 0 {
            pos = above
        } else {
            pos = closest
        }

        return pos
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)

    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero

        case .dragging(let translation):
            return translation
        }
    }

    var isDragging: Bool {
        switch self {
        case .inactive:
            return false

        case .dragging:
            return true
        }
    }
}

/*
struct Contenta {
    var header: String
    var text: String
}

struct AnimationView: View {

    @State var properties = [Contenta(header: "Filip", text: "19"), Contenta(header: "Terka", text: "20")]
    @State var w = UIScreen.main.bounds.width
    @State var h = UIScreen.main.bounds.height


    var body: some View {
        ScrollView {
            ForEach(properties, id: \.header) { c in
                Card(content: c).frame(width: self.w * 0.8)
            }
        }.frame(height: h * 0.6)
    }
}


struct Card: View {
    var content: Contenta
    var body: some View {
        Group {
            HStack {

                VStack(alignment: .leading) {
                    Text(content.header).bold().foregroundColor(Color.white).padding(3)
                    Text(content.text).bold().foregroundColor(Color.white).padding(3)
                }
                Spacer()
            }
            // .shadow(radius: 0.8)

        }.clipShape(RoundedRectangle(cornerRadius: 9))
            .background(Color(0x1abc9c))
        .padding(.bottom, 12)

    }
}*/



struct FSpacer: View {
    var count: Int = 1

    init(_ count: Int) {
        self.count = count
    }

    var body: some View {
        VStack {
            if count == 2 {
                Spacer()
                Spacer()
            }

            if count == 3 {
                Spacer()
                Spacer()
                Spacer()
            }

            if count == 6 {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }

            if count == 9 {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
        }
    }
}
