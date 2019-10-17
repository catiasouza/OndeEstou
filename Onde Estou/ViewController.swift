

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest //melhor localizacao
        gerenciadorLocalizacao.requestWhenInUseAuthorization()           //solicitacao
        gerenciadorLocalizacao.startUpdatingLocation()         //MONITORAR LOCALIZACAO
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse {
            
            let alertaController = UIAlertController(title: "Permissao de localizacao", message: "Necessaria permissao para acesso a sua localizacao! Por favor habilite!", preferredStyle: .alert)
            
            let acaoConfiguracao = UIAlertAction(title: "Abrir configuracoes", style: .default, handler: {(alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(configuracoes as URL)
                }
            })
            
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            
            alertaController.addAction(acaoConfiguracao)
            alertaController.addAction(acaoCancelar)
            
            present( alertaController, animated: true, completion: nil)
            
        }
        
    }
    
}
