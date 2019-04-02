//
//  MovieListViewController.m
//  MovieApp
//
//  Created by Admin on 3/24/19.
//  Copyright © 2019 ITI. All rights reserved.
//

#import "MovieListViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MoviePOJO.h"

#import "MoviedetailsViewController.h"
@interface MovieListViewController ()
{
    NSMutableArray  *myData;
    UIAlertView *progreesAlert;
    UIActivityIndicatorView *indicator;
     Boolean isDataFromNetwrok ;
}
@property (weak, nonatomic) IBOutlet UICollectionView *moviesCollectionView;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"Movies";
    progreesAlert = [[UIAlertView alloc] initWithTitle:@"\n\nLoading data\nPlease Wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    indicator= [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    [progreesAlert show];
    
    indicator.center = CGPointMake(progreesAlert.bounds.size.width / 2, progreesAlert.bounds.size.height - 50);
    
    [indicator startAnimating];
    [progreesAlert addSubview:indicator];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    myData = [NSMutableArray new];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //Background Thread
        
        MoviePresenter *moviePresenter = [[MoviePresenter alloc] initWithMovieView:self];
        [moviePresenter getMovies];
    });
     [self.moviesCollectionView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return myData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"moviecell" forIndexPath:indexPath];
    // Configure the cell
    UIImageView *imageView = [cell viewWithTag:1];
    NSString *imgPath=@"https://image.tmdb.org/t/p/w185//";
     MoviePOJO *movieDetails2= myData[indexPath.row];
    NSString *imgData=@"";//myData[indexPath.row][@"poster_path"];// poster_path  for network
    
//    if (isDataFromNetwrok) {
//        imgData=myData[indexPath.row][@"poster_path"];//myData[indexPath.row][@"poster_path"];// poster_path  for network
//    }else{
         imgData=movieDetails2.poster_path;//myData[indexPath.row][@"poster_path"];// poster_path  for network
  //  }
   
    if (imgData == (id)[NSNull null] || imgData.length == 0 ) {
        imgData = @"";
    }

    imgPath=[imgPath stringByAppendingString: imgData   ];
     
     [imageView sd_setImageWithURL:[NSURL URLWithString:imgPath]
                  placeholderImage:[UIImage imageNamed:@"defaultPoster.jpg"]];
  
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    MoviedetailsViewController *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"moviedetail"];
   MoviePOJO *movieDetails2=myData[indexPath.row];
    MoviePOJO *movieDetails;
//    if (isDataFromNetwrok) {
//        NSString *mid=[myData[indexPath.row][@"id"] stringValue];
//              movieDetails=[[MoviePOJO alloc] initWithMovie:mid :myData[indexPath.row][@"title"]:myData[indexPath.row][@"poster_path"] :myData[indexPath.row][@"overview"] :myData[indexPath.row][@"vote_average"]:myData[indexPath.row][@"release_date"]:@"false"];
//
//    }else{
         movieDetails=movieDetails2;
       // movieDetails.isFavourite=@"false";
//    }


   [detail setMovieDetail:movieDetails];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}


#pragma mark <UICollectionViewDelegate>


-(void)showLoading{
    
    printf("Show Loading\n");
    
}

-(void) hideLoading{
    
    printf("hide Loading\n");
        [progreesAlert dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)showErrorMessage:(NSString *)errorMessage{
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)renderMoviesWithObject:(NSArray<MoviePOJO *> *)movieList : (Boolean) isFromNetwrok {
    
    myData=movieList;
    isDataFromNetwrok=isFromNetwrok;
    
    [self.moviesCollectionView reloadData];
    
}

@end
