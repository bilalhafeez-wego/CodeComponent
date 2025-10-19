# Figma Connect Setup Guide

## Overview

You now have two approaches to connect your button components to Figma:

### Approach 1: Individual Component Files (Current Setup)

Each button variation has its own connection in `WegoButton.figma.swift`. This is useful when you have separate components in Figma.

### Approach 2: Component Set with Variants (Recommended)

If your Figma buttons are organized as a Component Set with variants, you can use property mappings in a single file.

---

## Step 1: Get Node IDs from Figma

1. Open your Figma file: https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0
2. Switch to **Dev Mode** (top right)
3. Select each button component you want to connect
4. Copy the URL from your browser - it will look like:
   ```
   https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=123-456
   ```
5. The `node-id=123-456` part is what you need (note: use the format `123:456` with colon in the file)

---

## Step 2: Update Node IDs in WegoButton.figma.swift

Open `CodeComponents/Sources/SwiftUI/Buttons/WegoButton.figma.swift` and replace the placeholder node IDs:

**Find components for:**

- ✅ Primary buttons (Large, Medium, Small)
- ✅ Secondary buttons (Large, Medium, Small)
- ✅ Tertiary buttons (Large, Medium, Small)
- ✅ Destructive buttons (Large, Medium, Small)
- ✅ Inline button
- ✅ External link button
- ✅ Button with icons
- ✅ Button with processing/loading state
- ✅ Optional button
- ✅ Exceptional button

**Replace format:**

```swift
// Change this:
let figmaNodeUrl = "...?node-id=YOUR_PRIMARY_LARGE_NODE_ID"

// To this (example):
let figmaNodeUrl = "...?node-id=123:456"
```

---

## Step 3: Publish to Figma

After updating all node IDs, run:

```bash
npx figma connect publish
```

This will:

1. Parse all your `.figma.swift` files
2. Validate the connections
3. Upload them to Figma's Dev Mode

---

## Step 4: Verify in Figma

1. Go back to your Figma file
2. Switch to Dev Mode
3. Select any button component
4. You should see your SwiftUI code in the "Code" panel!

---

## Alternative: Use Component Set with Variants (Advanced)

If your Figma buttons are organized as a **Component Set** with properties like:

- **Variant**: Primary, Secondary, Tertiary, etc.
- **Size**: Large, Medium, Small
- **State**: Default, Disabled, Loading

You can create a single dynamic connection:

```swift
struct WegoButton_ComponentSet_doc: FigmaConnect {
    let component = WegoButtonView.self
    let figmaNodeUrl = "YOUR_COMPONENT_SET_NODE_URL"

    @FigmaEnum("Variant", mapping: [
        "Primary": "primary",
        "Secondary": "secondary",
        "Tertiary": "tertiary",
        "Destructive": "destructive"
    ])
    var buttonVariant: String = "primary"

    @FigmaEnum("Size", mapping: [
        "Large": "large",
        "Medium": "medium",
        "Small": "small"
    ])
    var buttonSize: String = "large"

    @FigmaBoolean("Loading")
    var isLoading: Bool = false

    var body: some View {
        let variant: WegoButtonVariant = {
            switch buttonVariant {
            case "primary": return .primary
            case "secondary": return .secondary
            case "tertiary": return .tertiary
            case "destructive": return .destructive
            default: return .primary
            }
        }()

        let size: WegoButtonSize = {
            switch buttonSize {
            case "large": return .large
            case "medium": return .medium
            case "small": return .small
            default: return .large
            }
        }()

        return WegoButtonView(
            variant: variant,
            size: size,
            title: "Button",
            isProcessing: isLoading,
            action: { }
        )
    }
}
```

**Note:** The property names in `@FigmaEnum("Variant")` must **exactly match** the property names in your Figma Component Set.

---

## Troubleshooting

### Error: "The property X does not exist on the Figma component"

- Check that the property name in `@FigmaEnum("PropertyName")` exactly matches Figma
- Property names are case-sensitive

### Error: "The variant map could not be parsed"

- Make sure mapping values are strings: `"Primary": "primary"` not `"Primary": .primary`
- Avoid using computed properties named `variant` (use `buttonVariant` instead)

### Components not showing in Dev Mode

- Verify the node-id format uses colon: `123:456` not `123-456`
- Make sure you're looking at the correct component in Figma
- Try running `npx figma connect publish` again

---

## Dark Mode Support

SwiftUI automatically handles dark mode through the color assets in your `ColorPalette.xcassets`. The same button code works in both light and dark modes because:

1. Your colors use semantic names (e.g., `paletteCtaPrimary`)
2. These colors have both light and dark appearance variants in the asset catalog
3. SwiftUI automatically switches based on the system appearance

No additional code needed! 🎉

---

## Next Steps

1. ✅ Created `WegoButton.figma.swift` with all button variations
2. ⏳ Get node IDs from Figma for each button component
3. ⏳ Update the node IDs in the file
4. ⏳ Run `npx figma connect publish`
5. ⏳ Verify in Figma Dev Mode

Need help? Check the [Figma Code Connect documentation](https://github.com/figma/code-connect)
