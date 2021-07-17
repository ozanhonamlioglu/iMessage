//
//  UIDevice+Extensions.swift
//  Messages
//
//  Created by ozy on 16.07.2021.
//

import UIKit
import AudioToolbox

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
