# ``EnvironmentKit``

EnvironmentKit is a SwiftUI SDK that lets you create custom SwiftUI environment values with less code.

![EnvironmentKit logotype](Logo)

EnvironmentKit is a SwiftUI SDK that lets you define custom SwiftUI environment values with less code.

EnvironmentKit lets you go from this:

```swift
public struct MyViewStyle { ... }

public extension MyViewStyle {
    
    static var standard = Self()
}

private extension MyViewStyle {

    struct Key: EnvironmentKey {
        static var defaultValue: MyViewStyle = .standard
    }
}

public extension EnvironmentValues {

    var myViewStyle: MyViewStyle {
        get { self[MyViewStyle.Key.self] }
        set { self[MyViewStyle.Key.self] = newValue }
    }
}

public extension View {

    func myViewStyle(_ style: MyViewStyle) -> some View {
        environment(\.myViewStyle, style)
    }
}
```

to this:

```swift
struct MyViewStyle: EnvironmentValue { 
    ... 
    
    static var defaultValue = Self()
    static var keyPath: EnvironmentKeyPath { \.myViewStyle }    
}

extension EnvironmentValues {

    var myViewStyle: MyViewStyle {
        get { get() } set { set(newValue) }
    }
}

extension View {

    func myViewStyle(_ style: MyViewStyle) -> some View {
        environment(style)
    }
}
```

It's not a huge saving in lines of code, but the code is easier to write and remember than the standard boilerplate code.



## Installation

EnvironmentKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/EnvironmentKit.git
```

You can also just copy the `EnvironmentValue.swift` file to your project, instead of using the package.



## Getting Started

To define a custom environment value with EnvironmentKit, you just have to make your type implement `EnvironmentValue`, by providing a `defaultValue` and a `keyPath`:

```swift
struct MyViewStyle: EnvironmentValue { 
    ... 

    static var defaultValue = Self()
    static var keyPath: EnvironmentKeyPath { \.myViewStyle }   
}

extension EnvironmentValues {

    var myViewStyle: MyViewStyle {
        get { get() } set { set(newValue) }
    }
}
```

Since EnvironmentKit knows about the keypath, you can now use the custom `.environment(_:)` view modifier that doesn't require a keypath, to inject values into the environment.

To make things even easier, you can provide a custom view modifier, like the native SwiftUI `.buttonStyle(...)`:

```swift
extension View {

    func myViewStyle(_ style: MyViewStyle) -> some View {
        environment(style)
    }
}
```

You can now use the view modifier to apply custom styles in any part of your view hierarchy:

```swift
MyView()
    .myViewStyle(.customStyle)
```

Your views can access the injected style with the `@Environment` attribute and the custom key path, and will default the the default value if no value is injected:

```
struct MyView: View {

    @Environment(\.myViewStyle)
    let style

    ....
}
```

...and that's it! Environment values are MUCH more flexible than init injection, so make sure to give this approach a try.



## Future Work

My initial idea was for the `keyPath` property to be automatically resolved, by calling the `EnvironmentValues` with the type, and use the protocol to figure things out automatically. 

I tried to find a way for the SDK to automatically add a generic `EnvironmentValues` keypath property or function for the `EnvironmentValue` protocol, but couldn't get it to work.
 
It however seems Swift requires an actual property to be able to use it as a keypath in the `.environment` modifier. If we find a way to work around this limitation, the code would become even easier.



## License

EnvironmentKit is available under the MIT license.



## Topics

### Essentials

- ``EnvironmentValue``
- ``EnvironmentValueKey``
