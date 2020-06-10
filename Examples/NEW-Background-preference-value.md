## BackgroundPreferenceValue

```swift
struct BoundsKey: PreferenceKey {
    static var defaultValue: [Anchor<CGRect>] { return [] }
    static func reduce(value: inout [Anchor<CGRect>], nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct NextView: View {
    var body: some View {
        VStack {
            Text("Rectangle can fit")
                .anchorPreference(key: BoundsKey.self, value: .bounds) { [$0] }

            Text("both text's widths.")
                .anchorPreference(key: BoundsKey.self, value: .bounds) { [$0] }
        }
            .backgroundPreferenceValue(BoundsKey.self) { preferences in
                GeometryReader { g in
                    VStack {
                        Rectangle()
                            .frame(width: g[preferences[0]].width + g[preferences[1]].width,
                                   height: 20)
                            .offset(y: 51)
                    }
                }
        }
    }
}
```
