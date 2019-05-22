//
//  KHERedditPost.h
//  Reddit-ObjC
//
//  Created by Kaden Hendrickson on 5/22/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KHERedditPost : NSObject

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy, nullable)NSString *thumbnail;

-(instancetype)initWithTitle:(NSString *)title andThumbnail:(NSString *)thumbnail;




@end

@interface KHERedditPost  (JsonConvertible)

-(instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
