# ``EnvironmentKit``

EnvironmentKit is a SwiftUI SDK that lets you define custom SwiftUI environment values with less code.

![EnvironmentKit logotype](Logo)


## ‼️ Important Information

Xcode 16 added support for the new `@Entry` type, which makes it a lot easier than before to create various value types, which makes this SDK less useful than it was before.

While this SDK remains a fun experiment with how far we could push Swift to make it easier to create custom environment values, this will most probably be left as is until September 2025, at which it will be deleted.


## Installation

EnvironmentKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/EnvironmentKit.git
```

You can also just copy the `EnvironmentValue.swift` file to your project, instead of using the package.



## Getting Started

Without `EnvironmentKit`, you have to write this boilerplate code for each custom environment value:

```swift
public extension MyStyle {
    
    static var standard = Self()
}

private extension MyStyle {

    struct Key: EnvironmentKey {
        static var defaultValue: MyStyle = .standard
    }
}

public extension EnvironmentValues {

    var myStyle: MyStyle {
        get { self[MyStyle.Key.self] }
        set { self[MyStyle.Key.self] = newValue }
    }
}

public extension View {

    func myStyle(_ style: MyStyle) -> some View {
        environment(\.myStyle, style)
    }
}
```

With `EnvironmentKit`, you just need to implement `EnvironmentValue` and add a little extra code:

```swift
struct MyStyle: EnvironmentValue { 
    
    static var keyPath: EnvironmentPath { \.myStyle }    
}

extension EnvironmentValues {

    var myStyle: MyStyle {
        get { get() } set { set(newValue) }
    }
}

extension View {

    func myStyle(_ style: MyStyle) -> some View {
        environment(style)
    }
}
```

This makes it faster and easier to create custom environment values.


## How does it work?

To define a custom environment value with EnvironmentKit, you just have to make your type implement `EnvironmentValue` by providing a default initializer (or default property values) and a `keyPath`:

```swift
struct MyViewStyle: EnvironmentValue {

    var color: Color = .red
    
    static var keyPath: EnvironmentKeyPath { \.myViewStyle }   
}

extension EnvironmentValues {

    var myViewStyle: MyViewStyle {
        get { get() } set { set(newValue) }
    }
}
```

Since EnvironmentKit knows about the keypath, you can now use a custom `.environment(_:)` view modifier that doesn't require a keypath, to inject custom values into the environment.

To make things even easier, you can provide a custom view modifier, like the native SwiftUI `.buttonStyle(...)`:

```swift
extension View {

    func myViewStyle(_ style: MyViewStyle) -> some View {
        environment(style)
    }
}
```

You can now use your custom view modifier to apply custom styles in any part of your view hierarchy:

```swift
MyView()
    .myViewStyle(.customStyle)
```

Views can access injected values with the `@Environment` attribute and the custom key path:

```
struct MyView: View {

    @Environment(\.myViewStyle)
    let style

    ....
}
```

If no custom value is injected, EnvironmentKit will return a default value.

Environment value injection is MUCH more flexible than initializer or property injection, and can be used for all kind of types, like view styles, configurations, etc.

If you decide to give environment value injection a try, I hope that EnvironmentKit will make it a lot easier for you.



## Future Work

My initial idea was for the `keyPath` property to be automatically resolved, by having `EnvironmentValues` provide a generic function that could be use instead of an explicit key path property. 

It however seems Swift requires an actual property to be able to use it as a keypath in the `.environment` modifier. If we find a way to work around this limitation, the code would become even easier.

The dream would be for the type to just implement the `EnvironmentValue` protocol, and for EnvironmentKit to take care of the rest.



## License

EnvironmentKit is available under the MIT license.



## Topics

### Essentials

- ``EnvironmentValue``
- ``EnvironmentValueKey``
