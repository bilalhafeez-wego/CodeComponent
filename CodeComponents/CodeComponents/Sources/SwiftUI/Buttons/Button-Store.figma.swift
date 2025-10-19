import SwiftUI
import Figma

// MARK: - Button Store Component (App Store Download Button)
struct ButtonStore_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1780%3A4138"

    var body: some View {
        WegoButtonView(
            variant: .primary,
            size: .large,
            title: "Download on the App Store",
            action: { }
        )
    }
}