Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062E03A9AAB
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFPMpt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 08:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhFPMpn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 08:45:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCD061166;
        Wed, 16 Jun 2021 12:43:34 +0000 (UTC)
Date:   Wed, 16 Jun 2021 13:45:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH v2 1/6] iio: imu: mpu6050: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210616134536.47095845@jic23-huawei>
In-Reply-To: <20210616091523.03e17b0b@coco.lan>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-2-jic23@kernel.org>
        <20210616091523.03e17b0b@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Jun 2021 09:15:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun, 16 May 2021 17:20:58 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Remove an unblanced pm_runtime_put_sync_suspend() call
> > in inv_pu_pm_disable().  Not this call is not a bug, because the runtime
> > pm core will not allow the reference counter to go negative.  It is
> > however confusing and serves no purpose.
> > 
> > pm_runtime_resume_and_get() case found using coccicheck script under
> > review at:
> > https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> > 
> > pm_runtime_resume_and_get() returns <= 0 only so simplify related checks
> > to bring this more inline with nearby calls.
> > 
> > This is a prequel to taking a closer look at the runtime pm in IIO drivers
> > in general.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Thanks!

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to see if it can find anything we missed.

Jonathan

> 
> 
> > ---
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 19 ++++++-------------
> >  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++----
> >  2 files changed, 8 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > index 6244a07048df..4cae3765e327 100644
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
> > @@ -1422,7 +1416,6 @@ static void inv_mpu_pm_disable(void *data)
> >  {
> >  	struct device *dev = data;
> >  
> > -	pm_runtime_put_sync_suspend(dev);
> >  	pm_runtime_disable(dev);
> >  }
> >  
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

