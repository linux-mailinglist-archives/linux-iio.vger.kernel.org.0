Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678FB4607A7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 17:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhK1Qo7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353118AbhK1Qm7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 11:42:59 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0478C061574
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 08:39:42 -0800 (PST)
Received: from [81.101.6.87] (port=48012 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mrNDF-0007m8-25; Sun, 28 Nov 2021 16:39:41 +0000
Date:   Sun, 28 Nov 2021 16:44:30 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 43/49] iio:proximity:pulsedlight: Switch from CONFIG_PM
 guards to pm_ptr() / __maybe_unused
Message-ID: <20211128164344.1fe77e9f@jic23-huawei>
In-Reply-To: <CAJCx=gkO4a4dF7ZAEnJhLAzveDO2kKofe+uuAHb8X8ULxgC9RQ@mail.gmail.com>
References: <20211123211019.2271440-1-jic23@kernel.org>
        <20211123211019.2271440-44-jic23@kernel.org>
        <CAJCx=gkO4a4dF7ZAEnJhLAzveDO2kKofe+uuAHb8X8ULxgC9RQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 4
X-Spam-Status: No, score=0.4
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Nov 2021 14:22:46 -0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Tue, Nov 23, 2021 at 1:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM support is simpler and less error prone than the
> > use of #ifdef based config guards.
> >
> > Removing instances of this approach from IIO also stops them being
> > copied into new drivers.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Matt Ranostay <matt.ranostay@konsulko.com>  
> 
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
A clang build (without this patch) noted that lidar_write_power() is only used
in these functions (so I got an unused function warning). 

I'll add a maybe_unused to that as well if needed (subject to the
other discussion on how to do this better).

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > index 27026c060ab9..6adc2a0c27cb 100644
> > --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> > @@ -338,8 +338,7 @@ static const struct of_device_id lidar_dt_ids[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, lidar_dt_ids);
> >
> > -#ifdef CONFIG_PM
> > -static int lidar_pm_runtime_suspend(struct device *dev)
> > +static __maybe_unused int lidar_pm_runtime_suspend(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >         struct lidar_data *data = iio_priv(indio_dev);
> > @@ -347,7 +346,7 @@ static int lidar_pm_runtime_suspend(struct device *dev)
> >         return lidar_write_power(data, 0x0f);
> >  }
> >
> > -static int lidar_pm_runtime_resume(struct device *dev)
> > +static __maybe_unused int lidar_pm_runtime_resume(struct device *dev)
> >  {
> >         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> >         struct lidar_data *data = iio_priv(indio_dev);
> > @@ -358,9 +357,8 @@ static int lidar_pm_runtime_resume(struct device *dev)
> >
> >         return ret;
> >  }
> > -#endif
> >
> > -static const struct dev_pm_ops lidar_pm_ops = {
> > +static __maybe_unused const struct dev_pm_ops lidar_pm_ops = {
> >         SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
> >                            lidar_pm_runtime_resume, NULL)
> >  };
> > @@ -369,7 +367,7 @@ static struct i2c_driver lidar_driver = {
> >         .driver = {
> >                 .name   = LIDAR_DRV_NAME,
> >                 .of_match_table = lidar_dt_ids,
> > -               .pm     = &lidar_pm_ops,
> > +               .pm     = pm_ptr(&lidar_pm_ops),
> >         },
> >         .probe          = lidar_probe,
> >         .remove         = lidar_remove,
> > --
> > 2.34.0
> >  

