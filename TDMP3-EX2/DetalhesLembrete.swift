//
//  DetalhesLembrete.swift
//  TDMP3-EX2
//
//  Created by Roger Peratello on 04/12/22.
//

import UIKit

class DetalhesLembrete: UIViewController {
    
    var lembrete : Lembrete!
    @IBOutlet weak var lembreteStatus: UISwitch!
    @IBOutlet weak var lembreteTexto: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        lembreteTexto.text = lembrete.texto
        lembreteStatus.isOn = lembrete.concluido
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
