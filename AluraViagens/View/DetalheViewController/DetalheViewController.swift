//
//  DetalheViewController.swift
//  AluraViagens
//
//  Created by Jose Luis Damaren Junior on 19/04/23.
//

import UIKit

class DetalheViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    @IBOutlet weak var diariaViagemLabel: UILabel!
    @IBOutlet weak var precoSemDescontoLabel: UILabel!
    @IBOutlet weak var precoViagemLabel: UILabel!
    
    // MARK: - Atributos
    
    var viagem: Viagem?
    
    // MARK: - View life cycle
    
    class func instanciar(_ viagem: Viagem) -> DetalheViewController {
        let detalhesViewController = DetalheViewController(nibName: "DetalheViewController", bundle: nil)
        detalhesViewController.viagem = viagem
        return detalhesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuraView()
    }
    
    func configuraView() {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
        precoViagemLabel.text = "R$ \(viagem?.preco ?? 0)"
        
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string: "R$ \(viagem?.precoSemDesconto ?? 0)")
        attrString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attrString.length))
        precoSemDescontoLabel.attributedText = attrString
        
        if let numeroDeDias = viagem?.diaria, let numeroDeHospedes = viagem?.hospedes {
            let diarias = numeroDeDias == 1 ? "Diária" : "Diárias"
            let hospedes = numeroDeHospedes == 1 ? "Pessoa" : "Pessoas"
            diariaViagemLabel.text = "\(numeroDeDias) \(diarias) - \(numeroDeHospedes) \(hospedes)"
        }
    }
    
    // MARK: - Actions
    @IBAction func botaoVoltar(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
