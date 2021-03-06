//
//  PictureHelpers.swift
//  Rewatch
//
//  Created by Romain Pouclet on 2015-11-02.
//  Copyright © 2015 Perfectly-Cooked. All rights reserved.
//

import UIKit


func convertToBlackAndWhite(image: UIImage) -> UIImage {
    let colorSpace = CGColorSpaceCreateDeviceGray()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue).rawValue
    let width = Int(image.size.width)
    let height = Int(image.size.height)
    
    let context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, bitmapInfo)
    CGContextDrawImage(context, CGRect(origin: CGPointZero, size: image.size), image.CGImage)
    let ref = CGBitmapContextCreateImage(context)
    
    if let ref = CGImageCreateCopy(ref) {
        return UIImage(CGImage: ref)
    }

    return image
}
