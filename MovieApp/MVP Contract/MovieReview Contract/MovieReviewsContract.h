//
//  MovieReviewsContract.h
//  MovieApp
//
//  Created by Admin on 4/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContract.h"
#import "MoviePOJO.h"

//@protocol MovieReviewsContract <NSObject>
//@end
@protocol IMovieReviewsView <IBaseView>

- (void)renderMoviesReviewsWithObject:(NSMutableArray *)movieReviewsList ;

@end

@protocol IMovieReviewsPresenter <NSObject>

-(void) getMovieReviews: (MoviePOJO*) movie;

-(void) onSuccess : (NSArray *)moviesReviews  ;
-(void) onFail : (NSString*) errorMessage;
@end

@protocol IMovieReviewsManager <NSObject>

-(void) getMoviesReviews : (id<IMovieReviewsPresenter>) movieReviewsPresenter :(NSString*)movieId;

@end


