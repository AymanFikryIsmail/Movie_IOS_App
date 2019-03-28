//
//  FavouriteMoviePresenter.h
//  MovieApp
//
//  Created by Admin on 3/27/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieContract.h"
#import "DBManager.h"

@interface FavouriteMoviePresenter : NSObject <IMoviePresenter>

@property id<IMovieView> movieView;

-(instancetype) initWithMovieView : (id<IMovieView>) movieView;

@end
