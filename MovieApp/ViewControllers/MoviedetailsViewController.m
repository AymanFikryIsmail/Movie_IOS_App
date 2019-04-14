//
//  MoviedetailsViewController.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MoviedetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoviePOJO.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "MovieReviewsViewController.h"
@interface MoviedetailsViewController ()
{
    MoviePOJO* movieDetails;
    NSMutableArray * movieTrailerlist ;
    HCSStarRatingView *starRatingView;
    MoviedetailsPresenter *movieDetailsPresenter ;
}
@property (weak, nonatomic) IBOutlet UILabel *movieTilte;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UITextView *movieOverview;
@property (weak, nonatomic) IBOutlet UILabel *movieDate;
@property (weak, nonatomic) IBOutlet UIImageView *movieFavImage;
@property (weak, nonatomic) IBOutlet UITableView *trailerTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroungImage;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;

@end

@implementation MoviedetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"Movie Details";
    _reviewBtn.layer.cornerRadius = 10;
    _reviewBtn.layer.shadowOpacity = 1.0f;
    _reviewBtn.layer.masksToBounds = NO;
     starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(200, 300, 150, 50)];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
   
    starRatingView.accurateHalfStars = YES;
    starRatingView.allowsHalfStars = YES;
    starRatingView.enabled=false;
    starRatingView.emptyStarImage = [UIImage imageNamed:@"fav.png"];
    starRatingView.halfStarImage = [UIImage imageNamed:@"fav.png"]; // optional
    starRatingView.filledStarImage = [UIImage imageNamed:@"fav2.png"];
    starRatingView.tintColor = [UIColor redColor];
    starRatingView.backgroundColor=[UIColor clearColor];
   // [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
   // movieDetails = [movieDetails new];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        self->movieDetailsPresenter = [[MoviedetailsPresenter alloc] initWithMovieVDetailsiew:self];
        [self->movieDetailsPresenter getMovieDetail:self->movieDetails];
    });
      [self renderMovieDetailsWithObject];
}
-(void) setMovieDetail :(MoviePOJO* )movieDetail{
   // movieDetails=[MoviePOJO new];
    movieDetails=movieDetail;
  
    printf(" %s name \n",[ movieDetails.poster_path UTF8String]);
 }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)hideLoading {
    
}

- (void)showErrorMessage:(nonnull NSString *)errorMessage {
    
}

- (void)showLoading {
    
}

- (void)renderMovieDetailsWithObject {
    _movieTilte.text=movieDetails.title;
    _movieOverview.text=movieDetails.overview;
    _movieDate.text=movieDetails.release_date;
    starRatingView.value=[movieDetails.vote_average floatValue]/2;
    if([movieDetails.isFavourite isEqualToString:@"true"]){
        _movieFavImage.image=[UIImage imageNamed:@"heart-full.png"];
    }
    else{
        _movieFavImage.image=[UIImage imageNamed:@"heart-empty.png"];
    }
    NSString *imgPath=@"https://image.tmdb.org/t/p/w185//";
    NSString *imgData=movieDetails.poster_path;// poster_path  for network
    
    if (imgData == (id)[NSNull null] || imgData.length == 0 ) {
        imgData = @"";
    }
    
    imgPath=[imgPath stringByAppendingString: imgData   ];
    [_movieImage sd_setImageWithURL:[NSURL URLWithString:imgPath]
                 placeholderImage:[UIImage imageNamed:@"defaultPoster.jpg"]];
    [_backgroungImage sd_setImageWithURL:[NSURL URLWithString:imgPath]
                   placeholderImage:[UIImage imageNamed:@"defaultPoster.jpg"]];
    //[[_movieImage sd_setImageWithURL:[NSURL URLWithString: imgPath]placeholderImage:[UIImage imageNamed:@"defaultPoster.jpg"];
    
   // [_backgroungImage sd_setImageWithURL:[NSURL URLWithString: imgPath]];
//placeholderImage:[UIImage imageNamed:@"defaultPoster.jpg"];
    
}
- (IBAction)tabFavImage:(id)sender {
    if([movieDetails.isFavourite isEqualToString:@"false"]){
        _movieFavImage.image=[UIImage imageNamed:@"heart-full.png"];
        movieDetails.isFavourite=@"true";
        if ([[[DBManager getInstance] checkISFavData:movieDetails] count] >0) {
        [[DBManager getInstance] updateFavData:movieDetails];
        }else{
             [[DBManager getInstance] saveFavouriteData:movieDetails];
        }
    }
    else{
        _movieFavImage.image=[UIImage imageNamed:@"heart-empty.png"];
        movieDetails.isFavourite=@"false";
        [[DBManager getInstance] updateFavData:movieDetails];
       // [[DBManager getInstance] updateFavData:movieDetails];  saveFavouriteData
    }

}
- (IBAction)gotoReviews:(id)sender {
    MovieReviewsViewController *review=[self.storyboard instantiateViewControllerWithIdentifier:@"moviereview"];
    [review setMovieDetail:movieDetails];
   // [self presentViewController:review animated:YES completion:nil];
      [self.navigationController pushViewController:review animated:YES];
}
//- (IBAction)backToHome:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)renderMoviesTrailerWithObject:(NSArray *)movieTrailerist  {
    self->movieTrailerlist=movieTrailerist;
    [self.trailerTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [movieTrailerlist count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trailercell" forIndexPath:indexPath];
    //  UIImageView  *imageView  = [cell viewWithTag:1];
    UILabel *trailerLabel = [cell viewWithTag:2];
    TrailerPOJO* trailer=[movieTrailerlist objectAtIndex:indexPath.row];
    [trailerLabel setText:[trailer trailerName]];
//    imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TrailerPOJO* trailer=[movieTrailerlist objectAtIndex:indexPath.row];
    [movieDetailsPresenter playTrailer:trailer];
    
    
    
}

@end
