Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2150B3E1512
	for <lists+linux-iio@lfdr.de>; Thu,  5 Aug 2021 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhHEMwl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Aug 2021 08:52:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3595 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhHEMwk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Aug 2021 08:52:40 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GgT5g6n2jz6FFn8;
        Thu,  5 Aug 2021 20:52:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 14:52:24 +0200
Received: from localhost (10.47.74.155) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 5 Aug 2021
 13:52:23 +0100
Date:   Thu, 5 Aug 2021 13:51:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <devicetree@vger.kernel.org>,
        Nuno Sa <Nuno.Sa@analog.com>
Subject: Re: [PATCH 00/17] iio:adc:ad7280a Cleanup and proposed staging
 graduation.
Message-ID: <20210805135153.00004133@Huawei.com>
In-Reply-To: <YQtgZMWv5nfMgP8/@marsc.168.1.7>
References: <20210614113507.897732-1-jic23@kernel.org>
        <YNIfkaRZtWIXPbAj@marsc.168.1.7>
        <20210623093741.00007d1d@Huawei.com>
        <20210711155051.713c1207@jic23-huawei>
        <YOyFE/yHrLQxKpkU@marsc.168.1.7>
        <YQtgZMWv5nfMgP8/@marsc.168.1.7>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.155]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 5 Aug 2021 00:52:04 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> [...]
> 
> > > 
> > > Note there is loads of stuff that isn't implemented as it was developed alongside
> > > this patch series to verify individual patches rather than with the intent of
> > > actually emulating the device.
> > >   
> > OK, will be aware of that.
> >   
> > > It's hard coded to 2 a chain of 3 ad7280a devices because that seemed to hit most possible
> > > corner cases.
> > > 
> > > The top commit has the launch string I'm using.  You'll need a filesystem, but
> > > you can probably use one of the convenient ones debian posts as nocloud cloud
> > > images. 
> > > 
> > > There is some info on that on people.kernel.org/jic23 as I wrote up how to test
> > > CXL stuff on ARM recently and gave guidance on easy ways to get a filesystem.
> > > http://cdimage.debian.org/cdimage/cloud/sid/daily/20210702-691/debian-sid-nocloud-arm64-daily-20210702-691.qcow2
> > > will probably work and is more recent than the one linked from that blog post.   
> > 
> > I was using a debian imgage created from following the instructions on a
> > tutorial pointed by the QEMU docs.
> > https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/
> > Anyhow, I'll chance to the nocloud one if see things don't get working.
> >   
> > > 
> > > Give me a shout if you need more specific guidance than this very very rough guide!  
> > 
> > Sure, let's see if I can get through it now. Otherwise ...  
> 
> I've managed to get it running and see the emulated ad7280a working.
> Still getting some trouble with the ad7150 emulation though.
> I added a pull request with some comments about the ad7150 emulation on the
> github repository. 

Will take a look at some point.  Thanks.

> Overall I don't think it was so hacky, I just wonder if it could have been
> done more cleanly by passing a custom dtb in the launching string. The hacks
> at virt.c are mostly to add the busses, add the device nodes, and connect
> device gpio to interrupt lines. We could do it all by editing a dt, right?
> Anyhow, thanks a lot for sharing this stuff.

That's the alternative, though you also need to actually create the relevant
devices.  The dtb stuff is lengthy but really simple to do, it's also somewhat
resilient to other changes in how the virt model works (address changes etc).

Given I was there anyway, it seemed easier to do it all in one place.
 
> 
> >   
> > > 
> > > I mentioned this thread in the diversion the rust on linux thread took into
> > > use of QEMU to emulate devices which motivated me to stop being lazy and at least
> > > post this hideous version.  Probably the most useful bit is how to get a working
> > > spi device emulated on the arm virt machine as that is very handy for all manner
> > > of testing.  One day someone might implement a large set of IIO device emulation
> > > and bolt it into a CI...  
> > 
> > Agree, it's hard to get IIO drivers runtime tested because we often don't
> > have the required hardware to do it. I think emulation would help us with
> > that or, at least, would give us a little bit more confidence in our
> > changes than just relying on sharp eyes and compile/static tests.
> > Puching that into a CI would also be rather nice.
> >   
> > > 
> > > Jonathan
> > >   
> > > >   
> > > > > 
> > > > > Being able to see it running, I may feel more confident to provide a review
> > > > > for this set :)    
> 
> Guess I've been too optimistic. The way things are going I may take a few
> more weeks to have a closer look at all the patches. I'll try to make it
> before the next merge window or give up otherwise. It's not reasonable to
> ask you wait more since this set has been sitting on the list for so long.

Don't worry about it.  Driver was in staging a long time. It can wait as
long as we know it will move forwards eventually!

Jonathan

> 
> 
> [...]

