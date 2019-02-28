//
//  AVPlayerView.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-28.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit
import AVKit

class AVPlayerView: UIView {

   // the layer to display video
   fileprivate var videoLayer: AVPlayerLayer!
   
   // the player to control video
   fileprivate var player: AVPlayer? {
      didSet {
         videoLayer = AVPlayerLayer(player: self.player)
         videoLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
         layer.addSublayer(videoLayer)
      }
   }
   
   func setPlayer(_ player: AVPlayer?) {
      self.player = player
   }
   
   func updateVideoLayerFrame() {
      guard videoLayer != nil else {
         print("videoLayer is nil")
         return
      }
      print("videoLayer is set")
      videoLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      updateVideoLayerFrame()
   }

}
