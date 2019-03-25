//
//  MoviePresenter.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MoviePresenter.h"

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
    
    Moviesservice *movieService = [Moviesservice new];
      [movieService getMovies:self];
}

- (void)onSuccess:(MoviePOJO *)movie {
    
    [_movieView renderMoviesWithObject:movie];
    [_movieView hideLoading];
    
}


- (void)onFail:(NSString *)errorMessage{
    
    [_movieView showErrorMessage:errorMessage];
    [_movieView hideLoading];
}

@end
