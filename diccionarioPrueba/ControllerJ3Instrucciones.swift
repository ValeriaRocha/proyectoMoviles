//
//  ControllerJ3Instrucciones.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 26/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class ControllerJ3Instrucciones: UIViewController {
    
    @IBOutlet weak var tvInstrucciones: UITextView!
    @IBOutlet weak var vista: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Gravedad"
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "< Juegos", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        tvInstrucciones.layer.cornerRadius = 0.01 * tvInstrucciones.bounds.size.width
       // vista.layer.cornerRadius = 0.05 * vista.bounds.size.width
        
//        tvInstrucciones.text = "                         " + String(Usuario.user.puntos)
//        for i in Usuario.user.errores{
//            tvInstrucciones.text = tvInstrucciones.text + " " + i.nombre
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        performSegue(withIdentifier: "back", sender: self)
    }
    
    @IBAction func unwindPrincipal(unwindSegue : UIStoryboardSegue){
        
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
