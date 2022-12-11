//
//  ViewController.swift
//  TDMP3-EX2
//
//  Created by Roger Peratello on 04/12/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [Lembrete]()
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "Novo Lembrete", message: "Informe o novo lembrete", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Inserir", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.CreateItem(texto: text)
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.texto
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Editar", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Editar", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "Editar Lembrete", message: "Editar lembrete", preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.texto
            alert.addAction(UIAlertAction(title: "Salvar", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newText = field.text, !newText.isEmpty else {
                    return
                }
                self?.UpdateItem(item: item, texto: newText)
            }))
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "Apagar", style: .destructive, handler: { [weak self] _ in
            self?.DeleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Meus Lembretes"
        view.addSubview(tableView)
        GetAllItens()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
        
    
        
    // Core Data
    
    func GetAllItens(){
        do {
            models = try context.fetch(Lembrete.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Erro ao recuperar os registros!")
        }
        
    }
    
    func CreateItem(texto: String){
        let newItem = Lembrete(context: context)
        newItem.texto = texto
        
        do {
            try context.save()
            GetAllItens()
        } catch {
            print("Erro ao salvar o registro!")
        }
    }
    
    func UpdateItem(item : Lembrete, texto: String){
        item.texto = texto
        
        do {
            try context.save()
            GetAllItens()
        } catch {
            print("Erro ao atualizar o registro!")
        }
    }
    
    func DeleteItem(item : Lembrete){
        context.delete(item)
        
        do {
            try context.save()
            GetAllItens()
        } catch {
            print("Erro ao deletar registro!")
        }
    }

}

