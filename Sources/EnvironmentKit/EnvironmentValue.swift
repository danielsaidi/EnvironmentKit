//
//  File.swift
//  EnvironmentKit
//
//  Created by Daniel Saidi on 2024-04-14.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that should
/// be used as an environment value.
///
/// To implement this protocol, just provide a parameterless
/// ``init()`` and a ``keyPath`` value that returns a custom
/// `EnvironmentValues` property:
///
/// ```swift
/// struct MyViewStyle: EnvironmentValue {
///     static var keyPath: EnvironmentKeyPath { \.myViewStyle }
/// }
///
/// extension EnvironmentValues {
///     var myViewStyle: MyViewStyle {
///         get { get() } set { set(newValue) }
///     }
/// }
/// ```
///
/// You can now inject custom values into the environment by
/// using the ``SwiftUI/View/environment(_:)`` modifier that
/// doesn't require a keypath.
///
/// To make things even easier, you can also define a custom
/// view modifier for your value:
///
/// ```swift
/// extension View {
///     func myViewStyle(_ style: MyViewStyle) -> some View {
///         environment(style)
///     }
/// }
/// ```
///
/// You can now apply a custom style to any views, like this:
///
/// ```swift
/// MyView()
///     .myViewStyle(...)
/// ```
///
/// Views can use `@Environment` with the custom key path to
/// access injected values, like this:
///
/// ```swift
/// struct MyView: View {
///
///     @Environment(\.myViewStyle)
///
///     var body: some View { ... }
/// }
/// ```
///
/// If no value has been injected, the default value is used.
public protocol EnvironmentValue {
    
    /// Environment values must provide a default initializer.
    init()
    
    /// The `EnvironmentValue` keypath to use.
    static var keyPath: EnvironmentPath { get }

    /// This typealias defines an automatically resolved key.
    typealias EnvironmentKey = EnvironmentValueKey<Self>
    
    /// This typealias refers to an environment key path.
    typealias EnvironmentPath = WritableKeyPath<EnvironmentValues, Self>
}

public extension EnvironmentValue {
    
    /// A default value to use, when no value has been added
    /// to the the environment.
    static var defaultValue: Self { .init() }
}

/// This type is used by ``EnvironmentValue`` to define keys.
public struct EnvironmentValueKey<T: EnvironmentValue>: EnvironmentKey {
    
    /// A default value to use, when no value has been added
    /// to the the environment.
    public static var defaultValue: T { T.defaultValue }
}

public extension EnvironmentValues {
    
    /// Get a certain ``EnvironmentValue``.
    func get<T: EnvironmentValue>() -> T {
        self[T.EnvironmentKey.self]
    }
    
    /// Set a certain ``EnvironmentValue``.
    mutating func set<T: EnvironmentValue>(_ newValue: T) {
        self[T.EnvironmentKey.self] = newValue
    }
}

public extension View {

    /// Inject an ``EnvironmentValue`` into the environment.
    func environment<T: EnvironmentValue>(
        _ value: T
    ) -> some View {
        environment(T.keyPath, value)
    }
}


// MARK: - Preview Types

private struct MyView: View {
    
    @Environment(\.myViewStyle)
    private var style
    
    var body: some View {
        style.color
    }
}

private struct MyViewStyle: EnvironmentValue {
    
    var color: Color = .blue
}

private extension MyViewStyle {
    
    static var keyPath: EnvironmentPath { \.myViewStyle }
}

private extension View {

    func myViewStyle(_ style: MyViewStyle) -> some View {
        environment(style)
    }
}

private extension EnvironmentValues {

    var myViewStyle: MyViewStyle {
        get { get() } set { set(newValue) }
    }
}

#Preview {
    
    MyView()
        .myViewStyle(.init(color: .red))
}
