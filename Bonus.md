## Circle Animation

```swift
struct ContentView: View {
    @State var colora: Color = .green
    @State var colorb: Color = .green
    @State var size: CGFloat = 60.0
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(0x81ecec))
                .frame(width: size, height: size)
                .scaleEffect(isActive ? 3.3 : 1.0)

            Circle()
                .fill(Color(0x7ed6df))
                .frame(width: size, height: size)
                .scaleEffect(isActive ? 2.3 : 1.0)

            Circle()
                .fill(Color(0xffffff))
                .frame(width: size, height: size)
                .scaleEffect(isActive ? 1.3 : 1.0)
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.isActive.toggle()
                }
            }
        }
    }
}
```


## Styling a button

```swift
struct SleekView: View {
    var body: some View {
        Button("Sleek") {
            print("Sleep?")
        }.buttonStyle(Sleek())
    }
}

struct Sleek: ButtonStyle {
    func makeBody(configuration: Sleek.Configuration) -> some View {
        configuration.label.foregroundColor(Color.orange)
    }
}
```

## Styling a toggle

```swift

struct ToggleView: View {
    @State var isOn: Bool = false

    var body: some View {
        Toggle(isOn: $isOn) {
            Text("Hey").bold()
        }.toggleStyle(SleekToggler())
            .labelsHidden()
    }
}

struct SleekToggler: ToggleStyle {
    let width: CGFloat = 50.0

    func makeBody(configuration: Self.Configuration) -> some View {
        ZStack(alignment: configuration.isOn ? .trailing : .leading) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(0xd3d3d3))
                .frame(width: width, height: width / 3, alignment: .leading)

            RoundedRectangle(cornerRadius: 12)
                .fill(Color(0x3498db))
                .frame(width: width / 3, height: width / 3, alignment: .leading).onTapGesture {
                    configuration.$isOn.wrappedValue.toggle()
            }
        }.accessibility(activationPoint: configuration.isOn ? UnitPoint(x: 2.0, y: 3.0) : UnitPoint(x: 0.75, y: 0.90))
    }
}
```



## Alignment guides

```swift

struct Aligning: View {
    var body: some View {
        HStack(alignment: .feet) {
            Rectangle()
                .frame(width: 30, height: 100)
                .foregroundColor(Color.orange)
                .alignmentGuide(.feet, computeValue: { _ in 0 })

            Rectangle()
                .frame(width: 30, height: 100)
                .alignmentGuide(.feet, computeValue: { _ in 20 })
        }
    }
}


extension VerticalAlignment {
    enum Feet: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.bottom]
        }
    }
    static let feet = VerticalAlignment(Feet.self)
}
```

# DateView
```swift
struct DateV: View {
    @State private var date = Date()

    var body: some View {
        DatePicker(selection: $date, displayedComponents: .date, label: { Text("Date") })
    }
}
```



## Animatable Gradient
```swift

struct AnimGrad: View {
    @State var animate = false

    var body: some View {
        let ga: [UIColor] = [.blue, .green]
        let gb: [UIColor] = [.red, .yellow]
        let grad = Grad(from: ga, to: gb, pct: animate ? 1 : 0)

        return VStack {
            Spacer()

            Color.clear.frame(width: 200, height: 200)
                .overlay(Color.clear.modifier(grad))

            Spacer()

            Button("Toggle") {
                withAnimation {
                    self.animate.toggle()
                }
            }

            Spacer()
        }
    }
}



struct Grad: AnimatableModifier {
    let from: [UIColor]
    let to: [UIColor]
    var pct: CGFloat = 0.0

    var animatableData: CGFloat {
        get { pct }
        set { pct = newValue }
    }

    func body(content: Content) -> some View {
        var gColors = [Color]()

        for i in 0..<from.count {
            let mix = colorMixer(c1: from[i], c2: to[i], pct: pct)
            gColors.append(mix)
        }

        var grad = LinearGradient(gradient: Gradient(colors: gColors), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))

        return RoundedRectangle(cornerRadius: 15)
            .fill(grad)
            .frame(width: 200, height: 200)
    }

    func colorMixer(c1: UIColor, c2: UIColor, pct: CGFloat) -> Color {
        guard let cc1 = c1.cgColor.components else { return Color(c1) }
        guard let cc2 = c2.cgColor.components else { return Color(c1) }

        let r = (cc1[0] + (cc2[0] - cc1[0]) * pct)
        let g = (cc1[1] + (cc2[1] - cc1[1]) * pct)
        let b = (cc1[2] + (cc2[2] - cc1[2]) * pct)

        return Color(red: Double(r), green: Double(g), blue: Double(b))
    }
}
```

SOURCE: https://swiftui-lab.com/  
4/11/2019  
Many thanks!  
