//
//  MoviedetailsPresenter.m
//  MovieApp
//
//  Created by Admin on 3/28/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MoviedetailsPresenter.h"
#import "UIKit/UIKit.h"


@implementation MoviedetailsPresenter

-(instancetype) initWithMovieVDetailsiew : (id<IMovieDetailsView>) movieDetailsView{
    self = [super init];
    if (self) {
        _movieDetailsView= movieDetailsView;
    }
    return self;
}
-(void) playTrailer: (TrailerPOJO*) movie{
 
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *youtube = [NSURL URLWithString:movie.TrailerUrl];
    [application openURL:youtube options:@{} completionHandler:nil];
}
- (void)getMovieDetail : (MoviePOJO*) movie{
    NSURL* url = [[NSURL alloc] initWithString:@"http://google.com/"];
    NSData* data = [NSData dataWithContentsOfURL:url];
    if(data !=nil)
    {
        Moviesservice *movieService = [Moviesservice new];
        [movieService getMoviesDetails:self : movie.mid];
    }
    else
    {
        NSArray *moviesArray=[[DBManager getInstance] getTrailerData:movie] ;
        [self retrieveTrailers:moviesArray ];
        
    }
   
    [self onSuccess:movie];
}
- (void)retrieveTrailers:(NSArray *)moviesTrailer  {
    [_movieDetailsView  renderMoviesTrailerWithObject:moviesTrailer];
}
- (void)onSuccess:(MoviePOJO*) movie{
[_movieDetailsView  renderMovieDetailsWithObject];
[_movieDetailsView hideLoading];
}

- (void)onFail:(NSString *)errorMessage{
    [_movieDetailsView showErrorMessage:errorMessage];
    [_movieDetailsView hideLoading];
}


- (void)saveFavouriteMovies:(MoviePOJO *)movie {
    
    
    [[DBManager getInstance]updateFavData:movie];
}




@end
