//
//  recordDemo.h
//  MyApp
//
//  Created by Phan Quy Ky on 3/18/16.
//  Copyright © 2016 Phan Quy Ky. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface recordDemo : NSManagedObject


@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *hunidity;
@property (strong, nonatomic) NSString *tempC;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *windSpeed;


@end
