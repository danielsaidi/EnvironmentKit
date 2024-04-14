<p align="center">
    <img src ="Resources/Logo_Rounded.png" alt="EnvironmentKit Logo" title="EnvironmentKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/EnvironmentKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-5.9-orange.svg" alt="Swift 5.9" title="Swift 5.9" />
    <img src="https://img.shields.io/github/license/danielsaidi/EnvironmentKit" alt="MIT License" title="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About EnvironmentKit

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



## Documentation

The [online documentation][Documentation] has more information on how to use this SDK.



## Support my work

You can [sponsor me][Sponsors] on GitHub Sponsors or [reach out][Email] for paid support, to help support my [open-source projects][OpenSource].

Your support makes it possible for me to put more work into these projects and make them the best they can be.



## Contact

Feel free to reach out if you have questions or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

EnvironmentKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[Twitter]: https://twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[OpenSource]: https://danielsaidi.com/opensource
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/EnvironmentKit
[Getting-Started]: https://danielsaidi.github.io/EnvironmentKit/documentation/environmentkit/getting-started

[License]: https://github.com/danielsaidi/EnvironmentKit/blob/master/LICENSE
