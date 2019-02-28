//
//  VideoPlayerController.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-13.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

class VideoPlayerController: UIViewController {

   @IBOutlet weak var playerContainerView: UIView!
   @IBOutlet weak var backNavButton: UIButton! {
      didSet {
         backNavButton.addTarget(self, action: #selector(backToPrevScreen), for: .touchUpInside)
      }
   }
   
   fileprivate var playerControllerView: PlayerControllerView!
   
   override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      addBlackBackgroundStatusBar()
      loadVideoPlayerController()
   }

   fileprivate func addBlackBackgroundStatusBar() {
      let blackView = UIView()
      blackView.backgroundColor = .black
      blackView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(blackView)
      
      NSLayoutConstraint.activate([
         blackView.topAnchor.constraint(equalTo: view.topAnchor),
         blackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         blackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         blackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
      ])
   }
   
   override func viewWillAppear(_ animated: Bool) {
      navigationController?.setNavigationBarHidden(true, animated: false)
   }
   
   @objc fileprivate func backToPrevScreen(_ button: UIButton) {
      playerControllerView.removeFromSuperview()
      navigationController?.setNavigationBarHidden(false, animated: false)
      navigationController?.popViewController(animated: true)
   }
   
   fileprivate func loadVideoPlayerController() {
      guard let tempPlayerControllerView = Bundle.main.loadNibNamed("PlayerControllerView", owner: self, options: nil)?.first as? PlayerControllerView
         else {
            print("Could not load `PlayerControllerView` from Bundle")
            return
      }
      
      playerControllerView = tempPlayerControllerView
      addVideoPlayerController()
      playerControllerView.fullscreenDelegate = self
      playerControllerView.loadVideo()
   }

   fileprivate func addVideoPlayerController() {
      // Small Video Display
      let screenWidth = ScreenHelper.width
      let videoHeight = screenWidth * (9 / 16)
      playerControllerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: videoHeight)
      playerControllerView.translatesAutoresizingMaskIntoConstraints = false
      playerContainerView.addSubview(playerControllerView)
      
      NSLayoutConstraint.activate([
         playerControllerView.topAnchor.constraint(equalTo: playerContainerView.topAnchor),
         playerControllerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor),
         playerControllerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor),
         playerControllerView.bottomAnchor.constraint(equalTo: playerContainerView.bottomAnchor),
      ])
   }
   
   fileprivate func rotateVideoToSmallscreen() {
      // 1 pretend lanscape full screen
      let screenWidth = ScreenHelper.width
      let screenHeight = ScreenHelper.height
      
      var transform = self.playerControllerView.transform
      let scaleT = CGAffineTransform(scaleX: 16/9, y: 16/9)
      transform = transform.concatenating(scaleT)
      let tempY = (screenHeight - screenWidth * 9 / 16) / 2
      let translateT = CGAffineTransform(translationX: tempY, y: 0)
      transform = transform.concatenating(translateT)
      let rotateT = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
      self.playerControllerView.transform = transform.concatenating(rotateT)
      
      // 2 back to small screen
      UIView.animate(withDuration: 0.3, animations: {
         
         self.playerControllerView.transform = .identity
         self.playerControllerView.avPlayerView.updateVideoLayerFrame()
         
      })
   }
}

extension VideoPlayerController: VideoFullscreenDelegate {
   func prepareForFullscreen() {
//      print("Controller: prepareForFullscreen")
      let fullscreenViewController = LandscapeViewController()
      fullscreenViewController.playerControllerView = self.playerControllerView
      _ = fullscreenViewController.view
      present(fullscreenViewController, animated: false)
   }
   
   func prepareForSmallscreen() {
//      print("Controller: prepareForSmallscreen")
      dismiss(animated: false) {
         self.addVideoPlayerController()
         self.rotateVideoToSmallscreen()
      }
   }
}
