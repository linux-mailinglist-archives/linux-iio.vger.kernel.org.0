Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4987354901
	for <lists+linux-iio@lfdr.de>; Tue,  6 Apr 2021 00:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhDEW4m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 5 Apr 2021 18:56:42 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3330 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhDEW4k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Apr 2021 18:56:40 -0400
Received: from dggeme710-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FDmCL69V9z14CQP;
        Tue,  6 Apr 2021 06:53:02 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme710-chm.china.huawei.com (10.1.199.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 06:56:29 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.013;
 Tue, 6 Apr 2021 06:56:29 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH 7/7] iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather
 than request and disable
Thread-Topic: [PATCH 7/7] iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather
 than request and disable
Thread-Index: AQHXJ/C5T8RD3naq3EySlPnFa6wlYaqhqiMwgAPWTACAAQs2cA==
Date:   Mon, 5 Apr 2021 22:56:29 +0000
Message-ID: <45db9c440033417ba081d1a3bc2cc967@hisilicon.com>
References: <20210402184544.488862-1-jic23@kernel.org>
        <20210402184544.488862-8-jic23@kernel.org>
        <b63838854fee434aa96cd54c13014b51@hisilicon.com>
 <20210405155152.14abf3dc@jic23-huawei>
In-Reply-To: <20210405155152.14abf3dc@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.143]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Tuesday, April 6, 2021 2:52 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: linux-iio@vger.kernel.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> Lars-Peter Clausen <lars@metafoo.de>; Alexandru Ardelean
> <ardeleanalex@gmail.com>; tiantao (H) <tiantao6@hisilicon.com>
> Subject: Re: [PATCH 7/7] iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than
> request and disable
> 
> On Fri, 2 Apr 2021 20:30:17 +0000
> "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com> wrote:
> 
> > > -----Original Message-----
> > > From: Jonathan Cameron [mailto:jic23@kernel.org]
> > > Sent: Saturday, April 3, 2021 7:46 AM
> > > To: linux-iio@vger.kernel.org
> > > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Jonathan Cameron
> > > <jonathan.cameron@huawei.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > > Alexandru Ardelean <ardeleanalex@gmail.com>
> > > Subject: [PATCH 7/7] iio:adc:ad_sigma_delta: Use IRQF_NO_AUTOEN rather than
> > > request and disable
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > These devices are not able to mask the signal used as a data ready
> > > interrupt.  As such they previously requested the irq then immediately
> > > disabled it.  Now we can avoid the potential of a spurious interrupt
> > > by avoiding the irq being auto enabled in the first place.
> > >
> > > I'm not sure how this code could have been called with the irq already
> > > disabled, so I believe the conditional would always have been true and
> > > have removed it.
> > >
> >
> > If irq_dis is true, it seems the original code assumed interrupt was
> > open. Now the code is moving to disable-irq for true irq_dis. For
> > false irq_dis, this patch has no side effect so looks correct.
> Hi Barry,
> 
> As far as I can tell (and I looked closely :), at the point where
> ad_sd_probe_trigger() can be called, irq_dis is always false,
> so the original check is misleading by implying
> otherwise.

I didn't realize that. Thanks for clarification.

> 
> Taken in isolation of what is visible in this patch I'd agree
> the change you suggest makes sense, but I'd also like to clean
> up the wrong impression the original check was giving.  It is
> also worth noting that ad_sigma_delta.h lists irq_dis as a
> private member of the structure that should only be used in the
> library (reducing chances of any drivers in future doing something
> odd with it).
> 

Yes. It makes sense.

> The other checks on irq_dis look suspicious as well, but removing
> those would rather spread the scope of this patch.
> 
> As Lars has given an Reviewed-by and this is his code, I'm going
> to press ahead with this as it stands.
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to see if we missed anything.
> 
> Thanks,
> 
> Jonathan
> 
> >
> > A safer way might be as below?
> >
> > if(!sigma_delta->irq_dis)
> > 	irq_flags = sigma_delta->info->irq_flags | IRQF_NO_AUTOEN;
> >
> > request_irq(irq_flags);
> >
> > sigma_delta->irq_dis =  true;
> >
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> > > ---
> > >  drivers/iio/adc/ad_sigma_delta.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > > b/drivers/iio/adc/ad_sigma_delta.c
> > > index 9289812c0a94..e777ec718973 100644
> > > --- a/drivers/iio/adc/ad_sigma_delta.c
> > > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > > @@ -485,18 +485,15 @@ static int ad_sd_probe_trigger(struct iio_dev
> *indio_dev)
> > >  	sigma_delta->trig->ops = &ad_sd_trigger_ops;
> > >  	init_completion(&sigma_delta->completion);
> > >
> > > +	sigma_delta->irq_dis = true;
> > >  	ret = request_irq(sigma_delta->spi->irq,
> > >  			  ad_sd_data_rdy_trig_poll,
> > > -			  sigma_delta->info->irq_flags,
> > > +			  sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
> > >  			  indio_dev->name,
> > >  			  sigma_delta);
> > >  	if (ret)
> > >  		goto error_free_trig;
> > >
> > > -	if (!sigma_delta->irq_dis) {
> > > -		sigma_delta->irq_dis = true;
> > > -		disable_irq_nosync(sigma_delta->spi->irq);
> > > -	}
> > >  	iio_trigger_set_drvdata(sigma_delta->trig, sigma_delta);
> > >
> > >  	ret = iio_trigger_register(sigma_delta->trig);
> > > --
> > > 2.31.1
> >

Thanks
Barry
