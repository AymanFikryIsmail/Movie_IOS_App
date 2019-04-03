//
//  MovieReviewsViewController.m
//  MovieApp
//
//  Created by Admin on 4/3/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MovieReviewsViewController.h"
#import "MoviePOJO.h"
@interface MovieReviewsViewController ()
{
     MoviePOJO* movieDetails;
    NSMutableArray * movieReviewlist ;
}
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;

@end

@implementation MovieReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       MovieReviewsPresenter*  moviereviewPresenter = [[MovieReviewsPresenter alloc] initWithMovieReviewView:self];
        [moviereviewPresenter getMovieReviews:self->movieDetails];
    });
    // Do any additional setup after loading the view.
}
-(void) setMovieDetail :(MoviePOJO* )movieDetail{
     movieDetails=[MoviePOJO new];
    movieDetails=movieDetail;
    printf(" %s name \n",[ movieDetails.poster_path UTF8String]);
    
    //;
}
- (IBAction)backToDetails:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideLoading {
    
}

- (void)showErrorMessage:(nonnull NSString *)errorMessage {
    
}

- (void)showLoading {
    
}

- (void)renderMoviesReviewsWithObject:(NSMutableArray *)movieReviewsList {
    self->movieReviewlist=movieReviewsList;
        [self.reviewTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [movieReviewlist count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewcell" forIndexPath:indexPath];
//    UIImageView  *imageView  = [cell viewWithTag:1];
//    UILabel *trailerLabel = [cell viewWithTag:2];
//    TrailerPOJO* trailer=[movieTrailerlist objectAtIndex:indexPath.row];
//    [trailerLabel setText:[trailer trailerName]];
  
    
    return cell;
}

@end