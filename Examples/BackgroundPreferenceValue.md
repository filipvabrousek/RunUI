## BackgroundPreferenceValue

```swift
struct RowFrame: PreferenceKey {
    static var defaultValue: [Anchor<CGRect>] { return [] }

    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> [Anchor<CGRect>]) {
        value.append(contentsOf: nextValue())
    }
}

struct Rowo: View {
    let text: Text

    var body: some View {
        text
            .foregroundColor(.green)
            .padding()
            .anchorPreference(key: RowFrame.self, value: .bounds) { [$0] }

    }
}

struct NextView: View {
    var body: some View {
        VStack {
            Rowo(text: Text("Row"))
            Rowo(text: Text("Row"))
            Rowo(text: Text("Row"))
        }.backgroundPreferenceValue(RowFrame.self) { value in
            GeometryReader { g in
                ZStack {
                    ForEach(0..<value.count) { i in
                        RoundedRectangle(cornerRadius: 23.0)
                            .fill(Color.blue)
                            .offset(x: 0, y: g[value[i]].origin.y)
                            .frame(width: g.size.width, height: g[value[i]].size.height)
                            .fixedSize()
                    }
                }
            }
        }
    }
}
```
