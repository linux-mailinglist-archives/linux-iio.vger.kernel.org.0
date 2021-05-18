Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68940387880
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhERMLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 08:11:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3019 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbhERMLm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 08:11:42 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkvsK6kj1zlg8D;
        Tue, 18 May 2021 20:08:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 20:10:20 +0800
Received: from localhost (10.52.121.12) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 13:10:18 +0100
Date:   Tue, 18 May 2021 13:08:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
CC:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        <linux-staging@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging: iio: cdc: ad7746: avoid overwrite of
 num_channels
Message-ID: <20210518130833.00001807@Huawei.com>
In-Reply-To: <CACKVXZA9rPGLLxyq3gWTynoH7dPgYitqe-dO=YNad7VxHfwQhA@mail.gmail.com>
References: <cover.1620766020.git.lucas.p.stankus@gmail.com>
        <09e65d3a235febfc4c3ee172b573ba8c9cde94b8.1620766020.git.lucas.p.stankus@gmail.com>
        <CA+U=DsptfNDut3984MJkKckgWBhNd_0p17RfpidEXwYhMRfxtg@mail.gmail.com>
        <CACKVXZA9rPGLLxyq3gWTynoH7dPgYitqe-dO=YNad7VxHfwQhA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.12]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 May 2021 21:55:20 -0300
Lucas Stankus <lucas.p.stankus@gmail.com> wrote:

> On Wed, May 12, 2021 at 2:20 PM Alexandru Ardelean
> <ardeleanalex@gmail.com> wrote:
> >
> > On Tue, May 11, 2021 at 11:55 PM Lucas Stankus
> > <lucas.p.stankus@gmail.com> wrote:  
> > >
> > > AD7745 devices don't have the CIN2 pins and therefore can't handle related
> > > channels. Forcing the number of AD7746 channels may lead to enabling more
> > > channels than what the hardware actually supports.
> > > Avoid num_channels being overwritten after first assignment.
> > >
> > > Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
> > > ---
> > >  drivers/staging/iio/cdc/ad7746.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > > index e03d010b2f4c..9e0da43b2871 100644
> > > --- a/drivers/staging/iio/cdc/ad7746.c
> > > +++ b/drivers/staging/iio/cdc/ad7746.c
> > > @@ -693,7 +693,6 @@ static int ad7746_probe(struct i2c_client *client,
> > >                 indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
> > >         else
> > >                 indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
> > > -       indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);  
> >
> > ohh; good catch
> >
> > this falls into the category of a fix, so a Fixes tag is required;
> > this looks so old, that i did not bother tracking it before
> > 83e416f458d53  [which is 2011]  
> 
> As Jonathan said, this bug was already fixed and the patch will be dropped,
> but thank you for the review.
> 
> This was my first bug fix in the kernel, so sorry for the absence of a
> Fixes tag, I'll make sure to add one next time.
> 

Wasn't already fixed - I just applied this patch without PATCH 1/2
so now it is ;)

Jonathan

> 
> >
> > so, maybe something like:
> >
> > Fixes: 83e416f458d53 ("staging: iio: adc: Replace, rewrite ad7745 from
> > scratch.")
> >  
> > >         indio_dev->modes = INDIO_DIRECT_MODE;
> > >
> > >         if (pdata) {
> > > --
> > > 2.31.1
> > >  

