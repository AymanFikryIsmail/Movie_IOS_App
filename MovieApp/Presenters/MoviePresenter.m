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

-(instancetype) initWithMovieView : (id<IMovieView>) movieView{
    self = [super init];
    
    if (self) {
        
        _movieView = movieView;
    }
    
    
    return self;
}
- (void)getMovies {
    [_movieView showLoading];
 
    
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"WWN");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"Unknown");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"Not Reachable");
                break;
            default:
                break;
        }
    }];
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://google.com/"];
    NSData* data = [NSData dataWithContentsOfURL:url];
   // if ([[AFNetworkReachabilityManager sharedManager] isReachable])
    if(data !=nil)
    {
        Moviesservice *movieService = [Moviesservice new];
        [movieService getMovies:self];
    }
    else
    {
        NSArray *moviesArray=[[DBManager getInstance] getAllData] ;
        [self onSuccess:moviesArray : false];
    }
    
}

- (void)onSuccess:(NSArray *)movies : (Boolean) isFromNetwrok {
    
    //NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
//    BOOL isFirst= [def boolForKey:@"isLunch"];
//    if (!isFirst) {
//         [[DBManager getInstance] saveData:movies ] ;
//        [def setBool:true  forKey:@"isLunch"];
//    }
    [[DBManager getInstance]deleteAll];
  [[DBManager getInstance] saveData:movies ] ;
    [_movieView renderMoviesWithObject:movies :isFromNetwrok];
    [_movieView hideLoading];
    
}


- (void)onFail:(NSString *)errorMessage{
    
    [_movieView showErrorMessage:errorMessage];
    [_movieView hideLoading];
}

@end

