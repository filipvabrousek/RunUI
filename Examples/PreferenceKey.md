# PreferenceKey

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

            HStack {
                Text("Third").bold()
                    .frame(width: width, alignment: .leading)
                    .background(EqualiserView())
                TextField("Enter first item", text: $c)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }.modifier(CWidth(width: $width))
    }
}

struct WPref: Equatable {
    let width: CGFloat
}

struct ColumnKey: PreferenceKey {
    typealias Value = [WPref]
    static var defaultValue: [WPref] = []
    static func reduce(value: inout [WPref], nextValue: () -> [WPref]) {
        value.append(contentsOf: nextValue())
    }
}



// it gets the width of each Text() using GR (used as background)
// generates (key/value) pair for the CWidth()
struct EqualiserView: View {
    var body: some View {
        GeometryReader { g in
            Rectangle()
                .fill(Color.blue)
                .preference(key: ColumnKey.self,
                    value: [WPref(width: g.frame(in: .global).width)])
        }
    }
}



// Listens for preference changes trigerred by EqalizerView() above
/* Iterate through the preference key/value pairs for all the child views looking for the widest Text view, which it saves to width the argument passed to it (so all textViews fit)  */

/*
 named value produced by a view. Views with multiple children automatically combine all child values into a single value visible to their ancestors. */
struct CWidth: ViewModifier {
    @Binding var width: CGFloat?

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ColumnKey.self) { (prefs) in
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
