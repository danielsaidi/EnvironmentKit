# Release Notes


## 0.1

This version adds an `EnvironmentValue` protocol, that can be implemented by any type that you want to inject into the SwiftUI environment.

All you need to do is to implement the protocol, add a `defaultValue` to your value type, add a property extension to the SwiftUI `EnvironmentValues`, and finally add a `keyPath` to your value type, that refers to this property extension. 
