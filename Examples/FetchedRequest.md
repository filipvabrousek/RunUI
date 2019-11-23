## FetchedRequest
* crashes

```swift
class User: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var hobbies: NSSet?
    @NSManaged var parent: User?
}

extension User {
    static func getNodes() -> NSFetchRequest<User> {
        let req = User.fetchRequest() as! NSFetchRequest<User>
        req.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
       // req.predicate = NSPredicate(format: "parent = %@", root ?? NSNull())
        return req
    }
}


struct FetchView: View {
    @Environment(\.managedObjectContext) var ctx: NSManagedObjectContext
    @FetchRequest(fetchRequest: User.getNodes()) var res: FetchedResults<User>

    var body: some View {
        List {
            ForEach(res, id: \.self) { u in
                Text("\(u)").bold()
            }
        }
    }
}
```
