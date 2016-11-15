//
//  LinkList.swift
//  LinkList
//
//  Created by ChenKaijie on 16/11/10.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import Foundation

class Node<T> {
    var value: T
    var next: Node?
    weak var previous: Node?

    init(value: T) {
        self.value = value
    }
}

class LinkList<T: Comparable> {
    var head: Node<T>?
    var tail: Node<T>?
    
    // Add
    func append(value: T) {
        let newNode = Node.init(value: value)
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        }
        else {
            head = newNode
        }
        tail = newNode
    }
    
    // Size
    func linkListSize() -> Int {
        if let node = head {
            var index = 1
            var node = node.next
            while node != nil {
                index += 1
                node = node?.next
            }
            return index
        }
        else {
            return 0
        }
    }
    
    // Search
    func searchNode(indexNode: Node<T>) -> Int {
        if let node = head {
            if node === indexNode {
                return 0
            }
            else {
                var index: Int = 0
                var node = node.next
                while node != nil {
                    index += 1
                    if node === indexNode {
                        return index
                    }
                    node = node?.next
                }
                // 不存在返回-1
                return -1
            }

        }
        else {
            // 不存在返回-1
            return -1
        }
    }
    
    func lowBeforeHigh(low: Node<T>, high: Node<T>) -> Bool {
        if low === high {
            return false
        }
        else {
            var node = low.next
            while node != nil {
                if node === high {
                    return true
                }
                node = node?.next
            }
        }
        return false
    }
    
    func searchIndex(index: Int) -> Node<T>? {
        if let node = head {
            if index == 0 {
                return node
            }
            else {
                var node = node.next
                var nodeIndex: Int = 1
                while node != nil {
                    if nodeIndex == index {
                        return node
                    }
                    nodeIndex += 1
                    node = node?.next
                }
                return nil
            }
        }
        else {
            return nil
        }
    }
    
    // Remove
    func remove(node: Node<T>) -> T {
        let preNode = node.previous
        let nextNode = node.next
        
        if let preNode = preNode {
            // 前节点存在
            preNode.next = nextNode
        }
        else {
            // 不存在前节点，将nextNode置成head
            head = nextNode
        }
        nextNode?.previous = preNode
        
        if nextNode == nil {
            tail = preNode
        }
        
        // 将node置成nil
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
}

extension LinkList: CustomStringConvertible {
    var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node?.value)"
            node = node?.next
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
}

//MARK: - QuickSort
func quickSort(linkList: inout LinkList<Int>, low: inout Node<Int>?, high: inout Node<Int>?) {
    guard linkList.head != nil && linkList.tail != nil else {
        return
    }
    guard low != nil && high != nil else {
        return
    }
    guard linkList.lowBeforeHigh(low: low!, high: high!) else {
        return
    }
    
    let midIndex = partition(linkList: &linkList, low: &low!, high: &high!)
    // 递归
    quickSort(linkList: &linkList, low: &low, high: &linkList.searchIndex(index: midIndex )!.previous)
    quickSort(linkList: &linkList, low: &linkList.searchIndex(index: midIndex)!.next, high: &high)
}

func partition(linkList: inout LinkList<Int>, low: inout Node<Int>, high: inout Node<Int>) -> Int {
    var value: Int = 0
    var lowNode = low
    var highNode = high
    let lowValue = low.value
    
    while linkList.lowBeforeHigh(low: lowNode, high: highNode) {
        // 从右边向左边扫描
        while linkList.lowBeforeHigh(low: lowNode, high: highNode) && highNode.value >= lowValue {
            highNode = highNode.previous!
        }

        if highNode === lowNode {
            value = linkList.searchNode(indexNode: lowNode)
            break
        }
        
        // lowNode和highNode交换值
        let temp1Value = lowNode.value
        lowNode.value = highNode.value
        highNode.value = temp1Value
        
        // 从左边向右边扫描
        while linkList.lowBeforeHigh(low: lowNode, high: highNode) && lowNode.value <= lowValue {
            lowNode = lowNode.next!
        }
        if lowNode === highNode {
            value = linkList.searchNode(indexNode: lowNode)
            break
        }
        // lowNode和highNode交换值
        let temp2Value = lowNode.value
        lowNode.value = highNode.value
        highNode.value = temp2Value
    }
    return value
}

func swapTwoNode(low: inout Node<Int>, high: inout Node<Int>) {
    // 相邻节点
    if low.next === high {
        low.previous?.next = high
        high.previous = low.previous
        
        low.previous = high
        low.next = high.next
        
        high.next?.previous = low
        high.next = low
    }
    else {
        // 非相邻节点
        low.previous?.next = high
        low.next?.previous = high
        
        high.next?.previous = low
        high.previous?.next = low
        
        let temp1 = low.previous
        low.previous = high.previous
        high.previous = temp1
        
        let temp2 = low.next
        low.next = high.next
        high.next = temp2
    }
}
