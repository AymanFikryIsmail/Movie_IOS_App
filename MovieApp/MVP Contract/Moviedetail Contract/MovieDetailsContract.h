//
//  MovieDetailsContract.h
//  MovieApp
//
//  Created by Admin on 3/28/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContract.h"
#import "MoviePOJO.h"
#import "TrailerPOJO.h"

//@protocol MovieDetailsContract <NSObject>
@protocol IMovieDetailsView <IBaseView>

-(void) renderMovieDetailsWithObject ;
- (void)renderMoviesTrailerWithObject:(NSArray *)movieTrailerist ;

@end

@protocol IMovieDetailsPresenter <NSObject>

-(void) getMovieDetail: (MoviePOJO*) movie;
-(void) saveFavouriteMovies: (MoviePOJO*) movie;
-(void) playTrailer: (TrailerPOJO*) movie;
- (void)retrieveTrailers:(NSArray *)moviesTrailer  ;
-(void) onSuccess : (MoviePOJO*) movie;
-(void) onFail : (NSString*) errorMessage;
@end

@protocol IMovieDetailsManager <NSObject>

-(void) getMoviesDetails : (id<IMovieDetailsPresenter>) movieDetailsPresenter :(NSString*)movieId;

@end


