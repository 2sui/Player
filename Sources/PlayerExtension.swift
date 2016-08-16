//
//  PlayerExtension.swift
//  VideoPlayer
//

import UIKit


// MARK: - 

// MARK: Player extension

extension Player {
    
    /**
     Add player layer to toView.
     
     - parameter toView: View that player layer will be add to.
     */
    public func addLayerToView(toView: UIView?) {
        self.view.removeFromSuperview()
        
        if nil != toView {
            toView!.addSubview(self.view)
        }
    }
    
    /**
     Add player controller to viewController and player layer to toView. (toView must be viewController`s view or one of its subview)
     
     - parameter viewController: View Controller that player controller will be add to.
     - parameter toView:         View that player layer will be add to.
     */
    public func addToViewController(viewController: UIViewController?, toView: UIView?) {
        self.willMoveToParentViewController(nil)
        addLayerToView(nil)
        self.removeFromParentViewController()
        
        if nil != viewController && (nil != toView || nil != viewController!.view) {
            let dstView = toView ?? viewController!.view!
            
            // make surce toView is subview of viewController`s view
            guard dstView == viewController!.view || viewController!.view.subviews.contains(dstView) else {
                return
            }
            
            viewController!.addChildViewController(self)
            self.view.frame = dstView.bounds
            self.addLayerToView(dstView)
            self.didMoveToParentViewController(viewController!)
        }
    }
}
