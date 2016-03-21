//
//  respon.swift
//  MyApp
//
//  Created by Phan Quy Ky on 3/18/16.
//  Copyright © 2016 Phan Quy Ky. All rights reserved.
//

import UIKit

class respon: NSObject {
    
    func addProduct(product: recordDemo) {
        MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait { (context) -> Void in
            let entity = recordDemo.MR_createInContext(context) as! recordDemo
            
            entity.desc = product.desc
            entity.hunidity = product.hunidity
//            entity.price = product.price
        }
    }
    
    func updateProduct(product: recordDemo) {
        MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait { (context) -> Void in
            let predicate = NSPredicate(format: "desc = '\(product.desc)'")
            if let entity = recordDemo.MR_findFirstWithPredicate(predicate, inContext: context) as? recordDemo {
                entity.hunidity = product.hunidity
//                entity.price = product.price
            }
        }
    }
    
    func deleteProduct(productId: String) {
        MagicalRecord.saveUsingCurrentThreadContextWithBlockAndWait { (context) -> Void in
            let predicate = NSPredicate(format: "desc = '\(productId)'")
            recordDemo.MR_deleteAllMatchingPredicate(predicate, inContext: context)
        }
    }
    
//    func getProductById(productId: String) -> recordDemo? {
//        var context = NSManagedObjectContext.MR_contextForCurrentThread()
//        var predicate = NSPredicate(format: "id = '\(productId)'")
//        if let product = Product.MR_findFirstWithPredicate(predicate, inContext: context) as? Product {
//            return product
//        }
//        return nil
//    }
    
    func getProducts() -> [recordDemo]? {
        let context = NSManagedObjectContext.MR_contextForCurrentThread()
        
        if let products = recordDemo.MR_findAllInContext(context) as! [recordDemo]? {
            return products
        }
        return nil
    }
}
