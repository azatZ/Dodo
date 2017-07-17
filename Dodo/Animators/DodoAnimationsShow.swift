import UIKit

/// Collection of animation effects use for showing the notification bar.
struct DodoAnimationsShow {
  /**
  
  Animation that fades the bar in.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func fade(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doFade(duration, showView: true, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar in/out vertically.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideVertically(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doSlideVertically(duration, showView: true, view: view,
      locationTop: locationTop,completed: completed)
  }
}
