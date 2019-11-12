## Selection

```swift
struct ModeView: View {
    @State var names: [P] = ["Filip", "Bond", "Hey"].map { P(name: $0) }
    @State var selectedRows = Set<UUID>()

    var body: some View {
        NavigationView {
            List(names, selection: $selectedRows) { n in
                Text(n.name).bold()
            }
                .navigationBarItems(trailing: EditButton())
                .navigationBarTitle("Selected \(selectedRows.count) users")
                .padding()
        }
    }
}
```

## EditMode
```swift
struct EditView: View {
    @Environment(\.editMode) var emode
    // emode?.wrappedValue == .inactive
    @State var mode: EditMode = .inactive

    var body: some View {
        NavigationView {
            VStack {
                if mode == .inactive {
                    Text("Inactive")
                } else {
                    Text("Active")
                }
            }.navigationBarItems(trailing: toggle)
        }
    }

    var toggle: some View {
        Button("Toggle") {
            if self.mode == EditMode.inactive {
                self.mode = .active
            } else {
                self.mode = .inactive
            }
        }
    }
}
```
