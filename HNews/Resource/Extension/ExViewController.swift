//
//  ExViewController.swift
//  HNews
//
//  Created by Edu on 02/02/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentVC(viewControllerIn: UIViewController, modalIn: UIModalPresentationStyle = .overCurrentContext, transition: UIModalTransitionStyle = .coverVertical) {
        viewControllerIn.modalPresentationStyle = modalIn
        viewControllerIn.modalTransitionStyle = transition
        self.present(viewControllerIn, animated: true, completion: nil)
    }
    
    func presentVCWithNav(viewControllerIn: UIViewController) {
        viewControllerIn.overrideUserInterfaceStyle = .light
        if self.navigationController != nil {
            self.navigationController?.pushViewController(viewControllerIn, animated: true)
        }else{
            let navController = UINavigationController()
            navController.addChild(viewControllerIn)
            navController.modalPresentationStyle = .overCurrentContext
            navController.modalTransitionStyle = .crossDissolve
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    func backViewController() {
        
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
            if(self.navigationController?.viewControllers.count == 1){
                self.dismiss(animated: true, completion: {})
            }
        }else{
            self.dismiss(animated: true, completion: {})
        }
    }
    
    func backViewToRootController() {
        
        if self.navigationController != nil {
            self.navigationController?.popToRootViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: {})
        }
    }
    
    func showLoading(colorIn: UIColor) {
        
        /*UIApplication.shared.windows.first?.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        let mLoadingView = NVActivityIndicatorView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 50, y: (UIScreen.main.bounds.height / 2) - 150, width: 100, height: 100), type: .ballClipRotatePulse, color: colorIn, padding: 0)
        mLoadingView.tag = 707
        mLoadingView.startAnimating()
        self.view.addSubview(mLoadingView)*/
    }
    
    func removeLoading() {
        
        UIApplication.shared.windows.first?.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        self.view.subviews.forEach { (viewIn) in
            if viewIn.tag == 707 {
                viewIn.removeFromSuperview()
            }
        }
    }
}

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
   }
}

extension UIApplication {
    var statusBarUIView: UIView? {
        
        if #available(iOS 13.0, *) {
            let tag = 3848245
            
            let keyWindow = UIApplication.shared.connectedScenes
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows.first
            
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999
                
                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }
            
        } else {
            
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}
