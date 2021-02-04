//
//  HNews.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import Foundation

struct HNews: Codable {
    
    var nID: String?
    var nTitle: String?
    var nStoryTitle: String?
    var nDate: String?
    var nAuthor: String?
    var nURL: String?
    
    init(idIn: String? = nil, titleIn: String? = nil, storyTitleIn: String? = nil, dateIn: String? = nil, authorIn: String? = nil, urlIn: String? = nil) {
        
        self.nID = idIn
        self.nTitle = titleIn
        self.nStoryTitle = storyTitleIn
        self.nDate = dateIn
        self.nAuthor = authorIn
        self.nURL = urlIn
    }
    
    enum CodingKeys: String, CodingKey {
        
        case nID = "objectID"
        case nTitle = "title"
        case nStoryTitle = "story_title"
        case nDate = "created_at"
        case nAuthor = "author"
        case nURL = "url"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let nID: String? = try? container.decode(String.self, forKey: .nID)
        let nTitle: String? = try? container.decode(String.self, forKey: .nTitle)
        let nStoryTitle: String? = try? container.decode(String.self, forKey: .nStoryTitle)
        let nDate: String? = try? container.decode(String.self, forKey: .nDate)
        let nAuthor: String? = try? container.decode(String.self, forKey: .nAuthor)
        let nURL: String? = try? container.decode(String.self, forKey: .nURL)
        
        self.init(idIn: nID, titleIn: nTitle, storyTitleIn: nStoryTitle, dateIn: nDate, authorIn: nAuthor, urlIn: nURL)
    }
}

struct ResponseHNewsList: Codable {
    
    var mHNewsList: [HNews]?
    
    init(listIn: [HNews]?) {
        self.mHNewsList = listIn
    }
    
    enum CodingKeys: String, CodingKey {
        case mHNewsList = "hits"
    }
    
    public init(from decoder: Decoder) throws {
        let mContainer = try decoder.container(keyedBy: CodingKeys.self)
        let mHNewsList: [HNews]? = try? mContainer.decode([HNews].self, forKey: .mHNewsList)
        
        self.init(listIn: mHNewsList)
    }
}


