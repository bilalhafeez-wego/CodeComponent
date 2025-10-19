import SwiftUI
import Figma

// MARK: - Button Large (Component Set)
struct WegoButton_Large_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:1846"
    
    var body: some View {
        WegoButtonView(
            variant: .primary,
            size: .large,
            title: "Button Text",
            action: { }
        )
    }
}

// MARK: - Button Medium (Component Set)
struct WegoButton_Medium_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2099"
    
    var body: some View {
        WegoButtonView(
            variant: .primary,
            size: .medium,
            title: "Button Text",
            action: { }
        )
    }
}

// MARK: - Button Small (Component Set)
struct WegoButton_Small_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1951:2352"
    
    var body: some View {
        WegoButtonView(
            variant: .primary,
            size: .small,
            title: "Button Text",
            action: { }
        )
    }
}

// Additional button examples for different variants
// Note: The main component sets above (Large, Medium, Small) cover all variants through Figma's variant system

