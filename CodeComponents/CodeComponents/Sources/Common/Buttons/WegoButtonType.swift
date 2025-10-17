//
//  WegoButtonType.swift
//  WegoComponents
//
//  Created by Cursor on 15/10/2025.
//

import UIKit

// MARK: - Button Size

/// Defines the size of a Wego button
public enum WegoButtonSize {
    /// Large button - 48px height, 16pt font
    case large
    
    /// Medium button - 36px height, 14pt font
    case medium
    
    /// Small button - 28px height, 12pt font
    case small
}

// MARK: - Button Variant

/// Defines the visual style variant of a Wego button
public enum WegoButtonVariant {
    /// Primary action button - filled with primary color
    case primary
    
    /// Secondary action button - outlined with primary color
    case secondary
    
    /// Tertiary action button - minimal styling
    case tertiary
    
    /// Optional action button - outlined with optional color
    case optional
    
    /// Destructive action button - filled with destructive color
    case destructive
    
    /// Inline button - text only with underline
    case inline
    
    /// External link button - text with link color
    case externalLink
    
    /// Exceptional action button - special use case
    case exceptional
}

// MARK: - Button State

/// Defines the interaction state of a button
public enum WegoButtonState {
    /// Normal, interactive state
    case normal
    
    /// Button is currently being pressed
    case highlighted
    
    /// Button is disabled and non-interactive
    case disabled
    
    /// Button is processing an action (shows loading indicator)
    case processing
}

// MARK: - Button Icon Position

/// Defines where an icon appears relative to the button title
public enum WegoButtonIconPosition {
    /// No icon
    case none
    
    /// Icon appears before the title
    case leading
    
    /// Icon appears after the title
    case trailing
    
    /// Icons appear both before and after the title
    case both
    
    /// Icon only, no title
    case iconOnly
}

// MARK: - Button Configuration

/// Configuration for a Wego button
public struct WegoButtonConfiguration {
    
    // MARK: - Properties
    
    /// The visual style variant
    public let variant: WegoButtonVariant
    
    /// The button size
    public let size: WegoButtonSize
    
    /// The button title
    public var title: String?
    
    /// Leading icon image
    public var leadingIcon: UIImage?
    
    /// Trailing icon image
    public var trailingIcon: UIImage?
    
    /// Whether the button is enabled
    public var isEnabled: Bool
    
    /// Whether the button is in processing state
    public var isProcessing: Bool
    
    // MARK: - Computed Properties
    
    /// The icon position based on configured icons
    public var iconPosition: WegoButtonIconPosition {
        let hasLeading = leadingIcon != nil
        let hasTrailing = trailingIcon != nil
        let hasTitle = title != nil && !title!.isEmpty
        
        if !hasLeading && !hasTrailing {
            return .none
        } else if hasLeading && hasTrailing {
            return .both
        } else if hasLeading && !hasTitle {
            return .iconOnly
        } else if hasLeading {
            return .leading
        } else if hasTrailing {
            return .trailing
        }
        
        return .none
    }
    
    // MARK: - Initialization
    
    /// Creates a button configuration
    /// - Parameters:
    ///   - variant: The button variant style
    ///   - size: The button size (default: .large)
    ///   - title: The button title text
    ///   - leadingIcon: Optional leading icon
    ///   - trailingIcon: Optional trailing icon
    ///   - isEnabled: Whether the button is enabled (default: true)
    ///   - isProcessing: Whether the button shows processing state (default: false)
    public init(
        variant: WegoButtonVariant,
        size: WegoButtonSize = .large,
        title: String? = nil,
        leadingIcon: UIImage? = nil,
        trailingIcon: UIImage? = nil,
        isEnabled: Bool = true,
        isProcessing: Bool = false
    ) {
        self.variant = variant
        self.size = size
        self.title = title
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isEnabled = isEnabled
        self.isProcessing = isProcessing
    }
}

// MARK: - Button Style Protocol

/// Protocol for button style providers
public protocol WegoButtonStyleProtocol {
    /// Background color for the button
    var backgroundColor: UIColor { get }
    
    /// Border color for the button
    var borderColor: UIColor { get }
    
    /// Title color for the button
    var titleColor: UIColor { get }
    
    /// Icon tint color for the button
    var iconTintColor: UIColor { get }
    
    /// Border width for the button
    var borderWidth: CGFloat { get }
    
    /// Whether the title should be underlined
    var shouldUnderlineTitle: Bool { get }
}

// MARK: - Button Colors Helper

/// Helper struct to manage button colors based on variant and state
public struct WegoButtonColors {
    
    // MARK: - Color Resolution
    
    /// Resolves the appropriate style for a button configuration and state
    /// - Parameters:
    ///   - variant: The button variant
    ///   - state: The button state
    /// - Returns: A button style providing colors
    public static func style(for variant: WegoButtonVariant, state: WegoButtonState) -> WegoButtonStyleProtocol {
        switch variant {
        case .primary:
            return PrimaryButtonStyle(state: state)
        case .secondary:
            return SecondaryButtonStyle(state: state)
        case .tertiary:
            return TertiaryButtonStyle(state: state)
        case .optional:
            return OptionalButtonStyle(state: state)
        case .destructive:
            return DestructiveButtonStyle(state: state)
        case .inline:
            return InlineButtonStyle(state: state)
        case .externalLink:
            return ExternalLinkButtonStyle(state: state)
        case .exceptional:
            return ExceptionalButtonStyle(state: state)
        }
    }
}

// MARK: - Button Style Implementations

private struct PrimaryButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteCtaPrimary") ?? .systemGreen
        case .highlighted:
            return UIColor(named: "paletteCtaPrimaryTap") ?? .systemGreen
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var borderColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteLineActive") ?? .systemGreen
        case .highlighted:
            return UIColor(named: "paletteLineActive") ?? .systemGreen
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtInverseStill") ?? .white
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        2
    }
    
    var shouldUnderlineTitle: Bool {
        false
    }
}

private struct SecondaryButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteCtaInverse") ?? .white
        case .highlighted:
            return UIColor(named: "paletteCtaSecondaryTap") ?? .systemGreen.withAlphaComponent(0.1)
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var borderColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteLineActive") ?? .systemGreen
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtActivePrimary") ?? .systemGreen
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        2
    }
    
    var shouldUnderlineTitle: Bool {
        false
    }
}

private struct TertiaryButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteCtaInverse") ?? .white
        case .highlighted:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray6
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var borderColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteCtaInverse") ?? .white
        case .highlighted:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray6
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtPrimary") ?? .label
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        1
    }
    
    var shouldUnderlineTitle: Bool {
        false
    }
}

private struct OptionalButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteCtaInverse") ?? .white
        case .highlighted:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray6
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var borderColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteLineDivider") ?? .systemGray4
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtPrimary") ?? .label
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        2
    }
    
    var shouldUnderlineTitle: Bool {
        false
    }
}

private struct DestructiveButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteCtaDestructive") ?? .systemRed
        case .highlighted:
            return UIColor(named: "paletteCtaDestructiveTap") ?? .systemRed
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var borderColor: UIColor {
        switch state {
        case .normal:
            return UIColor(named: "paletteLineDestructive") ?? .systemRed
        case .highlighted:
            return UIColor(named: "paletteLineDestructive") ?? .systemRed
        case .disabled, .processing:
            return UIColor(named: "paletteCtaOptionalTap") ?? .systemGray5
        }
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtInverseStill") ?? .white
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        2
    }
    
    var shouldUnderlineTitle: Bool {
        false
    }
}

private struct InlineButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        .clear
    }
    
    var borderColor: UIColor {
        .clear
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtPrimary") ?? .label
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        0
    }
    
    var shouldUnderlineTitle: Bool {
        true
    }
}

private struct ExternalLinkButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        .clear
    }
    
    var borderColor: UIColor {
        .clear
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtLink") ?? .systemBlue
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        0
    }
    
    var shouldUnderlineTitle: Bool {
        true
    }
}

private struct ExceptionalButtonStyle: WegoButtonStyleProtocol {
    let state: WegoButtonState
    
    var backgroundColor: UIColor {
        .clear
    }
    
    var borderColor: UIColor {
        .clear
    }
    
    var titleColor: UIColor {
        switch state {
        case .normal, .highlighted:
            return UIColor(named: "paletteTxtActiveSecondary") ?? .systemGreen
        case .disabled, .processing:
            return UIColor(named: "paletteTxtDisabled") ?? .systemGray
        }
    }
    
    var iconTintColor: UIColor {
        titleColor
    }
    
    var borderWidth: CGFloat {
        0
    }
    
    var shouldUnderlineTitle: Bool {
        true
    }
}

