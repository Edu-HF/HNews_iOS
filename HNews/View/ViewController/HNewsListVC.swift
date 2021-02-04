//
//  HNewsListVC.swift
//  HNews
//
//  Created by Edu on 02/02/21.
//

import UIKit

class HNewsListVC: BaseViewController {
    
    //MARK: Properties and Vars
    @IBOutlet weak var mHNewsTV: UITableView!
    private var mRControl = UIRefreshControl()
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    //MARK: Private Methods
    private func setupUI() {
        
        self.setupNavBar(titleIn: "Hack News", colorBGIn: .baseNavBarColor, titleColorIn: .white)
        self.mHNewsTV.register(UINib(nibName: "HNewsCell", bundle: nil), forCellReuseIdentifier: "HNewsCell")
        self.mHNewsTV.estimatedRowHeight = UITableView.automaticDimension
        self.setupListeners()
        self.setupRC()
        HNewsPresenter.sharedIntance.getHNewsList()
    }
    
    private func setupListeners() {
        
        HNewsPresenter.sharedIntance.mainAPIMsg.bind { msgIn in
            self.mRControl.endRefreshing()
            self.showAlertWithActions(titleIn: "Attention", msgIn: msgIn, actionsIn: nil)
        }
        
        HNewsPresenter.sharedIntance.mHNewsList.bind { _ in
            self.mRControl.endRefreshing()
            self.mHNewsTV.reloadData()
        }
        
        HNewsPresenter.sharedIntance.mHNewsSelected.bind { _ in
            self.presentVCWithNav(viewControllerIn: HNewsDetailVC())
        }
    }
    
    private func setupRC() {
        
        self.mRControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        self.mHNewsTV.addSubview(mRControl)
    }
    
    //MARK: Public Methods
    
    //MARK: Actions Methods
    @objc func onRefresh() {
        HNewsPresenter.sharedIntance.getHNewsList()
    }
}

extension HNewsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HNewsPresenter.sharedIntance.mHNewsList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mHNCell = tableView.dequeueReusableCell(withIdentifier: "HNewsCell") as! HNewsCell
        mHNCell.setupCell(newsIn: HNewsPresenter.sharedIntance.mHNewsList.value[indexPath.row])
        
        return mHNCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        indexPath.row.isMultiple(of: 2) ? cell.animationSlideInHorizontal(delay: 0.5, direction: .Left, block: {}) : cell.animationSlideInHorizontal(delay: 0.5, direction: .Right, block: {})
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let mDeleteBtn = UIContextualAction.init(style: .destructive, title: "", handler: { _,_, completionHandler in
            HNewsPresenter.sharedIntance.removeHNewsFromList(newsIn: HNewsPresenter.sharedIntance.mHNewsList.value[indexPath.row])
            completionHandler(true)
        })
        
        let mDeleteIC = UIImage(named: "Delete_IC")
        mDeleteBtn.image = mDeleteIC
        mDeleteBtn.backgroundColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        
        let mConfig = UISwipeActionsConfiguration(actions: [mDeleteBtn])
        mConfig.performsFirstActionWithFullSwipe = true
        
        return mConfig
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        HNewsPresenter.sharedIntance.mHNewsSelected.value = HNewsPresenter.sharedIntance.mHNewsList.value[indexPath.row]
    }
}
