//
//  File.swift
//  EnvironmentKit
//
//  Created by Daniel Saidi on 2024-04-14.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// injected into the environment.
public protocol EnvironmentValue {
    
    /// A default value to use, when no value has been added
    /// to the the environment.
    static var defaultValue: Self { get }
    
    /// The environment values keypath to use to add a value
    /// to the environment.
    static var keyPath: EnvironmentKeyPath { get }
    
    typealias EnvironmentKey = EnvironmentValueKey<Self>
    typealias EnvironmentKeyPath = WritableKeyPath<EnvironmentValues, Self>
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

extension View {

    /// Inject an ``EnvironmentValue`` into the environment.
    func environment<T: EnvironmentValue>(
        _ value: T
    ) -> some View {
        environment(T.keyPath, value)
    }
}


// MARK: - Preview Types

private struct MyView: View {
    
    init(
        style: MyViewStyle = .defaultValue
    ) {
        self.style = style
    }
    
    private let style: MyViewStyle
    
    var body: some View {
        style.color
    }
}

private struct MyViewStyle: EnvironmentValue {
    
    init(color: Color = .blue) {
        self.color = color
    }
    
    var color: Color
}

private extension MyViewStyle {
    
    static var defaultValue = Self()
    static var keyPath: EnvironmentKeyPath { \.myViewStyle }
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
}
