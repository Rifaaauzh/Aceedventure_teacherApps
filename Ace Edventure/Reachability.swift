//
//  Reachability.swift
//  Ace Edventure
//
//  Created by Rifa Fauziah on 31/05/2024.
//

import Foundation
import Network

func checkInternetConnection(completion: @escaping (Bool) -> Void) {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            completion(true)
        } else {
            completion(false)
        }
        monitor.cancel()
    }
    
    monitor.start(queue: queue)
}
