# Button Components Setup Instructions

## ✅ Files Successfully Copied!

All button component files have been copied to your CodeComponents project at:  
`/Users/bilalhafeez/Desktop/CodeComponent/CodeComponents/`

---

## 🚀 Quick Start Guide

### Step 1: Open Project in Xcode

```bash
open /Users/bilalhafeez/Desktop/CodeComponent/CodeComponents/CodeComponents.xcodeproj
```

Or double-click `CodeComponents.xcodeproj` in Finder.

---

### Step 2: Add Files to Xcode Project

Since the files are now in your project directory, you need to add them to the Xcode project:

#### A. Add All Folders at Once (Recommended)

1. In Xcode, right-click on the **CodeComponents** folder (blue icon) in Project Navigator
2. Select **"Add Files to CodeComponents..."**
3. Navigate to `CodeComponents/Sources/`
4. Select all these folders (hold Cmd to select multiple):
   - `DesignTokens`
   - `Common`
   - `UIKit`
   - `SwiftUI`
   - `SampleApp`
5. In the dialog:
   - ✅ **UN-check** "Copy items if needed" (files are already in place)
   - ✅ **Select** "Create groups"
   - ✅ **Check** "CodeComponents" target
6. Click **"Add"**

#### B. Add Color Assets

1. Right-click on **CodeComponents** folder again
2. Select **"Add Files to CodeComponents..."**
3. Navigate to `CodeComponents/Resources/`
4. Select `ColorPalette.xcassets`
5. Same settings as above
6. Click **"Add"**

---

### Step 3: Configure App Target (IMPORTANT!)

Your project is currently a framework, but you need an app to run the showcase. Choose **ONE** option:

#### Option A: Run in Swift Playgrounds (Easiest - Recommended for Quick Testing)

1. Create a new Swift Playground
2. Copy this code:

```swift
import SwiftUI
import PlaygroundSupport

// Paste the ButtonShowcaseView code here
// Then at the bottom:

PlaygroundPage.current.setLiveView(ButtonShowcaseView())
```

#### Option B: Create iOS App Target (Best for Full Testing)

1. In Xcode: **File → New → Target**
2. Choose **iOS → App**
3. Fill in:
   - Product Name: `ButtonShowcaseApp`
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Minimum Deployment: **iOS 15.0**
4. Click **"Finish"**
5. In the new target's settings:
   - General → Frameworks: Add **CodeComponents.framework**
6. Replace the default ContentView with:

```swift
import SwiftUI
import CodeComponents

@main
struct ButtonShowcaseAppMain: App {
    var body: some Scene {
        WindowGroup {
            ButtonShowcaseView()
        }
    }
}
```

#### Option C: Create Separate App Project (Most Flexible)

1. File → New → Project
2. Choose **iOS → App**
3. Name it anything you want
4. Add CodeComponents as a framework dependency
5. Use the ButtonShowcaseView in ContentView

---

### Step 4: Build and Run

Once files are added:

1. Select your scheme (**ButtonShowcaseApp** if you created Option B)
2. Choose a simulator (iPhone 16 recommended)
3. Press **Cmd+R** to build and run

---

## 📱 What You'll See

The showcase app has **5 tabs**:

### Tab 1: Variants 🎨

- All 8 button variants
- Primary, Secondary, Tertiary, Optional, Destructive, Inline, External Link, Exceptional

### Tab 2: Sizes 📏

- Large buttons (48pt) - For CTAs
- Medium buttons (36pt) - For secondary actions
- Small buttons (28pt) - For inline links

### Tab 3: States 🔄

- Normal, Pressed, Disabled, Processing
- Interactive demo with toggle states

### Tab 4: Icons ⭐️

- Text only, Leading icon, Trailing icon, Both icons, Icon only
- Different sizes with icons

### Tab 5: Real World Examples 💼

- Login form
- Card actions
- Search interface
- Bottom sheet
- Navigation
- Loading states

---

## 🎯 Files Structure (After Adding to Xcode)

Your Project Navigator should look like this:

```
CodeComponents
├── 📁 Sources
│   ├── 📁 DesignTokens
│   │   ├── WegoSpacingTokens.swift
│   │   └── WegoTypographyTokens.swift
│   ├── 📁 Common
│   │   └── 📁 Buttons
│   │       └── WegoButtonType.swift
│   ├── 📁 UIKit
│   │   └── 📁 Buttons
│   │       └── WegoButton.swift
│   ├── 📁 SwiftUI
│   │   └── 📁 Buttons
│   │       ├── WegoButtonStyle.swift
│   │       └── WegoButton+SwiftUI.swift
│   └── 📁 SampleApp
│       ├── ButtonShowcaseApp.swift
│       └── ButtonShowcaseView.swift
├── 📁 Resources
│   └── 🎨 ColorPalette.xcassets
└── CodeComponents.swift
```

---

## ⚠️ Common Issues & Solutions

### Issue 1: "No such module 'CodeComponents'"

**Solution:** Make sure all source files are added to the CodeComponents target:

1. Select a file in Project Navigator
2. In File Inspector (right panel), check **Target Membership**
3. Ensure "CodeComponents" is checked

### Issue 2: Colors not found

**Solution:** Verify ColorPalette.xcassets is in the project:

1. Check it appears in Project Navigator
2. Select it and verify Target Membership includes CodeComponents
3. Build Settings → "Copy Bundle Resources" should include it

### Issue 3: Build errors

**Solution:**

1. Clean build folder: **Cmd+Shift+K**
2. Close and reopen Xcode
3. Check iOS Deployment Target is **15.0 or higher**
4. Verify Swift Language Version is **Swift 5** or higher

### Issue 4: Can't run the app

**Solution:**

- If you're building a framework, you need an app target (see Step 3)
- Use Option A (Playgrounds) for quickest testing
- Or create an app target (Option B)

---

## 🧪 Testing Checklist

Once running, test these features:

### Visual Testing

- [ ] All 8 button variants display correctly
- [ ] Colors match the design system
- [ ] Large buttons are 48pt height
- [ ] Medium buttons are 36pt height
- [ ] Small buttons are 28pt height
- [ ] Icons are sized correctly (20/16/14pt)
- [ ] Corner radius is fully rounded

### Interaction Testing

- [ ] Buttons respond to taps
- [ ] Highlighted state shows on press
- [ ] Disabled buttons don't respond
- [ ] Processing state shows spinner
- [ ] All actions print to console

### Theme Testing

- [ ] Light mode displays correctly
- [ ] Dark mode displays correctly (toggle in simulator: Cmd+Shift+A)
- [ ] Colors adapt automatically
- [ ] All variants work in both modes

### Size Testing

- [ ] Large buttons fit full width
- [ ] Medium buttons have appropriate size
- [ ] Small buttons are minimal but tappable
- [ ] Icons scale correctly with button size

---

## 📚 Usage Examples

### In Your Own Views

```swift
import SwiftUI
import CodeComponents

struct MyView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Large primary button
            WegoButtonView.primary(title: "Continue") {
                // Handle action
            }

            // Medium secondary with icon
            WegoButtonView(
                variant: .secondary,
                size: .medium,
                title: "Search",
                leadingIcon: Image(systemName: "magnifyingglass")
            ) {
                // Handle search
            }

            // Small inline link
            WegoButtonView.inline(title: "Learn More", size: .small) {
                // Handle learn more
            }
        }
        .padding()
    }
}
```

---

## 🎨 Design Tokens Quick Reference

```swift
// Use these for custom layouts
WegoSpacingTokens.buttonHeightLarge           // 48pt
WegoSpacingTokens.buttonHeightMedium          // 36pt
WegoSpacingTokens.buttonHeightSmall           // 28pt
WegoSpacingTokens.buttonCornerRadius          // 100pt
WegoTypographyTokens.buttonTitleFontLarge     // 16pt Semi Bold
```

---

## 📖 Additional Documentation

Comprehensive docs available in project root:

- **BUTTON_SHOWCASE_README.md** - Full feature documentation
- **FILES_COPIED.md** - Complete file manifest
- **SETUP_INSTRUCTIONS.md** - This file

---

## ✅ Next Steps

After successful setup:

1. **Explore the showcase** - Navigate through all 5 tabs
2. **Test in light/dark mode** - Toggle with Cmd+Shift+A
3. **Test on device** - Run on physical iPhone for real experience
4. **Integrate into your app** - Use the examples as reference
5. **Customize as needed** - Adapt colors/sizes for your brand

---

## 🆘 Need Help?

If you encounter issues:

1. Check **Common Issues** section above
2. Review the **FILES_COPIED.md** for file verification
3. Read **BUTTON_SHOWCASE_README.md** for detailed specs
4. Clean build and restart Xcode
5. Verify all files are added with correct target membership

---

## 🎉 Success Criteria

You'll know setup is successful when:

✅ Project builds without errors  
✅ App runs in simulator/device  
✅ All 5 tabs are visible and navigable  
✅ Buttons respond to taps  
✅ Colors display correctly  
✅ Dark mode works automatically

---

**Setup Time:** ~5-10 minutes  
**Ready to:** Add files to Xcode and run the showcase!  
**Status:** All files copied ✅ - Ready for Xcode setup

---

**Last Updated:** October 15, 2025  
**Project:** CodeComponents Button Showcase  
**iOS Version:** 15.0+
