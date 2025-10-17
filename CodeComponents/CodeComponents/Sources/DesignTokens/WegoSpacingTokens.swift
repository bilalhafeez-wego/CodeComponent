//
//  WegoSpacingTokens.swift
//  WegoComponents
//
//  Created by Cursor on 15/10/2025.
//

import Foundation
import CoreGraphics

/// Spacing and sizing constants for Wego design system
/// Based on Figma Mobile App Foundation v3.0
public enum WegoSpacingTokens {
    
    // MARK: - Button Height
    
    /// Height for large buttons (48px)
    public static let buttonHeightLarge: CGFloat = 48
    
    /// Height for medium buttons (36px)
    public static let buttonHeightMedium: CGFloat = 36
    
    /// Height for small buttons (28px)
    public static let buttonHeightSmall: CGFloat = 28
    
    // MARK: - Button Icon Size
    
    /// Icon size for large buttons (20x20pt)
    public static let buttonIconSizeLarge: CGFloat = 20
    
    /// Icon size for medium buttons (16x16pt)
    public static let buttonIconSizeMedium: CGFloat = 16
    
    /// Icon size for small buttons (14x14pt)
    public static let buttonIconSizeSmall: CGFloat = 14
    
    // MARK: - Button Spacing - Large
    
    /// Gap between elements for large buttons
    public static let buttonElementGapLarge: CGFloat = 4
    
    /// Horizontal padding for large buttons with text only
    public static let buttonHorizontalPaddingLargeTextOnly: CGFloat = 24
    
    /// Horizontal padding for large buttons with leading icon
    public static let buttonHorizontalPaddingLargeWithIcon: CGFloat = 20
    
    /// Vertical padding for large buttons
    public static let buttonVerticalPaddingLarge: CGFloat = 14
    
    // MARK: - Button Spacing - Medium
    
    /// Gap between elements for medium buttons
    public static let buttonElementGapMedium: CGFloat = 4
    
    /// Horizontal padding for medium buttons with text only
    public static let buttonHorizontalPaddingMediumTextOnly: CGFloat = 16
    
    /// Horizontal padding for medium buttons with leading icon
    public static let buttonHorizontalPaddingMediumLeadingIcon: CGFloat = 12
    
    /// Horizontal padding for medium buttons trailing text with icon
    public static let buttonHorizontalPaddingMediumTrailingText: CGFloat = 16
    
    /// Vertical padding for medium buttons
    public static let buttonVerticalPaddingMedium: CGFloat = 9
    
    /// Icon only padding for medium buttons
    public static let buttonIconOnlyPaddingMedium: CGFloat = 10
    
    // MARK: - Button Spacing - Small
    
    /// Gap between elements for small buttons (inline)
    public static let buttonElementGapSmall: CGFloat = 2
    
    /// Gap between elements for small inline buttons
    public static let buttonElementGapSmallInline: CGFloat = 4
    
    // MARK: - Universal Button Settings
    
    /// Corner radius for fully rounded buttons (all sizes)
    public static let buttonCornerRadius: CGFloat = 100
    
    /// Border width for button borders (Primary, Secondary, etc.)
    public static let buttonBorderWidth: CGFloat = 2
    
    /// Border width for tertiary buttons
    public static let buttonBorderWidthTertiary: CGFloat = 1
}

