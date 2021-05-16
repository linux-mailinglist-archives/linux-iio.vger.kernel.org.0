Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144A7381F7B
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 17:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhEPPgy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 11:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234525AbhEPPgy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 11:36:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5403161139;
        Sun, 16 May 2021 15:35:37 +0000 (UTC)
Date:   Sun, 16 May 2021 16:36:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/28] iio: imu: mpu6050: Use
 pm_runtime_resume_and_get() to replace open coding.
Message-ID: <20210516163649.1fea5ef9@jic23-huawei>
In-Reply-To: <20210512161102.3d45d9d4@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-14-jic23@kernel.org>
        <20210512161102.3d45d9d4@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:11:02 +0200
Mauro Carvalho Chehab <mchehab@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:39 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Found using coccicheck script under review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > pm_runtime_resume_and_get() returns <= 0 only so simplify related checks
> > to bring this more inline with nearby calls.
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.  
> 
> Hmm... I guess there are some weird things happening there at
> inv_mpu_core_probe(). The code there does:
> 
> ...
>         pm_runtime_put(dev); // Already mentioned above

That one is ok I think as it matches the pm_runtime_get_noresume() a couple
of lines further up.

That will increment the counter, but not carry out a resume (which make sense
as the device is already powered up).  The pm_runtime_put() will cause
the device to suspend which is fine and somewhat logical.

>         result = devm_add_action_or_reset(dev, inv_mpu_pm_disable, dev);
>         if (result)
>                 return result;
> 
> and inv_mpu_pm_disable, in turn, calls:
> 
> 	pm_runtime_put_sync_suspend(dev);

Good spot on that one.  I'll drop it in v2.

> 
> I failed to see where the corresponding get for both 
> pm_runtime_put() and pm_runtime_put_sync_suspend(), as the
> remaining RPM get/put logic seemed balanced.

> 
> 
> 
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 18 ++++++------------
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++----
> >  2 files changed, 8 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 6244a07048df..06b9c84f6bfb 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -570,11 +570,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
> >  	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
> >  	period_us = 1000000 / freq_hz;
> >  
> > -	result = pm_runtime_get_sync(pdev);
> > -	if (result < 0) {
> > -		pm_runtime_put_noidle(pdev);
> > +	result = pm_runtime_resume_and_get(pdev);
> > +	if (result)
> >  		return result;
> > -	}
> >  
> >  	switch (chan->type) {
> >  	case IIO_ANGL_VEL:
> > @@ -812,11 +810,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
> >  		return result;
> >  
> >  	mutex_lock(&st->lock);
> > -	result = pm_runtime_get_sync(pdev);
> > -	if (result < 0) {
> > -		pm_runtime_put_noidle(pdev);
> > +	result = pm_runtime_resume_and_get(pdev);
> > +	if (result)
> >  		goto error_write_raw_unlock;
> > -	}
> >  
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SCALE:
> > @@ -930,11 +926,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
> >  		result = 0;
> >  		goto fifo_rate_fail_unlock;
> >  	}
> > -	result = pm_runtime_get_sync(pdev);
> > -	if (result < 0) {
> > -		pm_runtime_put_noidle(pdev);
> > +	result = pm_runtime_resume_and_get(pdev);
> > +	if (result)
> >  		goto fifo_rate_fail_unlock;
> > -	}
> >  
> >  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
> >  	if (result)
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > index e21ba778595a..2d0e8cdd4848 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -173,11 +173,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
> >  
> >  	if (enable) {
> >  		scan = inv_scan_query(indio_dev);
> > -		result = pm_runtime_get_sync(pdev);
> > -		if (result < 0) {
> > -			pm_runtime_put_noidle(pdev);
> > +		result = pm_runtime_resume_and_get(pdev);
> > +		if (result)
> >  			return result;
> > -		}
> >  		/*
> >  		 * In case autosuspend didn't trigger, turn off first not
> >  		 * required sensors.  
> 
> 
> 
> Thanks,
> Mauro

