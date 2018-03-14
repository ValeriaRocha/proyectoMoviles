//
//  Modelo.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Modelo {
    var arrTotal : [Category]
//    var fav : [String]
//    var mal : [String]
    
    init(){
//        fav = [String]();
//        mal = [String]();
        let sena1 = Sena(nombre: "Arana_web", path: "LenguajeSenasMexicano_Web/LSM_Animales_Web")
        var arrSena = [Sena]()
        arrSena.append(sena1)
        let cat = Category(nombre: "Animales", arrSena: arrSena)
        var arrCat = [Category]()
        arrCat.append(cat)
        self.arrTotal = arrCat
    }
}
