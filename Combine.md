# Combine

## 1
```swift
let publisher = Just(1) // Publisher
// subscripber
publisher.sink(receiveCompletion: { _ in
    print("Finished")
}) { (value) in
    print(value)
}
```

## 2
```swift
// Failure type is Never (indictaes that it ends successfully)
let sub = PassthroughSubject<String, Never>()
sub.sink(receiveCompletion: { _ in
    print("Finished")
}) { res in
    print(res)
}

sub.send("Hey")
sub.send(completion: .finished)
```

## 3
* Current Value Subject - starts with initial value
```swift
let subj = CurrentValueSubject<Int, Never>(1)
subj.send(2)
print(subj.value)

subj.sink { val in
    print(val)
}
```

## 4
* Publisher and Subscriber Life Cycle
* 1 - subscriber connets to the Publisher by Calling ```Subscribe<S>(S)```
* 2 - Publisher creates a subscription by calling ```receive<S>(subscriber: S)``` on itself
* 3 - Publisher calls ```receive(subscription:)``` on the subscriber
* 4 - Subscriber calls ```request(:)``` on the subscription and passes ```Demand``` parameter (how many times can send)
* 5 - Publisher sends value by calling ```receive(_:)``` on the subscriber
* 6 - Subscription ends with outcomes: ```Cancelled, Finish, Fail```
    
    
```swift
let sm = PassthroughSubject<Int, Never>()
let token = sm
    .print()
    .sink { val in
        print("Value \(val)")
}

sm.send(3)
```


## Advanced
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

SOURCE: // https://www.vadimbulavin.com/swift-combine-framework-tutorial-getting-started/
Many thanks!
