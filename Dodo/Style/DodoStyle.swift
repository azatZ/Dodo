import UIKit

/// Combines various styles for the toolbar element.
public class DodoStyle {
  
  /// The parent style is used to get the property value if the object is missing one.
  var parent: DodoStyle? {
    didSet {
      changeParent()
    }
  }
  
  init(parentStyle: DodoStyle? = nil) {
    self.parent = parentStyle
  }
  
  private func changeParent() {
    bar.parent = parent?.bar
    label.parent = parent?.label
  }
  
  /**
  
  Reverts all the default styles to their initial values. Usually used in setUp() function in the unit tests.
  
  */
  public static func resetDefaultStyles() {
    DodoBarDefaultStyles.resetToDefaults()
    DodoLabelDefaultStyles.resetToDefaults()
  }
  
  
  /// Clears the styles for all properties for this style object. The styles will be taken from parent and default properties.
  public func clear() {
    bar.clear()
    label.clear()
  }
  
  /**

  Styles for the bar view.

  */
  public lazy var bar: DodoBarStyle = self.initBarStyle()
  
  private func initBarStyle() -> DodoBarStyle {
    return DodoBarStyle(parentStyle: parent?.bar)
  }
  

  /**

  Styles for the text label.

  */
  public lazy var label: DodoLabelStyle = self.initLabelStyle()
  
  private func initLabelStyle() -> DodoLabelStyle {
    return DodoLabelStyle(parentStyle: parent?.label)
  }
  
}
