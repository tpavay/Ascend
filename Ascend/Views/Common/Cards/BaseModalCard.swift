//
//  BaseModalCard.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/29/25.
//

import SwiftUI

struct BaseModalCard<Content: View>: View {
    let headerText: String
    let leftButtonText: String
    let rightButtonText: String
    let leftButtonAction: () -> Void
    let rightButtonAction: () -> Void
    let content: () -> Content
    
    var body: some View {
        VStack {
            headerSection

            Spacer()
            
            content()
                .padding(.vertical, -8)
            
            Spacer()
            
            Divider().opacity(0.3)
            
            buttonSection
                .frame(height: 44)
            
        }
        .frame(width: 300, height: 300)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 10)
    }
    
    var headerSection: some View {
        Text(headerText)
            .padding(.top, 12)
            .padding(.bottom, 0)
            .font(.headline)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
    }
    
    var buttonSection: some View {
            HStack(spacing: 0) {
                Button(action: leftButtonAction) {
                    Text(leftButtonText)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                }
                Divider().frame(height: 44)
                Button(action: rightButtonAction) {
                    Text(rightButtonText)
                        .foregroundColor(.accentPrimary)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 12)
            .font(.system(size: 16, weight: .semibold))
        }
}

#Preview {
    @Previewable @State var date = Date()
    BaseModalCard(
        headerText: "Start Time",
        leftButtonText: "Cancel",
        rightButtonText: "OK",
        leftButtonAction: {},
        rightButtonAction: {}) {
            DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel)
        }
}
