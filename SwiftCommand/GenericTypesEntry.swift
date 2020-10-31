//
//  GenericTypesEntry.swift
//  SwiftCommand
//
//  Created by hehanlong on 2020/10/31.
//

import Foundation

// T只是一个占位符 构建系统编译函数时候不会找T的实际类型
// T U V
// Dictionary<Key,Value> 驼峰命令类型参数
func dataChange<T>(_ a:inout T, _ b:inout T) // T是类型参数 调用函数的时候需要传入
{
    let temp:T = a ;
    a = b ;
    b = temp ;
}

struct Stack<Element>
{
    var array = [Element]()
    
    mutating func push(_ one:Element){
        array.append(one)
    }
    
    mutating func pop() -> Element
    {
        return array.removeLast()
    }
    
}

// extension Stack<Element> 扩展可以直接用类型参数名
extension Stack {
    // 计算属性。 扩展中不能有存储属性
    var first: Element? { // 'let' declarations cannot be computed properties let不能修饰计算属性
        
        return array.isEmpty ? nil: array[array.count - 1]; // 三目运算符
    }
    
}


func GenericTypesEntry() -> Void
{
    var a = 2 ;
    var b = -2 ;
    dataChange(&a ,&b)
    print("泛型 类型参数 2,-2 -> \(a),\(b)")
   
    
    var temp = Stack<Int>() ;
    temp.push(1);
    temp.push(2);

    print("泛型struct \(temp.pop())")
    
    
    // swift语言默认的是不可变的状态，例如方法传入实参时会进行拷贝，拷贝之后的是不可变的。
    // 编码时声明的var变量如果没有修改其具体数值，编译器会提示是否修改成let。看来let肯定是速度更快一些的

    // 值类型 包括基本数据类型 集合类型(数组 字典 集合) 在 变量赋值 函数传递 都是拷贝的
    // 引用类型  lambda和自定义类型 都是传引用的
    
    //let temp1 = [1, 2, 3] // let使数组等集合类型,分配在栈上,不能修改,比如调用append等方法
    var temp1 = [1, 2, 3]
    let temp2 = temp1  // 这里发生拷贝
    temp1.append(4)
    //temp2.append(5); // Cannot use mutating member on immutable value:
    for one in temp2 {
        print("值类型 变量赋值,函数传递 都是拷贝的 \(one) ")
    }// temp2 并没有新增加的4
    
    
 
    
    
}





