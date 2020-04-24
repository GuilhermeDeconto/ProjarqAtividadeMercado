//
//  MagazinePageViewController.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import UIKit

enum PageViewType:String {
    case frutas = "Frutas"
    case carnes = "Carnes"
    case verduras = "Verduras"
    case flores = "Flores"
    case higiene = "Higiene"
}

class MagazinePageViewController: UIPageViewController {

    private (set) lazy var orderedViewControllers:[UIViewController] = {
        return [self.newPageView(.frutas),
                self.newPageView(.carnes),
                self.newPageView(.verduras),
                self.newPageView(.flores),
                self.newPageView(.higiene)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    var currentIndex:Int {
        get {
            return orderedViewControllers.firstIndex(of: self.viewControllers!.first!)!
        }
        
        set {
            guard newValue >= 0,
                newValue < orderedViewControllers.count else {
                    return
            }
            
            let vc = orderedViewControllers[newValue]
            let direction:UIPageViewController.NavigationDirection = newValue > currentIndex ? .forward : .reverse
            self.setViewControllers([vc], direction: direction, animated: true, completion: nil)
        }
    }
    
    private func newPageView(_ viewType:PageViewType) -> UIViewController {
        let controller = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "MagazineViewController") as! MagazineViewController
        controller.category = viewType.rawValue
        return controller
    }
    
}
extension MagazinePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let nextIndex = currentIndex + 1
        
        guard orderedViewControllers.count != nextIndex else {
            return nil
        }
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return currentIndex
    }
}
