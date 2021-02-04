//
//  BaseViewController.swift
//  HNews
//
//  Created by Edu on 02/02/21.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: Vars
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        self.view.backgroundColor = .baseAppColor
    }
    
    //MARK: Public Methods
    func setupNavBar(titleIn: String, withBackBtn: Bool = false, colorBGIn: UIColor = .baseNavBarColor, titleColorIn: UIColor = .black) {
        self.navigationController?.navigationBar.isHidden = false
        self.setStatusBarColor(colorIn: colorBGIn)
        self.navigationItem.title = titleIn
        self.navigationController?.navigationBar.barTintColor = colorBGIn
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleColorIn]
        if withBackBtn {
            let image = UIImage(systemName: "chevron.left")
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(goToBack))
            self.navigationItem.leftBarButtonItem?.tintColor = titleColorIn
        }else {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        }
    }
    
    func setStatusBarColor(colorIn: UIColor, isHideIn: Bool = false) {
        self.navigationController?.navigationBar.isHidden = isHideIn
        UIApplication.shared.statusBarUIView?.backgroundColor = colorIn
    }
    
    func buildLeftNavBtn(iconIn: UIImage? = nil, iconTintColor: UIColor? = .white, titleIn: String? = nil, titleColorIn: UIColor? = .white, targetIn: Any, selectorIn: Selector) {
        
        if titleIn != nil {
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(title: titleIn, style: .plain, target: targetIn, action: selectorIn)]
            self.navigationItem.leftBarButtonItem?.tintColor = titleColorIn
        }else{
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: iconIn, style: .plain, target: targetIn, action: selectorIn)]
            self.navigationItem.leftBarButtonItem?.tintColor = iconTintColor
        }
    }
    
    func buildRightNavBtn(iconIn: UIImage? = nil, iconTintColor: UIColor? = .white, titleIn: String? = nil, titleColorIn: UIColor? = .white, targetIn: Any, selectorIn: Selector) {
        
        if titleIn != nil {
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(title: titleIn, style: .plain, target: targetIn, action: selectorIn)]
            self.navigationItem.rightBarButtonItem?.tintColor = titleColorIn
        }else{
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: iconIn, style: .plain, target: targetIn, action: selectorIn)]
            self.navigationItem.rightBarButtonItem?.tintColor = iconTintColor
        }
    }
    
    func openURL(urlIn: String) {
        if let mURL = URL(string: urlIn) {
            if UIApplication.shared.canOpenURL(mURL) {
                UIApplication.shared.open(mURL, options: [:], completionHandler: nil)
            }
        }
    }
 
    //MARK: Action Methods
    @objc private func goToRoot() {
        self.backViewToRootController()
    }
    
    @objc private func goToBack() {
        self.backViewController()
    }
    
    //MARK: Alerts
    func showAlertWithActions(titleIn: String, msgIn: String, actionsIn: [UIAlertAction]?) {
        DispatchQueue.main.async {
            let mAlert = UIAlertController(title: titleIn, message: msgIn, preferredStyle: .alert)
            
            if let actions = actionsIn {
                actions.forEach { (actionIn) in
                    mAlert.addAction(actionIn)
                }
            }else{
                mAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    mAlert.dismiss(animated: true, completion: nil)
                }))
            }
            
            self.present(mAlert, animated: true, completion: nil)
        }
    }
    
}
