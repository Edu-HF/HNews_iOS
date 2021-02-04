//
//  HNewsCell.swift
//  HNews
//
//  Created by Edu on 03/02/21.
//

import UIKit

class HNewsCell: UITableViewCell {
    
    //MARK: Outlets and Vars
    @IBOutlet weak var nTitleLB: UILabel!
    @IBOutlet weak var nAuthorLB: UILabel!
    private var mHNews: HNews!
    
    //MARK: Life Cycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.preSetupCell()
    }

    override func prepareForReuse() {
        self.nTitleLB.text = ""
        self.nAuthorLB.text = ""
    }
    
    //MARK: Private Methods
    private func preSetupCell() {
        self.nTitleLB.textColor = .baseAppColor
        self.nAuthorLB.textColor = .gray
    }
    
    //MARK: Public Methods
    func setupCell(newsIn: HNews?) {
        
        if let mHN = newsIn {
            self.mHNews = mHN
            self.nTitleLB.text = self.mHNews.nTitle ?? self.mHNews.nStoryTitle
            
            if let mAuthor = self.mHNews.nAuthor, let mDate = self.mHNews.nDate {
                self.nAuthorLB.text = mAuthor + " - " + mDate.getHourFromDate()
            }
        }
    }
    
}
