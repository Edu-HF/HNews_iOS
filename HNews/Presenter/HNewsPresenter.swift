//
//  HNewsPresenter.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation

class HNewsPresenter: NSCoder {
    
    //MARK: Shared Instance
    class var sharedIntance: HNewsPresenter {
        struct Static {
            static let instance: HNewsPresenter = HNewsPresenter()
        }
        
        return Static.instance
    }
    
    //MARK: Properties
    private let mainService = HNewsService()
    var mainAPIMsg: EZDynamicType<String> = EZDynamicType("")
    var mHNewsList: EZDynamicType<[HNews]> = EZDynamicType([])
    var mHNewsSelected: EZDynamicType<HNews> = EZDynamicType(HNews())
    
    //MARK: Private Methods
    private func saveHNewsList(listIn: [HNews]) {
        
        let mList = listIn.filter() { !self.getItemDeleteList().contains($0.nID ?? "") }
        
        do {
            try UserDefaults.standard.set(PropertyListEncoder().encode(mList), forKey: "MAIN_HNEWS_LIST_KEY")
        } catch {
            return
        }
        
        self.mHNewsList.value = mList
    }
    
    private func saveItemDeteleID(idIn: String) -> Bool {
        
        var mList = self.getItemDeleteList()
        mList.append(idIn)
        
        do {
            try UserDefaults.standard.set(PropertyListEncoder().encode(mList), forKey: "MAIN_HNEWS_DELETE_ID_LIST_KEY")
        } catch {
            return false
        }
        
        return true
    }
    
    private func getItemDeleteList() -> [String] {
        
        let uDefaults = UserDefaults.standard
        guard let mListData = uDefaults.object(forKey: "MAIN_HNEWS_DELETE_ID_LIST_KEY") as? Data else { return [] }
        guard let mList = try? PropertyListDecoder().decode([String].self, from: mListData) else { return [] }
        
        return mList
    }
    
    private func getSaveHNewsList() {
        
        let uDefaults = UserDefaults.standard
        guard let mListData = uDefaults.object(forKey: "MAIN_HNEWS_LIST_KEY") as? Data else { return }
        guard let mList = try? PropertyListDecoder().decode([HNews].self, from: mListData) else { return }
        
        self.mHNewsList.value = mList
    }
    
    //MARK: Public Methods
    func removeHNewsFromList(newsIn: HNews) {
        
        guard let mID = newsIn.nID else { return }

        if self.saveItemDeteleID(idIn: mID) {
            self.saveHNewsList(listIn: self.mHNewsList.value)
        }
    }
    
    //MARK: API Methods
    func getHNewsList() {
        
        self.mainService.getHNewsList().done { responseIn in
            
            if let mHNList = responseIn.mHNewsList {
                self.saveHNewsList(listIn: mHNList)
            }
        
        }.catch { errorIn in
            self.mainAPIMsg.value = errorIn.localizedDescription
        }
    }
}
