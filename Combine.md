# Combine

```swift
enum iOSError: Error {
    case wrong
}

let publisher = PassthroughSubject<Int, iOSError>()

let subscriber = publisher
    .filter { $0 >= 13 }
    .sink(receiveCompletion: { (err) in
        print("Please update your software.")
    }) { (val) in
        print("Yes !")
}

publisher.send(13) // Wow !
```

## Notification.subscriber
```swift
extension Notification.Name {
    static let new = Notification.Name("new")
}

struct P {
    let content: String
}

let PP = NotificationCenter.Publisher(center: .default, name: .new, object: nil)
    .map { (notif) -> String? in
        return (notif.object as? P)?.content ?? ""
}

let l = UILabel()
let lasta = Subscribers.Assign(object: l, keyPath: \.text)
PP.subscribe(lasta)

let post = P(content: "I love Combine!")
NotificationCenter.default.post(name: .new, object: post)
print("Latest post \(l.text!)")



```
