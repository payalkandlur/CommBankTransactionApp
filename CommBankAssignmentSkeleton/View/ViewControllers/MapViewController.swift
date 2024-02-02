//
//  MapViewController.swift
//  CommBankAssignmentSkeleton
//
//  Created by Payal Kandlur on 2/1/24.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    let mapView = MKMapView()
    var latitude: Double? = nil
    var longitude: Double? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        openMapView()
    }

    private func openMapView() {

        guard let lat = latitude, let long = longitude else { return }
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true

        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.title = "\(latitude ?? 0.00),\(longitude ?? 0.00)"
        mapView.addAnnotation(annotation)

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locationCoordinate, span: span)
        mapView.setRegion(region, animated: true)

        mapView.frame = view.bounds
        view.addSubview(mapView)
    }
}
