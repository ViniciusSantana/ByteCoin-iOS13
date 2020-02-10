//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegates()
        initializer()
    }
    
    func assignDelegates(){
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    func initializer(){
        let row = currencyPicker.selectedRow(inComponent: 0 )
        pickerView(currencyPicker, didSelectRow: row, inComponent: 0)
        
    }
    
    func fetchData(for currency : String){
        coinManager.getCoinPrice(for: currency)
    }
    
    
}

//MARK: -  UIPickerViewDataSource
extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: -  UIPickerViewDelegate
extension ViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fetchData(for: coinManager.currencyArray[row])
    }
}

//MARK: -  CoinManagerDelegate
extension ViewController : CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitCoinLabel.text =  coin.stringExchangeValue
            self.currencyLabel.text = coin.currency
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}


