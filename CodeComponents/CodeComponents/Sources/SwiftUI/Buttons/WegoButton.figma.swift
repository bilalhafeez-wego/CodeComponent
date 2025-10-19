import SwiftUI
import Figma

// MARK: - Button Large (Component Set)
struct WegoButton_Large_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:1846"
    
    @FigmaEnum("Type", mapping: [
        "Primary": WegoButtonVariant.primary,
        "Secondary": WegoButtonVariant.secondary,
        "Tertiary": WegoButtonVariant.tertiary,
        "Destructive": WegoButtonVariant.destructive,
        "Optional": WegoButtonVariant.optional,
        "Inline Button": WegoButtonVariant.inline,
        "External Link": WegoButtonVariant.externalLink,
        "Exception": WegoButtonVariant.exceptional
    ])
    var type: WegoButtonVariant = .primary
    
    @FigmaEnum("State", mapping: [
        "Processing": true
    ], hideDefault: true)
    var isProcessing: Bool = false
    
    @FigmaEnum("State", mapping: [
        "Disabled": true
    ], hideDefault: true)
    var isDisabled: Bool = false
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .large,
            title: "Button",
            isProcessing: isProcessing,
            action: { }
        )
        .disabled(isDisabled)
    }
}

// MARK: - Button Medium (Component Set)
struct WegoButton_Medium_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2099"
    
    @FigmaEnum("Type", mapping: [
        "Primary": WegoButtonVariant.primary,
        "Secondary": WegoButtonVariant.secondary,
        "Tertiary": WegoButtonVariant.tertiary,
        "Destructive": WegoButtonVariant.destructive,
        "Optional": WegoButtonVariant.optional,
        "Inline Button": WegoButtonVariant.inline,
        "External Link": WegoButtonVariant.externalLink,
        "Exception": WegoButtonVariant.exceptional
    ])
    var type: WegoButtonVariant = .primary
    
    @FigmaEnum("State", mapping: [
        "Processing": true
    ], hideDefault: true)
    var isProcessing: Bool = false
    
    @FigmaEnum("State", mapping: [
        "Disabled": true
    ], hideDefault: true)
    var isDisabled: Bool = false
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .medium,
            title: "Button",
            isProcessing: isProcessing,
            action: { }
        )
        .disabled(isDisabled)
    }
}

// MARK: - Button Small (Component Set)
struct WegoButton_Small_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2352"
    
    @FigmaEnum("Type", mapping: [
        "Primary": WegoButtonVariant.primary,
        "Secondary": WegoButtonVariant.secondary,
        "Tertiary": WegoButtonVariant.tertiary,
        "Destructive": WegoButtonVariant.destructive,
        "Optional": WegoButtonVariant.optional,
        "Inline Button": WegoButtonVariant.inline,
        "External Link": WegoButtonVariant.externalLink,
        "Exception": WegoButtonVariant.exceptional
    ])
    var type: WegoButtonVariant = .primary
    
    @FigmaEnum("State", mapping: [
        "Processing": true
    ], hideDefault: true)
    var isProcessing: Bool = false
    
    @FigmaEnum("State", mapping: [
        "Disabled": true
    ], hideDefault: true)
    var isDisabled: Bool = false
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .small,
            title: "Button",
            isProcessing: isProcessing,
            action: { }
        )
        .disabled(isDisabled)
    }
}

