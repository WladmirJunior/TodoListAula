//
//  ViewController.swift
//  TodoList3
//
//  Created by Wladmir  on 19/08/20.
//  Copyright © 2020 Wladmir . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listaDeTarefas: [String] = []
    let keyLista = "listaDeTarefas"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if let lista = UserDefaults.standard.value(forKey:  keyLista) as? [String] {
            listaDeTarefas.append(contentsOf: lista)
        }
    }

    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova tarefa",
                                      message: "Adicione uma nova tarefa",
                                      preferredStyle: .alert)
        
        let acaoSalvar = UIAlertAction(title: "Salvar", style: .default) { (action) in
            if let textField = alert.textFields?.first, let texto = textField.text {
                self.listaDeTarefas.append(texto)
                self.tableView.reloadData()
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.keyLista)
            }
        }

        alert.addAction(acaoSalvar)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addTextField()
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listaDeTarefas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.listaDeTarefas, forKey: self.keyLista)
        }
    }
}

