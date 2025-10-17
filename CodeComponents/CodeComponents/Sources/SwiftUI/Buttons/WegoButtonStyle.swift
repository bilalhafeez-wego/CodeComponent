//
//  WegoButtonStyle.swift
//  WegoComponents
//
//  Created by Cursor on 15/10/2025.
//

import SwiftUI

// MARK: - Wego Button Style

/// SwiftUI ButtonStyle implementation for Wego design system buttons
@available(iOS 15.0, *)
public struct WegoButtonStyle: ButtonStyle {
    
    // MARK: - Properties
    
    let variant: WegoButtonVariant
    let size: WegoButtonSize
    let isProcessing: Bool
    
    // MARK: - Initialization
    
    public init(variant: WegoButtonVariant, size: WegoButtonSize = .large, isProcessing: Bool = false) {
        self.variant = variant
        self.size = size
        self.isProcessing = isProcessing
    }
    
    // MARK: - ButtonStyle
    
    public func makeBody(configuration: Configuration) -> some View {
        WegoButtonStyleView(
            configuration: configuration,
            variant: variant,
            size: size,
            isProcessing: isProcessing
        )
    }
}

// MARK: - Button Style View

@available(iOS 15.0, *)
private struct WegoButtonStyleView: View {
    
    let configuration: ButtonStyle.Configuration
    let variant: WegoButtonVariant
    let size: WegoButtonSize
    let isProcessing: Bool
    
    @Environment(\.isEnabled) private var isEnabled
    
    private var buttonState: WegoButtonState {
        if isProcessing {
            return .processing
        } else if !isEnabled {
            return .disabled
        } else if configuration.isPressed {
            return .highlighted
        } else {
            return .normal
        }
    }
    
    private var style: WegoButtonStyleProtocol {
        WegoButtonColors.style(for: variant, state: buttonState)
    }
    
    var body: some View {
        ZStack {
            if isProcessing {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(style.titleColor)))
            } else {
                if #available(iOS 16.0, *) {
                    configuration.label
                        .font(fontForSize)
                        .foregroundColor(Color(style.titleColor))
                        .underline(style.shouldUnderlineTitle)
                } else {
                    // Fallback for iOS 15: omit underline as the API with parameters is unavailable
                    configuration.label
                        .font(fontForSize)
                        .foregroundColor(Color(style.titleColor))
                }
            }
        }
        .frame(height: heightForSize)
        .padding(.horizontal, horizontalPadding)
        .background(Color(style.backgroundColor))
        .cornerRadius(WegoSpacingTokens.buttonCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: WegoSpacingTokens.buttonCornerRadius)
                .stroke(Color(style.borderColor), lineWidth: style.borderWidth)
        )
        .opacity(configuration.isPressed ? 0.9 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
    
    // MARK: - Size Helpers
    
    private var heightForSize: CGFloat {
        switch size {
        case .large:
            return WegoSpacingTokens.buttonHeightLarge
        case .medium:
            return WegoSpacingTokens.buttonHeightMedium
        case .small:
            return WegoSpacingTokens.buttonHeightSmall
        }
    }
    
    private var fontForSize: Font {
        switch size {
        case .large:
            return .system(size: WegoTypographyTokens.buttonTitleFontSizeLarge, weight: .semibold)
        case .medium:
            return .system(size: WegoTypographyTokens.buttonTitleFontSizeMedium, weight: .semibold)
        case .small:
            return .system(size: WegoTypographyTokens.buttonTitleFontSizeSmall, weight: .semibold)
        }
    }
    
    private var horizontalPadding: CGFloat {
        // Simplified padding - SwiftUI buttons handle this more automatically
        switch size {
        case .large:
            return WegoSpacingTokens.buttonHorizontalPaddingLargeTextOnly
        case .medium:
            return WegoSpacingTokens.buttonHorizontalPaddingMediumTextOnly
        case .small:
            return 8 // Minimal padding for small buttons
        }
    }
}

// MARK: - View Extensions

@available(iOS 15.0, *)
public extension View {
    
    /// Applies Wego button style with the specified variant and size
    /// - Parameters:
    ///   - variant: The button variant style
    ///   - size: The button size (default: .large)
    ///   - isProcessing: Whether the button shows processing state
    /// - Returns: Modified view with button style applied
    func wegoButtonStyle(_ variant: WegoButtonVariant, size: WegoButtonSize = .large, isProcessing: Bool = false) -> some View {
        self.buttonStyle(WegoButtonStyle(variant: variant, size: size, isProcessing: isProcessing))
    }
}

// MARK: - Predefined Button Styles

@available(iOS 15.0, *)
public extension ButtonStyle where Self == WegoButtonStyle {
    
    /// Primary button style
    static var wegoPrimary: WegoButtonStyle {
        WegoButtonStyle(variant: .primary)
    }
    
    /// Secondary button style
    static var wegoSecondary: WegoButtonStyle {
        WegoButtonStyle(variant: .secondary)
    }
    
    /// Tertiary button style
    static var wegoTertiary: WegoButtonStyle {
        WegoButtonStyle(variant: .tertiary)
    }
    
    /// Optional button style
    static var wegoOptional: WegoButtonStyle {
        WegoButtonStyle(variant: .optional)
    }
    
    /// Destructive button style
    static var wegoDestructive: WegoButtonStyle {
        WegoButtonStyle(variant: .destructive)
    }
    
    /// Inline button style
    static var wegoInline: WegoButtonStyle {
        WegoButtonStyle(variant: .inline)
    }
    
    /// External link button style
    static var wegoExternalLink: WegoButtonStyle {
        WegoButtonStyle(variant: .externalLink)
    }
    
    /// Exceptional button style
    static var wegoExceptional: WegoButtonStyle {
        WegoButtonStyle(variant: .exceptional)
    }
}

