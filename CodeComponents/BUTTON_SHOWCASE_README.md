# Button Components Showcase

## Overview

This project showcases all variants, sizes, states, and configurations of the WegoButton components imported from Figma.

## Project Structure

```
CodeComponents/
├── Sources/
│   ├── DesignTokens/
│   │   ├── WegoSpacingTokens.swift       # Spacing/sizing constants
│   │   └── WegoTypographyTokens.swift    # Typography definitions
│   ├── Common/
│   │   └── Buttons/
│   │       └── WegoButtonType.swift      # Shared types, enums, protocols
│   ├── UIKit/
│   │   └── Buttons/
│   │       └── WegoButton.swift          # UIKit button implementation
│   ├── SwiftUI/
│   │   └── Buttons/
│   │       ├── WegoButtonStyle.swift     # SwiftUI button styles
│   │       └── WegoButton+SwiftUI.swift  # SwiftUI button view
│   └── SampleApp/
│       ├── ButtonShowcaseApp.swift       # Main app entry point
│       └── ButtonShowcaseView.swift      # Comprehensive showcase UI
└── Resources/
    └── ColorPalette.xcassets/            # Color assets from Wego design system
```

## Running the Showcase

1. Open `CodeComponents.xcodeproj` in Xcode
2. Select the `CodeComponents` scheme
3. Choose your target device or simulator (iPhone 16 recommended)
4. Build and run (Cmd+R)

## Showcase Features

The app includes **5 comprehensive tabs**:

### 1. Variants Tab 🎨

Shows all 8 button variants at large size:

- Primary (filled green)
- Secondary (outlined green)
- Tertiary (minimal white)
- Optional (outlined gray)
- Destructive (filled red)
- Inline (text with underline)
- External Link (link blue text)
- Exceptional (green text)

### 2. Sizes Tab 📏

Demonstrates all 3 button sizes:

- **Large (48pt)** - Primary actions, CTAs
- **Medium (36pt)** - Secondary actions, compact layouts
- **Small (28pt)** - Inline links, minimal UI

### 3. States Tab 🔄

Shows all 4 button states:

- Normal (interactive)
- Pressed/Highlighted (tap interaction)
- Disabled (non-interactive)
- Processing (with loading indicator)

### 4. Icons Tab ⭐️

Displays all icon configurations:

- Text only
- Leading icon + text
- Text + trailing icon
- Both icons + text
- Icon only
- Icons at different sizes

### 5. Real World Examples Tab 💼

Practical implementations:

- Login form (large buttons)
- Card actions (medium buttons)
- Search interface (with filters)
- Bottom sheet confirmations
- Multi-step navigation
- Loading states

## Button Specifications

### Variants (8 total)

| Variant       | Description     | Use Case                          |
| ------------- | --------------- | --------------------------------- |
| Primary       | Filled green    | Main CTAs, primary actions        |
| Secondary     | Outlined green  | Secondary actions                 |
| Tertiary      | Minimal white   | Tertiary actions, cancel          |
| Optional      | Outlined gray   | Optional actions                  |
| Destructive   | Filled red      | Delete, remove, dangerous actions |
| Inline        | Underlined text | Inline links, secondary links     |
| External Link | Blue link text  | External navigation               |
| Exceptional   | Green text      | Special actions                   |

### Sizes (3 total)

| Size   | Height | Font | Icon | Use Case                         |
| ------ | ------ | ---- | ---- | -------------------------------- |
| Large  | 48pt   | 16pt | 20pt | Primary CTAs, full-width actions |
| Medium | 36pt   | 14pt | 16pt | Secondary actions, toolbars      |
| Small  | 28pt   | 12pt | 14pt | Inline links, minimal UI         |

### States (4 total)

| State       | Description               | Visual Feedback   |
| ----------- | ------------------------- | ----------------- |
| Normal      | Default interactive state | Full color        |
| Highlighted | Pressed/tapped            | Slightly darker   |
| Disabled    | Non-interactive           | Muted colors      |
| Processing  | Loading/async operation   | Spinner animation |

### Configurations (5 total)

- **Text only** - Simple button with title
- **Leading icon** - Icon before text
- **Trailing icon** - Icon after text
- **Both icons** - Icons on both sides
- **Icon only** - Just icon, no text

## Design Tokens

### Spacing

```swift
// Heights
WegoSpacingTokens.buttonHeightLarge    // 48pt
WegoSpacingTokens.buttonHeightMedium   // 36pt
WegoSpacingTokens.buttonHeightSmall    // 28pt

// Icon Sizes
WegoSpacingTokens.buttonIconSizeLarge    // 20pt
WegoSpacingTokens.buttonIconSizeMedium   // 16pt
WegoSpacingTokens.buttonIconSizeSmall    // 14pt

// Spacing
WegoSpacingTokens.buttonElementGapLarge      // 4pt
WegoSpacingTokens.buttonCornerRadius         // 100pt (fully rounded)
WegoSpacingTokens.buttonBorderWidth          // 2pt
```

### Typography

```swift
// Large
WegoTypographyTokens.buttonTitleFontLarge      // 16pt, Semi Bold

// Medium
WegoTypographyTokens.buttonTitleFontMedium     // 14pt, Semi Bold

// Small
WegoTypographyTokens.buttonTitleFontSmall      // 12pt, Semi Bold
```

## Usage Examples

### SwiftUI

```swift
import SwiftUI

// Simple button (default large size)
WegoButtonView.primary(title: "Continue") {
    print("Tapped")
}

// Medium button with icon
WegoButtonView(
    variant: .secondary,
    size: .medium,
    title: "Search",
    leadingIcon: Image(systemName: "magnifyingglass")
) {
    performSearch()
}

// Small inline button
WegoButtonView.inline(title: "Learn More", size: .small) {
    showMoreInfo()
}

// Processing state
WegoButtonView(
    variant: .primary,
    title: "Submit",
    isProcessing: isLoading
) {
    submitForm()
}
.disabled(isLoading)
```

### UIKit

```swift
import UIKit

// Simple button (default large size)
let button = WegoButton.primary(title: "Continue")
button.actionHandler = {
    print("Tapped")
}

// Medium button with icon
let searchBtn = WegoButton(configuration: WegoButtonConfiguration(
    variant: .secondary,
    size: .medium,
    title: "Search",
    leadingIcon: UIImage(systemName: "magnifyingglass")
))

// Small inline button
let linkBtn = WegoButton(configuration: WegoButtonConfiguration(
    variant: .inline,
    size: .small,
    title: "Learn More"
))

// Processing state
button.setProcessing(true)
performAsyncOperation {
    button.setProcessing(false)
}
```

## Color System

All colors are from the `ColorPalette.xcassets` with the `palette` prefix:

**CTA Colors:**

- `paletteCtaPrimary` - Primary green (#44b50c)
- `paletteCtaDestructive` - Destructive red (#df3131)
- `paletteCtaInverse` - White/inverse

**Text Colors:**

- `paletteTxtPrimary` - Primary text
- `paletteTxtDisabled` - Disabled state
- `paletteTxtInverseStill` - White text on colored backgrounds
- `paletteTxtLink` - Link blue

**Line/Border Colors:**

- `paletteLineActive` - Active borders
- `paletteLineDestructive` - Destructive borders
- `paletteLineDivider` - Dividers

## Dark Mode Support

All buttons automatically support dark mode through `ColorPalette.xcassets`. The color assets contain both light and dark mode appearances, and iOS automatically switches based on system settings.

## Accessibility

- ✅ VoiceOver support
- ✅ Dynamic Type support
- ✅ Minimum touch targets
- ✅ Semantic labels
- ✅ State announcements

## Testing Checklist

Use the showcase app to test:

- [ ] All 8 variants display correctly
- [ ] All 3 sizes have correct dimensions
- [ ] All 4 states work as expected
- [ ] Icons display at correct sizes
- [ ] Light mode renders correctly
- [ ] Dark mode renders correctly
- [ ] Tap interactions feel responsive
- [ ] Processing states show spinner
- [ ] Disabled buttons are non-interactive
- [ ] Touch targets are adequate (especially small buttons)
- [ ] VoiceOver announces buttons correctly

## Figma Source

These components are synced from Figma Mobile App Foundation v3.0:

- **Large (Light):** Node 9652:2076
- **Large (Dark):** Node 9657:3626
- **Medium:** Node 9652:2325
- **Small:** Node 9652:2574
- **File Key:** PbuesgQvYEFWxnhQIKb1vR

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Known Considerations

1. **Small Buttons:** The 28pt height is below iOS's recommended 44pt minimum touch target. Use small buttons only for inline/link actions where appropriate.

2. **Medium Button Padding:** Medium buttons have nuanced padding rules based on icon position (leading vs trailing).

3. **Backward Compatibility:** All button APIs default to `.large` size for backward compatibility.

## Next Steps

After reviewing the showcase:

1. Test all variants in your app's context
2. Verify colors match your brand guidelines
3. Test on physical devices
4. Conduct accessibility audit
5. Gather feedback from design team

## Support

For questions or issues:

- Check the component source files in `Sources/`
- Review design tokens in `DesignTokens/`
- Reference Figma designs for visual accuracy

---

**Last Updated:** October 15, 2025  
**Version:** 1.0  
**Status:** Ready for Testing ✅


