//
//  HeroDetailViewController.swift
//  Stefanini-desafio-app
//
//  Created by School Picture Dev on 18/04/18.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class HeroDetailViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var descriptionOfHero: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    // MARK: - @IBActions
    @IBAction func swipeDownAction(_ sender: Any) {
        //fecha a tela caso o usuario arraste para baixo
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Variables
    var hero: Hero!
    
    // MARK: - Private Vars
    private lazy var placeholderIcon = UIImage(named: "stefanini256")!
    
    // MARK: - Private Methods
    private func prepareView() {
        //descrição do heroi
        self.descriptionOfHero.text = self.hero.description
        //imagem do heroi utilizando o framework SDWebImage
        self.heroImage.sd_setShowActivityIndicatorView(true)
        self.heroImage.sd_setIndicatorStyle(.gray)
        self.heroImage.sd_setImage(with: URL(string: self.hero.thumbnail), placeholderImage: self.placeholderIcon)
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //carrega a tela com os dados do heroi
        self.prepareView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
