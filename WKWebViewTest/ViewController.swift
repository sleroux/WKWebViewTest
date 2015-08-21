/* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet var container: UIView!
    @IBOutlet var segControl: UISegmentedControl!
    @IBOutlet var urlLabel: UILabel!

    var webViews = [WKWebView]()

    let defaultSites = [
        "https://mozilla.org",
        "https://apple.com",
        "https://microsoft.com",
        "https://getpocket.com",
        "https://yahoo.com"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        segControl.addTarget(self, action: "didChangeSegment", forControlEvents: UIControlEvents.ValueChanged)

        for i in 0..<5 {
            let webView = WKWebView(frame: CGRect(origin: CGPointZero, size: container.frame.size))
            container.addSubview(webView)
            webViews.append(webView)
            webView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth

            let request = NSURLRequest(URL: NSURL(string: defaultSites[i])!)
            webView.loadRequest(request)
        }

        segControl.selectedSegmentIndex = 0
        didChangeSegment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func didChangeSegment() {
        for webView in webViews {
            webView.hidden = true
        }

        let selectedWebView = webViews[segControl.selectedSegmentIndex]
        selectedWebView.hidden = false
        urlLabel.text = selectedWebView.URL?.absoluteString
    }
}

