//
//  CoroutinesUtils.swift
//  swiftui_app
//
//  Created by Mercedes Franchesca Gonzalez Cejas on 3/10/23.
//

import Foundation

class CoroutinesUtils {
    
    let main = DispatchQueue.main
    let bg = DispatchQueue.global(qos: .background)
    
    func exec(queue: DispatchQueue, work: @escaping () async -> Void) {
        queue.async {
            Task {
                await work()
            }
        }
    }
    
    func runMain(work: @escaping () async -> Void) {
        exec(queue: main, work: work)
    }
    
    func runBG(work: @escaping () async -> Void) {
        exec(queue: bg, work: work)
    }
}
