//
//  Category.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Category: Codable {
    var nombre : String
    var arrSena : [Sena]
    
    init(nombre:String, arrSena:[Sena]){
        self.nombre = nombre
        self.arrSena = arrSena
    }
    
}
