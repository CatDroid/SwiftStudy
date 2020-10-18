//
//  ConsoleIO.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/9.
//

import Foundation

enum OutputType {
    case error
    case standard
}


class ConsoleIO {
    
    func writeMessage(msg:String, to:OutputType = OutputType.standard)
    {
        // Swift的Switch语句会自动在case结尾处加上break，执行完满足条件的case部分后，就自动退出了
        // case 0,3:
        switch to {
        case .standard:
            print("Warn: \(msg)")
        case .error:
            fputs("Error: \(msg)\n", stderr)
        default:
            break ;
        }
        
    }
    
    // 外部参数名 和 内部参数名
    public func funcArgName(  x:Int,   y:Int,  z:Int,   w:Double)
    {
        print("函数的局部名称和外部名称 \(x) \(y) \(z) \(w)");
    }
    
    
    // Switch当然也支持显式的break，通常只有一种情况下你会这么做，
    // 那就是当你也不想在default里做任何事情的时候，这个时候你就可以在default里显式地加上一句break
    func switchFloat(value:Float) -> Bool
    {
        var matchFlag = true
        switch value {
        case 1.5...2.5:
            print("支持区间运算符")
        case 4,5,6,7,8:
            print("支持多个值");
        case 9:
            print("6")
            fallthrough
        case 10:
            print("fallthrough");
        default:
            matchFlag = false
            print("default break")
            break;
        }
        return matchFlag
    }
    
    
}


