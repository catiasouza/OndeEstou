

import UIKit
import MapKit

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    @IBOutlet weak var velocidadeLabel: UILabel!
    @IBOutlet weak var endereco: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.desiredAccuracy = kCLLocationAccuracyBest //melhor localizacao
        gerenciadorLocalizacao.requestWhenInUseAuthorization()           //solicitacao
        gerenciadorLocalizacao.startUpdatingLocation()         //MONITORAR LOCALIZACAO
        
    }
    
    // exibindo dados
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       let localizacaoUsuario = locations.last
        
        let latitude = localizacaoUsuario!.coordinate.latitude
        let longitude = localizacaoUsuario!.coordinate.longitude
        
        longitudeLabel.text = String(longitude)
        latitudeLabel.text = String(latitude)
        
        velocidadeLabel.text = String(localizacaoUsuario!.speed)
        
        
        
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
