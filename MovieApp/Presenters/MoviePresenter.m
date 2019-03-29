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
    
//    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)

    NSURL* url = [[NSURL alloc] initWithString:@"http://google.com/"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if (data != nil){
        Moviesservice *movieService = [Moviesservice new];
    [movieService getMovies:self];
     } else{
    NSArray *moviesArray=[[DBManager getInstance] getAllData] ;
     [self onSuccess:moviesArray];
       }

}

- (void)onSuccess:(NSArray *)movies {
    
    NSUserDefaults *def=[NSUserDefaults standardUserDefaults];
    BOOL isFirst= [def boolForKey:@"isLunch"];
    if (!isFirst) {
         [[DBManager getInstance] saveData:movies ] ;
        [def setBool:true  forKey:@"isLunch"];
    }

    [_movieView renderMoviesWithObject:movies];
    [_movieView hideLoading];
    
}


- (void)onFail:(NSString *)errorMessage{
    
    [_movieView showErrorMessage:errorMessage];
    [_movieView hideLoading];
}

@end

