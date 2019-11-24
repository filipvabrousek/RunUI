## Decryption animation

```swift


struct Decryption: View {
    @State var rot: Double = 90
    @State var rotb: Double = 180
    @State var sta: Bool = false

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(lineWidth: 10)
                .frame(width: 218.0, height: 218.0)
                .foregroundColor(Color(hex: "3498db"))
                .rotationEffect(.degrees(rot * 1.5), anchor: .center)

            Circle()
                .trim(from: 0.2, to: 0.8)
                .stroke(lineWidth: 10)
                .frame(width: 238.0, height: 238.0)
                .foregroundColor(Color.black)
                .rotationEffect(.degrees(rot * 2), anchor: .center)

            Circle()
                .trim(from: 0.1, to: 0.7)
                .stroke(lineWidth: 10)
                .frame(width: 258.0, height: 258.0)
                .foregroundColor(Color(hex: "1abc9c"))
                .rotationEffect(.degrees(rot / 3), anchor: .center)

        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                self.rot = 200
            }
        }
    }
}
```


* ```hex``` conversion ```Color``` extension needed
