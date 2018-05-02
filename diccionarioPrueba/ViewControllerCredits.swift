//
//  ViewControllerCredits.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 24/04/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class ViewControllerCredits: UIViewController {

    @IBOutlet weak var tvCredits: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let font1 = UIFont(name: "AvenirNextCondensed-Medium", size: 20)
        let bold1 = UIFont(name: "AvenirNextCondensed-Bold", size: 20)
        
        self.title = "Créditos"
        tvCredits.layer.cornerRadius = 0.01 * tvCredits.bounds.size.width
        
        var credits = addBoldText(fullString: "El proyecto de Aprendizaje de Lenguaje de Señas Mexicanas ha sido desarrollado por estudiantes del Tecnológico de Monterrey durante el semestre Enero Mayo de 2018, como parte del curso Desarrollo de Aplicaciones para Dispositivos Móviles y asesorados por la maestra Yolanda Martínez Treviño.\n\nDesarrolladores:\nAna Clarissa Miranda Peña\nValeria Rocha Sepúlveda\nMiguel Ángel Rocha Cabello\n\nAprendizaje de Lenguaje de Señas Mexicanas se distribuye como está de manera gratuita y se prohíbe su distribución y uso con fines de lucro.", boldPartOfString: "Desarrolladores:", font: font1, boldFont: bold1)
        
        var credits2 = addBoldText(fullString: "\n\nFont de los nombres de los juegos\nEl font se consiguió dentro de la siguiente página: https://www.noupe.com/design/best-of-2015-100-free-fonts-for-designers-95285.html\nLa liga del font en específico: http://freegoodiesfordesigners.blogspot.mx/2015/02/hipster-free-font-bellaboo-by-marcelo.html\n", boldPartOfString: "Font de los nombres de los juegos", font: font1, boldFont: bold1)
        credits.append(credits2)
        
        credits2 = addBoldText(fullString: "\nInstructora de LSM\nEdyth Esthela de la Rosa Lozoya", boldPartOfString: "Instructora de LSM", font: font1, boldFont: bold1)
        credits.append(credits2)
        
        credits2 = addBoldText(fullString: "\n\nImágenes del juego Gravedad\nhttps://stocksnap.io/\n", boldPartOfString: "Imágenes del juego Gravedad", font: font1, boldFont: bold1)
        credits.append(credits2)
        
        credits2 = addBoldText(fullString: "\nFondo de pantalla del juego Gravedad\nValeria Rocha Sepúlveda\n", boldPartOfString: "Fondo de pantalla del juego Gravedad", font: font1, boldFont: bold1)
        
        credits2 = addBoldText(fullString: "\nIconos del Tab Bar\nAPP-BITS Liga: https://www.app-bits.com/\n", boldPartOfString: "Iconos del Tab Bar", font: font1, boldFont: bold1)
        credits.append(credits2)
        
        credits2 = addBoldText(fullString: "\nFotografía y Video:\nRebeca Patricia Fuentes García\n", boldPartOfString: "Fotografía y Video", font: font1, boldFont: bold1)
        credits.append(credits2)
        
        tvCredits.attributedText = credits
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addBoldText(fullString: NSString, boldPartOfString: NSString, font: UIFont!, boldFont: UIFont!) -> NSMutableAttributedString {
        let nonBoldFontAttribute = [NSAttributedStringKey.font:font!]
        let boldFontAttribute = [NSAttributedStringKey.font:boldFont!]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString as String))
        return boldString
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
