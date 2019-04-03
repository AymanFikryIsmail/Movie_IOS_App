//
//  MovieReviewsViewController.h
//  MovieApp
//
//  Created by Admin on 4/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePOJO.h"
#import "MovieReviewsContract.h"
#import "MovieReviewsPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieReviewsViewController : UIViewController <IMovieReviewsView , UITableViewDelegate , UITableViewDataSource >

-(void) setMovieDetail :(MoviePOJO* )movieDetail;
@end

NS_ASSUME_NONNULL_END
