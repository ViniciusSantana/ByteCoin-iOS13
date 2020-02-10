//
//  BitCoinExchangeRate.swift
//  ByteCoin
//
//  Created by Vinicius Santana on 14/06/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct BitCoinExchangeRateData: Codable {
    let time, assetIDBase, assetIDQuote: String
    let rate: Double

    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}
