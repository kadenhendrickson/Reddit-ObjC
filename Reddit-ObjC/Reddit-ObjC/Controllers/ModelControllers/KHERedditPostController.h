//
//  KHERedditPostController.h
//  Reddit-ObjC
//
//  Created by Kaden Hendrickson on 5/22/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class KHERedditPost;

NS_ASSUME_NONNULL_BEGIN

@interface KHERedditPostController : NSObject

@property (nonatomic, copy) NSArray<KHERedditPost *> *posts;

+(instancetype)shared;

-(void)fetchPosts:(void (^) (BOOL))completion;

-(void)fetchImageForPost:(KHERedditPost *)post completion:(void (^) (UIImage *_Nullable image))completion;

@end

NS_ASSUME_NONNULL_END
