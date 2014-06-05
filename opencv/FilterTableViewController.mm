//
//  FilterTableViewController.m
//  opencv
//
//  Created by t_akaishi on 2014/06/05.
//  Copyright (c) 2014年 t_akaishi. All rights reserved.
//

#import "FilterTableViewController.h"
#import "RootViewController.h"
#import "OpenCVHelper.h"


@interface FilterTableViewController ()

@end


@implementation FilterTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{

    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        items = [NSMutableDictionary dictionary];
        NSFileManager* fileManager = [[NSFileManager alloc] init];
        NSString *path = [[NSBundle mainBundle] bundlePath];
        for(NSString *content in [fileManager contentsOfDirectoryAtPath:path error:nil]) {
            BOOL isDir;
            if([[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:content] isDirectory:&isDir] && isDir) {
                for(NSString *content2 in [fileManager contentsOfDirectoryAtPath:[path stringByAppendingPathComponent:content] error:nil]) {
                    if([[content2 pathExtension] isEqualToString:@"xml"])
                    {
                        
                        if(nil == [items objectForKey:content])
                        {
                            NSMutableArray* arr = [NSMutableArray array];
                            [arr addObject:content2];
                            [items setObject:arr forKey:content];
                        }
                        else
                        {
                            NSMutableArray* arr = [items objectForKey:content];
                            [arr addObject:content2];
                        }
                        // NSLog(@"%@", content2);
                    }
                }
            }

        }
        // items = [NSArray arrayWithObjects:@"haarcascade_eye", @"b", @"c", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"filert view load");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"numberOfSectionsInTableView:%d", [items count]);
    return [items count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"numberOfRowsInSection:%d", section);
    NSInteger i = 0;
    for(id key in [items allKeys])
    {
        NSLog(@"numberOfRowsInSection:loop:%d", i);
        if(i == section)
        {
            NSLog(@"numberOfRowsInSection:%d", [[items objectForKey:key] count]);
            return [[items objectForKey:key] count];
        }
        i++;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger i = 0;
    for(id key in [items allKeys])
    {
        NSLog(@"numberOfRowsInSection:loop:%d", i);
        if(i == section)
        {
            NSLog(@"numberOfRowsInSection:%d", [[items objectForKey:key] count]);
            return key;
        }
        i++;
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"section : %d, row no : %d", indexPath.section, indexPath.row];
    NSLog(@"testagaga=>%@", CellIdentifier);
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // NSArray* data = [NSArray arrayWithObjects:@"東京", @"名古屋", @"大阪", nil];
    // Configure the cell...

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //セルのテキストとして、データの内容とセクションと行数を表示させます。
        NSInteger i = 0;
        for(id key in [items allKeys])
        {
            if(i == indexPath.section)
            {
                cell.textLabel.text = [[items objectForKey:key] objectAtIndex:indexPath.row];
                break;
            }
            i++;
        }
        // cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@", [items objectAtIndex:indexPath.row], CellIdentifier];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selecte:%d", indexPath.row);
    NSInteger i = 0;
    for(id key in [items allKeys])
    {
        if(i == indexPath.section)
        {
            NSString* cascadeFile = [NSString stringWithFormat:@"%@/%@", key, [[items objectForKey:key] objectAtIndex:indexPath.row]];
            NSLog(@"cascadeFile=>%@", cascadeFile);
            if([cascadeFile isEqualToString:@"haarcascades/haarcascade_eye.xml"])
            {
                NSLog(@"cascadeFile ok");
            }
            RootViewController* view = [self.navigationController.viewControllers objectAtIndex:0];
            // view.imageView.image = [OpenCVHelper detect:view.imageView.image cascade:[[items objectForKey:key] objectAtIndex:indexPath.row]];
            view.imageView.image = [OpenCVHelper detect:view.imageView.image cascade:cascadeFile];
            // cell.textLabel.text = [[items objectForKey:key] objectAtIndex:indexPath.row];
            break;
        }
        i++;
    }
    // view.cascadeFile = @"test";
    // view.imageView.image = [OpenCVHelper detect:view.imageView.image cascade:@"haarcascade_eye_tree_eyeglasses.xml"];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
