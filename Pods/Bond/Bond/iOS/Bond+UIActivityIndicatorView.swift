//
//  Bond+UIActivityIndicatorView.swift
//  Bond
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

private var animatingDynamicHandleUIActivityIndicatorView: UInt8 = 0;

extension UIActivityIndicatorView: Bondable {
  
  public var dynIsAnimating: Dynamic<Bool> {
    if let d: AnyObject = objc_getAssociatedObject(self, &animatingDynamicHandleUIActivityIndicatorView) {
      return (d as? Dynamic<Bool>)!
    } else {
      let d = InternalDynamic<Bool>(self.isAnimating())
      let bond = Bond<Bool>() { [weak self] v in
        if let s = self {
          if v {
            s.startAnimating()
          } else {
            s.stopAnimating()
          }
        }
      }
      d.bindTo(bond, fire: false, strongly: false)
      d.retain(bond)
      objc_setAssociatedObject(self, &animatingDynamicHandleUIActivityIndicatorView, d, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return d
    }
  }
  
  public var designatedBond: Bond<Bool> {
    return self.dynIsAnimating.designatedBond
  }
}
