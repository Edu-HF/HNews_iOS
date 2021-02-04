//
//  ExUIColor.swift
//  HNews
//
//  Created by Edu on 02/02/21.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var baseNavBarColor: UIColor {
        return UIColor().fromHex(0x465471)
    }

    
    @nonobjc class var baseAppColor: UIColor {
        return UIColor().fromHex(0x2B2F3D)
    }
    
    @nonobjc class var baseMainMenuStatusBarColor: UIColor {
        
        if let colorHex = Bundle.main.infoDictionary?["APP_MENU_STATUS_COLOR"] as? String {
            if let mColor = UInt32(colorHex, radix: 16) {
                return UIColor().fromHex(mColor)
            }
        }
        
        return UIColor().fromHex(0xF15A24)
    }
    
   
    
    func fromHex(_ rgbValue:UInt32, alpha:Double=1.0) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
