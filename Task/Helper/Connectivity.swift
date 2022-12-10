//
//  Connectivity.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
import Alamofire
class Connectivity {
    static let shared = Connectivity()
    let reachabilityManager: Alamofire.NetworkReachabilityManager!
    
    public class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    init() {

        reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    }
}
