Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20D037FB92
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhEMQgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhEMQgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:36:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4905F61106;
        Thu, 13 May 2021 16:34:48 +0000 (UTC)
Date:   Thu, 13 May 2021 17:35:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Rui Miguel Silva" <rui.silva@linaro.org>
Cc:     "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        <linux-iio@vger.kernel.org>,
        "Julia Lawall" <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 01/28] iio: gyro: fxa210002c: Balance runtime pm + use
 pm_runtime_resume_and_get().
Message-ID: <20210513173557.2dfffa1b@jic23-huawei>
In-Reply-To: <20210513173131.64d84e4a@jic23-huawei>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-2-jic23@kernel.org>
        <20210512152243.48c2fc74@coco.lan>
        <20210512153005.0a9b1fb8@coco.lan>
        <CBBZA9T1OY9C.2611WSV49DV2G@arch-thunder>
        <20210513173131.64d84e4a@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 May 2021 17:31:31 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 13 May 2021 09:34:52 +0100
> "Rui Miguel Silva" <rui.silva@linaro.org> wrote:
> 
> > Hi Mauro,
> > On Wed May 12, 2021 at 2:30 PM WEST, Mauro Carvalho Chehab wrote:
> >   
> > > Em Wed, 12 May 2021 15:22:43 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > >    
> > > > Em Sun,  9 May 2021 12:33:27 +0100
> > > > Jonathan Cameron <jic23@kernel.org> escreveu:
> > > >     
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > 
> > > > > In both the probe() error path and remove() pm_runtime_put_noidle()
> > > > > is called which will decrement the runtime pm reference count.
> > > > > However, there is no matching function to have raised the reference count.
> > > > > Not this isn't a fix as the runtime pm core will stop the reference count
> > > > > going negative anyway.
> > > > > 
> > > > > An alternative would have been to raise the count in these paths, but
> > > > > it is not clear why that would be necessary.
> > > > > 
> > > > > Whilst we are here replace some boilerplate with pm_runtime_resume_and_get()
> > > > > Found using coccicheck script under review at:
> > > > > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > > > > 
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Cc: Rui Miguel Silva <rui.silva@linaro.org>      
> > > > 
> > > > LGTM.
> > > > 
> > > > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > >
> > > Hmm...not quite...

Because the fix and the cleanup are in substantially different places in the
driver I'm going to assume git will sort it out and apply the original patch to my
togreg branch - initially pushed out as testing for bots to poke at.

Thanks,

Jonathan
> > >    
> > > > > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > > > > index 5af7b48ff01a..539585b0d300 100644
> > > > > --- a/drivers/iio/gyro/fxas21002c_core.c
> > > > > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > > > > @@ -366,14 +366,7 @@ static int fxas21002c_write(struct fxas21002c_data *data,
> > > > >  
> > > > >  static int  fxas21002c_pm_get(struct fxas21002c_data *data)
> > > > >  {
> > > > > -	struct device *dev = regmap_get_device(data->regmap);
> > > > > -	int ret;
> > > > > -
> > > > > -	ret = pm_runtime_get_sync(dev);
> > > > > -	if (ret < 0)
> > > > > -		pm_runtime_put_noidle(dev);
> > > > > -
> > > > > -	return ret;
> > > > > +	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
> > > > >  }    
> > >
> > > fxas21002c_temp_get() and fxas21002c_axis_get() seem to be
> > > missing a pm_runtime_put*() if something gets wrong at
> > > regmap_field_read(), e. g.:    
> > 
> > Thanks for catching this, you are right. However I think it should
> > have is own patch, since it is a real fix and this one is not.
> > 
> > Jonathan, bellow goes a proper patch, please feel free to squash this
> > on top of yours, or just apply it separately, your call.
> > 
> > Cheers,
> >      Rui
> > 
> > 8<-------------------------------------------------------------------
> > 
> > From 314a56247515c05c0c5504c1e305127878af0c9b Mon Sep 17 00:00:00 2001
> > From: Rui Miguel Silva <rui.silva@linaro.org>
> > Date: Wed, 12 May 2021 23:39:29 +0100
> > Subject: [PATCH] iio: gyro: fxas21002c: balance runtime power in error path
> > 
> > If we fail to read temperature or axis we need to decrement the
> > runtime pm reference count to trigger autosuspend.
> > 
> > Add the call to pm_put to do that in case of error.
> > 
> > Fixes: a0701b6263ae ("iio: gyro: add core driver for fxas21002c")
> > Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>  
> 
> I've queued this as a fix in my fixes-togreg branch of iio.git and marked
> it for stable.
> 


> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/gyro/fxas21002c_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
> > index 1a20c6b88e7d..645461c70454 100644
> > --- a/drivers/iio/gyro/fxas21002c_core.c
> > +++ b/drivers/iio/gyro/fxas21002c_core.c
> > @@ -399,6 +399,7 @@ static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
> >  	ret = regmap_field_read(data->regmap_fields[F_TEMP], &temp);
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read temp: %d\n", ret);
> > +		fxas21002c_pm_put(data);
> >  		goto data_unlock;
> >  	}
> >  
> > @@ -432,6 +433,7 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
> >  			       &axis_be, sizeof(axis_be));
> >  	if (ret < 0) {
> >  		dev_err(dev, "failed to read axis: %d: %d\n", index, ret);
> > +		fxas21002c_pm_put(data);
> >  		goto data_unlock;
> >  	}
> >    
> 

