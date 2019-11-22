## Drag & Drop 
* only MacOS

```swift

struct Drop: View, DropDelegate {
    @State var text: String = "Drop photo"

    var body: some View {
        VStack {
            Spacer()
            Text("\(text)").bold()
            Spacer()
            HStack {
                Rectangle().fill(Color.clear)
            }//.onDrop(of: [(kUTTypeImage as String), "public.pdf"], delegate: self)


        }.onDrop(of: [kUTTypeImage as String, "public.pdf"], delegate: self)
            .onCopyCommand { () -> [NSItemProvider] in
                print("Wow")
                return [NSItemProvider(contentsOf: URL(string: "Hey"))!]

        }
    }

    // https://developer.apple.com/documentation/swiftui/view
    // + compositionGroup
    // + TouchBar :D

    func dropUpdated(info: DropInfo) -> DropProposal? {
        let p = DropProposal.init(operation: .copy)
        return p
    }

    func performDrop(info: DropInfo) -> Bool {
        print("perform drop")
        self.text = "Dropped"
        return true
    }
}
```
