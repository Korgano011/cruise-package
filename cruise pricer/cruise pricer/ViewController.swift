//
//  ViewController.swift
//  cruise pricer
//
//  Created by Thomas Daly on 11/9/25.
//

import UIKit
import CoreML

class ViewController: UIViewController {
    
    @IBOutlet weak var flightField: UITextField!
    
    @IBOutlet weak var hotelField: UITextField!
    
    @IBOutlet weak var nightsField: UITextField!
    
    @IBOutlet weak var roomField: UITextField!
    
    @IBOutlet weak var excursionField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var priceField: UILabel!
    
    let ships = ["0", "1", "2", "3", "4"]
    
    let model = try! cruisePricer(configuration: MLModelConfiguration())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            guard
        let flight = Double(flightField.text ?? ""),
        let hotel = Double(hotelField.text ?? ""),
            let nights = Double(nightsField.text ?? ""),
            let room = Double(roomField.text ?? ""),
            let excursion = Double(excursionField.text ?? "")
            else {
             priceField.text = "Please enter valid numbers"
                return
            }
            do {
                let prediction = try model.prediction(
                    flight: flight,
                    hotel: hotel,
                    nights: nights,
                    roomType: room,
                    excursions: excursion
                )
                priceField.text = String(format: "Estimated Cost: $%.0f", prediction.price)
            } catch {
                priceField.text = "Prediction failed"
            }
        case 1:
            view.backgroundColor = .silver
            imageView.image = UIImage(named: ships[0])
        case 2:
            view.backgroundColor = .emerald
            imageView.image = UIImage(named: ships[1])
        case 3:
            view.backgroundColor = .greenSea
            imageView.image = UIImage(named: ships[2])
        case 4:
            view.backgroundColor = .cyanite
            imageView.image = UIImage(named: ships[3])
        case 5:
            view.backgroundColor = .jigglyPuff
            imageView.image = UIImage(named: ships[4])
        default:
            fatalError("No such button")
        }
    }
    
}

