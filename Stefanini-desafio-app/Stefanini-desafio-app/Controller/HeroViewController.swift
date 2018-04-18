//
//  ViewController.swift
//  Stefanini-desafio-app
//
//  Created by Mario C on 17/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import UIKit
import SDWebImage

class HeroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Vars
    private var hero: [Hero]!
    private var navigateToHeroDetail: Hero!
    private lazy var placeholderIcon = UIImage(named: "stefanini256")!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        HeroApi.sharedInstance.getHeros {
            (hero, error) in
            if error != nil {
              //fazer dialog de erro
            } else {
                self.hero = hero
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDelegate/DataSource Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Ao selecionar uma célula chama a tela de detalhes.
        if (self.hero.count > 0) {
            self.navigateToHeroDetail = self.hero[indexPath.item]
            self.performSegue(withIdentifier: "HeroDetail", sender: self)
        }
    }
    //numero de seções
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //numero de linhas(celulas) na seção
        if self.hero != nil {
            return self.hero.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //tamanho da celula
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //identificador da célula
        let reuseIdentifier = "HeroTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? HeroTableViewCell else {
            print("Failed to dequeue cell")
            return UITableViewCell()
        }
        
        //imagem do heroi utilizando o framework SDWebImage
        cell.heroImage.sd_setShowActivityIndicatorView(true)
        cell.heroImage.sd_setIndicatorStyle(.gray)
        cell.heroImage.sd_setImage(with: URL(string: self.hero[indexPath.item].thumbnail), placeholderImage: self.placeholderIcon)
        //nome do heroi
        cell.heroName.text = self.hero[indexPath.item].name
        //descricao do heroi
        cell.heroDescription.text  = self.hero[indexPath.item].description
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //verifica qual tela é para abrir
        switch segue.destination {
        case let dvc as HeroDetailViewController:
            dvc.hero = self.navigateToHeroDetail
            self.navigateToHeroDetail = nil
        default:
            break
        }
    }
}

