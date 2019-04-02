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
-(void) playTrailer: (MoviePOJO*) movie{
 
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *youtube = [NSURL URLWithString:@"ttp://www.youtube.com/watch?v=Jeh40KFFS5Y"];
    [application openURL:youtube options:@{} completionHandler:nil];

     //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString: youtubePageName] options:@{} completionHandler:nil];
}
- (void)getMovieDetail : (MoviePOJO*) movie{
    Moviesservice *movieService = [Moviesservice new];
    [movieService getMoviesDetails:self : movie.mid];
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
