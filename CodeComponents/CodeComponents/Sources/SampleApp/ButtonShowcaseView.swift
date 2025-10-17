//
//  ButtonShowcaseView.swift
//  CodeComponents
//
//  Comprehensive showcase of all button variants, sizes, states, and configurations
//

import SwiftUI

@available(iOS 15.0, *)
struct ButtonShowcaseView: View {
    
    @State private var selectedTab = 0
    @State private var isProcessing = false
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                // Tab 1: All Variants (Large Size)
                AllVariantsView()
                    .tabItem {
                        Label("Variants", systemImage: "rectangle.3.group")
                    }
                    .tag(0)
                
                // Tab 2: All Sizes
                AllSizesView()
                    .tabItem {
                        Label("Sizes", systemImage: "square.resize")
                    }
                    .tag(1)
                
                // Tab 3: All States
                AllStatesView(isProcessing: $isProcessing)
                    .tabItem {
                        Label("States", systemImage: "slider.horizontal.3")
                    }
                    .tag(2)
                
                // Tab 4: With Icons
                WithIconsView()
                    .tabItem {
                        Label("Icons", systemImage: "star.circle")
                    }
                    .tag(3)
                
                // Tab 5: Real World Examples
                RealWorldExamplesView()
                    .tabItem {
                        Label("Examples", systemImage: "app.badge")
                    }
                    .tag(4)
            }
            .navigationTitle(navigationTitle)
        }
    }
    
    private var navigationTitle: String {
        switch selectedTab {
        case 0: return "Button Variants"
        case 1: return "Button Sizes"
        case 2: return "Button States"
        case 3: return "Buttons with Icons"
        case 4: return "Real World Examples"
        default: return "Button Showcase"
        }
    }
}

// MARK: - All Variants View

@available(iOS 15.0, *)
struct AllVariantsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader(title: "All Button Variants", subtitle: "Large size - Default state")
                
                VStack(spacing: 16) {
                    WegoButtonView.primary(title: "Primary Button") {
                        print("Primary tapped")
                    }
                    
                    WegoButtonView.secondary(title: "Secondary Button") {
                        print("Secondary tapped")
                    }
                    
                    WegoButtonView.tertiary(title: "Tertiary Button") {
                        print("Tertiary tapped")
                    }
                    
                    WegoButtonView(variant: .optional, title: "Optional Button") {
                        print("Optional tapped")
                    }
                    
                    WegoButtonView.destructive(title: "Destructive Button") {
                        print("Destructive tapped")
                    }
                    
                    WegoButtonView.inline(title: "Inline Button") {
                        print("Inline tapped")
                    }
                    
                    WegoButtonView.externalLink(title: "External Link") {
                        print("External link tapped")
                    }
                    
                    WegoButtonView(variant: .exceptional, title: "Exceptional Button") {
                        print("Exceptional tapped")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - All Sizes View

@available(iOS 15.0, *)
struct AllSizesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Large Buttons
                VStack(spacing: 16) {
                    SectionHeader(title: "Large Buttons", subtitle: "48pt height - Primary actions")
                    
                    VStack(spacing: 12) {
                        WegoButtonView.primary(title: "Large Primary", size: .large) {
                            print("Large primary tapped")
                        }
                        
                        WegoButtonView.secondary(title: "Large Secondary", size: .large) {
                            print("Large secondary tapped")
                        }
                        
                        WegoButtonView.destructive(title: "Large Destructive", size: .large) {
                            print("Large destructive tapped")
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Medium Buttons
                VStack(spacing: 16) {
                    SectionHeader(title: "Medium Buttons", subtitle: "36pt height - Secondary actions")
                    
                    VStack(spacing: 12) {
                        WegoButtonView.primary(title: "Medium Primary", size: .medium) {
                            print("Medium primary tapped")
                        }
                        
                        WegoButtonView.secondary(title: "Medium Secondary", size: .medium) {
                            print("Medium secondary tapped")
                        }
                        
                        WegoButtonView.destructive(title: "Medium Destructive", size: .medium) {
                            print("Medium destructive tapped")
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Small Buttons
                VStack(spacing: 16) {
                    SectionHeader(title: "Small Buttons", subtitle: "28pt height - Inline actions")
                    
                    VStack(spacing: 12) {
                        WegoButtonView.inline(title: "Small Inline", size: .small) {
                            print("Small inline tapped")
                        }
                        
                        WegoButtonView.externalLink(title: "Small External Link", size: .small) {
                            print("Small link tapped")
                        }
                        
                        WegoButtonView(variant: .exceptional, size: .small, title: "Small Exceptional") {
                            print("Small exceptional tapped")
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - All States View

@available(iOS 15.0, *)
struct AllStatesView: View {
    @Binding var isProcessing: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader(title: "Button States", subtitle: "Normal, Pressed, Disabled, Processing")
                
                VStack(spacing: 16) {
                    // Normal State
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Normal State")
                            .font(.headline)
                        WegoButtonView.primary(title: "Normal Button") {
                            print("Normal button tapped")
                        }
                    }
                    
                    // Disabled State
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Disabled State")
                            .font(.headline)
                        WegoButtonView.primary(title: "Disabled Button") {
                            print("This won't print")
                        }
                        .disabled(true)
                    }
                    
                    // Processing State
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Processing State")
                            .font(.headline)
                        WegoButtonView(
                            variant: .primary,
                            title: isProcessing ? "Processing..." : "Start Process",
                            isProcessing: isProcessing
                        ) {
                            isProcessing = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isProcessing = false
                            }
                        }
                        .disabled(isProcessing)
                    }
                    
                    // All states for Primary
                    Divider()
                    
                    Text("Primary Variant - All States")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        VStack {
                            WegoButtonView.primary(title: "Normal") {}
                            Text("Normal").font(.caption)
                        }
                        
                        VStack {
                            WegoButtonView.primary(title: "Disabled") {}
                                .disabled(true)
                            Text("Disabled").font(.caption)
                        }
                    }
                    
                    // All states for Secondary
                    Divider()
                    
                    Text("Secondary Variant - All States")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        VStack {
                            WegoButtonView.secondary(title: "Normal") {}
                            Text("Normal").font(.caption)
                        }
                        
                        VStack {
                            WegoButtonView.secondary(title: "Disabled") {}
                                .disabled(true)
                            Text("Disabled").font(.caption)
                        }
                    }
                    
                    // All states for Destructive
                    Divider()
                    
                    Text("Destructive Variant - All States")
                        .font(.headline)
                    
                    HStack(spacing: 12) {
                        VStack {
                            WegoButtonView.destructive(title: "Normal") {}
                            Text("Normal").font(.caption)
                        }
                        
                        VStack {
                            WegoButtonView.destructive(title: "Disabled") {}
                                .disabled(true)
                            Text("Disabled").font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - With Icons View

@available(iOS 15.0, *)
struct WithIconsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                SectionHeader(title: "Buttons with Icons", subtitle: "Leading, trailing, both, and icon-only")
                
                VStack(spacing: 16) {
                    // Text Only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Text Only")
                            .font(.headline)
                        WegoButtonView.primary(title: "Continue") {
                            print("Continue tapped")
                        }
                    }
                    
                    Divider()
                    
                    // Leading Icon
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Leading Icon")
                            .font(.headline)
                        WegoButtonView(
                            variant: .primary,
                            title: "Search",
                            leadingIcon: Image(systemName: "magnifyingglass")
                        ) {
                            print("Search tapped")
                        }
                    }
                    
                    Divider()
                    
                    // Trailing Icon
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Trailing Icon")
                            .font(.headline)
                        WegoButtonView(
                            variant: .primary,
                            title: "Next",
                            trailingIcon: Image(systemName: "arrow.right")
                        ) {
                            print("Next tapped")
                        }
                    }
                    
                    Divider()
                    
                    // Both Icons
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Both Icons")
                            .font(.headline)
                        WegoButtonView(
                            variant: .primary,
                            title: "Share",
                            leadingIcon: Image(systemName: "square.and.arrow.up"),
                            trailingIcon: Image(systemName: "chevron.right")
                        ) {
                            print("Share tapped")
                        }
                    }
                    
                    Divider()
                    
                    // Icon Only
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Icon Only")
                            .font(.headline)
                        HStack(spacing: 12) {
                            WegoButtonView(
                                variant: .primary,
                                title: "",
                                leadingIcon: Image(systemName: "heart.fill")
                            ) {
                                print("Heart tapped")
                            }
                            
                            WegoButtonView(
                                variant: .secondary,
                                title: "",
                                leadingIcon: Image(systemName: "star.fill")
                            ) {
                                print("Star tapped")
                            }
                            
                            WegoButtonView(
                                variant: .tertiary,
                                title: "",
                                leadingIcon: Image(systemName: "bookmark.fill")
                            ) {
                                print("Bookmark tapped")
                            }
                        }
                    }
                    
                    Divider()
                    
                    // Different sizes with icons
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Different Sizes with Icons")
                            .font(.headline)
                        
                        VStack(spacing: 12) {
                            WegoButtonView(
                                variant: .primary,
                                size: .large,
                                title: "Large with Icon",
                                leadingIcon: Image(systemName: "checkmark.circle.fill")
                            ) {
                                print("Large tapped")
                            }
                            
                            WegoButtonView(
                                variant: .primary,
                                size: .medium,
                                title: "Medium with Icon",
                                leadingIcon: Image(systemName: "checkmark.circle.fill")
                            ) {
                                print("Medium tapped")
                            }
                            
                            WegoButtonView(
                                variant: .inline,
                                size: .small,
                                title: "Small with Icon",
                                trailingIcon: Image(systemName: "arrow.right")
                            ) {
                                print("Small tapped")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
}

// MARK: - Real World Examples View

@available(iOS 15.0, *)
struct RealWorldExamplesView: View {
    @State private var isLoading = false
    @State private var showAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Login Form
                VStack(spacing: 16) {
                    SectionHeader(title: "Login Form", subtitle: "Typical login screen")
                    
                    VStack(spacing: 12) {
                        TextField("Email", text: .constant("user@example.com"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Password", text: .constant("••••••••"))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        WegoButtonView.primary(title: "Sign In", size: .large) {
                            print("Sign in tapped")
                        }
                        
                        WegoButtonView.inline(title: "Forgot Password?", size: .small) {
                            print("Forgot password tapped")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Card Actions
                VStack(spacing: 16) {
                    SectionHeader(title: "Card Actions", subtitle: "Action buttons in a card")
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Hotel Booking")
                            .font(.title2)
                            .bold()
                        Text("Grand Plaza Hotel")
                            .font(.body)
                        Text("$299/night")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            WegoButtonView.primary(title: "Book Now", size: .medium) {
                                print("Book tapped")
                            }
                            
                            WegoButtonView.secondary(title: "Details", size: .medium) {
                                print("Details tapped")
                            }
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Search Bar
                VStack(spacing: 16) {
                    SectionHeader(title: "Search Interface", subtitle: "Search with filters")
                    
                    VStack(spacing: 12) {
                        HStack {
                            TextField("Search...", text: .constant(""))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            WegoButtonView(
                                variant: .primary,
                                size: .medium,
                                title: "",
                                leadingIcon: Image(systemName: "magnifyingglass")
                            ) {
                                print("Search tapped")
                            }
                        }
                        
                        HStack(spacing: 8) {
                            Text("Filters:")
                                .font(.caption)
                            
                            WegoButtonView(
                                variant: .tertiary,
                                size: .small,
                                title: "Hotels"
                            ) {
                                print("Hotels filter")
                            }
                            
                            WegoButtonView(
                                variant: .tertiary,
                                size: .small,
                                title: "Flights"
                            ) {
                                print("Flights filter")
                            }
                            
                            WegoButtonView(
                                variant: .tertiary,
                                size: .small,
                                title: "Activities"
                            ) {
                                print("Activities filter")
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Bottom Sheet Actions
                VStack(spacing: 16) {
                    SectionHeader(title: "Bottom Sheet", subtitle: "Confirmation actions")
                    
                    VStack(spacing: 12) {
                        Text("Delete Account?")
                            .font(.title3)
                            .bold()
                        
                        Text("This action cannot be undone. All your data will be permanently deleted.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                        
                        WegoButtonView.destructive(title: "Delete Account", size: .large) {
                            showAlert = true
                        }
                        
                        WegoButtonView.secondary(title: "Cancel", size: .large) {
                            print("Cancel tapped")
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Navigation
                VStack(spacing: 16) {
                    SectionHeader(title: "Navigation", subtitle: "Multi-step process")
                    
                    VStack(spacing: 12) {
                        Text("Step 2 of 3")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(spacing: 12) {
                            WegoButtonView(
                                variant: .secondary,
                                size: .medium,
                                title: "Back",
                                leadingIcon: Image(systemName: "chevron.left")
                            ) {
                                print("Back tapped")
                            }
                            
                            WegoButtonView(
                                variant: .primary,
                                size: .medium,
                                title: "Next",
                                trailingIcon: Image(systemName: "chevron.right")
                            ) {
                                print("Next tapped")
                            }
                        }
                        
                        WegoButtonView.inline(title: "Skip", size: .small) {
                            print("Skip tapped")
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Loading State
                VStack(spacing: 16) {
                    SectionHeader(title: "Loading State", subtitle: "Async operation")
                    
                    VStack(spacing: 12) {
                        WegoButtonView(
                            variant: .primary,
                            title: isLoading ? "Submitting..." : "Submit Form",
                            isProcessing: isLoading
                        ) {
                            isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isLoading = false
                            }
                        }
                        .disabled(isLoading)
                        
                        if isLoading {
                            Text("Please wait...")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .alert("Account Deleted", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

// MARK: - Helper Views

struct SectionHeader: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title2)
                .bold()
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Preview

@available(iOS 15.0, *)
struct ButtonShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonShowcaseView()
    }
}

