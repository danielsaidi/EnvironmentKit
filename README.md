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

Instead of this standard boilerplate code:

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

You just need this:

```swift
struct MyStyle: EnvironmentValue { 
    
    static var keyPath: EnvironmentKeyPath { \.myStyle }    
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



## Installation

EnvironmentKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/EnvironmentKit.git
```

You can also just copy the `EnvironmentValue.swift` file to your project, instead of using the package.



## Getting Started

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
