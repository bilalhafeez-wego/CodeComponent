# Fixing Figma Module Compilation Errors

## Problem

When compiling your Xcode project, you see errors like:

```
❌ No such module 'Figma'
⚠️ Module 'Figma' was not compiled with library evolution support
```

## Why This Happens

The `.figma.swift` files are **not meant to be compiled** by Xcode. They are only used by the Figma Code Connect CLI tool for parsing and generating code snippets. The `Figma` module only exists in the Code Connect CLI environment, not in your Xcode project.

## Solution 1: Exclude from Target Membership (Recommended)

### Step 1: Open Xcode Project

Open your `CodeComponents.xcodeproj` in Xcode.

### Step 2: Select Each `.figma.swift` File

In the Project Navigator, select each `.figma.swift` file:
- `WegoButton.figma.swift`
- `Button-Store.figma.swift`
- Any other `.figma.swift` files

### Step 3: Remove from Target

1. With the file selected, open the **File Inspector** (⌥⌘1)
2. Look for the **Target Membership** section
3. **Uncheck** your target (e.g., `CodeComponents`)

![Target Membership Screenshot](https://developers.figma.com/assets/code-connect-target-membership.png)

### Step 4: Verify

The `.figma.swift` files should now appear **grayed out** in the Project Navigator, indicating they're not part of the build.

### Step 5: Clean and Build

```bash
# Clean build folder
⌘ + Shift + K

# Build
⌘ + B
```

## Solution 2: Add Build Phase Script (Alternative)

If you want to keep the files in the target but exclude them from compilation:

### Step 1: Open Build Phases

1. Select your project in Xcode
2. Select your target
3. Go to **Build Phases** tab

### Step 2: Add Run Script Phase

1. Click **+** → **New Run Script Phase**
2. Name it "Exclude Figma Files"
3. Add this script:

```bash
# Remove .figma.swift files from compilation
find "${SRCROOT}" -name "*.figma.swift" -type f | while read file; do
    echo "Excluding from compilation: $file"
done
```

### Step 3: Move Before "Compile Sources"

Drag the script phase **above** the "Compile Sources" phase.

## Solution 3: Use .swiftignore (If Available)

Some projects support a `.swiftignore` file:

Create `.swiftignore` in your project root:

```
*.figma.swift
```

**Note**: This is not standard Swift/Xcode functionality, but some build systems support it.

## Solution 4: Separate Directory (Best for Large Projects)

Move all `.figma.swift` files to a separate directory that's excluded from the target:

### Directory Structure

```
YourProject/
├── Sources/
│   └── SwiftUI/
│       └── Buttons/
│           ├── WegoButton+SwiftUI.swift      # ✅ Compiled
│           └── WegoButtonStyle.swift         # ✅ Compiled
├── FigmaConnect/                              # ← New directory
│   └── Buttons/
│       ├── WegoButton.figma.swift            # ❌ Not compiled
│       └── Button-Store.figma.swift          # ❌ Not compiled
└── figma.config.json
```

### Update figma.config.json

```json
{
  "codeConnect": {
    "include": ["FigmaConnect/**/*.swift"],
    "interactiveSetupFigmaFileUrl": "https://www.figma.com/design/...",
    "documentUrlSubstitutions": [
      {
        "from": "/Users/yourname/path/to/project",
        "to": "https://github.com/your-org/your-repo/blob/main"
      }
    ]
  }
}
```

### In Xcode

Make sure the `FigmaConnect` folder is added as a **folder reference** (blue folder icon), not a group, and is **not** part of any target.

## Verification

After applying any solution, verify:

### 1. Build Succeeds

```bash
⌘ + B
```

Should complete without Figma module errors.

### 2. Code Connect Still Works

```bash
cd /path/to/your/project
npx figma connect publish --dry-run
```

Should still find and parse your `.figma.swift` files.

### 3. Files Are Tracked by Git

```bash
git status
```

The `.figma.swift` files should still be tracked (not ignored by git).

## Common Mistakes

### ❌ Don't Add Figma as a Swift Package

Do **NOT** try to add the Figma module as a Swift Package Dependency in Xcode. The Figma module is only available in the Code Connect CLI environment.

### ❌ Don't Import Figma in Regular Code

Do **NOT** add `import Figma` to your actual component files:

```swift
// ❌ Wrong - in WegoButton+SwiftUI.swift
import SwiftUI
import Figma  // ❌ Don't do this!

public struct WegoButtonView: View {
    // ...
}
```

Only use `import Figma` in `.figma.swift` files:

```swift
// ✅ Correct - in WegoButton.figma.swift
import SwiftUI
import Figma  // ✅ Only here!

struct WegoButton_Large_doc: FigmaConnect {
    // ...
}
```

### ❌ Don't Delete .figma.swift Files

The files need to exist for Code Connect to work. Just exclude them from compilation.

## Recommended Approach

For most projects, **Solution 1** (Remove from Target Membership) is the simplest and most effective:

1. ✅ Files stay in their logical location next to components
2. ✅ Easy to maintain
3. ✅ No build scripts needed
4. ✅ Clear visual indication (grayed out in Xcode)

## Updating the Guide

Add this section to your `FIGMA_CODE_CONNECT_GUIDE.md`:

```markdown
## Xcode Configuration

### Exclude .figma.swift Files from Compilation

⚠️ **Important**: `.figma.swift` files must be excluded from Xcode compilation.

1. In Xcode, select each `.figma.swift` file
2. Open File Inspector (⌥⌘1)
3. Under **Target Membership**, uncheck your target
4. Files should appear grayed out in Project Navigator

**Why**: The `Figma` module only exists in the Code Connect CLI environment, not in Xcode. Attempting to compile these files will cause "No such module 'Figma'" errors.
```

## Testing

After fixing:

```bash
# 1. Clean build
⌘ + Shift + K

# 2. Build project
⌘ + B
# Should succeed ✅

# 3. Test Code Connect
npx figma connect publish --dry-run
# Should still work ✅
```

---

**Need Help?**

If you still see errors after applying these solutions:
1. Make sure **all** `.figma.swift` files are excluded
2. Clean derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData`
3. Restart Xcode
4. Try a clean build again


