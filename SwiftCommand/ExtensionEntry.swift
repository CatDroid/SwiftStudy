//
//  Extension.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/25.
//

import Foundation

// 扩展 统一单位 转换成米
extension Double {
    var km: Double {
        return self * 1_000.0
    }
    var m: Double {
        return self
    }
    var cm: Double {
        return self / 1_00.0
    }
    var mm: Double {
        return self / 1_000.0
    }
    
} // 只能扩展类或实例 的 计算属性

// 只能扩展便利构造函数  不能是指定构造函数和析构函数

class GamePlayer {
    var money:Double
    init(dollar:Double) {
        money = dollar
    }
}

extension GamePlayer {
    convenience init(renminbi:Double) { // 参数名字不一样 不是同一个构造函数
        let dollar = renminbi * 6.0
        self.init(dollar:dollar); // 必须调用指定构造函数
    }
}


func ExtensionEntry()
{

    print("厘米->米 \(114.5.cm)")
    
    let chinesePlayer = GamePlayer(renminbi:100);
    print("只能扩展便利构造函数 \(chinesePlayer.money)")
    
}

