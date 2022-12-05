//
//  ViewController.swift
//  TDMP3-EX2
//
//  Created by Roger Peratello on 04/12/22.
//

import UIKit

class ViewController: UITableViewController {

    var lembretes : [Lembrete] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        lembretes.append("Áries")
        lembretes.append("Aquários")
        lembretes.append("Gêmeos")
        */
        
        var lembrete : Lembrete
        
        lembrete = Lembrete(texto: "Viagem SP", concluido: false)
        lembretes.append(lembrete)
        lembrete = Lembrete(texto: "Viagem Bahia", concluido: false)
        lembretes.append(lembrete)
        lembrete = Lembrete(texto: "Viagem Brotas", concluido: true)
        lembretes.append(lembrete)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lembretes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celulaReuso = "celulaReuso"
        let lembrete : Lembrete = lembretes[indexPath.row]
        
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! LembreteCelula
        
        //celula.textLabel?.text = lembrete.texto
        
        celula.tituloLabel.text = lembrete.texto
        var status : String
        if (lembrete.concluido){
            status = "concluído"
        }
        else{
            status = "pendente"
        }
        celula.statusLabel?.text = status
        
        return celula
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "detalheLembrete" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let lembreteSelecionado = self.lembretes[indexPath.row]
                
                let viewControllerDestino = segue.destination as! DetalhesLembrete
                
                viewControllerDestino.lembrete = lembreteSelecionado
            }
        }        
    }


}

