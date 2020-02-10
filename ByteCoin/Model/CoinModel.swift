//
//  ExchangeRateModel.swift
//  ByteCoin
//
//  Created by Vinicius Santana on 14/06/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency : String
    let exchangeValue : Double
    
    var stringExchangeValue : String {
        return String(format: "%.2f", exchangeValue)
    }
}
