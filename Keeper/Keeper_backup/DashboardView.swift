import SwiftUI

struct AppUsage: Identifiable {
    let id = UUID()
    let name: String
    let hours: Double
    let change: Double // percentage change from last week
}

struct TodayUsage: Identifiable {
    let id = UUID()
    let name: String
    let hours: Double
}

struct DashboardView: View {
    @StateObject private var viewModel = AppSelectionViewModel()
    @State private var showingDailySummary = false
    
    // Mock data for testing - now represents daily averages
    let mockUsage: [AppUsage] = [
        AppUsage(name: "Instagram", hours: 0.8, change: -15),  // ~5.6 hrs/week
        AppUsage(name: "TikTok", hours: 0.9, change: 5),       // ~3.5 hrs/week
        AppUsage(name: "YouTube", hours: 1.2, change: -8)      // ~8.4 hrs/week
    ]
    
    // Mock data for today's usage
    let todayUsage: [TodayUsage] = [
        TodayUsage(name: "Instagram", hours: 0.3),
        TodayUsage(name: "TikTok", hours: 0.2),
        TodayUsage(name: "YouTube", hours: 0.4)
    ]
    
    var averageDailyHours: Double {
        mockUsage.reduce(0) { $0 + $1.hours }
    }
    
    var todayTotalHours: Double {
        todayUsage.reduce(0) { $0 + $1.hours }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Today's Usage Card
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Today's Usage")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(TimeFormatter.formatDuration(hours: todayTotalHours))
                            .font(.system(size: 34, weight: .bold))
                        
                        Text("So far today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Average Daily Usage Card
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Average Daily Usage")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(TimeFormatter.formatDuration(hours: averageDailyHours))
                            .font(.system(size: 34, weight: .bold))
                        
                        Text("Last 7 Days")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Weekly Summary Card
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("App Breakdown")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            Button(action: {
                                showingDailySummary = true
                            }) {
                                Text("Today")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        ForEach(mockUsage) { app in
                            UsageRowView(
                                appName: app.name,
                                hours: app.hours,
                                change: app.change
                            )
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    // Usage Chart
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily Average")
                            .font(.title2)
                            .bold()
                        
                        // Simple bar chart
                        VStack(spacing: 12) {
                            ForEach(mockUsage) { app in
                                VStack(spacing: 4) {
                                    HStack {
                                        Text(app.name)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(TimeFormatter.formatDuration(hours: app.hours))
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    GeometryReader { geometry in
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.blue.opacity(0.8))
                                            .frame(width: geometry.size.width * CGFloat(app.hours / 2.0))
                                    }
                                    .frame(height: 8)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .background(Color(.systemGroupedBackground))
            .sheet(isPresented: $showingDailySummary) {
                DailySummaryView(usage: mockUsage)
            }
        }
    }
}

struct DailySummaryView: View {
    let usage: [AppUsage]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Today's Summary")
                            .font(.title)
                            .bold()
                        
                        Text("You're on track with your daily average")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top)
                    
                    // Usage List
                    VStack(spacing: 16) {
                        ForEach(usage) { app in
                            UsageRowView(
                                appName: app.name,
                                hours: app.hours,
                                change: nil,
                                showChange: false
                            )
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                            .shadow(radius: 1)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Motivational Message
                    VStack(spacing: 12) {
                        Text("Keep up the good work! 🌟")
                            .font(.headline)
                        
                        Text("Your mindful app usage is helping you stay focused.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    DashboardView()
} 
