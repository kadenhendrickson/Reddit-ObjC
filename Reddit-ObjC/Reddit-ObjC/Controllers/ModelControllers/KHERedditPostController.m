//
//  KHERedditPostController.m
//  Reddit-ObjC
//
//  Created by Kaden Hendrickson on 5/22/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "KHERedditPostController.h"
#import "KHERedditPost.h"


static NSString * const baseURLString = @"http://www.reddit.com/.json";

@implementation KHERedditPostController

+ (instancetype)shared
{
    static KHERedditPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [KHERedditPostController new];
    });
    return shared;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL *url = [[NSURL alloc]initWithString:baseURLString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(NO);
            return;
        }
    
        if (!data) {
            NSLog(@"Data is missing!");
            completion(NO);
            return;
        }
        
        NSDictionary *topLevelJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *topLevelDataDictionary = topLevelJson[@"data"];
        NSArray<NSDictionary *> *childrenArray = topLevelDataDictionary[@"children"];
        NSMutableArray<KHERedditPost *> *arrayOfPost = [NSMutableArray new];
        
        for (NSDictionary *currentDictionary in childrenArray) {
            KHERedditPost *post = [[KHERedditPost alloc] initWithDictionary:currentDictionary];
            [arrayOfPost addObject:post];
        }
        
        KHERedditPostController.shared.posts = arrayOfPost;
        completion(YES);
        
    }] resume];
}

- (void)fetchImageForPost:(KHERedditPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:post.thumbnail];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if(!data) {
            NSLog(@"There was an error fetching data");
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
}

@end
