# ``EnvironmentKit``

EnvironmentKit is a SwiftUI SDK that lets you create custom SwiftUI environment values with less code.

![EnvironmentKit logotype](Logo)

EnvironmentKit is a SwiftUI SDK that lets you create custom SwiftUI environment values with less code.

EnvironmentKit lets you go from this (the standard boilerplate code for creating custom environment values):

```swift
public struct MyViewStyle { ... }

public extension MyViewStyle {
    
    static var standard = Self()
}

public extension View {

    func myViewStyle(_ style: MyViewStyle) -> some View {
        self.environment(\.myViewStyle, style)
    }
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
```

to this:

```swift
// You just have to implement EnvironmentValue:
struct MyViewStyle: EnvironmentValue { ... }

extension MyViewStyle {
    
    // ...define a default value...
    static var defaultValue = Self()
    
    // ...an environment key path (
    static var keyPath: EnvironmentKeyPath { \.myViewStyle }
}

extension View {

    // ...an optional view modifier
    func myViewStyle(_ style: MyViewStyle) -> some View {
        environment(style)
    }
}

extension EnvironmentValues {

    /// ...and a property for the keypath. That's it!
    var myViewStyle: MyViewStyle {
        get { get() } set { set(newValue) }
    }
}
```

It's not a huge saving in lines of code, but imo this code is less bloated than the standard boilerplate code.


## Installation

EnvironmentKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/EnvironmentKit.git
```

Since this SDK is a single file, you can just add it to your project instead of having this library as an external dependency.



## Future Work

I tried to find a way to not having to create an `EnvironmentValues` property for each value type, by having a generic `EnvironmentValues` function that took the type as an argument.

However, I couldn't get this to work. Seems like we need an actual environment values property to be able to use the keypath approach to inject values into the environment.

If you find a way to solve this, please share! 🙏



## Topics

### Essentials

- ``EnvironmentValue``
- ``EnvironmentValueKey``
