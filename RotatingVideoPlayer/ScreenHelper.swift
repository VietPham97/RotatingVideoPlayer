//
//  ScreenHelper.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-28.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

class ScreenHelper: NSObject {
   class var width: CGFloat {
      return UIScreen.main.bounds.size.width
   }
   
   class var height: CGFloat {
      return UIScreen.main.bounds.size.height
   }
}
