//
//  MoviePresenter.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MoviePresenter.h"
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
    
    //
    Moviesservice *movieService = [Moviesservice new];
      [movieService getMovies:self];
    
    
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

