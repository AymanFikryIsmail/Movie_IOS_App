//
//  FavouriteMovieViewController.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieContract.h"
#import "MoviePresenter.h"
@interface FavouriteMovieViewController : UIViewController <IMovieView , UICollectionViewDelegate , UICollectionViewDataSource>

@end
