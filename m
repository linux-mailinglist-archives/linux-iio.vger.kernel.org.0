Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4CA186A5A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 12:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgCPLtX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 07:49:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730882AbgCPLtX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Mar 2020 07:49:23 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 88596452F718665D9F9F;
        Mon, 16 Mar 2020 11:49:22 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Mar 2020 11:49:21 +0000
Received: from localhost (10.47.94.88) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 16 Mar
 2020 11:49:21 +0000
Date:   Mon, 16 Mar 2020 11:49:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: health: max30100: remove mlock usage
Message-ID: <20200316114920.00000689@Huawei.com>
In-Reply-To: <CAJCx=g=7_S5=JJ1K8JCLd06hTbhqTHupUJ1tYX6uiAP+1WtjsQ@mail.gmail.com>
References: <5e668b89.1c69fb81.d7e4f.0f61@mx.google.com>
        <20200315094604.62dc96be@archlinux>
        <CAJCx=gkZEDa5vg1R2gta9vERy2+W4vst0et0THO9Oth3d3Yzfg@mail.gmail.com>
        <CAJCx=g=7_S5=JJ1K8JCLd06hTbhqTHupUJ1tYX6uiAP+1WtjsQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.88]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Mar 2020 01:29:28 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Mon, Mar 16, 2020 at 1:21 AM Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
> >
> > On Sun, Mar 15, 2020 at 2:46 AM Jonathan Cameron <jic23@kernel.org> wrote:  
> > >
> > > On Tue, 10 Mar 2020 00:01:28 +0530
> > > Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
> > >  
> > > > Use local lock instead of indio_dev's mlock.
> > > > The mlock was being used to protect local driver state thus using the
> > > > local lock is a better option here.
> > > >
> > > > Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>  
> > >
> > > Matt.  Definitely need your input on this.
> > >  
> > > > ---
> > > >  drivers/iio/health/max30100.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
> > > > index 84010501762d..8ddc4649547d 100644
> > > > --- a/drivers/iio/health/max30100.c
> > > > +++ b/drivers/iio/health/max30100.c
> > > > @@ -388,7 +388,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> > > >                * Temperature reading can only be acquired while engine
> > > >                * is running
> > > >                */
> > > > -             mutex_lock(&indio_dev->mlock);
> > > > +             mutex_lock(&data->lock);  
> > >
> > > Hmm.. It's another complex one.  What is actually being protected here is
> > > the buffer state, but not to take it exclusively like claim_direct does.
> > >
> > > Here we need the inverse, we want to ensure we are 'not' in the direct
> > > mode because this hardware requires the buffer to be running to read the
> > > temperature.
> > >
> > > That is the sort of interface that is going to get userspace very
> > > confused.
> > >
> > > Matt, normally what I'd suggest here is that the temperature read should:
> > >
> > > 1) Claim direct mode, if it fails then do the dance you have here
> > > (with more comments to explain why you are taking an internal lock)
> > > 2) Start up capture as if we were in buffered mode
> > > 3) Grab that temp
> > > 4) stop capture to return to non buffered mode.
> > > 5) Release direct mode.
> > >
> > > I guess we decided it wasn't worth the hassle.
> > >
> > > So Rohit.  This one probably needs a comment rather than any change.
> > > We 'could' add a 'hold_buffered_mode' function that takes the mlock,
> > > verifies we are in buffered mode and continues to hold the lock
> > > until the 'release_buffered_mode'.  However, I'm not sure any other
> > > drivers do this particular dance, so clear commenting in the driver
> > > might be enough.   Should we ever change how mlock is used in the
> > > core, we'd have to fix this driver up as well.
> > >
> > > Hmm.  This is really hammering home that perhaps all the remaining
> > > mlock cases are 'hard'.  
> >
> > Heh really had to look this over what I was doing since it has been
> > almost half a decade now :).
> >
> > Think locking that mutex was only to prevent another read during the
> > temp reading, and not really
> > not sure how effective that is actually. Especially since the I2C
> > subsystem should handle those reads
> > in a queue like fashion.
> >
> > - Matt
> >  
> 
> So to be clear I think we can just remove the lock period since the
> odds of this actually being requested (or disabled) at the
> exact time so very remote. Along with the worse case being a failed read.

I disagree.   What that lock prevents is disabling buffered mode between
the check on whether it is enabled and the read.   That's a clear race
so we should keep the lock.

Jonathan


> 
> - Matt
> 
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >  
> > > >
> > > >               if (!iio_buffer_enabled(indio_dev))
> > > >                       ret = -EAGAIN;
> > > > @@ -399,7 +399,7 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
> > > >
> > > >               }
> > > >
> > > > -             mutex_unlock(&indio_dev->mlock);
> > > > +             mutex_unlock(&data->lock);
> > > >               break;
> > > >       case IIO_CHAN_INFO_SCALE:
> > > >               *val = 1;  /* 0.0625 */  
> > >  


