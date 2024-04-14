<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="EnvironmentKit Logo" title="EnvironmentKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/EnvironmentKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-5.9-orange.svg" alt="Swift 5.9" title="Swift 5.9" />
    <img src="https://img.shields.io/github/license/danielsaidi/EnvironmentKit" alt="MIT License" title="MIT License" />
    <a href="https://twitter.com/danielsaidi"><img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" /></a>
    <a href="https://mastodon.social/@danielsaidi"><img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" /></a>
</p>



## About EnvironmentKit

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

Since the entire thing is in a single line of code, you can just add that file to your project, instead of having this library as an external dependency.



## Documentation

The [online documentation][Documentation] has more information on how to use this SDK.



## Future Work

I tried to find a way to not having to create an `EnvironmentValues` property for each value type, by having a generic `EnvironmentValues` function that took the type as an argument.

However, I couldn't get this to work. Seems like we need an actual environment values property to be able to use the keypath approach to inject values into the environment.

If you find a way to solve this, please share! 🙏



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
[Getting-Started]: https://danielsaidi.github.io/EnvironmentKit/documentation/Environment/getting-started

[License]: https://github.com/danielsaidi/EnvironmentKit/blob/master/LICENSE
