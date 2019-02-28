//
//  PlayerControllerView.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-28.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

protocol VideoFullscreenDelegate: class {
   func prepareForFullscreen()
   func prepareForSmallscreen()
}

class PlayerControllerView: UIView {
   
   weak var fullscreenDelegate: VideoFullscreenDelegate?
   
   fileprivate var isFullscreen = false

   @IBOutlet weak var avPlayerView: AVPlayerView!
   @IBOutlet weak var sizeToggleButton: UIButton! {
      didSet {
         sizeToggleButton.addTarget(self, action: #selector(didPressSizeToggle), for: .touchUpInside)
      }
   }
   
   @objc fileprivate func didPressSizeToggle(_ button: UIButton) {
      print("Toggle Press")
   }
   

}
