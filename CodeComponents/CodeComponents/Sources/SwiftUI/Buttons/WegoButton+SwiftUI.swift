//
//  WegoButton+SwiftUI.swift
//  WegoComponents
//
//  Created by Cursor on 15/10/2025.
//

import SwiftUI

// MARK: - Wego Button View

/// SwiftUI view component for Wego design system buttons
@available(iOS 15.0, *)
public struct WegoButtonView: View {
    
    // MARK: - Properties
    
    let variant: WegoButtonVariant
    let size: WegoButtonSize
    let title: String
    let leadingIcon: Image?
    let trailingIcon: Image?
    let isProcessing: Bool
    let action: () -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Initialization
    
    /// Creates a Wego button view
    /// - Parameters:
    ///   - variant: The button variant style
    ///   - size: The button size (default: .large)
    ///   - title: The button title
    ///   - leadingIcon: Optional leading icon
    ///   - trailingIcon: Optional trailing icon
    ///   - isProcessing: Whether the button shows processing state
    ///   - action: Action to perform when tapped
    public init(
        variant: WegoButtonVariant,
        size: WegoButtonSize = .large,
        title: String,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        isProcessing: Bool = false,
        action: @escaping () -> Void
    ) {
        self.variant = variant
        self.size = size
        self.title = title
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isProcessing = isProcessing
        self.action = action
    }
    
    // MARK: - Body
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: elementGap) {
                if let leadingIcon = leadingIcon {
                    leadingIcon
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                }
                
                Text(title)
                
                if let trailingIcon = trailingIcon {
                    trailingIcon
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                }
            }
        }
        .buttonStyle(WegoButtonStyle(variant: variant, size: size, isProcessing: isProcessing))
    }
    
    // MARK: - Size Helpers
    
    private var iconSize: CGFloat {
        switch size {
        case .large:
            return WegoSpacingTokens.buttonIconSizeLarge
        case .medium:
            return WegoSpacingTokens.buttonIconSizeMedium
        case .small:
            return WegoSpacingTokens.buttonIconSizeSmall
        }
    }
    
    private var elementGap: CGFloat {
        switch size {
        case .large:
            return WegoSpacingTokens.buttonElementGapLarge
        case .medium:
            return WegoSpacingTokens.buttonElementGapMedium
        case .small:
            // Small buttons use different gaps for inline vs non-inline variants
            return variant == .inline || variant == .externalLink || variant == .exceptional ?
                WegoSpacingTokens.buttonElementGapSmallInline : WegoSpacingTokens.buttonElementGapSmall
        }
    }
}

// MARK: - Convenience Initializers

@available(iOS 15.0, *)
public extension WegoButtonView {
    
    /// Creates a primary button
    /// - Parameters:
    ///   - title: The button title
    ///   - size: The button size (default: .large)
    ///   - action: Action to perform when tapped
    /// - Returns: Configured button view
    static func primary(title: String, size: WegoButtonSize = .large, action: @escaping () -> Void) -> WegoButtonView {
        WegoButtonView(variant: .primary, size: size, title: title, action: action)
    }
    
    /// Creates a secondary button
    /// - Parameters:
    ///   - title: The button title
    ///   - size: The button size (default: .large)
    ///   - action: Action to perform when tapped
    /// - Returns: Configured button view
    static func secondary(title: String, size: WegoButtonSize = .large, action: @escaping () -> Void) -> WegoButtonView {
        WegoButtonView(variant: .secondary, size: size, title: title, action: action)
    }
    
    /// Creates a tertiary button
    /// - Parameters:
    ///   - title: The button title
    ///   - size: The button size (default: .large)
    ///   - action: Action to perform when tapped
    /// - Returns: Configured button view
    static func tertiary(title: String, size: WegoButtonSize = .large, action: @escaping () -> Void) -> WegoButtonView {
        WegoButtonView(variant: .tertiary, size: size, title: title, action: action)
    }
    
    /// Creates a destructive button
    /// - Parameters:
    ///   - title: The button title
    ///   - size: The button size (default: .large)
    ///   - action: Action to perform when tapped
    /// - Returns: Configured button view
    static func destructive(title: String, size: WegoButtonSize = .large, action: @escaping () -> Void) -> WegoButtonView {
        WegoButtonView(variant: .destructive, size: size, title: title, action: action)
    }
    
    /// Creates an inline button
    /// - Parameters:
    ///   - title: The button title
    ///   - size: The button size (default: .large)
    ///   - action: Action to perform when tapped
    /// - Returns: Configured button view
    static func inline(title: String, size: WegoButtonSize = .large, action: @escaping () -> Void) -> WegoButtonView {
        WegoButtonView(variant: .inline, size: size, title: title, action: action)
    }
    
    /// Creates an external link button
    /// - Parameters:
    ///   - title: The button title
    ///   - size: The button size (default: .large)
    ///   - action: Action to perform when tapped
    /// - Returns: Configured button view
    static func externalLink(title: String, size: WegoButtonSize = .large, action: @escaping () -> Void) -> WegoButtonView {
        WegoButtonView(variant: .externalLink, size: size, title: title, action: action)
    }
}

// MARK: - Preview Provider

@available(iOS 15.0, *)
struct WegoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Large buttons
                VStack(spacing: 12) {
                    Text("Large Buttons (48pt)").font(.headline)
                    
                    WegoButtonView.primary(title: "Primary Large") {
                        print("Primary tapped")
                    }
                    
                    WegoButtonView.secondary(title: "Secondary Large") {
                        print("Secondary tapped")
                    }
                    
                    WegoButtonView(
                        variant: .primary,
                        size: .large,
                        title: "With Icon",
                        leadingIcon: Image(systemName: "magnifyingglass")
                    ) {
                        print("With icon tapped")
                    }
                }
                
                Divider()
                
                // Medium buttons
                VStack(spacing: 12) {
                    Text("Medium Buttons (36pt)").font(.headline)
                    
                    WegoButtonView.primary(title: "Primary Medium", size: .medium) {
                        print("Medium primary tapped")
                    }
                    
                    WegoButtonView.secondary(title: "Secondary Medium", size: .medium) {
                        print("Medium secondary tapped")
                    }
                    
                    WegoButtonView(
                        variant: .primary,
                        size: .medium,
                        title: "With Icon",
                        leadingIcon: Image(systemName: "magnifyingglass")
                    ) {
                        print("Medium with icon tapped")
                    }
                }
                
                Divider()
                
                // Small buttons
                VStack(spacing: 12) {
                    Text("Small Buttons (28pt)").font(.headline)
                    
                    WegoButtonView.inline(title: "Inline Small", size: .small) {
                        print("Small inline tapped")
                    }
                    
                    WegoButtonView.externalLink(title: "Link Small", size: .small) {
                        print("Small link tapped")
                    }
                    
                    WegoButtonView(
                        variant: .inline,
                        size: .small,
                        title: "With Icon",
                        trailingIcon: Image(systemName: "arrow.right")
                    ) {
                        print("Small with icon tapped")
                    }
                }
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

