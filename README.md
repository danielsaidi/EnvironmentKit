<p align="center">
    <img src ="Resources/Logo_Rounded.png" alt="EnvironmentKit Logo" title="EnvironmentKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/EnvironmentKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/EnvironmentKit" alt="MIT License" title="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About EnvironmentKit

EnvironmentKit is a SwiftUI SDK that lets you define custom SwiftUI environment values with less code.


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



## Documentation

The [online documentation][Documentation] has more information about this SDK, how it works, etc.



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
