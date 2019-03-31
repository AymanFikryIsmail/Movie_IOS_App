//
//  MoviedetailsPresenter.h
//  MovieApp
//
//  Created by Admin on 3/28/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieDetailsContract.h"
#import "DBManager.h"
#import "MoviesService.h"

@interface MoviedetailsPresenter :  NSObject <IMovieDetailsPresenter>

@property id<IMovieDetailsView> movieDetailsView;

-(instancetype) initWithMovieVDetailsiew : (id<IMovieDetailsView>) movieDetailsView;


@end
