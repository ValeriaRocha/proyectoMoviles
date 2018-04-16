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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hola")
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        tvInstrucciones.layer.cornerRadius = 0.05 * tvInstrucciones.bounds.size.width
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
