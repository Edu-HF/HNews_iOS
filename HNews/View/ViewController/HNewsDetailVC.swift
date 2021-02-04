//
//  HNewsDetailVC.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import UIKit
import WebKit

class HNewsDetailVC: BaseViewController {

    //MARK: Properties and Vars
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupWV()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        self.setupNavBar(titleIn: "Hack News Detail", withBackBtn: true, colorBGIn: .baseNavBarColor, titleColorIn: .white)
    }
    
    private func setupWV() {
        
        if let mURLPath = HNewsPresenter.sharedIntance.mHNewsSelected.value.nURL {
            if let mURL = URL(string: mURLPath) {
                let mRequest = URLRequest(url: mURL)
                let mainWV = WKWebView(frame: self.view.bounds)
                mainWV.load(mRequest)
                self.view.addSubview(mainWV)
            }else{
                self.showCannotOpenContentMSG()
            }
        }else{
            self.showCannotOpenContentMSG()
        }
    }
    
    private func showCannotOpenContentMSG() {
        
        self.showAlertWithActions(titleIn: "Attention", msgIn: "An error occurred while trying to load the content, please try other content", actionsIn: [UIAlertAction.init(title: "Accept", style: .default, handler: { _ in
            self.backViewController()
        })])
    }
    
    //MARK: Public Methods
    
    //MARK: Actions Methods

}
