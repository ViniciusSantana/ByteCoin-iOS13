//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "2A796BB3-95ED-4744-91DF-98FD67CE8D75"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = (baseURL + "/\(currency)?apikey=\(apiKey)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let safeData = data {
                    if let rate = self.parseJson(safeData){
                        self.delegate?.didUpdateCurrency(self, coin: rate)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson(_ exchangeRate : Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(BitCoinExchangeRateData.self, from: exchangeRate)
            let currency = decodedData.assetIDQuote
            let value = decodedData.rate
            let exchangeRate = CoinModel(currency: currency, exchangeValue: value)
            return exchangeRate
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}
