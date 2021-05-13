Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23037FBF1
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhEMRAr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 13:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230115AbhEMRAq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 13:00:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8961E6121E;
        Thu, 13 May 2021 16:59:34 +0000 (UTC)
Date:   Thu, 13 May 2021 18:00:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 12/28] iio: accel: bmi088: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210513180042.5a7f1751@jic23-huawei>
In-Reply-To: <20210512155139.70a23906@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-13-jic23@kernel.org>
        <20210512155139.70a23906@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 15:51:39 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:38 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The call to pm_runtime_put_noidle() in remove() is not balanced by a get so
> > drop it.
> > 
> > Using pm_runtime_resume_and_get() allows for simple introduction of
> > error handling to allow for runtime resume failing.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Mike Looijmans <mike.looijmans@topic.nl>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if they can find anything we missed.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/accel/bmi088-accel-core.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> > index 61aaaf48c040..a06dae5c971d 100644
> > --- a/drivers/iio/accel/bmi088-accel-core.c
> > +++ b/drivers/iio/accel/bmi088-accel-core.c
> > @@ -285,11 +285,17 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_RAW:
> >  		switch (chan->type) {
> >  		case IIO_TEMP:
> > -			pm_runtime_get_sync(dev);
> > +			ret = pm_runtime_resume_and_get(dev);
> > +			if (ret)
> > +				return ret;
> > +
> >  			ret = bmi088_accel_get_temp(data, val);
> >  			goto out_read_raw_pm_put;
> >  		case IIO_ACCEL:
> > -			pm_runtime_get_sync(dev);
> > +			ret = pm_runtime_resume_and_get(dev);
> > +			if (ret)
> > +				return ret;
> > +
> >  			ret = iio_device_claim_direct_mode(indio_dev);
> >  			if (ret)
> >  				goto out_read_raw_pm_put;
> > @@ -319,7 +325,10 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> >  			*val = BMI088_ACCEL_TEMP_UNIT;
> >  			return IIO_VAL_INT;
> >  		case IIO_ACCEL:
> > -			pm_runtime_get_sync(dev);
> > +			ret = pm_runtime_resume_and_get(dev);
> > +			if (ret)
> > +				return ret;
> > +
> >  			ret = regmap_read(data->regmap,
> >  					  BMI088_ACCEL_REG_ACC_RANGE, val);
> >  			if (ret)
> > @@ -334,7 +343,10 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
> >  			return -EINVAL;
> >  		}
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		pm_runtime_get_sync(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> > +		if (ret)
> > +			return ret;
> > +
> >  		ret = bmi088_accel_get_sample_freq(data, val, val2);
> >  		goto out_read_raw_pm_put;
> >  	default:
> > @@ -376,7 +388,10 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> > -		pm_runtime_get_sync(dev);
> > +		ret = pm_runtime_resume_and_get(dev);
> > +		if (ret)
> > +			return ret;
> > +
> >  		ret = bmi088_accel_set_sample_freq(data, val);
> >  		pm_runtime_mark_last_busy(dev);
> >  		pm_runtime_put_autosuspend(dev);
> > @@ -530,7 +545,6 @@ int bmi088_accel_core_remove(struct device *dev)
> >  
> >  	pm_runtime_disable(dev);
> >  	pm_runtime_set_suspended(dev);
> > -	pm_runtime_put_noidle(dev);
> >  	bmi088_accel_power_down(data);
> >  
> >  	return 0;  
> 
> 
> 
> Thanks,
> Mauro

