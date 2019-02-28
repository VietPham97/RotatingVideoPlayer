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
      addVideoPlayerController()
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

   fileprivate func addVideoPlayerController() {
      guard let tempPlayerControllerView = Bundle.main.loadNibNamed("PlayerControllerView", owner: self, options: nil)?.first as? PlayerControllerView
         else {
            print("Could not load `PlayerControllerView` from Bundle")
            return
      }
      
      playerControllerView = tempPlayerControllerView
      playerControllerView.fullscreenDelegate = self
      
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
      
      playerControllerView.loadVideo()
   }
   

}

extension VideoPlayerController: VideoFullscreenDelegate {
   func prepareForFullscreen() {
      print("Controller: prepareForFullscreen")
   }
   
   func prepareForSmallscreen() {
      print("Controller: prepareForSmallscreen")
   }
}
