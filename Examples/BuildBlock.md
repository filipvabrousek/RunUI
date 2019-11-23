# Struct BuildBlock
## ViewBuilder.buildBlock()
* max is 10 variadic arguments
```swift
static func buildBlock<Content>(Content) -> TupleView<(C0, C1)>
static func buildBlock<C0, C1>(C0, C1) -> TupleView<(C0, C1)>
static func buildEither<TrueContent, FalseContent>(first: TrueContent) -> _ConditionalContent<TrueContent, FalseContent>
```

## protocol ViewModifier
* produces different version of original value
```swift
func body(content: Self.Content) -> Self.Body
```

## Views
* AnyView() - a type erased View
* TupleView() - a View created from Swift tuple of values


## List styles

```swift
DefaultListStyle()
PlainListStyle()
GroupedListStyle()
CarouselListStyle()
SideBarListStyle()
```

* fetchedResults


## Lists and ScrollViews
* ForEach conforms to DynamicViewContent - with methods:
```
onDelete()
onInsert(of: perform)
onMove(perform: )
```
