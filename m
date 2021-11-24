Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5130445B7C4
	for <lists+linux-iio@lfdr.de>; Wed, 24 Nov 2021 10:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhKXJwG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 24 Nov 2021 04:52:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4156 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhKXJwF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Nov 2021 04:52:05 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HzbmS2z43z67YnL;
        Wed, 24 Nov 2021 17:48:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 10:48:54 +0100
Received: from localhost (10.52.122.34) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 24 Nov
 2021 09:48:53 +0000
Date:   Wed, 24 Nov 2021 09:48:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 02/49] iio:accel:da280: Switch from CONFIG_PM_SLEEP
 guards to pm_ptr() / __maybe_unused
Message-ID: <20211124094852.00007897@Huawei.com>
In-Reply-To: <SXP13R.7A93XDVR9X8I@crapouillou.net>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-3-jic23@kernel.org>
        <SXP13R.7A93XDVR9X8I@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.122.34]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 22:17:52 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi,
> 
> Le mar., nov. 23 2021 at 21:09:32 +0000, Jonathan Cameron 
> <jic23@kernel.org> a écrit :
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM_SLEEP support is simpler and less error prone than 
> > the
> > use of #ifdef based config guards.
> > 
> > Removing instances of this approach from IIO also stops them being
> > copied into new drivers.
> > 
> > The pm_ptr() macro only removes the reference if CONFIG_PM is not
> > set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
> > will not always remove the pm_ops structure.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> No pm_ptr() for this one?
> 

Gah. I changed my mind about this half way through doing this and
decided to use it throughout rather than just in places that had
defined the pm_ops out by hand.

Missed this one in the update!  Anyhow, easy fix :)

Thanks,

Jonathan

> -Paul
> 
> > ---
> >  drivers/iio/accel/da280.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
> > index 9633bdae5fd4..91ac478891ce 100644
> > --- a/drivers/iio/accel/da280.c
> > +++ b/drivers/iio/accel/da280.c
> > @@ -153,17 +153,15 @@ static int da280_probe(struct i2c_client 
> > *client,
> >  	return devm_iio_device_register(&client->dev, indio_dev);
> >  }
> > 
> > -#ifdef CONFIG_PM_SLEEP
> > -static int da280_suspend(struct device *dev)
> > +static __maybe_unused int da280_suspend(struct device *dev)
> >  {
> >  	return da280_enable(to_i2c_client(dev), false);
> >  }
> > 
> > -static int da280_resume(struct device *dev)
> > +static __maybe_unused int da280_resume(struct device *dev)
> >  {
> >  	return da280_enable(to_i2c_client(dev), true);
> >  }
> > -#endif
> > 
> >  static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
> > 
> > --
> > 2.34.0
> >   
> 
> 

