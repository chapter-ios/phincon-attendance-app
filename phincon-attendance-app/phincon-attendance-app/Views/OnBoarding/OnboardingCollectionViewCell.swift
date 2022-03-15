//
//  OnboardingCollectionViewCell.swift
//  phincon-attendance-app
//
//  Created by Ade on 3/10/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: "OnboardingCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet var lbOnBoardTitle: UILabel!
    @IBOutlet var lbOnBoardDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(_ slide: OnboardingSlide) {
        self.lbOnBoardTitle.text = slide.title
        self.lbOnBoardDesc.text = slide.description
    }

}
