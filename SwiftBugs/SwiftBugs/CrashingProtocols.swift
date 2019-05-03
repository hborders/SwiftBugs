//
//  CrashingProtocols.swift
//  SwiftBugs
//
//  Created by Heath Borders on 5/2/19.
//  Copyright © 2019 Heath Borders. All rights reserved.
//

import Foundation

protocol P1: class {
    associatedtype P1P1: P1
    associatedtype P1P2: P2
    associatedtype P1P3: P3
    associatedtype P1AnyP4: AnyP4<P1P1, P1P2>
    
    var anyP4: P1AnyP4? { get set }
    
    func p2(_ p2: P1P2)
    func p3(_ p3: P1P3)
}

protocol P2 {
    associatedtype P2P2: P2
    associatedtype P2P3: P3
    
    var p2p2: P2P2? { get }
    var p2s1: String { get }
    var p2e2: String? { get }
    var p2p3: P2P3 { get }
}

protocol P3 {
    var p3s1: String { get }
}

protocol P4 {
    associatedtype P4P1: P1
    associatedtype P4P2: P2
    
    func p1(_ p1: P4P1,
            p2s: [P4P2])
}

final class AnyP4<
    AP4P1: P1,
    AP4P2: P2
>: P4 {
    typealias P4P1 = AP4P1
    typealias P4P2 = AP4P2
    
    private let p1p2s: (AP4P1, [AP4P2]) -> Void
    init<AP4P4: P4>(_ ap4p4: AP4P4)
        where
        AP4P4.P4P1 == AP4P1,
        AP4P4.P4P2 == AP4P2 {
            p1p2s = {
                ap4p4.p1($0, p2s: $1)
            }
    }
    
    func p1(_ p1: P4P1,
            p2s: [P4P2]) {
        p1p2s(p1, p2s)
    }
}
