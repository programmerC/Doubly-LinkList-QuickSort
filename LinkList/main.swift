//
//  main.swift
//  LinkList
//
//  Created by ChenKaijie on 16/11/10.
//  Copyright © 2016年 com.ckj. All rights reserved.
//

import Foundation

var linkList = LinkList<Int>()
linkList.append(value: 12)
linkList.append(value: 5)
linkList.append(value: 30)
linkList.append(value: 3)
linkList.append(value: 3)
linkList.append(value: 2)
linkList.append(value: 9)
linkList.append(value: 4)
linkList.append(value: 11)
linkList.append(value: 19)
linkList.append(value: 15)
linkList.append(value: 16)

print("Init Data: \(linkList)")

var firstNode = linkList.searchIndex(index: 0)
var endNode = linkList.searchIndex(index: linkList.linkListSize() - 1)
quickSort(linkList: &linkList, low: &firstNode, high: &endNode)

print("After QuickSort: \(linkList)")
