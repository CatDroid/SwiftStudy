//
//  main.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/9.
//

import Foundation


print("Hello, World!")

print("Swift没有main函数,但是它有一个main文件. ")


var myDouble = 40.0 ; // 字面值推断是Double
var myFloat:Float = 14;


let CONST_VALUE = 12 ;
// CONST_VALUE = 13 ; // let是一个常量
print("CONST_VALUE is  \(CONST_VALUE), myDouble = \(myDouble) , myFloat = \(myFloat)")
// 采用斜线与小括号() 类似kotlin的模版字符串

let uninitialFlag:Bool ; // 没有初始值 必须声明类型

//print("uninitialFlag \(uninitialFlag)") // Constant 'uninitialFlag' used before being initialized

 
uninitialFlag = false ;
print("uninitialFlag = \(uninitialFlag) ") // uninitialFlag = false


let output = ConsoleIO();

output.writeMessage(msg: "main write message", to: OutputType.error)

print("switch with float -> \(output.switchFloat(value:6))") // 函数实参 使用 命名参数
 
print("switch with float -> \(output.switchFloat(value:9))")
