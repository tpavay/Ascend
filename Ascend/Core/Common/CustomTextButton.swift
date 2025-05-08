//
//  CustomButton.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/26/25.
//

import SwiftUI

struct CustomTextButton: View {
    /// The text displayed within the button. Cannot be changed after button is created.
    let buttonText: String
    
    /// The color of the button text. Defaults to black.
    let buttonTextColor: Color
    
    /// Whether or not the button should contain an image
    let hasImage: Bool
    
    /// The string mapped to the image to display in the button. Defaults to pencil
    let imageString: String
    
    /// The color to fill the background with. Defaults to clear
    let fillColor: Color
    
    /// Whether or not the button has a border. Defaults to false
    let isBorderedButton: Bool
    
    /// The corner radius of the background. Defaults to 10
    let cornerRadius: CGFloat
    
    /// Line width of the border. Defaults to 1
    let borderLineWidth: CGFloat
    
    /// Action to be executed when the button is tapped. Defaults to a simple print statement.
    let action: () -> Void
    
    init(buttonText: String,
         buttonTextColor: Color = .black,
         hasImage: Bool = false,
         imageString: String = "pencil",
         fillColor: Color = .clear,
         isBorderedButton: Bool = true,
         cornerRadius: CGFloat = 10,
         borderLineWidth: CGFloat = 1,
         action: @escaping () -> Void = { print("Button Tapped!") })
    {
        self.buttonText = buttonText
        self.buttonTextColor = buttonTextColor
        self.hasImage = hasImage
        self.imageString = imageString
        self.fillColor = fillColor
        self.isBorderedButton = isBorderedButton
        self.cornerRadius = cornerRadius
        self.borderLineWidth = borderLineWidth
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            buttonContent
        }
    }
    
    /// Computed property that represents the content displayed within our button.
    ///
    /// Returns a `Label` with the applied styles if `hasImage` is `true`. Otherwise `Text` with the
    /// applied styles.
    ///
    /// Note: The `ViewBuilder` macro allows us to conditionally return different Views to be
    /// stored in our computed property. Without `@ViewBuilder`, Swift would expect all paths
    /// to return the same type of `View`.
    @ViewBuilder
    private var buttonContent: some View {
        if !hasImage {
            applyStyle(to: Text(buttonText))
        }
        else {
            applyStyle(to: Label(buttonText, systemImage: imageString))
        }
    }
    
    /// Function that applies the style to any content that conforms to View.
    /// - Parameter content: The content to apply the styling to.
    /// - Returns: A view with the applied styles
    private func applyStyle<T: View>(to content: T) -> some View {
        content
            .font(.headline)
            .fontWeight(.bold)
            .foregroundStyle(buttonTextColor)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(fillColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(lineWidth: isBorderedButton ? borderLineWidth : 0)
                    )
            )
    }
}

#Preview("Light Mode") {
    VStack(spacing: 20) {
        // Basic text-only button
        CustomTextButton(buttonText: "Sign Up", buttonTextColor: Color(UIColor.label))
        
        // Bordered button
        CustomTextButton(
            buttonText: "Create Account",
            buttonTextColor: Color(UIColor.label),
            isBorderedButton: true
        )
        
        // Filled button with brand color
        CustomTextButton(
            buttonText: "Start Workout",
            buttonTextColor: Color(UIColor.label),
            fillColor: .accentPrimary) // AccentPrimary Light Mode
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack(spacing: 20) {
        // Basic text-only button
        CustomTextButton(buttonText: "Sign Up", buttonTextColor: Color(UIColor.label))
        
        // Bordered button
        CustomTextButton(
            buttonText: "Create Account",
            buttonTextColor: Color(UIColor.label),
            isBorderedButton: true
        )
        
        // Filled button with brand color
        CustomTextButton(
            buttonText: "Start Workout",
            buttonTextColor: Color(UIColor.label),
            fillColor: .accentPrimary) // AccentPrimary Dark Mode
    }
    .preferredColorScheme(.dark)
}
