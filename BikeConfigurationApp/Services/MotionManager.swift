//
//  MotionManager.swift
//  Motion
//
//  Created by Simon Hopkin on 05/09/2024.
//

import Foundation
import CoreMotion

public typealias MotionManagerOrientationUpdatesCallback = (_ pitch: Double, _ roll: Double, _ yaw: Double) -> Void

public protocol MotionManagerProtocol {
    func startDeviceOrientationUpdates(callback: @escaping MotionManagerOrientationUpdatesCallback) throws
    func stopDeviceOrientationUpdates()
}

/// Wraps `CoreMotion` to provide access to three-dimensional device orientation updates
public struct MotionManager : MotionManagerProtocol {

    private(set) var motionManager: CMMotionManagerProtocol
    
    public init(motionManager: CMMotionManagerProtocol) {
        self.motionManager = motionManager
        self.motionManager.deviceMotionUpdateInterval = 0.1
    }
    
    /// Start providing three-dimensional device orientation updates
    public func startDeviceOrientationUpdates(callback: @escaping MotionManagerOrientationUpdatesCallback) throws {
        guard motionManager.isDeviceMotionAvailable else {
            throw MotionManagerError.deviceMotionNotAvailable
        }
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { motion, error in
            if let motion = motion {
                let roll = motion.attitude.roll * 180 / .pi
                let pitch = motion.attitude.pitch * 180 / .pi
                let yaw = motion.attitude.yaw * 180 / .pi
                callback(roll, pitch, yaw)
            }
        }
    }
    
    /// Stop providing three-dimensional device orientation updates
    public func stopDeviceOrientationUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }
}

public enum MotionManagerError : Error {
    case deviceMotionNotAvailable
}

public protocol CMMotionManagerProtocol {
    var isDeviceMotionAvailable: Bool { get }
    var deviceMotionUpdateInterval: TimeInterval { get set }
    
    func startDeviceMotionUpdates(to queue: OperationQueue, withHandler handler: @escaping CMDeviceMotionHandler)
    func stopDeviceMotionUpdates()
}

extension CMMotionManager : CMMotionManagerProtocol {}

