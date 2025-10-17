//
//  WegoButton.swift
//  WegoComponents
//
//  Created by Cursor on 15/10/2025.
//

import UIKit

/// A customizable button component following Wego design system
/// Supports multiple variants, states, and icon configurations
public final class WegoButton: UIButton {
    
    // MARK: - Properties
    
    /// The button configuration
    public var buttonConfiguration: WegoButtonConfiguration {
        didSet {
            updateAppearance()
        }
    }
    
    /// Action handler closure
    public var actionHandler: (() -> Void)?
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let leadingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let trailingIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = WegoSpacingTokens.buttonElementGapLarge // Will be updated based on size
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private var contentConstraints: [NSLayoutConstraint] = []
    private var heightConstraint: NSLayoutConstraint?
    
    // MARK: - Initialization
    
    /// Creates a Wego button with the specified configuration
    /// - Parameter configuration: The button configuration
    public init(configuration: WegoButtonConfiguration) {
        self.buttonConfiguration = configuration
        super.init(frame: .zero)
        setupButton()
        updateAppearance()
    }
    
    required init?(coder: NSCoder) {
        self.buttonConfiguration = WegoButtonConfiguration(variant: .primary, title: "Button")
        super.init(coder: coder)
        setupButton()
        updateAppearance()
    }
    
    // MARK: - Setup
    
    private func setupButton() {
        // Add stack view
        addSubview(stackView)
        addSubview(activityIndicator)
        
        // Setup height constraint (will be updated based on size)
        let height = heightForSize(buttonConfiguration.size)
        heightConstraint = heightAnchor.constraint(equalToConstant: height)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heightConstraint!
        ])
        
        // Configure button
        layer.cornerRadius = WegoSpacingTokens.buttonCornerRadius
        layer.masksToBounds = true
        
        // Add target
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Configure accessibility
        accessibilityTraits = .button
    }
    
    // MARK: - Appearance Update
    
    private func updateAppearance() {
        let currentState = resolveButtonState()
        let style = WegoButtonColors.style(for: buttonConfiguration.variant, state: currentState)
        
        // Update colors
        backgroundColor = style.backgroundColor
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        
        // Update content
        updateContent(style: style)
        
        // Update enabled state
        isEnabled = buttonConfiguration.isEnabled && !buttonConfiguration.isProcessing
        
        // Update processing state
        if buttonConfiguration.isProcessing {
            activityIndicator.startAnimating()
            activityIndicator.color = style.titleColor
            stackView.alpha = 0
        } else {
            activityIndicator.stopAnimating()
            stackView.alpha = 1
        }
        
        // Update accessibility
        accessibilityLabel = buttonConfiguration.title
        if buttonConfiguration.isProcessing {
            accessibilityValue = "Processing"
        } else {
            accessibilityValue = nil
        }
    }
    
    private func updateContent(style: WegoButtonStyleProtocol) {
        // Clear stack view
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Update stack spacing based on size
        stackView.spacing = elementGapForSize(buttonConfiguration.size)
        
        let iconSize = iconSizeForSize(buttonConfiguration.size)
        let font = fontForSize(buttonConfiguration.size)
        
        // Add leading icon if needed
        if let leadingIcon = buttonConfiguration.leadingIcon {
            leadingIconImageView.image = leadingIcon.withRenderingMode(.alwaysTemplate)
            leadingIconImageView.tintColor = style.iconTintColor
            stackView.addArrangedSubview(leadingIconImageView)
            
            NSLayoutConstraint.activate([
                leadingIconImageView.widthAnchor.constraint(equalToConstant: iconSize),
                leadingIconImageView.heightAnchor.constraint(equalToConstant: iconSize)
            ])
        }
        
        // Add title if needed
        if let title = buttonConfiguration.title, !title.isEmpty {
            let label = UILabel()
            label.text = title
            label.font = font
            label.textColor = style.titleColor
            label.textAlignment = .center
            label.numberOfLines = 1
            
            if style.shouldUnderlineTitle {
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: font,
                    .foregroundColor: style.titleColor,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                label.attributedText = NSAttributedString(string: title, attributes: attributes)
            }
            
            stackView.addArrangedSubview(label)
        }
        
        // Add trailing icon if needed
        if let trailingIcon = buttonConfiguration.trailingIcon {
            trailingIconImageView.image = trailingIcon.withRenderingMode(.alwaysTemplate)
            trailingIconImageView.tintColor = style.iconTintColor
            stackView.addArrangedSubview(trailingIconImageView)
            
            NSLayoutConstraint.activate([
                trailingIconImageView.widthAnchor.constraint(equalToConstant: iconSize),
                trailingIconImageView.heightAnchor.constraint(equalToConstant: iconSize)
            ])
        }
        
        // Update height constraint
        heightConstraint?.constant = heightForSize(buttonConfiguration.size)
        
        // Update padding based on icon configuration
        updatePadding()
    }
    
    private func updatePadding() {
        // Remove existing constraints
        NSLayoutConstraint.deactivate(contentConstraints)
        contentConstraints.removeAll()
        
        let horizontalPadding = horizontalPaddingForSize(buttonConfiguration.size, iconPosition: buttonConfiguration.iconPosition)
        
        let leadingConstraint = stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: horizontalPadding)
        let trailingConstraint = stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -horizontalPadding)
        
        contentConstraints = [leadingConstraint, trailingConstraint]
        NSLayoutConstraint.activate(contentConstraints)
    }
    
    // MARK: - Size Helpers
    
    private func heightForSize(_ size: WegoButtonSize) -> CGFloat {
        switch size {
        case .large:
            return WegoSpacingTokens.buttonHeightLarge
        case .medium:
            return WegoSpacingTokens.buttonHeightMedium
        case .small:
            return WegoSpacingTokens.buttonHeightSmall
        }
    }
    
    private func iconSizeForSize(_ size: WegoButtonSize) -> CGFloat {
        switch size {
        case .large:
            return WegoSpacingTokens.buttonIconSizeLarge
        case .medium:
            return WegoSpacingTokens.buttonIconSizeMedium
        case .small:
            return WegoSpacingTokens.buttonIconSizeSmall
        }
    }
    
    private func fontForSize(_ size: WegoButtonSize) -> UIFont {
        switch size {
        case .large:
            return WegoTypographyTokens.buttonTitleFontLarge
        case .medium:
            return WegoTypographyTokens.buttonTitleFontMedium
        case .small:
            return WegoTypographyTokens.buttonTitleFontSmall
        }
    }
    
    private func elementGapForSize(_ size: WegoButtonSize) -> CGFloat {
        switch size {
        case .large:
            return WegoSpacingTokens.buttonElementGapLarge
        case .medium:
            return WegoSpacingTokens.buttonElementGapMedium
        case .small:
            // Small buttons use different gaps for inline vs non-inline variants
            return buttonConfiguration.variant == .inline || buttonConfiguration.variant == .externalLink || buttonConfiguration.variant == .exceptional ?
                WegoSpacingTokens.buttonElementGapSmallInline : WegoSpacingTokens.buttonElementGapSmall
        }
    }
    
    private func horizontalPaddingForSize(_ size: WegoButtonSize, iconPosition: WegoButtonIconPosition) -> CGFloat {
        switch size {
        case .large:
            switch iconPosition {
            case .none:
                return WegoSpacingTokens.buttonHorizontalPaddingLargeTextOnly
            case .iconOnly:
                return WegoSpacingTokens.buttonVerticalPaddingLarge
            default:
                return WegoSpacingTokens.buttonHorizontalPaddingLargeWithIcon
            }
        case .medium:
            switch iconPosition {
            case .none:
                return WegoSpacingTokens.buttonHorizontalPaddingMediumTextOnly
            case .iconOnly:
                return WegoSpacingTokens.buttonIconOnlyPaddingMedium
            case .leading:
                return WegoSpacingTokens.buttonHorizontalPaddingMediumLeadingIcon
            default:
                return WegoSpacingTokens.buttonHorizontalPaddingMediumTrailingText
            }
        case .small:
            // Small buttons (inline variants) have minimal padding
            return 0
        }
    }
    
    private func resolveButtonState() -> WegoButtonState {
        if buttonConfiguration.isProcessing {
            return .processing
        } else if !buttonConfiguration.isEnabled {
            return .disabled
        } else if isHighlighted {
            return .highlighted
        } else {
            return .normal
        }
    }
    
    // MARK: - Actions
    
    @objc private func buttonTapped() {
        actionHandler?()
    }
    
    // MARK: - Touch Handling
    
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted != oldValue {
                UIView.animate(withDuration: 0.15) {
                    self.updateAppearance()
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    /// Sets the processing state of the button
    /// - Parameter isProcessing: Whether the button should show processing state
    public func setProcessing(_ isProcessing: Bool) {
        buttonConfiguration.isProcessing = isProcessing
    }
    
    /// Sets the enabled state of the button
    /// - Parameter isEnabled: Whether the button should be enabled
    public func setEnabled(_ isEnabled: Bool) {
        buttonConfiguration.isEnabled = isEnabled
    }
    
    /// Updates the button title
    /// - Parameter title: The new title text
    public func setTitle(_ title: String?) {
        buttonConfiguration.title = title
    }
    
    /// Updates the leading icon
    /// - Parameter icon: The new leading icon image
    public func setLeadingIcon(_ icon: UIImage?) {
        buttonConfiguration.leadingIcon = icon
    }
    
    /// Updates the trailing icon
    /// - Parameter icon: The new trailing icon image
    public func setTrailingIcon(_ icon: UIImage?) {
        buttonConfiguration.trailingIcon = icon
    }
}

// MARK: - Convenience Initializers

public extension WegoButton {
    
    /// Creates a primary button with text
    /// - Parameter title: The button title
    /// - Returns: Configured WegoButton
    static func primary(title: String) -> WegoButton {
        return WegoButton(configuration: WegoButtonConfiguration(variant: .primary, title: title))
    }
    
    /// Creates a secondary button with text
    /// - Parameter title: The button title
    /// - Returns: Configured WegoButton
    static func secondary(title: String) -> WegoButton {
        return WegoButton(configuration: WegoButtonConfiguration(variant: .secondary, title: title))
    }
    
    /// Creates a destructive button with text
    /// - Parameter title: The button title
    /// - Returns: Configured WegoButton
    static func destructive(title: String) -> WegoButton {
        return WegoButton(configuration: WegoButtonConfiguration(variant: .destructive, title: title))
    }
    
    /// Creates an inline button with text
    /// - Parameter title: The button title
    /// - Returns: Configured WegoButton
    static func inline(title: String) -> WegoButton {
        return WegoButton(configuration: WegoButtonConfiguration(variant: .inline, title: title))
    }
}

