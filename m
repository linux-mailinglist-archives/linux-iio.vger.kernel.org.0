Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231E21B10AA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 17:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDTPsq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 11:48:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgDTPsq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 11:48:46 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0D2619F995A092B0620F;
        Mon, 20 Apr 2020 16:48:45 +0100 (IST)
Received: from localhost (10.47.82.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 20 Apr
 2020 16:48:44 +0100
Date:   Mon, 20 Apr 2020 16:48:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/7] iio: light: clean out of_match_ptr and tidy headers
Message-ID: <20200420164832.00004065@Huawei.com>
In-Reply-To: <03f6eb6e7cf61c6dfd8bcd9aeaaf6977cb095191.camel@analog.com>
References: <20200419150206.43033-1-jic23@kernel.org>
        <beff54a412caddaaa7facbc2df2ddf939668fc44.camel@analog.com>
        <03f6eb6e7cf61c6dfd8bcd9aeaaf6977cb095191.camel@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.82]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Apr 2020 06:22:09 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2020-04-20 at 06:04 +0000, Ardelean, Alexandru wrote:
> > [External]
> > 
> > On Sun, 2020-04-19 at 16:01 +0100, jic23@kernel.org wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Hi All,
> > > 
> > > Given we keep having to explain to people that of_match_ptr is less
> > > than ideal now we have the option of ACPI DSDT using PRP0001 and
> > > the compatible, it seems sensible to reduce the number of instances
> > > that people might copy for a new driver.
> > > 
> > > Added theoretical benefit is that we can probe all these drivers from
> > > appropriate DSDT (though I doubt anyone will).
> > > 
> > > I'm sending this first set out to see if anyone has strong views against
> > > doing this for at least the simple drivers that have no other device
> > > tree dependence.  Obviously more work would be needed to remove
> > > use of of_match_ptr from IIO completely.
> > > 
> > > Light sensors picked as a starting point as they tend to be simple.
> > > 
> > > I may do follow ups in larger blocks to avoid so many small patches
> > > (or indeed flatten these into one when applying)  
> > 
> > fwiw: i was also planning to do a sweep of these;
> > well, tbh, the main intent was to target ADI drivers first and do a bigger
> > conversion for them to make the slightly friendlier with ACPI; 
> > 
> > aside from this, i'm also noticing some bad patterns being copied from older
> > drivers, when asking new people to write Linux drivers;
> > i did not make a list, probably should have;
> > one is 'mlock' [still] being copied; and accessing other internal fields;
> > but the internal fields accessing requires a bit of a cleanup in the form of
> > privatizing the fields somehow;
> >   
> 
> One thing I noticed in the series.
> No idea if it is needed or not; a build would tell:
>    Is '#include <linux/mod_devicetable.h>' required for this change?
> Most patches add it, but I don't feel it is needed; I could be wrong though.

I addressed this in reply to patch 7.  It's mainly obtained via
i2c.h and spi.h in these drivers.  They don't have any particular need
to include it as they could deal with an opaque pointer.

However, seems unlikely that'll get tidied up any time soon and
debatable whether there is any point in doing so.

> 
> What I noticed is that all 'linux/of.h' , 'linux/of_device.h' &
> 'linux/of_platform.h' include it.

True, but we shouldn't include any of them unless we have reason to do
so. They bring baggage we don't need for these drivers.

Jonathan


> 
> >   
> > > Thanks
> > > 
> > > Jonathan
> > > 
> > > Jonathan Cameron (7):
> > >   iio: light: bh1780: use mod_devicetable.h and drop of_match_ptr macro
> > >   iio: light: cm32181: Add mod_devicetable.h and remove of_match_ptr
> > >   iio: light: cm3232: Add mod_devicetable.h include and drop
> > >     of_match_ptr
> > >   iio: light: gp2ap020a00f: Swap of.h for mod_devicetable.h + drop
> > >     of_match_ptr
> > >   iio: light: opt3001: Add mod_devicetable.h and drop use of
> > >     of_match_ptr
> > >   iio: light: st_uvis25: Add mod_devicetable.h and drop of_match_ptr
> > >   iio: light: vl6180: swap of.h for mod_devicetable.h and drop
> > >     of_match_ptr
> > > 
> > >  drivers/iio/light/bh1780.c        | 6 ++----
> > >  drivers/iio/light/cm32181.c       | 3 ++-
> > >  drivers/iio/light/cm3232.c        | 3 ++-
> > >  drivers/iio/light/gp2ap020a00f.c  | 6 ++----
> > >  drivers/iio/light/opt3001.c       | 3 ++-
> > >  drivers/iio/light/st_uvis25_i2c.c | 3 ++-
> > >  drivers/iio/light/st_uvis25_spi.c | 3 ++-
> > >  drivers/iio/light/vl6180.c        | 2 +-
> > >  8 files changed, 15 insertions(+), 14 deletions(-)
> > >   


