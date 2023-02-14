//
//  NetworkStatus.swift
//  Libreria Trantor
//
//  Created by Dani Durà on 14/2/23.
//

import SwiftUI
import Network

enum NetworkStatusEnum {
    case offline, online, unknown
}

final class NetworkStatus:ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label:"MonitorNetwork")
    
    @Published var status:NetworkStatusEnum = .unknown
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        monitor.start(queue: queue)
    }
}

