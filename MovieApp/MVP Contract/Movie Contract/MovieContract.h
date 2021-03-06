//
//  MovieContract.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContract.h"
#import "MoviePOJO.h"

//MovieContract
@protocol IMovieView <IBaseView>

-(void) renderMoviesWithObject : (NSArray<MoviePOJO *> *)movieList: (Boolean) isFromNetwrok;

@end

@protocol IMoviePresenter <NSObject>

-(void) getMovies :(int) sortType;
-(void) onSuccess : (NSArray*) movie :(Boolean) isFromNetwrok ;
-(void) onFail : (NSString*) errorMessage;

@end

@protocol IMovieManager <NSObject>

-(void) getMovies : (id<IMoviePresenter>) moviePresenter :(int) sortType;

@end

