//
//  ViewController.swift
//  Stefanini-desafio-app
//
//  Created by Mario C on 17/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import UIKit

class HeroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDelegate/DataSource Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //quando clicar em um heroi deve chamar a tela de detalhes
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //identificador da célula
        let reuseIdentifier = "HeroTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HeroTableViewCell else {
            print("Failed to dequeue cell")
            return UITableViewCell()
        }
        
        return cell
    }
    
    // MARK: - Navigation
}

