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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .large,
            title: "Button",
            action: { }
        )
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .medium,
            title: "Button",
            action: { }
        )
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .small,
            title: "Button",
            action: { }
        )
    }
}

// MARK: - Button Large - Disabled State
struct WegoButton_Large_Disabled_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:1846"
    let variant = ["State": "Disabled"]
    
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .large,
            title: "Button",
            action: { }
        )
        .disabled(true)
    }
}

// MARK: - Button Medium - Disabled State
struct WegoButton_Medium_Disabled_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2099"
    let variant = ["State": "Disabled"]
    
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .medium,
            title: "Button",
            action: { }
        )
        .disabled(true)
    }
}

// MARK: - Button Small - Disabled State
struct WegoButton_Small_Disabled_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2352"
    let variant = ["State": "Disabled"]
    
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .small,
            title: "Button",
            action: { }
        )
        .disabled(true)
    }
}

// MARK: - Button Large - Processing State
struct WegoButton_Large_Processing_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:1846"
    let variant = ["State": "Processing"]
    
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .large,
            title: "Button",
            isProcessing: true,
            action: { }
        )
    }
}

// MARK: - Button Medium - Processing State
struct WegoButton_Medium_Processing_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2099"
    let variant = ["State": "Processing"]
    
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .medium,
            title: "Button",
            isProcessing: true,
            action: { }
        )
    }
}

// MARK: - Button Small - Processing State
struct WegoButton_Small_Processing_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2352"
    let variant = ["State": "Processing"]
    
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
    
    var body: some View {
        WegoButtonView(
            variant: type,
            size: .small,
            title: "Button",
            isProcessing: true,
            action: { }
        )
    }
}

