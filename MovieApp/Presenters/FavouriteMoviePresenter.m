//
//  FavouriteMoviePresenter.m
//  MovieApp
//
//  Created by Admin on 3/27/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "FavouriteMoviePresenter.h"

@implementation FavouriteMoviePresenter

-(instancetype) initWithMovieView : (id<IMovieView>) movieView{
    self = [super init];
    
    if (self) {
        
        _movieView = movieView;
    }
    
    
    return self;
}
- (void)getMovies :(int ) sortType{
    [_movieView showLoading];
        NSArray *moviesArray=[[DBManager getInstance] getFavData] ;
    [self onSuccess:moviesArray: false];
}

- (void)onSuccess:(NSArray *)movies :(Boolean)isFromNetwrok {
    
    
    [_movieView renderMoviesWithObject:movies:false];
    [_movieView hideLoading];
    
}


- (void)onFail:(NSString *)errorMessage{
    
    [_movieView showErrorMessage:errorMessage];
    [_movieView hideLoading];
}




@end
