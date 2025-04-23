import Foundation
import Combine

@MainActor
class AppSelectionViewModel: ObservableObject {
    @Published var selectedApps: Set<String> = []
    private let selectedAppsKey = "SelectedAppNames"
    
    // Mock list of popular apps for testing
    let availableApps = [
        "Instagram",
        "TikTok",
        "YouTube",
        "Twitter",
        "Facebook",
        "Reddit",
        "Snapchat",
        "WhatsApp",
        "Messenger",
        "LinkedIn"
    ]

    func toggleApp(_ appName: String) {
        if selectedApps.contains(appName) {
            selectedApps.remove(appName)
        } else {
            selectedApps.insert(appName)
        }
        saveSelectedApps()
    }

    func saveSelectedApps() {
        UserDefaults.standard.set(Array(selectedApps), forKey: selectedAppsKey)
        print("Saved selected apps: \(selectedApps)")
    }

    func loadSelectedApps() {
        if let savedApps = UserDefaults.standard.array(forKey: selectedAppsKey) as? [String] {
            selectedApps = Set(savedApps)
            print("Loaded selected apps: \(selectedApps)")
        }
    }
}
