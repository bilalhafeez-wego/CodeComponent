# Figma Code Connect Integration Guide

A comprehensive guide for integrating SwiftUI components with Figma using Code Connect.

## Table of Contents

1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Initial Setup](#initial-setup)
4. [Configuration](#configuration)
5. [Creating Code Connections](#creating-code-connections)
6. [Mapping Component Properties](#mapping-component-properties)
7. [Handling Component States](#handling-component-states)
8. [Publishing to Figma](#publishing-to-figma)
9. [Known Issues & Limitations](#known-issues--limitations)
10. [Troubleshooting](#troubleshooting)
11. [Best Practices](#best-practices)

---

## Overview

Figma Code Connect allows you to link your SwiftUI components to Figma designs, enabling developers to see accurate code snippets directly in Figma's Dev Mode. This guide covers the complete setup process and best practices learned from integrating the WegoButton component.

### What You'll Achieve

- ✅ Link SwiftUI components to Figma designs
- ✅ Show accurate code snippets in Figma Dev Mode
- ✅ Map component variants (Primary, Secondary, etc.)
- ✅ Map component sizes (Large, Medium, Small)
- ✅ Handle component states (Disabled, Processing)
- ✅ Provide developers with copy-paste ready code

---

## Prerequisites

### Required Tools

- **Xcode** 15.0 or later
- **Node.js** 18.0 or later
- **npm** or **yarn**
- **Git** with repository access
- **Figma account** with access to your design file

### Required Access

- Write access to your GitHub repository
- Edit access to your Figma design file
- Figma Personal Access Token (for publishing)

---

## Initial Setup

### Step 1: Install Figma Code Connect CLI

```bash
npm install -g @figma/code-connect
```

### Step 2: Authenticate with Figma

1. Go to your Figma account settings
2. Navigate to **Personal Access Tokens**
3. Click **Generate new token**
4. Copy the token
5. Create a `.env` file in your project root:

```bash
FIGMA_ACCESS_TOKEN="your_token_here"
```

⚠️ **Important**: Add `.env` to your `.gitignore` to prevent committing secrets!

```bash
echo ".env" >> .gitignore
```

### Step 3: Initialize Code Connect

Run the setup command in your project directory:

```bash
npx figma connect setup
```

This will:

- Create a `figma.config.json` file
- Prompt you for your Figma file URL
- Generate a sample `.figma.swift` file

---

## Configuration

### Configure `figma.config.json`

Create or update your `figma.config.json` file:

```json
{
  "codeConnect": {
    "include": ["YourProject/Sources/SwiftUI/**/*.swift"],
    "interactiveSetupFigmaFileUrl": "https://www.figma.com/design/YOUR_FILE_KEY/...",
    "documentUrlSubstitutions": [
      {
        "from": "/Users/yourname/path/to/project",
        "to": "https://github.com/your-org/your-repo/blob/main"
      }
    ]
  }
}
```

#### Configuration Parameters

| Parameter                       | Description                       | Example                                 |
| ------------------------------- | --------------------------------- | --------------------------------------- |
| `include`                       | Glob pattern for files to parse   | `["Sources/**/*.swift"]`                |
| `interactiveSetupFigmaFileUrl`  | Your Figma file URL               | `https://www.figma.com/design/...`      |
| `documentUrlSubstitutions.from` | Local project path (use git root) | `/Users/you/project`                    |
| `documentUrlSubstitutions.to`   | GitHub repository URL             | `https://github.com/org/repo/blob/main` |

⚠️ **Critical**: The `from` path must be your **git repository root**, not a subdirectory!

---

## Creating Code Connections

### Step 1: Get Your Figma Component Node ID

1. Open your Figma file
2. Select the **component set** (not individual variants)
3. Right-click → **Copy link**
4. Extract the node ID from the URL:
   ```
   https://www.figma.com/design/FILE_KEY/...?node-id=1951:1846
                                                    ↑ This is your node ID
   ```

### Step 2: Create a `.figma.swift` File

Create a file named `YourComponent.figma.swift` next to your component:

```swift
import SwiftUI
import Figma

// MARK: - Your Component Connection
struct YourComponent_doc: FigmaConnect {
    let component = YourComponentView.self
    let figmaNodeUrl = "https://www.figma.com/design/FILE_KEY/...?node-id=YOUR_NODE_ID"

    var body: some View {
        YourComponentView(
            // Add your component's parameters here
            title: "Example",
            action: { }
        )
    }
}
```

### Step 3: Exclude from Xcode Compilation

⚠️ **Critical Step**: `.figma.swift` files must be excluded from Xcode compilation!

1. Open your Xcode project
2. Select each `.figma.swift` file in Project Navigator
3. Open **File Inspector** (⌥⌘1)
4. Under **Target Membership**, **uncheck** your target
5. Files should appear grayed out

**Why**: The `Figma` module only exists in Code Connect CLI, not in Xcode. If not excluded, you'll get:
```
❌ No such module 'Figma'
⚠️ Module 'Figma' was not compiled with library evolution support
```

### Step 4: Test Your Connection

Run a dry run to validate:

```bash
npx figma connect publish --dry-run
```

If successful, you'll see:

```
✓ Successfully connected component: YourComponent_doc
✓ All Code Connect files are valid
```

---

## Mapping Component Properties

### Mapping Enums (Variants)

Use `@FigmaEnum` to map Figma variant properties to Swift enums:

```swift
struct Button_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/...?node-id=..."

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary,
        "Tertiary": ButtonVariant.tertiary,
        "Destructive": ButtonVariant.destructive
    ])
    var variant: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: variant,
            title: "Button",
            action: { }
        )
    }
}
```

#### Key Points:

- The first parameter (`"Type"`) must match the **exact property name** in Figma
- Mapping keys (`"Primary"`) must match **exact variant values** in Figma
- Mapping values (`.primary`) are your Swift enum cases
- You must provide a default value (`= .primary`)

### Mapping Strings

Use `@FigmaString` for text properties:

```swift
@FigmaString("Text Content")
var buttonText: String = "Button"

var body: some View {
    ButtonView(
        title: buttonText,
        action: { }
    )
}
```

⚠️ **Limitation**: This only works if the text is exposed as a **component property** in Figma, not just a text layer.

### Mapping Booleans

Use `@FigmaBoolean` for boolean properties:

```swift
@FigmaBoolean("Has Icon")
var hasIcon: Bool = false

var body: some View {
    ButtonView(
        showIcon: hasIcon,
        action: { }
    )
}
```

---

## Handling Component States

### The Challenge

Figma components often have state variants (Default, Hover, Disabled, Processing) that need different code representations.

### ❌ What Doesn't Work

**Attempting to map multiple properties to the same Figma property:**

```swift
// DON'T DO THIS - causes conflicts!
@FigmaEnum("State", mapping: ["Processing": true])
var isProcessing: Bool = false

@FigmaEnum("State", mapping: ["Disabled": true])
var isDisabled: Bool = false
```

This creates parsing errors and undefined values.

### ✅ The Solution: Variant Mapping

Create **separate `FigmaConnect` structs** for each state using the `variant` property:

#### Base Connection (Default State)

```swift
struct Button_Large_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/...?node-id=1951:1846"

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary
    ])
    var type: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: type,
            size: .large,
            title: "Button",
            action: { }
        )
    }
}
```

#### Disabled State Connection

```swift
struct Button_Large_Disabled_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/...?node-id=1951:1846"
    let variant = ["State": "Disabled"]  // ← Key difference!

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary
    ])
    var type: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: type,
            size: .large,
            title: "Button",
            action: { }
        )
        .disabled(true)  // ← Shows disabled modifier
    }
}
```

#### Processing State Connection

```swift
struct Button_Large_Processing_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/...?node-id=1951:1846"
    let variant = ["State": "Processing"]  // ← Matches Processing state

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary
    ])
    var type: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: type,
            size: .large,
            title: "Button",
            isProcessing: true,  // ← Shows processing parameter
            action: { }
        )
    }
}
```

### How It Works

Figma Connect automatically selects the correct connection based on:

1. The Figma node ID
2. The variant property values

When a developer selects a button with `State=Disabled` in Figma, Code Connect shows the `Button_Large_Disabled_doc` code snippet.

---

## Publishing to Figma

### Step 1: Validate Your Connections

```bash
npx figma connect publish --dry-run
```

Check for:

- ✅ All components successfully connected
- ✅ No validation errors
- ✅ Correct node IDs

### Step 2: Publish to Figma

```bash
npx figma connect publish
```

You should see:

```
✓ Successfully connected component: Button_Large_doc
✓ Successfully connected component: Button_Large_Disabled_doc
✓ Successfully connected component: Button_Large_Processing_doc
✓ Validating Code Connect files...
✓ All Code Connect files are valid
✓ Uploading to Figma...
✓ Successfully uploaded to Figma
```

### Step 3: Verify in Figma

1. Open your Figma file
2. Switch to **Dev Mode** (Shift + D)
3. Select a component instance
4. Look for the **"Code Connect"** section
5. You should see the **"Connected"** badge
6. Click to view the code snippet

### Step 4: Commit and Push to GitHub

```bash
git add .
git commit -m "Add Figma Code Connect for ButtonView"
git push origin main
```

⚠️ **Important**: Push to `main` branch (see Known Issues below)

---

## Known Issues & Limitations

### 1. ⚠️ GitHub Branch Limitation

**Issue**: Figma Code Connect only generates links to the `main` branch, regardless of your current branch.

**Impact**:

- If your code is on `feature/my-branch`, Figma will link to `main`
- The "View in GitHub" link may show 404 if the file doesn't exist on `main`

**Workaround**:

1. Merge your feature branch to `main` before publishing
2. Or accept that the GitHub link will point to `main`

**Example**:

```bash
# Your current branch
git branch
# * feature/code-connect

# Figma will still generate this URL:
# https://github.com/org/repo/blob/main/Sources/Button.swift
```

### 2. ⚠️ Git Remote URL Format

**Issue**: Figma Connect requires standard HTTPS GitHub URLs.

**Problem**: If your git remote uses SSH with a custom host:

```bash
git@github-custom:org/repo.git
```

Figma Connect converts this to an invalid URL:

```
https://github-custom/org/repo/...  # ❌ Invalid!
```

**Solution**: Update your git remote to use standard HTTPS:

```bash
git remote set-url origin https://github.com/org/repo.git
```

**Note**: You can still use SSH for daily work; just switch to HTTPS before publishing.

### 3. ⚠️ Text Content Mapping

**Issue**: Cannot dynamically map text content from Figma.

**Reason**: Text in Figma is typically a text layer, not a component property.

**Limitation**: Code snippets will always show hardcoded text:

```swift
ButtonView(
    title: "Button",  // ← Always shows this, regardless of Figma text
    action: { }
)
```

**Workaround**: Use a generic placeholder like `"Button"` or `"Label"`.

### 4. ⚠️ `hideDefault` Parameter Limitations

**Issue**: The `hideDefault: true` parameter doesn't work reliably with `@FigmaEnum`.

**Problem**: Attempting to hide default values causes undefined or empty values:

```swift
// This causes issues:
@FigmaEnum("State", mapping: ["Disabled": true], hideDefault: true)
var isDisabled: Bool = false
```

**Result**: Shows `isProcessing: ,` or `.disabled(undefined)` in code snippets.

**Solution**: Use variant mapping instead (see [Handling Component States](#handling-component-states)).

### 5. ⚠️ Path Mapping Complexity

**Issue**: `documentUrlSubstitutions` must map from git root, not project subdirectories.

**Example Problem**:

```json
{
  "documentUrlSubstitutions": [
    {
      "from": "/Users/you/project/SubFolder", // ❌ Wrong!
      "to": "https://github.com/org/repo/blob/main"
    }
  ]
}
```

This creates incorrect URLs with duplicated paths.

**Solution**: Always use git repository root:

```json
{
  "documentUrlSubstitutions": [
    {
      "from": "/Users/you/project", // ✅ Correct!
      "to": "https://github.com/org/repo/blob/main"
    }
  ]
}
```

### 6. ⚠️ Parser Strictness

**Issue**: The Swift parser is very strict about syntax.

**Common Errors**:

- Computed properties in `body` cause parsing errors
- String interpolation in property wrappers fails
- Complex mapping logic isn't supported

**Solution**: Keep connections simple and declarative.

---

## Troubleshooting

### Problem: "No such module 'Figma'" or Library Evolution Warning

**Symptoms**: Xcode build fails with:
```
❌ No such module 'Figma'
⚠️ Module 'Figma' was not compiled with library evolution support
```

**Cause**: `.figma.swift` files are being compiled by Xcode, but the `Figma` module only exists in the Code Connect CLI environment.

**Solution**:

1. **Exclude from Target Membership** (Recommended):
   - Select each `.figma.swift` file in Xcode
   - Open File Inspector (⌥⌘1)
   - Under **Target Membership**, uncheck your target
   - Files should appear grayed out

2. **Verify Exclusion**:
   ```bash
   # Clean build
   ⌘ + Shift + K
   
   # Build again
   ⌘ + B
   # Should succeed ✅
   ```

3. **Confirm Code Connect Still Works**:
   ```bash
   npx figma connect publish --dry-run
   # Should still parse files ✅
   ```

**Alternative**: Move all `.figma.swift` files to a separate `FigmaConnect/` directory that's not part of any target.

See `FIGMA_COMPILATION_FIX.md` for detailed solutions.

### Problem: "Can't show code. File not found"

**Symptoms**: Connected badge appears, but clicking shows "File not found" error.

**Causes**:

1. File doesn't exist on `main` branch
2. Incorrect `documentUrlSubstitutions` path mapping
3. Git remote URL is not standard HTTPS format

**Solutions**:

```bash
# 1. Check your current branch
git branch

# 2. Verify file exists on main
git checkout main
ls path/to/your/file.swift

# 3. Check git remote URL
git remote -v

# 4. Update to HTTPS if needed
git remote set-url origin https://github.com/org/repo.git

# 5. Verify config paths
cat figma.config.json
```

### Problem: "The property 'X' does not exist on the Figma component"

**Symptoms**: Validation fails with property not found error.

**Cause**: Property name in `@FigmaEnum` doesn't match Figma exactly.

**Solution**:

1. Open Figma
2. Select your component
3. Check the exact property name in the properties panel
4. Update your code to match exactly (case-sensitive!)

```swift
// If Figma shows "Type" (capital T):
@FigmaEnum("Type", mapping: [...])  // ✅ Correct

// Not:
@FigmaEnum("type", mapping: [...])  // ❌ Wrong case
```

### Problem: "Variant values must be either a String or Bool literal"

**Symptoms**: Parser error about variant values.

**Cause**: Trying to use enum cases directly in mapping.

**Wrong**:

```swift
@FigmaEnum("Type", mapping: [
    "Primary": .primary  // ❌ Parser doesn't understand this
])
```

**Correct**:

```swift
@FigmaEnum("Type", mapping: [
    "Primary": ButtonVariant.primary  // ✅ Full type name
])
var type: ButtonVariant = .primary
```

### Problem: Shows `isProcessing: ,` or `.disabled(undefined)`

**Symptoms**: Code snippet shows empty or undefined values.

**Cause**: Using `@FigmaEnum` with `hideDefault` for boolean states.

**Solution**: Use variant mapping instead (see [Handling Component States](#handling-component-states)).

### Problem: "Unknown remote URL - assuming GitHub Enterprise"

**Symptoms**: Warning about unknown remote URL format.

**Cause**: Git remote uses SSH with custom host.

**Solution**:

```bash
# Change from SSH to HTTPS
git remote set-url origin https://github.com/org/repo.git

# Republish
npx figma connect publish
```

---

## Best Practices

### 1. File Organization

```
YourProject/
├── Sources/
│   └── SwiftUI/
│       └── Components/
│           ├── Button/
│           │   ├── ButtonView.swift          # Your component
│           │   └── ButtonView.figma.swift    # Code Connect file
│           └── TextField/
│               ├── TextFieldView.swift
│               └── TextFieldView.figma.swift
└── figma.config.json
```

**Naming Convention**: `ComponentName.figma.swift`

### 2. Connection Naming

Use descriptive names that indicate size and state:

```swift
// ✅ Good
struct Button_Large_doc: FigmaConnect { }
struct Button_Large_Disabled_doc: FigmaConnect { }
struct Button_Medium_Processing_doc: FigmaConnect { }

// ❌ Bad
struct Button1: FigmaConnect { }
struct Button2: FigmaConnect { }
```

### 3. Keep Code Snippets Clean

Show production-ready code:

```swift
// ✅ Good - clean and usable
var body: some View {
    ButtonView(
        variant: .primary,
        size: .large,
        title: "Button",
        action: { }
    )
}

// ❌ Bad - too much noise
var body: some View {
    ButtonView(
        variant: .primary,
        size: .large,
        title: "Button",
        leadingIcon: nil,
        trailingIcon: nil,
        isProcessing: false,
        isDisabled: false,
        action: { }
    )
}
```

### 4. Document Your Connections

Add comments to explain complex mappings:

```swift
// MARK: - Button Large - Disabled State
// Shows the disabled modifier when State=Disabled in Figma
struct Button_Large_Disabled_doc: FigmaConnect {
    // ...
}
```

### 5. Test Before Publishing

Always run a dry run first:

```bash
# Test
npx figma connect publish --dry-run

# If successful, publish
npx figma connect publish
```

### 6. Version Control

**Do commit**:

- ✅ `.figma.swift` files
- ✅ `figma.config.json`
- ✅ Documentation

**Don't commit**:

- ❌ `.env` file (contains secrets!)
- ❌ Personal access tokens
- ❌ Temporary files

### 7. Keep Connections in Sync

When you update your component:

1. Update the Swift component
2. Update the `.figma.swift` connection
3. Republish to Figma
4. Verify in Dev Mode

### 8. Handle Multiple Sizes

Create separate connections for each size:

```swift
// Large
struct Button_Large_doc: FigmaConnect {
    let figmaNodeUrl = "...?node-id=1951:1846"
    var body: some View {
        ButtonView(variant: type, size: .large, ...)
    }
}

// Medium
struct Button_Medium_doc: FigmaConnect {
    let figmaNodeUrl = "...?node-id=1951:2099"
    var body: some View {
        ButtonView(variant: type, size: .medium, ...)
    }
}

// Small
struct Button_Small_doc: FigmaConnect {
    let figmaNodeUrl = "...?node-id=1951:2352"
    var body: some View {
        ButtonView(variant: type, size: .small, ...)
    }
}
```

---

## Example: Complete Button Integration

Here's a complete example showing all concepts together:

```swift
import SwiftUI
import Figma

// MARK: - Button Large (Default State)
struct Button_Large_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/FILE_KEY/...?node-id=1951:1846"

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary,
        "Tertiary": ButtonVariant.tertiary,
        "Destructive": ButtonVariant.destructive
    ])
    var type: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: type,
            size: .large,
            title: "Button",
            action: { }
        )
    }
}

// MARK: - Button Large (Disabled State)
struct Button_Large_Disabled_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/FILE_KEY/...?node-id=1951:1846"
    let variant = ["State": "Disabled"]

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary,
        "Tertiary": ButtonVariant.tertiary,
        "Destructive": ButtonVariant.destructive
    ])
    var type: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: type,
            size: .large,
            title: "Button",
            action: { }
        )
        .disabled(true)
    }
}

// MARK: - Button Large (Processing State)
struct Button_Large_Processing_doc: FigmaConnect {
    let component = ButtonView.self
    let figmaNodeUrl = "https://www.figma.com/design/FILE_KEY/...?node-id=1951:1846"
    let variant = ["State": "Processing"]

    @FigmaEnum("Type", mapping: [
        "Primary": ButtonVariant.primary,
        "Secondary": ButtonVariant.secondary,
        "Tertiary": ButtonVariant.tertiary,
        "Destructive": ButtonVariant.destructive
    ])
    var type: ButtonVariant = .primary

    var body: some View {
        ButtonView(
            variant: type,
            size: .large,
            title: "Button",
            isProcessing: true,
            action: { }
        )
    }
}

// Repeat for Medium and Small sizes...
```

---

## Additional Resources

### Official Documentation

- [Figma Code Connect Documentation](https://developers.figma.com/docs/code-connect/)
- [SwiftUI Code Connect Guide](https://developers.figma.com/docs/code-connect/swiftui/)
- [GitHub Repository](https://github.com/figma/code-connect)

### Getting Help

- [Figma Community Forum](https://forum.figma.com/)
- [Code Connect GitHub Issues](https://github.com/figma/code-connect/issues)

---

## Summary Checklist

Before publishing your Code Connect integration:

- [ ] Installed Figma Code Connect CLI
- [ ] Created Figma Personal Access Token
- [ ] Added `.env` to `.gitignore`
- [ ] Configured `figma.config.json` correctly
- [ ] Created `.figma.swift` files for all components
- [ ] Mapped all component variants
- [ ] Handled component states with variant mapping
- [ ] Tested with `--dry-run`
- [ ] Published to Figma successfully
- [ ] Verified in Figma Dev Mode
- [ ] Committed and pushed to `main` branch
- [ ] Verified GitHub links work
- [ ] Documented any custom mappings

---

**Questions or Issues?**

If you encounter problems not covered in this guide, please:

1. Check the [Troubleshooting](#troubleshooting) section
2. Review [Known Issues](#known-issues--limitations)
3. Consult the [official documentation](https://developers.figma.com/docs/code-connect/)
4. Open an issue in your team's repository

---

_Last Updated: October 2025_
_Version: 1.0_
