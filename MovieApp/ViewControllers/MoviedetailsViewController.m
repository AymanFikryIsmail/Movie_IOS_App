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
@interface MoviedetailsViewController ()
{
    MoviePOJO* movieDetails;
    
}
@property (weak, nonatomic) IBOutlet UILabel *movieTilte;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

@end

@implementation MoviedetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
   // movieDetails = [movieDetails new];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        MoviedetailsPresenter *movieDetailsPresenter = [[MoviedetailsPresenter alloc] initWithMovieVDetailsiew:self];
        [movieDetailsPresenter getMovieDetail:self->movieDetails];
    });
}
-(void) setMovieDetail :(MoviePOJO* )movieDetail{
    movieDetails=movieDetail;
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
    NSString *imgPath=@"https://image.tmdb.org/t/p/w185//";
    NSString *imgData=movieDetails.poster_path;// poster_path  for network
    
    if (imgData == (id)[NSNull null] || imgData.length == 0 ) {
        imgData = @"";
    }
    
    imgPath=[imgPath stringByAppendingString: imgData   ];
    [_movieImage sd_setImageWithURL:[NSURL URLWithString: imgPath]];
placeholderImage:[UIImage imageNamed:@"1.png"];
    
}


@end
