//
//  CustomTextField.swift
//  100day's Project
//
//  Created by 이호찬 on 14/01/2019.
//  Copyright © 2019 EverydayPJ. All rights reserved.
//

import UIKit

protocol TextFieldisMaxDelegate {
    func delegate(_ isMax: Bool)
}

class CustomTextField: CustomTextFieldEffects {
    
    var activeColor: UIColor? {
        didSet {
            updateBorder()
        }
    }
    
    private let defaultColor = UIColor(red: 7/255, green: 170/255, blue: 135/255, alpha: 1)
    private let warningColor = UIColor(red: 254/255, green: 121/255, blue: 121/255, alpha: 1)
    private var inactiveColor: UIColor? = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    
    private var warningPlaceholder = "over maximum characters"
    var maxCount = 5
    var isMaxDelegate: TextFieldisMaxDelegate?
    public private(set) var isMaxCharater = false {
        didSet {
            isMaxDelegate?.delegate(isMaxCharater)
        }
    }

    
    private var secondPlaceholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            //            updateBorder()
            updatePlaceholder()
        }
    }
    
    private let textFieldInsets = CGPoint(x: 6, y: 0)
    private let borderLayer = CALayer()
    
    // MARK: - TextFieldEffects
    
    override open func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: .zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        
        placeholderLabel.frame = frame.insetBy(dx: 0, dy: 0)
        placeholderLabel.font = placeholderFontFromFont(font!)
        
        activeColor = defaultColor
        secondPlaceholder = "max \(maxCount) characters"
        //        updateBorder()
        updatePlaceholder()
        
        layer.addSublayer(borderLayer)
        addSubview(placeholderLabel)
        addSubview(placeholderImageView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: self)
        
    }
    
    @objc open func textFieldDidChange() {
        if let count = text?.count {
            if count > maxCount {
                isMaxCharater = true
                activeColor = warningColor
                placeholderLabel.text = warningPlaceholder
                placeholderLabel.textColor = activeColor
                placeholderImageView.image = #imageLiteral(resourceName: "xred")
            } else {
                isMaxCharater = false
                activeColor = defaultColor
                placeholderLabel.text = secondPlaceholder
                placeholderLabel.textColor = activeColor
                if count == 0 {
                    placeholderImageView.image = nil
                } else {
                    placeholderImageView.image = #imageLiteral(resourceName: "o")
                }
            }
            print(isMaxCharater)
        }
    }
    
    override open func animateViewsForTextEntry() {
        updateBorder()
        if let activeColor = activeColor {
            performPlaceholderAnimationWithColor(activeColor)
        }
    }
    
    override open func animateViewsForTextDisplay() {
        updateBorder()
        if let inactiveColor = inactiveColor {
            performPlaceholderAnimationWithColor(inactiveColor)
        }
    }
    
    // MARK: - Private
    
    private func updateBorder() {
        //        placeholderLabel.text = isFirstResponder ? placeholder : nil
        placeholderLabel.isHidden = isFirstResponder ? false : true
        print(placeholderLabel.isHidden)
        
        borderLayer.frame = rectForBorder(frame)
        borderLayer.backgroundColor = isFirstResponder ? activeColor?.cgColor : inactiveColor?.cgColor
        
        //        print(placeholderLabel.text)
        
    }
    
    private func updatePlaceholder() {
        
        placeholderLabel.text = secondPlaceholder
        placeholderLabel.textColor = inactiveColor
        placeholderLabel.sizeToFit()
        inputImageView()
        layoutPlaceholderInTextRect()
        
        if isFirstResponder {
            animateViewsForTextEntry()
        }
    }
    
    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
        let fontSize = font.pointSize - 2
        let smallerFont = UIFont(name: font.fontName, size: fontSize)
        return smallerFont
    }
    
    private func rectForBorder(_ bounds: CGRect) -> CGRect {
        var newRect:CGRect
        newRect = CGRect(x: 5, y: bounds.size.height - font!.lineHeight + textFieldInsets.y, width: bounds.size.width, height: 1)
        
        return newRect
    }
    
    private func layoutPlaceholderInTextRect() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        switch textAlignment {
        case .center:
            originX += textRect.size.width/2 - placeholderLabel.bounds.width/2
        case .right:
            originX += textRect.size.width - placeholderLabel.bounds.width
        default:
            break
        }
        
        placeholderLabel.frame = CGRect(x: originX, y: bounds.height - placeholderLabel.frame.height,
                                        width: textRect.size.width, height: placeholderLabel.frame.size.height)
    }
    
    private func inputImageView() {
        placeholderImageView.frame = CGRect(x: bounds.size.width - 20, y: 5, width: 24, height: 24)
    }
    
    private func performPlaceholderAnimationWithColor(_ color: UIColor) {
        let yOffset: CGFloat = 4
        
        UIView.animate(withDuration: 0.15, animations: {
            self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            //            self.placeholderLabel.alpha = 0
        }) { _ in
            self.placeholderLabel.transform = .identity
            self.placeholderLabel.transform = CGAffineTransform(translationX: 0, y: yOffset)
            
            UIView.animate(withDuration: 0.15, animations: {
                self.placeholderLabel.textColor = color
                self.placeholderLabel.transform = .identity
                self.placeholderLabel.alpha = 1
            }) { _ in
                self.animationCompletionHandler?(self.isFirstResponder ? .textEntry : .textDisplay)
            }
        }
    }
    
    // MARK: - Overrides
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = CGRect(x: 0, y: 0, width: bounds.size.width - 20, height: bounds.size.height - font!.lineHeight + textFieldInsets.y)
        return newBounds.insetBy(dx: textFieldInsets.x, dy: 0)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let newBounds = CGRect(x: 0, y: 0, width: bounds.size.width - 20, height: bounds.size.height - font!.lineHeight + textFieldInsets.y)
        
        return newBounds.insetBy(dx: textFieldInsets.x, dy: 0)
    }
    
}


open class CustomTextFieldEffects: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    /**
     The type of animation a TextFieldEffect can perform.
     
     - TextEntry: animation that takes effect when the textfield has focus.
     - TextDisplay: animation that takes effect when the textfield loses focus.
     */
    public enum AnimationType: Int {
        case textEntry
        case textDisplay
    }
    
    /**
     Closure executed when an animation has been completed.
     */
    public typealias AnimationCompletionHandler = (_ type: AnimationType)->()
    
    /**
     UILabel that holds all the placeholder information
     */
    public let placeholderLabel = UILabel()
    
    public let placeholderImageView = UIImageView()

    
    
    /**
     Creates all the animations that are used to leave the textfield in the "entering text" state.
     */
    open func animateViewsForTextEntry() {
        fatalError("\(#function) must be overridden")
    }
    
    /**
     Creates all the animations that are used to leave the textfield in the "display input text" state.
     */
    open func animateViewsForTextDisplay() {
        fatalError("\(#function) must be overridden")
    }
    
    /**
     The animation completion handler is the best place to be notified when the text field animation has ended.
     */
    open var animationCompletionHandler: AnimationCompletionHandler?
    
    /**
     Draws the receiver’s image within the passed-in rectangle.
     
     - parameter rect:    The portion of the view’s bounds that needs to be updated.
     */
    open func drawViewsForRect(_ rect: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    open func updateViewsForBoundsChange(_ bounds: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    // MARK: - Overrides
    
    override open func draw(_ rect: CGRect) {
        // FIXME: Short-circuit if the view is currently selected. iOS 11 introduced
        // a setNeedsDisplay when you focus on a textfield, calling this method again
        // and messing up some of the effects due to the logic contained inside these
        // methods.
        // This is just a "quick fix", something better needs to come along.
        guard isFirstResponder == false else { return }
        drawViewsForRect(rect)
    }
    
    override open var text: String? {
        didSet {
            if let text = text, !text.isEmpty || isFirstResponder {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
    
    // MARK: - UITextField Observing
    
    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
            
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    /**
     The textfield has started an editing session.
     */
    @objc open func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }
    
    /**
     The textfield has ended an editing session.
     */
    @objc open func textFieldDidEndEditing() {
        animateViewsForTextDisplay()
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
    
}
