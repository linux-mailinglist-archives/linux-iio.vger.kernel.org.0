Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29F31D9DFF
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgESRhg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 13:37:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbgESRhg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 May 2020 13:37:36 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 66C6BCE8FBF4D674BAFD;
        Tue, 19 May 2020 18:37:33 +0100 (IST)
Received: from localhost (10.47.86.149) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 19 May
 2020 18:37:32 +0100
Date:   Tue, 19 May 2020 18:37:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200519183705.000040e5@Huawei.com>
In-Reply-To: <20200519164433.GA8726@ict14-OptiPlex-980>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
        <20200519124402.26076-2-jonathan.albrieux@gmail.com>
        <20200519132207.GA4623@gerhold.net>
        <20200519140354.GB30573@ict14-OptiPlex-980>
        <20200519160137.GJ1634618@smile.fi.intel.com>
        <20200519164433.GA8726@ict14-OptiPlex-980>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.86.149]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 19 May 2020 18:44:33 +0200
Jonathan Albrieux <jonathan.albrieux@gmail.com> wrote:

> On Tue, May 19, 2020 at 07:01:37PM +0300, Andy Shevchenko wrote:
> > On Tue, May 19, 2020 at 04:03:54PM +0200, Jonathan Albrieux wrote:  
> > > On Tue, May 19, 2020 at 03:22:07PM +0200, Stephan Gerhold wrote:  
> > > > On Tue, May 19, 2020 at 02:43:51PM +0200, Jonathan Albrieux wrote:  
> > 
> > ...
> >   
> > > > > +maintainers:
> > > > > +  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>  
> > > > 
> > > > Should probably add someone here, although I'm not sure who either.
> > > >   
> > > 
> > > Yep I couldn't find a maintainer for that driver..what to do in this case?  
> > 
> > Volunteer yourself!
> >   
> 
> While I'd really like to, I have to decline the offer as I currently don't have
> enought knowledge to become a maintainer :-) but thank you! (Who knows, maybe in
> a couple of year!) Now I'll make the final edits and will submit a new
> patchset soon with all the changes

Don't be so hard on yourself.  We all get thrown in at the deep end :)

Note that being a driver maintainer (or even just the binding) really
just means you get cc'd on the patches and I'll make sure you've had time
to review them if you wish.   Best of all, if you have hardware (and time)
being able to test them, that is extremely useful (whether you are
maintaining the driver or not!) 

I closely review the majority of stuff that comes through IIO and in
the case of bindings we also have Rob and co. doing an amazing job.
We have some excellent additional reviewers who review IIO stuff all the
time, some of which have reviewed your patch I see.  Without them I'd
never survive the deluge.

Of course it's entirely your decision, but I'd definitely encourage you
to give it a go.

Thanks,

Jonathan




> 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   
> 
> Best regards,
> Jonathan Albrieux


