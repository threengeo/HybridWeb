//
//  WebViewModel.swift
//  HybridWeb
//
//  Created by nextez on 2022/05/02.
//

import Foundation
import Combine
import MapKit

class WebViewModel: NSObject, ObservableObject {
    
    var alertEvent = PassthroughSubject<AppAlert, Never>()
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {  // 기기 전체 설정
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest // 정확도 (kCLLocationAccuracyBest: 3km)
            locationManager!.delegate = self
        } else {
            // 위치 서비스가 꺼져 있을 때
            print("앱 사용을 위해 위치 서비스가 필요 합니다.")
            alertEvent.send(AppAlert("알림", "앱 사용을 위해 위치 서비스가 필요 합니다."))
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("자녀 보호 기능 등으로 인해 위치 서비스가 제한 되었을 수 있습니다.")
            alertEvent.send(AppAlert("알림", "자녀 보호 기능 등으로 인해 위치 서비스가 제한 되었을 수 있습니다."))
        case .denied:
            // 앱 위치 서비스가 꺼져 있을 때
            print("앱을 정상적으로 사용 하려면 위치 접근이 필요 합니다.")
            alertEvent.send(AppAlert("알림", "앱을 정상적으로 사용 하려면 위치 접근이 필요 합니다."))
        case .authorizedAlways, .authorizedWhenInUse:
            print(".authorizedAlways, .authorizedWhenInUse")
        @unknown default:
            break
        }
    }
    
}


extension WebViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")
        checkLocationAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager: didUpdateLocations")
        if let locationCoordinate = manager.location?.coordinate {
            print("Latitude=[\(locationCoordinate.latitude)], Longitude=[\(locationCoordinate.longitude)]")
        }
    }
}
