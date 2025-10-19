# Button Components - Figma Connect Setup

## ✅ What's Been Set Up

I've created a comprehensive Figma Connect setup for your `WegoButtonView` component with **20 different variations**:

### Files Created:

1. **`WegoButton.figma.swift`** - Main file with all button variations
2. **`Button-Store.figma.swift`** - App Store download button (already published ✅)
3. **`FIGMA_CONNECT_SETUP_GUIDE.md`** - Detailed setup instructions
4. **`create-button-connections.sh`** - Helper script (optional)

---

## 📊 Button Variations Included

The `WegoButton.figma.swift` file includes connections for:

### By Variant & Size (12 combinations):

- ✅ **Primary**: Large, Medium, Small
- ✅ **Secondary**: Large, Medium, Small
- ✅ **Tertiary**: Large, Medium, Small
- ✅ **Destructive**: Large, Medium, Small

### Special Variants (7 types):

- ✅ **Inline** button (text with underline)
- ✅ **External Link** button (with arrow icon)
- ✅ **Optional** button
- ✅ **Exceptional** button
- ✅ **With Leading Icon** (search icon example)
- ✅ **With Trailing Icon** (arrow icon example)
- ✅ **Processing/Loading State** (with activity indicator)

### Already Published:

- ✅ **Button Store** (App Store download button)

**Total: 20 button component connections ready!**

---

## 🚀 Quick Start - 3 Steps to Publish

### Step 1: Get Node IDs from Figma

1. Open your Figma file: https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0
2. Switch to **Dev Mode** (toggle in top right)
3. In the left sidebar, find your button components (look for "Button-Large", "Button-Medium", etc.)
4. Click on each button component
5. Copy the URL from your browser address bar
6. Extract the node-id from the URL

**Example URL:**

```
https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0?node-id=1234-5678
```

**Node ID to use:** `1234:5678` (replace dash with colon!)

### Step 2: Update WegoButton.figma.swift

Open `CodeComponents/Sources/SwiftUI/Buttons/WegoButton.figma.swift` and replace each placeholder:

```swift
// Find this:
let figmaNodeUrl = "...?node-id=YOUR_PRIMARY_LARGE_NODE_ID"

// Replace with your actual node ID:
let figmaNodeUrl = "...?node-id=1234:5678"
```

**Tip:** Use Find & Replace in your editor:

- Find: `YOUR_PRIMARY_LARGE_NODE_ID`
- Replace: `1234:5678` (your actual node ID)

Repeat for each button type.

### Step 3: Publish to Figma

```bash
# Test first (optional)
npx figma connect publish --dry-run

# Publish for real
npx figma connect publish
```

---

## 🎯 Two Approaches to Choose From

### Approach 1: Individual Components (Current Setup) ⭐ Recommended if you have separate button components

**Pros:**

- ✅ Works with any Figma structure
- ✅ Each button can have unique examples
- ✅ Easy to understand and maintain
- ✅ No need to restructure Figma

**Cons:**

- ❌ Need to update node IDs for each variation
- ❌ More files to manage

**When to use:** Your buttons are separate components in Figma (not a Component Set with variants)

---

### Approach 2: Component Set with Variants (Advanced)

**Pros:**

- ✅ One file handles all variants dynamically
- ✅ Automatically syncs with Figma properties
- ✅ Less maintenance

**Cons:**

- ❌ Requires buttons to be a Component Set in Figma
- ❌ Property names must match exactly
- ❌ More complex setup

**When to use:** Your buttons are organized as a Component Set with properties like "Variant", "Size", "State"

**Example file structure:**

```swift
@FigmaEnum("Variant", mapping: ["Primary": "primary", "Secondary": "secondary"])
var buttonVariant: String = "primary"

@FigmaEnum("Size", mapping: ["Large": "large", "Medium": "medium"])
var buttonSize: String = "large"
```

See `FIGMA_CONNECT_SETUP_GUIDE.md` for the complete example.

---

## 🎨 Dark Mode Support

**Good news:** Dark mode is automatically supported! 🌙

Your `WegoButtonView` uses semantic color names from `ColorPalette.xcassets`:

- `paletteCtaPrimary`
- `paletteTxtInverseStill`
- etc.

These colors have both **light** and **dark** appearance variants in the asset catalog, so SwiftUI automatically switches based on the system appearance.

**No additional code needed!**

---

## 📱 Activity Indicator / Loading State

The processing/loading state is already included:

```swift
// In WegoButton.figma.swift
struct WegoButton_Processing_doc: FigmaConnect {
    var body: some View {
        WegoButtonView(
            variant: .primary,
            size: .large,
            title: "Loading...",
            isProcessing: true,  // ← Shows activity indicator
            action: { }
        )
    }
}
```

When `isProcessing: true`, your button will show a loading indicator (handled by `WegoButtonStyle`).

---

## 🔗 Link Buttons

Two types of link buttons are included:

### 1. Inline Button (underlined text)

```swift
WegoButtonView(
    variant: .inline,
    size: .small,
    title: "Learn more",
    action: { }
)
```

### 2. External Link Button (with icon)

```swift
WegoButtonView(
    variant: .externalLink,
    size: .small,
    title: "Visit website",
    trailingIcon: Image(systemName: "arrow.up.right"),
    action: { }
)
```

---

## 🔍 Finding Button Components in Figma

Your Figma file might have buttons named like:

- `Button/Primary/Large`
- `Button/Primary/Medium`
- `Button/Secondary/Large`
- Or: `Button` (as a Component Set with variants)

**To find them:**

1. Open Figma file
2. Go to **Assets** panel (left sidebar)
3. Look for components starting with "Button"
4. Or search for "button" in the search bar

---

## ✅ Checklist

- [x] Created `WegoButton.figma.swift` with 20 button variations
- [x] Published `Button-Store.figma.swift` successfully
- [ ] Get node IDs from Figma for each button type
- [ ] Update node IDs in `WegoButton.figma.swift`
- [ ] Run `npx figma connect publish`
- [ ] Verify in Figma Dev Mode

---

## 🐛 Troubleshooting

### "Invalid figma node URL"

- ✅ Use colon format: `1234:5678` not `1234-5678`
- ✅ Make sure the node ID exists in your Figma file

### "The property X does not exist on the Figma component"

- ✅ Only happens with `@FigmaEnum`/`@FigmaString` property wrappers
- ✅ Check property names match exactly (case-sensitive)
- ✅ For now, the template uses static values (no properties), so this won't happen

### Components not showing in Dev Mode

- ✅ Make sure you're in Dev Mode (not Design Mode)
- ✅ Select the correct component
- ✅ Wait a few seconds for the code to load
- ✅ Try refreshing the page

### "Successfully connected but validation failed"

- ✅ This happens when property mappings don't match Figma
- ✅ The current setup uses static values, so validation should pass
- ✅ Only add property wrappers if you're using Component Sets

---

## 📚 Additional Resources

- **Figma Code Connect Docs**: https://github.com/figma/code-connect
- **Your Figma File**: https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0
- **Setup Guide**: See `FIGMA_CONNECT_SETUP_GUIDE.md` for detailed instructions

---

## 🎉 What Happens After Publishing?

Once you publish:

1. **Designers** can see your SwiftUI code in Figma Dev Mode
2. **Developers** can copy the exact code to use in their projects
3. **Everyone** has a single source of truth for button implementation
4. **Handoff** becomes seamless - no more "how do I implement this button?"

---

## 💡 Pro Tips

1. **Start with one button** - Get one working first, then do the rest
2. **Use the dry-run flag** - Test before publishing: `npx figma connect publish --dry-run`
3. **Keep examples realistic** - Use real button text like "Continue", "Cancel", "Delete"
4. **Document edge cases** - Add comments for special behaviors
5. **Update regularly** - When you change button code, republish to Figma

---

## 🤝 Need Help?

If you get stuck:

1. Check the troubleshooting section above
2. Review `FIGMA_CONNECT_SETUP_GUIDE.md`
3. Run with verbose logging: `npx figma connect publish --verbose`
4. Check the Figma Code Connect GitHub issues

---

**Ready to publish? Let's do this! 🚀**

1. Get those node IDs from Figma
2. Update `WegoButton.figma.swift`
3. Run `npx figma connect publish`
4. Check Figma Dev Mode
5. Celebrate! 🎉
