//
//  MoviePresenter.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MoviePresenter.h"

#import <AFNetworkReachabilityManager.h>
//#import "Reachability.h"
@implementation MoviePresenter
{
@protected int msortType;
}
-(instancetype) initWithMovieView : (id<IMovieView>) movieView{
    self = [super init];
    
    if (self) {
        
        _movieView = movieView;
    }
    
    
    return self;
}
- (void)getMovies :(int) sortType {
    [_movieView showLoading];
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
//    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
////            case AFNetworkReachabilityStatusReachableViaWWAN:
////                NSLog(@"WWN");
////                break;
////            case AFNetworkReachabilityStatusReachableViaWiFi:
////                NSLog(@"WiFi");
////                break;
////            case AFNetworkReachabilityStatusUnknown:
////                NSLog(@"Unknown");
////                break;
//            case AFNetworkReachabilityStatusNotReachable:
//            {
////                NSMutableArray *moviesArray=[NSMutableArray new];
//                NSArray *moviesArray=[[DBManager getInstance] getAllData : sortType] ;
//                self->msortType=sortType;
//                // Query Realm for all dogs less than 2 years old
////                RLMResults<MoviePOJO *> *puppies = [MoviePOJO objectsWhere:@"sortType = 0"];
////               NSUInteger a= puppies.count; // => 0 because no dogs have been added to the Realm yet
////                for (RLMObject *object in puppies) {
////                    [moviesArray addObject:object];
////                }
//                [self onSuccess:moviesArray : false];
//                break;
//            }
//            default:
//            {Moviesservice *movieService = [Moviesservice new];
//                [movieService getMovies:self : sortType] ;
//                break;
//            }
//        }
//    }];
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://google.com/"];
    NSData* data = [NSData  dataWithContentsOfURL:url ];
    if(data !=nil)
//    if ([[AFNetworkReachabilityManager sharedManager] isReachable])
    {
    Moviesservice *movieService = [Moviesservice new];
    [movieService getMovies:self : sortType] ;
    }
    else
    {
    NSArray *moviesArray=[[DBManager getInstance] getAllData : sortType] ;
    self->msortType=sortType;
    [self onSuccess:moviesArray : false];
    }

}

- (void)onSuccess:(NSArray *)movies : (Boolean) isFromNetwrok {
    
    if (isFromNetwrok)
    {
        [[DBManager getInstance]deleteAll];
//
//        [[RLMRealm defaultRealm] beginWriteTransaction];
//        [[RLMRealm defaultRealm]deleteAllObjects];
//        [[RLMRealm defaultRealm] commitWriteTransaction];
        if (movies.count!=0) {
            [[DBManager getInstance] saveData:movies : msortType] ;
            
            // Persist your data easily
//            RLMRealm *realm = [RLMRealm defaultRealm];
//            for (int i=0; i<[movies count]; i++) {
//                [realm transactionWithBlock:^{
//                    [realm addObject:movies[i]];
//                }];
//            }
        }
    }
     [_movieView hideLoading];
    [_movieView renderMoviesWithObject:movies :isFromNetwrok];
}


- (void)onFail:(NSString *)errorMessage{
    
    [_movieView showErrorMessage:errorMessage];
    [_movieView hideLoading];
}

@end

