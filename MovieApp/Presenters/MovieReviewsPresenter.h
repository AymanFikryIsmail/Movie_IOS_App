//
//  MovieReviewsPresenter.h
//  MovieApp
//
//  Created by Admin on 4/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MovieReviewsContract.h"
#import "MoviesService.h"
#import "DBManager.h"
@interface MovieReviewsPresenter : NSObject <IMovieReviewsPresenter>

@property id<IMovieReviewsView> movieVReviewiew;

-(instancetype) initWithMovieReviewView : (id<IMovieReviewsView>) movieVReviewiew;

@end
