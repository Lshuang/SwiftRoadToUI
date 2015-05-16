//
//  HeroListTableViewController.swift
//  SwiftRoadToUI
//
//  Created by Shawn Li on 15/5/17.
//  Copyright (c) 2015年 Shawn Li. All rights reserved.
//

import UIKit

class HeroListTableViewController: UITableViewController {
    var heroList = [Hero]();  //数据源
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData();
        //导航上还有编辑按钮，现在我们来实现编辑功能
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
   // 要让系统知道导航坐标的按钮是我们的编辑按钮，然后在控制器中加入一个新的方法setEditing，这个也是自动补全的
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true) //先实现父类的
        tableView.setEditing(editing, animated: true)
    }
    
    func loadInitialData() {
        let hero1 = Hero()
        hero1.name = "德玛西亚皇子"
        heroList.append(hero1)
        
        let hero2 = Hero()
        hero2.name = "德玛西亚之力"
        heroList.append(hero2)
        
        let hero3 = Hero()
        hero3.name = "德邦总管"
        heroList.append(hero3)
        
        

    }
    // 反向过渡
    @IBAction func unwindToList(segue: UIStoryboardSegue) { //设置源头是新增英雄这个场景，然后我们把源头中的实例取出，非空的话添加到列表中。
        let source = segue.sourceViewController as! AddHeroViewController
        let r1 = source.hero
        if r1.name != "" {
            heroList.append(r1)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return heroList.count
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        let h1 = heroList[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = heroList[indexPath.row].name
        if h1.isLike {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let h1 = heroList[indexPath.row] //取出点击的行
        h1.isLike = !h1.isLike; //单击后喜欢状态取反
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        tableView.reloadData()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete { //如果是删除按钮
            // Delete the row from the data source
            heroList.removeAtIndex(indexPath.row) //先删除数组中的元素
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) //删除列表行，其他行向上推
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
