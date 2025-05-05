import SwiftUI
import FamilyControls
import DeviceActivity
import Foundation

struct AppSelectionReviewView: View {
    @ObservedObject var viewModel: AppSelectionViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.green)
                        
                        Text("Apps Selected!")
                            .font(.title)
                            .bold()
                        
                        Text("We'll help you stay mindful of your time on these apps.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top)
                    
                    // Selected Apps List
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Your Selected Apps")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(Array(viewModel.selectedApps), id: \.self) { app in
                            HStack {
                                Image(systemName: "app.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                                    .frame(width: 30)
                                
                                Text(app)
                                    .font(.body)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.toggleApp(app)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Motivational Message
                    VStack(spacing: 12) {
                        Text("Let's keep you focused this week 🔥")
                            .font(.headline)
                        
                        Text("You'll receive your first usage summary soon.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                    
                    // Continue Button
                    Button(action: {
                        if currentPage == 1 {
                            requestScreenTimePermission { success in
                                DispatchQueue.main.async {
                                    withAnimation {
                                        currentPage += 1
                                    }
                                }
                            }
                        } else {
                            withAnimation {
                                currentPage += 1
                            }
                        }
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    AppSelectionReviewView(viewModel: AppSelectionViewModel())
}

func fetchUsageStats() {
    let calendar = Calendar.current
    let startOfDay = calendar.startOfDay(for: Date())
    let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
    let interval = DateInterval(start: startOfDay, end: endOfDay)
    let context = DeviceActivityReport.Context.daily

    Task {
        do {
            let reports = try await DeviceActivityReportCenter.shared.loadReports(
                for: context,
                between: interval
            )
            var usage: [String: TimeInterval] = [:]
            for report in reports {
                for (token, data) in report.applications {
                    let appName = token.localizedDisplayName ?? token.bundleIdentifier ?? token.rawValue
                    usage[appName] = data.totalActivityDuration
                }
            }
            DispatchQueue.main.async {
                self.appUsageStats = usage
            }
        } catch {
            print("Failed to fetch activity: \\(error)")
            DispatchQueue.main.async {
                self.appUsageStats = [:]
            }
        }
    }
}

extension DeviceActivityReport.Context {
    static let daily = Self("daily")
}

let appGroupID = "group.com.yourcompany.keeper" // Replace with your actual group

func saveUsageToAppGroup(_ usage: [String: TimeInterval]) {
    if let defaults = UserDefaults(suiteName: appGroupID) {
        defaults.set(usage, forKey: "appUsageStats")
    }
}

// In your report's makeConfiguration or similar:
func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> String {
    var usage: [String: TimeInterval] = [:]
    for (token, activity) in data.flatMap({ $0.applicationActivity }) {
        let appName = token.localizedDisplayName ?? token.bundleIdentifier ?? token.rawValue
        usage[appName] = activity.totalActivityDuration
    }
    saveUsageToAppGroup(usage)
    // ... return your configuration ...
}

func fetchUsageStatsFromAppGroup() {
    if let defaults = UserDefaults(suiteName: appGroupID),
       let usage = defaults.dictionary(forKey: "appUsageStats") as? [String: TimeInterval] {
        DispatchQueue.main.async {
            self.appUsageStats = usage
        }
    }
}

struct AppSelectionReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AppSelectionReviewView(viewModel: AppSelectionViewModel())
    }
} 