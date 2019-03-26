//
//  MoviePresenter.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContract.h"
#import "MoviesService.h"
#import "DBManager.h"
@interface MoviePresenter : NSObject <IMoviePresenter>

@property id<IMovieView> movieView;

-(instancetype) initWithMovieView : (id<IMovieView>) movieView;


@end

