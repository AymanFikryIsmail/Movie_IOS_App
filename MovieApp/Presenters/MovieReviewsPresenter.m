//
//  MovieReviewsPresenter.m
//  MovieApp
//
//  Created by Admin on 4/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MovieReviewsPresenter.h"

@implementation MovieReviewsPresenter
-(instancetype)  initWithMovieReviewView : (id<IMovieReviewsView>) movieVReviewiew{
    self = [super init];
    
    if (self) {
        
        _movieVReviewiew= movieVReviewiew;
    }
    
    
    return self;
}
- (void)getMovieReviews:(MoviePOJO *)movie {
    Moviesservice *movieService = [Moviesservice new];
    [movieService getMoviesReviews:self :movie.mid];
    
}


- (void)onSuccess:(NSArray *)moviesReviews {
    [_movieVReviewiew  renderMoviesReviewsWithObject:moviesReviews];
    [_movieVReviewiew hideLoading];
}

- (void)onFail:(NSString *)errorMessage{
    [_movieVReviewiew showErrorMessage:errorMessage];
    [_movieVReviewiew hideLoading];
}



@end