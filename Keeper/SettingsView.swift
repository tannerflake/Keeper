import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationFrequency") private var notificationFrequency = "weekly"
    @State private var selectedTime = Date()
    @AppStorage("notificationTimeString") private var notificationTimeString = "20:00"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Picker("Summary Frequency", selection: $notificationFrequency) {
                        Text("Daily").tag("daily")
                        Text("Weekly").tag("weekly")
                    }
                    
                    DatePicker("Notification Time",
                             selection: $selectedTime,
                             displayedComponents: .hourAndMinute)
                        .onChange(of: selectedTime) { newValue in
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm"
                            notificationTimeString = formatter.string(from: newValue)
                        }
                        .onAppear {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "HH:mm"
                            if let date = formatter.date(from: notificationTimeString) {
                                selectedTime = date
                            }
                        }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Link("Privacy Policy",
                         destination: URL(string: "https://example.com/privacy")!)
                    
                    Link("Terms of Service",
                         destination: URL(string: "https://example.com/terms")!)
                }
                
                Section(header: Text("Support")) {
                    Button("Contact Support") {
                        // Add support action
                    }
                    
                    Button("Send Feedback") {
                        // Add feedback action
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
} 