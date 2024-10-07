//
//  DynamicSizeGeometry.swift
//  Inovel
//
//  Created by Gokhan Kaya on 27.07.2024.
//

import Foundation
import SwiftUI
extension GeometryProxy {
    /// Dynamic hight by device
    /// - Parameter height: Percent value
    /// - Returns: Calculated value for device height
    func dh(height : Double)  -> Double {
        return size.height * height
    }
    
    /// Dynamic width by device
    /// - Parameter width: Percent value
    /// - Returns: Calculated value for device width
    func dw(width : Double)  -> Double {
        return size.width * width
    }
}
