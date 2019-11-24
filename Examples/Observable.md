## EnvironmentObject
* need to set it in SceneDelegate()
* ALL Views update if something changes
```swift
 let contentView = A().environmentObject(Env())
 ```
 
```swift
class Env: ObservableObject {
    @Published var data: String = ""
}
```


```swift
struct A: View {
    @EnvironmentObject var env: Env
    
    var body: some View {
        VStack {
            Button("Crack"){
                self.env.data = "Heya !!!"
            }
            
            B() // YOU DO NOT HAVE TO PASS IT
        }
    }
}


struct B: View {
    @EnvironmentObject var env: Env
    
    var body: some View {
        VStack {
            Text("Value \(env.data)")
        }
    }
}

```

## ObservedObject
* no need to set it in SceneDelegate()
* required for reference types (Class)
* need to pass through Views


```swift

struct C: View {
    @ObservedObject var env = Env()

    var body: some View {
        VStack {
            Button("Crack") {
                self.env.data = "Heya !!!"
            }

            D(title: self.$env.data)
        }
    }
}


struct D: View {
    var title: Binding<String>

    var body: some View {
        VStack {
            Text("D Value \(title.wrappedValue)")
        }
    }
}
```
## $ = 2 way binding, reads and writes Value
