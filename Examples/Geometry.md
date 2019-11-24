# Geometry

## GeometryReader, GeometryProxy

```swift
struct BarView: View {
    @State var value: CGFloat = 0.80

    var body: some View {
        GeometryReader { g in
            VStack {
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .opacity(0.1)
                        .clipShape(RoundedRectangle(cornerRadius: 6.0))

                    Rectangle()
                        .foregroundColor(.green)
                        .frame(minWidth: 0, idealWidth: self.getWidth(proxy: g),
                            maxWidth: self.getWidth(proxy: g))
                        .clipShape(RoundedRectangle(cornerRadius: 6.0))

                }.frame(height: 10)

            }.frame(height: 10)
                .padding([.leading, .trailing], 10)
        }
    }

    func getWidth(proxy: GeometryProxy) -> CGFloat {
        let frame = proxy.frame(in: .global)
        let w = frame.size.width
        return (w - 0.2 * w) * value
    }
}
```



## GeometryEffect

```swift

struct EffectView: View {
    @State var offset: CGFloat = 0.8
    @State var skew: CGFloat = 0.3
    @State var skewed: Bool = false

    var body: some View {
        Text("Skewed")
            .font(.system(size: 40, weight: .heavy, design: .default))
            .background(Color.green)
            .modifier(Skew(offset: offset, skew: skew))
    }
}


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
```
