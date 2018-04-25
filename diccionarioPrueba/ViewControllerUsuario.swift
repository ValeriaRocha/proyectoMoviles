//
//  ViewControllerUsuario.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 21/04/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class ViewControllerUsuario: UIViewController {
    @IBOutlet weak var txtPuntos: UILabel!
    @IBOutlet weak var btError: UIButton!
    @IBOutlet weak var btFav: UIButton!
    @IBOutlet weak var btCreditos: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Usuario"
        btFav.layer.cornerRadius = 0.05 * btFav.bounds.width
        btError.layer.cornerRadius = 0.05 * btError.bounds.width
        btCreditos.layer.cornerRadius = 0.05 * btCreditos.bounds.width
        // Do any additional setup after loading the view.
        txtPuntos.text = String(Usuario.user.puntos)
        txtPuntos.layer.cornerRadius = 2 * txtPuntos.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        txtPuntos.text = String(Usuario.user.puntos)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier != "credits"){
            let vista = segue.destination as! TableViewControllerSena
            if(segue.identifier == "favoritos")
            {
                vista.datoMostrar = Usuario.user.favoritos
                vista.datoMostrarFiltro = Usuario.user.favoritos
                vista.bEdit = true
                vista.sSegue = "favoritos"
            }
            
            if(segue.identifier == "errores")
            {
                vista.datoMostrar = Usuario.user.errores
                vista.datoMostrarFiltro = Usuario.user.errores
                vista.bEdit = true
                vista.sSegue = "errores"
            }
        }
    }
    

}
