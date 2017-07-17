import UIKit

/// Collection of animation effects use for hiding the notification bar.
struct DodoAnimationsHide {
  /**
  
  Animation that fades the bar out.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func fade(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
    DodoAnimations.doFade(duration, showView: false, view: view, completed: completed)
  }
  
  /**
  
  Animation that slides the bar vertically out of view.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.
  
  */
  static func slideVertically(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: @escaping DodoAnimationCompleted) {
      
      DodoAnimations.doSlideVertically(duration, showView: false, view: view,
        locationTop: locationTop, completed: completed)
  }
}
