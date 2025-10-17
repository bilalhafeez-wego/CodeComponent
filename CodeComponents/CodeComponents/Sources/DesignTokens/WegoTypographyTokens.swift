//
//  WegoTypographyTokens.swift
//  WegoComponents
//
//  Created by Cursor on 15/10/2025.
//

import UIKit

/// Typography tokens for Wego design system
/// Based on Figma Mobile App Foundation v3.0
public enum WegoTypographyTokens {
    
    // MARK: - Button Typography - Large
    
    /// Font size for large button titles (16pt)
    public static let buttonTitleFontSizeLarge: CGFloat = 16
    
    /// Line height for large button titles (20pt)
    public static let buttonTitleLineHeightLarge: CGFloat = 20
    
    /// Font for large button titles - Inter Semi Bold, 16pt
    public static var buttonTitleFontLarge: UIFont {
        return UIFont.systemFont(ofSize: buttonTitleFontSizeLarge, weight: .semibold)
    }
    
    // MARK: - Button Typography - Medium
    
    /// Font size for medium button titles (14pt)
    public static let buttonTitleFontSizeMedium: CGFloat = 14
    
    /// Line height for medium button titles (18pt)
    public static let buttonTitleLineHeightMedium: CGFloat = 18
    
    /// Font for medium button titles - Inter Semi Bold, 14pt
    public static var buttonTitleFontMedium: UIFont {
        return UIFont.systemFont(ofSize: buttonTitleFontSizeMedium, weight: .semibold)
    }
    
    // MARK: - Button Typography - Small
    
    /// Font size for small button titles (12pt)
    public static let buttonTitleFontSizeSmall: CGFloat = 12
    
    /// Line height for small button titles (16pt)
    public static let buttonTitleLineHeightSmall: CGFloat = 16
    
    /// Font for small button titles - Inter Semi Bold, 12pt
    public static var buttonTitleFontSmall: UIFont {
        return UIFont.systemFont(ofSize: buttonTitleFontSizeSmall, weight: .semibold)
    }
    
    // MARK: - Common Properties
    
    /// Font weight for all button titles
    public static let buttonTitleFontWeight: UIFont.Weight = .semibold
    
    // MARK: - Helper Methods
    
    /// Creates a button title font with custom configuration
    /// - Parameter size: The desired font size
    /// - Returns: Configured UIFont
    public static func buttonFont(size: CGFloat = buttonTitleFontSizeLarge) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: buttonTitleFontWeight)
    }
}

