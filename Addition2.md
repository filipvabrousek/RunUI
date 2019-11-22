## Addition2


### Mask
```swift
Image("iceland")
            .resizable()
            .frame(width: 200, height: 200)
            .imageScale(.large)
            .keyboardType(.emailAddress)
            .mask(Text("SwiftUI")
                    .font(.system(size: 40, weight: .black, design: .default)))
```

### KeyboardType
```swift
struct KType: View {
    @State var str = ""

    var body: some View {
        TextField("Hey", text: $str)
            .keyboardType(.asciiCapableNumberPad)
    }
}
```

### Accessibility
```swift
struct Access: View {
    var body: some View {
        Text("CZE").bold()
        .minimumScaleFactor(3.0)
        // text can Compress space between characters
        .allowsTightening(true)

        // taps continue through the View (isUserIntEnabled :D)
        .allowsHitTesting(true)
        // lines that are too long will wrap
        .truncationMode(.tail)
        .textContentType(.countryName)
        .flipsForRightToLeftLayoutDirection(true)
    }
}
```

```swift
struct Accesibility: View {
    var body: some View {
        Text("Accessible")
            .accessibilityAction {
                print("Access enabled")
            }
            .accessibilityAdjustableAction { (x) in
                print(x)
        }
    }
}
```

### Gesture
```swift
     Text("Gesture").highPriorityGesture(TapGesture(count: 2)
              .onEnded {
                  print("Hey")
           })
```

### Scheme
```swift
Text("Command")
            .colorScheme(.light)
            .preferredColorScheme(.dark)
        // A compositing group makes compositing effects in this view’s ancestor views, like opacity and the blend mode, take effect before this view renders.
        .compositingGroup()
            .moveDisabled(true)
```


### PopOver
```swift
struct PopOver: View {
    @State var show: Bool = false

    var body: some View {
        Button("Hey") {
            self.show.toggle()
            print("Bubmlebee 2")

        }.popover(isPresented: $show) {
            Text("Wow")
        }
    }
}
```



# MacOS
```swift
struct Paste: View {
    var body: some View {
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onMoveCommand { d in
                print(d)
        }
        .onPasteCommand(of: ["Hello"]) { (provider) in
            print("Hello pasted")
        }
    }
}
```


### onHover
```swift
Text("Hover me")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .focusable()
            .onHover { (val) in
            print("Hovering")
}
```

## TouchBar
```swift
struct Touch: View {
    var body: some View {
        Text("TouchBar").touchBar(
            TouchBar {
                Button("Hey"){
                    print("Wow")
                }
            }
        )
    }
}
```


## Controls

```swift
struct Controls: View {
    var body: some View {
        Text("Hey").controlSize(.mini)
    }
}
```
