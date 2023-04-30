//
//  ViewController.swift
//  AluraViagens
//
//  Created by Jose Luis Damaren Junior on 17/04/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var viagensTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configuraTableView()
    }
    
    func configuraTableView() {
        viagensTableView.dataSource = self
        viagensTableView.delegate = self
        viagensTableView.register(UINib(nibName: "ViagemTableViewCell", bundle: nil), forCellReuseIdentifier: "ViagemTableViewCell")
        viagensTableView.register(UINib(nibName: "OfertaTableViewCell", bundle: nil), forCellReuseIdentifier: "OfertaTableViewCell")
    }
    
    func irParaDetalhes(_ viagem: Viagem?) {
        if let viagem = viagem {
            let detalheController = DetalheViewController.instanciar(viagem)
            navigationController?.pushViewController(detalheController, animated: true)
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return secaoDeViagens?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secaoDeViagens?[section].numeroDeLinhas ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let viewModel = secaoDeViagens?[indexPath.section]
        
        switch viewModel?.tipo {
        case .destaques:
            guard let celulaViagem = tableView.dequeueReusableCell(withIdentifier: "ViagemTableViewCell") as? ViagemTableViewCell else {
                fatalError("error when creating ViagemTableViewCell")
            }
            celulaViagem.configuraCelula(viewModel?.viagens[indexPath.row])
            return celulaViagem
        case .ofertas:
            guard let celulaOferta = tableView.dequeueReusableCell(withIdentifier: "OfertaTableViewCell") as? OfertaTableViewCell else {
                fatalError("error when creating OfertaTableViewCell")
            }
            celulaOferta.delegate = self
            celulaOferta.configuraCelula(viewModel?.viagens)
            return celulaOferta
        default:
            return UITableViewCell()
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 300
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = Bundle.main.loadNibNamed("HomeTableViewHeader", owner: self)?.first as? HomeTableViewHeader
            headerView?.configureView()
            
            return headerView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? 410 : 500
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = secaoDeViagens?[indexPath.section]
        
        switch viewModel?.tipo {
        case .destaques, .internacionais:
            let viagemSelecionada = viewModel?.viagens[indexPath.row]
            irParaDetalhes(viagemSelecionada)
        default:
            break
        }
    }
}

extension ViewController: OfertaTableViewCellDelegate {
    func didSelectView(_ viagem: Viagem?) {
        irParaDetalhes(viagem)
    }
}
