//
//  MoviedetailsViewController.h
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailsContract.h"
#import "MoviedetailsPresenter.h"

@interface MoviedetailsViewController : UIViewController<IMovieDetailsView , UITableViewDelegate , UITableViewDataSource >


-(void) setMovieDetail :(MoviePOJO* )movieDetail;
@end
