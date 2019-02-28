//
//  UILabel+Extension.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-28.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

extension UILabel {
   func displayTime(fromSeconds totalSeconds: Int) {
      let timeFormat = "%02d"
      let minutes = totalSeconds / 60
      let minutesString = String(format: timeFormat, minutes)
      let seconds = totalSeconds % 60
      let secondsString = String(format: timeFormat, seconds)
      
      text = "\(minutesString):\(secondsString)"
   }
}
