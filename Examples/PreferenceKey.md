# PreferenceKey
* had to rewrite it 

```swift

struct Wrapper: View {
    @State var w: CGFloat? = nil

    var body: some View {
        VStack {
            HStack {
                Text("Simple")
                    .background(MEqualiser())
                    .frame(width: w, alignment: .leading)
                Rectangle().frame(width: 40, height: 40)
            }

            HStack {
                Text("Lot longer")
                    .background(MEqualiser())
                    .frame(width: w, alignment: .leading)
                Rectangle().frame(width: 40, height: 40)
            }
        }.modifier(WrapWidth(width: $w))
    }
}



struct WP: Equatable {
    let width: CGFloat
}


// We are changing values of CKey through MEqualiser View (we feed geometry.frame into it)
struct CKey: PreferenceKey {
    typealias Value = [WP]
    static var defaultValue: [WP] = []
    static func reduce(value: inout [WP], nextValue: () -> [WP]) {
        value.append(contentsOf: nextValue())
    }
}

struct MEqualiser: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(
                    key: CKey.self, // we get the width here and we listen for this call in CMWidth
                    value: [WP(width: geometry.frame(in: .global).width)]
                )
        }
    }
}

// Listens for preference changes trigerred by MEqualiser() above
/* Iterate through the preference key/value pairs for all the child views looking for the widest Text view, which it saves to width the argument passed to it (so all Text view fit)  */
struct WrapWidth: ViewModifier {
    @Binding var width: CGFloat?

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(CKey.self) { prefs in
                for p in prefs {
                    let old = self.width ?? CGFloat.zero
                    if p.width > old {
                        self.width = p.width + 20
                    }
                }
        }
    }
}

// SOURCE: https://medium.com/better-programming/using-the-preferencekey-protocol-to-align-views-7f3ae32f60fc
// Many thanks!
```
