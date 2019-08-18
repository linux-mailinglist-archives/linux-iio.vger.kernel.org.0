Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2257391924
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 21:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHRTHM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 15:07:12 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38918 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfHRTHM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Aug 2019 15:07:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 6B5DC9E7644;
        Sun, 18 Aug 2019 20:07:09 +0100 (BST)
Date:   Sun, 18 Aug 2019 20:07:08 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mircea Caprioru <mircea.caprioru@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
Message-ID: <20190818200708.659eb4bb@archlinux>
In-Reply-To: <20190818194627.4bc9571a@archlinux>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
        <20190814073150.4602-4-mircea.caprioru@analog.com>
        <CAL_JsqKONxFbS-nUMc1c=-9HcXCrOVmOOfn9htKOJOjAS6HCKg@mail.gmail.com>
        <20190818194627.4bc9571a@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 18 Aug 2019 19:46:27 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 14 Aug 2019 20:39:04 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
> 
> > On Wed, Aug 14, 2019 at 1:32 AM Mircea Caprioru
> > <mircea.caprioru@analog.com> wrote:  
> > >
> > > This patch add device tree binding documentation for AD7192 adc in YAML
> > > format.
> > >
> > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> > > ---
> > > Changelog V2:
> > > - remove description from spi and interrupt properties
> > > - changed the name of the device from ad7192 to adc in the example
> > >
> > > Changelog V3:
> > > - added semicolon at the end of the dt example
> > >
> > >  .../bindings/iio/adc/adi,ad7192.yaml          | 121 ++++++++++++++++++
> > >  1 file changed, 121 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml    
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>  
> 
> For some reason, this patch gave me a git error based on encoding. 
> I applied it by hand instead and all seemed fine.  Not sure why
> that happened!
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> so the autobuilders can play with it.
> 
> Thanks,
> 
> Jonathan
> 
I spoke a bit soon as the build test was still running.

you have const values for the regulators - that doesn't make much sense
to my mind and means your example gives warnings...

    items:
      - const: dvdd
/iio/Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml: adc@0: dvdd-supply:0: 'dvdd' was expected

I've dropped this and will pick up in v4.

thanks,

Jonathan

