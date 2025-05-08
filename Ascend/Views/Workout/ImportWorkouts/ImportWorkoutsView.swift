//
//  ImportWorkoutsView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/21/25.
//

import SwiftUI
import HealthKit

struct ImportWorkoutsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var thirdPartyWorkouts: [ThirdPartyWorkout] = []
    //let healthKitManager = HealthKitManager.shared
    @State private var isLoading: Bool = false
    @State var isError: Bool = false
    @State var errorString: String = ""
    @State var errorDescription: String = ""
    @State private var monitoringTask: Task<Void, Never>?
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView()
                    Text("Loading workouts...")
                        .padding()
                }
                
                if isError {
                    errorContent
                }
                
                if !isLoading && !isError {
                    if thirdPartyWorkouts.isEmpty {
                        VStack {
                            Text("No StairMaster workouts found")
                                .font(.headline)
                            Text("Record workouts with Apple Fitness and they'll appear here")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 0) {
                                ForEach(thirdPartyWorkouts, id: \.startDate) { workout in
                                    ImportWorkoutsCellView(workout: workout)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Import Workouts")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
//            .task {
//                await startMonitoring()
//            }
//            .onAppear {
//                startMonitoring()
//            }
//            .onDisappear {
//                monitoringTask?.cancel()
//            }
        }
    }
    
    private var errorContent: some View {
        VStack {
            ErrorView(errorText: errorString, errorDescription: errorDescription)
            CustomTextButton(
                buttonText: "Return to Dashboard",
                buttonTextColor: .white,
                fillColor: .accentPrimary,
                action: { dismiss() }
            )
        }
        .buttonStyle(.plain)
        .padding()
    }
}

#Preview {
    ImportWorkoutsView()
}
