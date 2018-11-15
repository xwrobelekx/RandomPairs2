//
//  RandomPairController.swift
//  RandomPairs2
//
//  Created by Kamil Wrobel on 11/15/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


class RandomPairController {
    
    
    //MARK: - Singleton
    static let shared = RandomPairController()
    private init(){}
    
    
    //MARK: - Source Of Truth
    var people = [String]()
    
    
    //MARK: - Crud
    func add(person: String){
        people.append(person)
    }
    
    func remove(at index: Int){
        people.remove(at: index)
    }
    
    
    //MARK: - Converts to double array
    func splitInPairs(array: [String]) -> [[String]]{
        var counter = 1
        var index = 0
        var masterarray = [[String]]()
        var pair = [String]()
        
        while index <= (array.count - 1) {
            if counter <= 2{
                counter += 1
                pair.append(array[index])
                index += 1
                
            } else {
                masterarray.append(pair)
                counter = 1
                pair = []
            }
        }
        masterarray.append(pair)
        return masterarray
    }
    
    

    
    
    
}
