//
//  Text.swift
//  tukang-bakso-app
//
//  Created by oka_uliandana on 22/02/25.
//

import SwiftUI

extension Text {

    func size10() -> some View {
        return self.font(.custom(Config.typography, size: 10))
    }
    
    func size12() -> some View {
        return self.font(.custom(Config.typography, size: 12))
    }
    
    func size13() -> some View {
        return self.font(.custom(Config.typography, size: 13))
    }

    func size14() -> some View {
        return self.font(.custom(Config.typography, size: 14))
    }
    
    func size24() -> some View {
        return self.font(.custom(Config.typography, size: 24))
    }

}
