//
//  Seña.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Sena: NSObject {
    var nombre : String
    var path : String
    var aprendida : Bool
    
    init(nombre:String, path:String, aprendida : Bool){
        self.nombre = nombre
        self.path = path
        self.aprendida = aprendida
    }
}
