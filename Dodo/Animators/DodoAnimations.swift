import UIKit

/// Collection of animation effects use for showing and hiding the notification bar.
public enum DodoAnimations: String {
  /// Used for showing notification without animation.
  case noAnimation = "No animation"
  
  /// Animation that slides the bar in/out vertically.
  case slideVertically = "Slide vertically"
  
  /**
  
  Get animation function that can be used for showing notification bar.
  
  - returns: Animation function.
  
  */
  public var show: DodoAnimation {
    switch self {
      
    case .noAnimation:
      return DodoAnimations.doNoAnimation
      
    case .slideVertically:
      return DodoAnimationsShow.slideVertically
    }
  }
  
  /**
  
  Get animation function that can be used for hiding notification bar.
  
  - returns: Animation function.
  
  */
  public var hide: DodoAnimation {
    switch self {
    case .noAnimation:
      return DodoAnimations.doNoAnimation
      
    case .slideVertically:
      return DodoAnimationsHide.slideVertically
    }
  }
  
  /**

  A empty animator which is used when no animation is supplied.
  It simply calls the completion closure.
  
  - parameter view: View supplied for animation.
  - parameter completed: A closure to be called after animation completes.

  */
  static func doNoAnimation(_ view: UIView, duration: TimeInterval?, locationTop: Bool,
    completed: DodoAnimationCompleted) {
      
    completed()
  }
  
  /// Helper function for fading the view in and out.
  static func doFade(_ duration: TimeInterval?, showView: Bool, view: UIView,
    completed: @escaping DodoAnimationCompleted) {
      
    let actualDuration = duration ?? 0.5
    let startAlpha: CGFloat = showView ? 0 : 1
    let endAlpha: CGFloat = showView ? 1 : 0

    view.alpha = startAlpha
    
    UIView.animate(withDuration: actualDuration,
      animations: {
        view.alpha = endAlpha
      },
      completion: { finished in
        completed()
      }
    )
  }
  
  /// Helper function for sliding the view vertically
  static func doSlideVertically(_ duration: TimeInterval?, showView: Bool, view: UIView,
    locationTop: Bool, completed: @escaping DodoAnimationCompleted) {
    
    let actualDuration = duration ?? 0.5
    view.layoutIfNeeded()
    
    var distance: CGFloat = 0
      
    if locationTop {
      distance = view.frame.height + view.frame.origin.y
    } else {
      distance = UIScreen.main.bounds.height - view.frame.origin.y
    }
            
    let transform = CGAffineTransform(translationX: 0, y: locationTop ? -distance : distance)
      
    let start: CGAffineTransform = showView ? transform : CGAffineTransform.identity
    let end: CGAffineTransform = showView ? CGAffineTransform.identity : transform
    
    view.transform = start
    
    UIView.animate(withDuration: actualDuration,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: [],
      animations: {
        view.transform = end
      },
      completion: { finished in
        completed()
      }
    )
  }
  
}
