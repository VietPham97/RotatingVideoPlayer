//
//  LandscapeViewController.swift
//  RotatingVideoPlayer
//
//  Created by Viet Pham on 2019-02-28.
//  Copyright © 2019 Viet Pham. All rights reserved.
//

import UIKit

class LandscapeViewController: UIViewController {
   
   var playerControllerView: PlayerControllerView!
   
   fileprivate let screenWidth = ScreenHelper.width
   fileprivate let screenHeight = ScreenHelper.height

   override func viewDidLoad() {
      super.viewDidLoad()
      addPlayerContainerView()
      addVideoPlayerController()
      prepareForVideoControllerViewAnimation()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
//      UIView.animate(withDuration: 0.3, animations: {
//
//         self.playerControllerView.transform = .identity
//         self.playerControllerView.avPlayerView.updateVideoLayerFrame()
//
//      })
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      UIView.animate(withDuration: 0.3, animations: {
         
         self.playerControllerView.transform = .identity
         self.playerControllerView.avPlayerView.updateVideoLayerFrame()
         
      })
   }
   
   fileprivate func prepareForVideoControllerViewAnimation() {
      var playerTransform = playerControllerView.transform
      // scale value
      let scaleT = CGAffineTransform(scaleX: 9/16, y: 9/16)
      playerTransform = playerTransform.concatenating(scaleT)
      // translate value - position
      let tempY = (screenHeight - screenWidth * 9/16) / 2
      let translateT = CGAffineTransform(translationX: 0, y: -tempY)
      playerTransform = playerTransform.concatenating(translateT)
      // rotate value - rotation
      let rotateT = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
      playerTransform = playerTransform.concatenating(rotateT)
      // assign the modified transform back to original
      playerControllerView.transform = playerTransform
   }
   
   fileprivate func addVideoPlayerController() {
      // pretent that device is landscapeRight
      playerControllerView.frame = CGRect(x: 0, y: 0, width: screenHeight, height: screenWidth)
      playerControllerView.translatesAutoresizingMaskIntoConstraints = false
      playerContainerView.addSubview(playerControllerView)
      
      NSLayoutConstraint.activate([
         playerControllerView.topAnchor.constraint(equalTo: view.topAnchor),
         playerControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         playerControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         playerControllerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
   }
   
   let playerContainerView: UIView = {
      let v = UIView()
      v.backgroundColor = .black
      v.translatesAutoresizingMaskIntoConstraints = false
      return v
   }()
   
   fileprivate func addPlayerContainerView() {
      view.addSubview(playerContainerView)
      NSLayoutConstraint.activate([
         playerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         playerContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         playerContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         playerContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      ])
   }
   
   override var prefersStatusBarHidden: Bool {
      return true
   }
   
   override var prefersHomeIndicatorAutoHidden: Bool {
      return true
   }
   
   // orientation
   override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
      return .landscapeRight
   }
   
   override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return .landscapeRight
   }
   
   override var shouldAutorotate: Bool {
      return true
   }
}
