# Figma Connect - Quick Reference Card

## 🎯 Your Current Status

✅ **20 button variations** ready in `WegoButton.figma.swift`  
✅ **1 button published** (`Button-Store.figma.swift`)  
⏳ **19 buttons** waiting for node IDs

---

## ⚡ Quick Commands

```bash
# Test what will be published
npx figma connect publish --dry-run

# Publish to Figma
npx figma connect publish

# Create a new connection from Figma URL
npx figma connect create <FIGMA_URL> --outDir CodeComponents/Sources/SwiftUI/Buttons

# Run the interactive helper script
./create-button-connections.sh
```

---

## 📝 3-Step Process

### 1️⃣ Get Node ID from Figma

- Open Figma → Dev Mode
- Select button component
- Copy URL: `...?node-id=1234-5678`
- Use format: `1234:5678` (colon, not dash!)

### 2️⃣ Update WegoButton.figma.swift

```swift
// Replace:
node-id=YOUR_PRIMARY_LARGE_NODE_ID
// With:
node-id=1234:5678
```

### 3️⃣ Publish

```bash
npx figma connect publish
```

---

## 📂 File Structure

```
CodeComponents/Sources/SwiftUI/Buttons/
├── WegoButton+SwiftUI.swift          ← Your actual button component
├── WegoButton.figma.swift            ← 20 button variations (UPDATE NODE IDs)
└── Button-Store.figma.swift          ← Already published ✅
```

---

## 🎨 Button Variations Available

**Size × Variant:**

- Primary: Large, Medium, Small
- Secondary: Large, Medium, Small
- Tertiary: Large, Medium, Small
- Destructive: Large, Medium, Small

**Special Types:**

- Inline, External Link, Optional, Exceptional
- With Icons (leading/trailing)
- Processing/Loading state

---

## 🔗 Important Links

- **Figma File**: https://www.figma.com/design/epvlg1wjyLKHF74h5z6XCS/Component-Library-4.0
- **Docs**: `BUTTON_FIGMA_CONNECT_README.md`
- **Detailed Guide**: `FIGMA_CONNECT_SETUP_GUIDE.md`

---

## ❓ Common Issues

| Issue                  | Solution                                         |
| ---------------------- | ------------------------------------------------ |
| Invalid node URL       | Use `1234:5678` not `1234-5678`                  |
| Property doesn't exist | Remove `@FigmaEnum` wrappers (use static values) |
| Not showing in Figma   | Wait a few seconds, refresh page                 |
| Can't find components  | Check Assets panel in Figma                      |

---

## 🎯 Next Action

**→ Open `WegoButton.figma.swift` and update the node IDs!**

Then run: `npx figma connect publish`

---

**Questions? Check `BUTTON_FIGMA_CONNECT_README.md` for full details.**
