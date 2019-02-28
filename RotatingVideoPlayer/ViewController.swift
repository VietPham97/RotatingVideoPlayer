//
//  ViewController.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-13.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }

   @IBAction func didPressOpenVideoPlayer(_ sender: UIButton) {
//      print("openVideoPlayer")
      let videoPlayerController = VideoPlayerController.init(nibName: "VideoPlayerController", bundle: nil)
      present(videoPlayerController, animated: true)
   }
   
   // orientation
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
