//
//  Moviesservice.h
//  MovieApp
//
//  Created by Admin on 3/25/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkObserver.h"
#import "ServiceProtocol.h"
#import "MovieContract.h"
#import "MovieDetailsContract.h"
#import "MovieReviewsContract.h"
#import "NetworkManager.h"

@interface Moviesservice : NSObject <NetworkObserver , ServiceProtocol , IMovieManager , IMovieDetailsManager , IMovieReviewsManager>

@property id<IMoviePresenter> moviePresenter;
@property id<IMovieDetailsPresenter> moviedetailsPresenter;
@property id<IMovieReviewsPresenter> movieReviewsPresenter;

@end
