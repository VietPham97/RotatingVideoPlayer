//
//  PortraitNavController.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-13.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

class PortraitNavController: UINavigationController {

   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
   
   override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
      return .portrait
   }
   
   override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return .portrait
   }
   
   override var shouldAutorotate: Bool {
      return true
   }

}
