## EnvironmentObject
* you do **not** have to pass it
* need to set it in SceneDelegate()
* any View can access it

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
* you **have to** pass the object
* no need to set it in SceneDelegate()
* required for reference types (Class)
* if View C wanted data from View A, you would need to hand the object also to View B

## $ - 2 way binding, reads and writes Value

```swift
C: View {
    @ObservedObject var env = Env()
    //   EO we have to set it up in SceneDelegate()

    var body: some View {
        VStack {
            Button("Crack") {
                self.env.data = "Heya !!!"
            }

            D()//.environmentObject(env)
        }
    }
}


struct D: View {
    @ObservedObject var env = Env()

    var body: some View {
        VStack {
            Text("Value \(env.data)")
        }
    }
}
```
