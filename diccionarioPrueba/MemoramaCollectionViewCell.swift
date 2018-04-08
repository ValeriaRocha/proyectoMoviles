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
    var senaImg: Bool!
    var sena: Sena!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func renderCarta(senaImg: Bool, sena: Sena){
        self.senaImg = senaImg
        self.sena = sena
    }
    
    //    func removerCarta(lugar: Array<IndexPath>){
    //        for index in 0...lugar.count - 1{
    //            let cartaCell = UICollectionView.cellForItem(self).
    //        }
    //    }
    
    struct Carta{
        var senaImg: Bool!
        var sena: Sena!
        
        init(senaImg: Bool, sena: Sena) {
            self.senaImg = senaImg
            self.sena = sena
        }
    }
    
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
}
