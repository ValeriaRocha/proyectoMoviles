//
//  MemoramaCollectionViewCell.swift
//  diccionarioPrueba
//
//  Created by Mickey Rocha on 4/2/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class MemoramaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbCarta: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(text: String){
        lbCarta.text = text
    }
}
