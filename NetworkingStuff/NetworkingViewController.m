//
//  NetworkingViewController.m
//  NetworkingStuff
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "NetworkingViewController.h"
#import "AFNetworking.h"
#import "MovieCell.h"

@interface NetworkingViewController ()

@end

@implementation NetworkingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    // add this as another acceptable content type 
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    self.title = @"IMDB Search";
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(posterTapped:)];
    tapRecognizer.numberOfTapsRequired = 2;
    
    [self.navigationController.navigationBar addGestureRecognizer:tapRecognizer];
}
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UINib *nib = [UINib nibWithNibName:@"MovieCell" bundle:[NSBundle mainBundle]];
    NSArray *array = [nib instantiateWithOwner:nil options:nil];
    MovieCell *cell = [array lastObject];
    
    /* 
     UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(posterTapped:)];
     tapRecognizer.numberOfTapsRequired = 2;
     // assigning the gestureRecognizer to a particular UIImageView.
     [cell.moviePoster addGestureRecognizer:tapRecognizer];
     
     cell.moviePoster.userInteractionEnabled = YES;
     
     */
    
    NSDictionary *movie = [self.movies objectAtIndex:indexPath.row];
    
    NSString *title = [movie valueForKey:@"title"];
    id year = [movie valueForKey:@"year"];
    
    cell.titleLabel.text = title;
    cell.yearLabel.text = [NSString stringWithFormat:@"%@", year];
    
    NSURL *posterURL = [NSURL URLWithString:[movie valueForKey:@"poster"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
    NSLog(@"about to load image");
                                    
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image){
      cell.moviePoster.image = image;
      NSLog(@"image loaded");
    [cell layoutSubviews];
  }];
    [operation start];
    
    
    return cell;
}

// handler for the tap gesture
-(void)posterTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"posterTapped!");
    
    // take the first cell in the row and animate the image.
    MovieCell *firstCell = (MovieCell *)[self.movieTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (firstCell) {
        [UIView animateWithDuration:0.5 animations:^{
            firstCell.moviePoster.alpha = 0.0;
            firstCell.moviePoster.transform = CGAffineTransformMakeRotation(M_PI);
            //firstCell.moviePoster.transform = CGAffineTransformMakeRotation(45);
        }];
    }
}

- (IBAction)search:(id)sender
{
    // dismiss the keyboard view upon searching
    [self.view endEditing:YES];
    
    NSString *searchURL = [NSString stringWithFormat:@"http://imdbapi.org/?type=json&title=%@&limit=10", self.searchField.text];
    // encode special characters found in the searchURL.
    NSString *encodedURL = [searchURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        self.movies = JSON;
        [self.movieTable reloadData];
        //NSLog(@"%@", [JSON valueForKeyPath:@"title"]);
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        NSLog(@"Errors. %@", error);
     }];
    [operation start];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
