# PreferenceKey
* had to rewrite it 

```swift

struct Fields: View {
    @State var a: String = ""
    @State var b: String = ""
    @State var c: String = ""
    @State var width: CGFloat? = nil

    var body: some View {
        Form {
            HStack {
                Text("First").bold()
                    .frame(width: width, alignment: .leading)
                    .background(EqualiserView())
                TextField("Enter first item", text: $a)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            HStack {
                Text("Second").bold()
                    .frame(width: width, alignment: .leading)
                    .background(EqualiserView())
                TextField("Enter first item", text: $b)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

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
        }.modifier(CMWidth(width: $w))
    }
}


struct WP: Equatable {
    let width: CGFloat
}

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
                    key: CKey.self,
                    value: [WP(width: geometry.frame(in: .global).width)]
                )
        }
    }
}


struct CMWidth: ViewModifier {
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
