//
//  PlayerControllerView.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-28.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit
import AVKit

protocol VideoFullscreenDelegate: class {
   func prepareForFullscreen()
   func prepareForSmallscreen()
}

class PlayerControllerView: UIView {
   
   weak var fullscreenDelegate: VideoFullscreenDelegate?
   
   fileprivate var isFullscreen = false
   fileprivate var isPlaying = false
   fileprivate var player: AVPlayer?

   @IBOutlet weak var playbackControlView: UIView!
   @IBOutlet weak var avPlayerView: AVPlayerView!
   @IBOutlet weak var playPauseButton: UIButton! {
      didSet {
         playPauseButton.addTarget(self, action: #selector(didPressPlayPause), for: .touchUpInside)
      }
   }
   @IBOutlet weak var sizeToggleButton: UIButton! {
      didSet {
         sizeToggleButton.addTarget(self, action: #selector(didPressSizeToggle), for: .touchUpInside)
      }
   }
   
   @objc fileprivate func didPressPlayPause(_ button: UIButton) {
      if isPlaying {
         pauseVideo()
      } else {
         playVideo()
      }
   }
   
   fileprivate func cancelDelayHidePlaybackControl() {
      NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hidePlaybackControl), object: nil)
   }
   
   fileprivate func delayHidePlaybackControl(after timeInterval: TimeInterval) {
      perform(#selector(hidePlaybackControl), with: nil, afterDelay: timeInterval)
   }
   
   @objc fileprivate func hidePlaybackControl() {
      UIView.animate(withDuration: 0.3) {
         self.playbackControlView.alpha = 0
      }
   }
   
   fileprivate func showPlaybackControl() {
      playbackControlView.alpha = 1
   }
   
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//      print("touchOnScreenEnded")
      showPlaybackControl()
      delayHidePlaybackControl(after: 3)
   }
   
   func loadVideo() {
      guard let videoPath = Bundle.main.path(forResource: "httyd3", ofType: "mp4")
         else {
            print("Could not load `httyd3.mp4` video")
            return
      }
      
      let videoUrl = URL(fileURLWithPath: videoPath)
      let avAsset = AVURLAsset(url: videoUrl)
      let keys = [ "duration" ]
      
      avAsset.loadValuesAsynchronously(forKeys: keys) { [weak self] in
         self?.didFinishLoading(videoAsset: avAsset)
      }
   }
   
   fileprivate func didFinishLoading(videoAsset: AVURLAsset) {
      // prepare for playing video
      DispatchQueue.main.async { [unowned self] in
         let playerItem = AVPlayerItem(asset: videoAsset)
         playerItem.addObserver(self, forKeyPath: "status", options: .new, context: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(self.playerItemDidPlayToEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
         
         self.player = AVPlayer(playerItem: playerItem)
         self.player?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
         self.avPlayerView.setPlayer(self.player)
      }
   }
   
   override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
      guard let currentItem = self.player?.currentItem else { return }
      
      if object as? AVPlayerItem == currentItem && keyPath == "status" {
         
         if currentItem.status == .failed {
            print("Status: Failed")
         } else if currentItem.status == .readyToPlay {
            print("Status: ReadyToPlay")
            self.playVideo()
         }
         
      }
   }
   
   fileprivate func playVideo() {
      isPlaying = true
      player?.play()
      // switch to pause
      playPauseButton.setImage(#imageLiteral(resourceName: "icon_pause_white"), for: .normal)
      // delay hiding playback control
      delayHidePlaybackControl(after: 3)
   }
   
   fileprivate func pauseVideo() {
      isPlaying = false
      player?.pause()
      // switch to play
      playPauseButton.setImage(#imageLiteral(resourceName: "icon_play_white"), for: .normal)
      // cancel delay hiding playback control
      cancelDelayHidePlaybackControl()
   }
   
   func removePlayer() {
      // remove all observers
      player?.currentItem?.removeObserver(self, forKeyPath: "status")
      NotificationCenter.default.removeObserver(self)
      
      // stop the player
      player?.pause()
      player = nil
   }
   
   @objc fileprivate func playerItemDidPlayToEnd() {
      print("Video Playing has ended")
   }
   
   @objc fileprivate func didPressSizeToggle(_ button: UIButton) {
      if isFullscreen {
         fullscreenDelegate?.prepareForSmallscreen()
      } else {
         fullscreenDelegate?.prepareForFullscreen()
      }
      isFullscreen = !isFullscreen
   }
   

}
