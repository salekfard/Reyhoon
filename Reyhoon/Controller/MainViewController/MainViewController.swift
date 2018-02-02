//
//  MainViewController.swift
//  Reyhoon
//
//  Created by Ali Salekfard on 2/2/18.
//  Copyright © 2018 Ali Salekfard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    @IBOutlet weak var collectionSelf: UICollectionView!
    
    var arrayCollection = [Response_Coordinates_branches]();
    let sizeBaseCell = CGSize();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionSelf.dataSource = self;
        self.collectionSelf.delegate = self;
        self.collectionSelf.transform = CGAffineTransform(scaleX: -1, y: 1);
        
        self.getData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadAllData()
    {
        arrayCollection = [Response_Coordinates_branches]();
    }
    
    func hideWaitingView()
    {
        DispatchQueue.main.async {
            self.view.hideActivityViewWith(afterDelay: 0.5);
        }
    }
    
    func getData()
    {
        func showAlert(_ strMessage : String)
        {
            AlertHelper.show(viewController: self, Title: NSLocalizedString("SystemMessage", comment: ""), message: strMessage, actions: [AlertActionCustom(title: NSLocalizedString("Retry", comment: ""), style: UIAlertActionStyle.default)])
            {
                action in
                self.reloadAllData();
                self.getData();
            }
        }
        
        self.view.showActivityView();
        
        RESTfulManager.sendDefaultRequest(HttpMethod: .get, Url: GENERAL_URL_SERVICES+"/public-api/v1/listings/by-coordinates?lng=51.409954&lat=35.757540", TimeOut: GENERAL_SERVICES_TIME_OUT, withSuccess: {(response) in
            
            let responseEntity = Response_Coordinates(JSONString: response!);
            
            if (responseEntity != nil && responseEntity?.branches != nil)
            {
                if (responseEntity!.branches.count > 0)
                {
                    self.reloadAllData();
                    
                    self.arrayCollection.append(contentsOf: Response_Coordinates_branches.getNearest(branches: responseEntity!.branches, count: 10));
                    
                    self.collectionSelf.reloadData();
                }
                else
                {
                    showAlert(NSLocalizedString("NoResult", comment: ""));
                }
            }
            else
            {
                showAlert(NSLocalizedString("Error.Problem", comment: ""));
            }
            
            self.hideWaitingView();
            
        }, andFailure: { (error) in
            
            if (error != nil)
            {
                let nsError = error! as NSError;
                if (nsError.code == -1008 || nsError.code == -1009)
                {
                    showAlert(NSLocalizedString("Error.Connection", comment: ""));
                    self.hideWaitingView();
                    return;
                }
            }
            
            showAlert(NSLocalizedString("Error.Problem", comment: ""));
            self.hideWaitingView();
        })
    }
    
    //MARK: CollectionViewDelegates&&DataSources
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell;
        
        let dic : Response_Coordinates_branches = arrayCollection[indexPath.row];
        
        cell.lblTitle.text = dic.name_fa;
        
        cell.lblDistance.text = dic.distanceDescription;
        cell.lblDistance.backgroundColor = dic.distanceColor;
        
        return cell;
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    }*/
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
}
