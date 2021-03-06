import UIKit

class DodoToolbar: UIView {
  var layoutGuide: UILayoutSupport?
  var style: DodoStyle
  private var didCallHide = false
  
  convenience init(witStyle style: DodoStyle) {
    self.init(frame: CGRect())
    
    self.style = style
  }
  
  override init(frame: CGRect) {
    style = DodoStyle()
    
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    func show(inSuperview parentView: UIView, withMessage message: String, completion: DodoAnimationCompleted? = nil) {
      
    if superview != nil { return } // already being shown
  
    parentView.addSubview(self)
    applyStyle()
    layoutBarInSuperview()
    
    createLabel(message)
    
    style.bar.animationShow(self, style.bar.animationShowDuration, style.bar.locationTop,  {})
  }
  
  func hide(_ onAnimationCompleted: @escaping ()->()) {
    // Respond only to the first hide() call
    if didCallHide { return }
    didCallHide = true
    
    style.bar.animationHide(self, style.bar.animationHideDuration,
                            style.bar.locationTop, { [weak self] in
        
      self?.removeFromSuperview()
      onAnimationCompleted()
    })
  }
    
  // MARK: - Label
  
  private func createLabel(_ message: String) {
    let label = UILabel()
    
    label.font = style.label.font
    label.text = message
    label.textColor = style.label.color
    label.textAlignment = NSTextAlignment.center
    label.numberOfLines = style.label.numberOfLines
    
    if style.bar.debugMode {
      label.backgroundColor = UIColor.red
    }
    
    if let shadowColor = style.label.shadowColor {
      label.shadowColor = shadowColor
      label.shadowOffset = style.label.shadowOffset
    }
    
    addSubview(label)
    layoutLabel(label)
  }
  
  private func layoutLabel(_ label: UILabel) {
    label.translatesAutoresizingMaskIntoConstraints = false
    
    // Stretch the label vertically
    TegAutolayoutConstraints.fillParent(label, parentView: self,
      margin: style.label.horizontalMargin, vertically: true)
    
      if let superview = superview {
        // If there are no buttons - stretch the label to the entire width of the view
        TegAutolayoutConstraints.fillParent(label, parentView: superview,
          margin: style.label.horizontalMargin, vertically: false)
      }

  }
  
  // MARK: - Style the bar
  
  private func applyStyle() {
    backgroundColor = style.bar.backgroundColor
    layer.cornerRadius = style.bar.cornerRadius
    layer.masksToBounds = true
    
    if let borderColor = style.bar.borderColor , style.bar.borderWidth > 0 {
      layer.borderColor = borderColor.cgColor
      layer.borderWidth = style.bar.borderWidth
    }
  }
  
  private func layoutBarInSuperview() {
    translatesAutoresizingMaskIntoConstraints = false
    
    if let superview = superview {
      // Stretch the toobar horizontally to the width if its superview
      TegAutolayoutConstraints.fillParent(self, parentView: superview,
        margin: style.bar.marginToSuperview.width, vertically: false)
      
      let vMargin = style.bar.marginToSuperview.height
      let verticalMargin = style.bar.locationTop ? -vMargin : vMargin
      
      
      if let layoutGuide = layoutGuide {
        
        // Align the top/bottom edge of the toolbar with the top/bottom layout guide
        // (a tab bar, for example)
       _ = TegAutolayoutConstraints.alignVerticallyToLayoutGuide(self,
          onTop: style.bar.locationTop,
          layoutGuide: layoutGuide,
          constraintContainer: superview,
          margin: verticalMargin)
        
      } else {
        
        // Align the top/bottom of the toolbar with the top/bottom of its superview
        _ = TegAutolayoutConstraints.alignSameAttributes(superview, toItem: self,
          constraintContainer: superview,
          attribute: style.bar.locationTop ? NSLayoutAttribute.top : NSLayoutAttribute.bottom,
          margin: verticalMargin)
      }
        
        
    }
  }
}
