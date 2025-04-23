//
//  KeeperUsageReport.swift
//  KeeperUsageReport
//
//  Created by Tanner Flake on 4/15/25.
//

import DeviceActivity
import SwiftUI

@main
struct KeeperUsageReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
