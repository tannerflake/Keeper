import SwiftUI

struct UsageRowView: View {
    let appName: String
    let hours: Double
    let change: Double?
    let showChange: Bool
    
    init(appName: String, hours: Double, change: Double? = nil, showChange: Bool = true) {
        self.appName = appName
        self.hours = hours
        self.change = change
        self.showChange = showChange
    }
    
    var body: some View {
        HStack {
            // App Icon
            Image(systemName: "app.fill")
                .foregroundColor(.blue)
                .font(.title2)
                .frame(width: 30)
            
            // App Name
            Text(appName)
                .font(.body)
            
            Spacer()
            
            // Usage Time
            Text(TimeFormatter.formatDuration(hours: hours))
                .font(.body)
                .bold()
            
            // Change Percentage (if available)
            if showChange, let change = change {
                Text(String(format: "(%+.0f%%)", change))
                    .font(.subheadline)
                    .foregroundColor(change < 0 ? .green : .red)
                    .frame(width: 60, alignment: .trailing)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    VStack {
        UsageRowView(appName: "Instagram", hours: 2.5, change: -15)
        UsageRowView(appName: "TikTok", hours: 0.8, change: 5)
        UsageRowView(appName: "YouTube", hours: 0.3, change: -8)
    }
    .padding()
} 