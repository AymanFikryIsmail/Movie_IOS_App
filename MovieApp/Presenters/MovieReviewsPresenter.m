//
//  MovieReviewsPresenter.m
//  MovieApp
//
//  Created by Admin on 4/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MovieReviewsPresenter.h"

@implementation MovieReviewsPresenter
{
@protected MoviePOJO* mMovie;
}
-(instancetype)  initWithMovieReviewView : (id<IMovieReviewsView>) movieVReviewiew{
    self = [super init];
    
    if (self) {
        
        _movieVReviewiew= movieVReviewiew;
    }
    
    
    return self;
}
- (void)getMovieReviews:(MoviePOJO *)movie {
    mMovie=movie;
    NSURL* url = [[NSURL alloc] initWithString:@"http://google.com/"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if(data !=nil)
    {
        Moviesservice *movieService = [Moviesservice new];
        [movieService getMoviesReviews:self :movie.mid];
    }
    else
    {
        NSArray *moviesArray=[[DBManager getInstance] getReviewData:movie] ;
        [self onSuccess:moviesArray ];
        
    }
}


- (void)onSuccess:(NSArray *)moviesReviews {
    NSArray *moviesArray=[[DBManager getInstance] getReviewData:mMovie] ;
    if (moviesArray.count ==0) {
        [[DBManager getInstance] saveReviewData : moviesReviews:mMovie];
    }
    
    [_movieVReviewiew  renderMoviesReviewsWithObject:moviesReviews];
    [_movieVReviewiew hideLoading];
}

- (void)onFail:(NSString *)errorMessage{
    [_movieVReviewiew showErrorMessage:errorMessage];
    [_movieVReviewiew hideLoading];
}



@end
