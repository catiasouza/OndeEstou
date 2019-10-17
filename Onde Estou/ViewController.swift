

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
        
      localizacaoUsuario?.speed
            
        velocidadeLabel.text = String(localizacaoUsuario!.speed)
            
      
        let deltaLat: CLLocationDegrees = 0.01
        let deltaLon: CLLocationDegrees = 0.01
        
        let localizacao: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let areaExibicao: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: deltaLat, longitudeDelta: deltaLon)
        
        let regiao: MKCoordinateRegion = MKCoordinateRegion(center: localizacao, span: areaExibicao)
        
        mapa.setRegion(regiao, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(localizacaoUsuario! ) { (detalhesLocal, erro) in
            if erro == nil{
                
                if  let dadosLocal = detalhesLocal?.first{
                
                    var thoroughfare = ""
                    if dadosLocal.thoroughfare != nil {
                        thoroughfare = dadosLocal.thoroughfare!
                    }
                    var subThoroughfare = ""
                    if dadosLocal.subThoroughfare != nil {
                        subThoroughfare = dadosLocal.subThoroughfare!
                    }
                    var locality = ""
                    if dadosLocal.locality != nil {
                        locality = dadosLocal.locality!
                    }
                    var subLocality = ""
                    if dadosLocal.subLocality != nil {
                        subLocality = dadosLocal.subLocality!
                    }
                    var postalCode = ""
                    if dadosLocal.postalCode != nil {
                        postalCode = dadosLocal.postalCode!
                    }
                    var country = ""
                    if dadosLocal.country != nil {
                        country = dadosLocal.country!
                    }
                    var administrativeArea = ""
                    if dadosLocal.administrativeArea != nil {
                        administrativeArea = dadosLocal.administrativeArea!
                    }
                     var subAdministrativeArea = ""
                     if dadosLocal.subAdministrativeArea != nil {
                        subAdministrativeArea = dadosLocal.subAdministrativeArea!
                    }
                    self.endereco.text = thoroughfare + "-"
                                            + subThoroughfare + "/"
                                            + locality + "-"
                                            + country + "-"
                    
                    print(
                        "\n / Rua: " + thoroughfare +
                        "\n / Numero: " + subThoroughfare +
                        "\n / Cidade: " + locality +
                        "\n / Bairro: " + subLocality +
                        "\n / CEP: " + postalCode +
                        "\n / Pais: " + country +
                        "\n /Area: " + administrativeArea +
                        "\n / subAdministrativeArea:" + subAdministrativeArea
                    )
                }
            }else{
                print(erro as Any)
            }
        }
        
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

