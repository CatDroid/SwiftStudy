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

// 要使用字典键的任何自定义类型都必须符合Hashable协议。
// 这个协议有一个必须实现的属性。
// var hashValue: Int { get }
// 使用此属性生成一个int，字典可以使用它进行查找
// Hashable继承自Equatable您还必须实现
// func ==(_ lhs: Self, _ rhs: Self) -> Bool.

struct Pixel : Hashable {

    let x:Int  ;
    let y:Int  ;
    init(_ x:Int ,_ y:Int) {
        self.x = x ;
        self.y = y ;
    }
    
    // MARK: Hashable
//    var hashValue: Int {
//        get {
//            return self.x * 31499 + self.y
//        }
//    }
    
    // Swift字典的健 参数类型 必须是一个哈希类型/可哈希
    // 基本类型 String Int Double Bool 都是可哈希
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.x)
            hasher.combine(self.y)
    }
    
    // 不是所有的类型都可以用全等号 == 进行比较的  比如我们自定义的类型和结构体
    // Swift标准库中定义了 Equatable 协议 这个协议要求class/struct实现全等操作符和不等操作符
    static func ==(lh: Pixel, rh: Pixel) -> Bool {
        return lh.x == rh.x && rh.y == lh.y
    }
}



// extension Stack<Element> 扩展可以直接用类型参数名
extension Stack {
    // 计算属性。 扩展中不能有存储属性
    var first: Element? { // 'let' declarations cannot be computed properties let不能修饰计算属性
        
        return array.isEmpty ? nil: array[array.count - 1]; // 三目运算符
    }
    
}

func findFirstMatched<T:Equatable>(_ array:[T], _ wanted:T)->Int?
{
    for (index,value) in array.enumerated() {
        if (value == wanted) {
            return index
        }
    }
    return nil
}


// 关联类型，协议中的泛型 在协议实现之前都不需要指定
protocol MyContainerProtocol {
    
    associatedtype U
    // 实现类可以 使用  typealias WeightType = Double
    
    mutating func addOne(_ one:U)
    
    subscript(i:Int) -> U  { get } // subscript只支持读
    
    var myCount:Int {get}  // 只读属性
    
}

extension Array : MyContainerProtocol{

    typealias U = Element
    
    var myCount: Int {
        return self.count
    }
    
    mutating func addOne(_ one:U)
    {
        self.append(one)
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
    
    
    // 类型约束 必须继承某个类或者某个协议/协议组合
    print("类型约束 全等操作符== 必须继承标准库协议Equatable \(findFirstMatched([Pixel(2,3), Pixel(7,6), Pixel(1,200), Pixel(5,6)],Pixel(1,200))!)" );
    
    
    var extesionArray = [2, 7 ,8]
    extesionArray.addOne(1);
    print("协议中的关联类型 associateType 和 typealias  \(extesionArray.myCount)" ) // 4
    
    
}





