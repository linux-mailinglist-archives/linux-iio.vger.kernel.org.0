Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F33A938E
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jun 2021 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFPHRd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Jun 2021 03:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231168AbhFPHRc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Jun 2021 03:17:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56C9A6135C;
        Wed, 16 Jun 2021 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623827727;
        bh=cKQ8FtYLrDWSYjjUkT0+AwrjarJV72ufmL8nQVDEz9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N99irlUDRJ/qQ9DXGEpvtJmRLQb/jb78UcNqY5omzompBbmz2cdCxnQ5e07TI2p23
         aeyadR+f1JBTIheWBNYc7LkQhb891xq5TYYZnxcCoekIo4aWt+Y+Y3O5IknqVehV+/
         zU3nvQbfb0rIWcI8sq1bT55Wd8y+tYSTIbVq6T8Rcu6pzezoCiITIZxLV2g6ln8P/5
         1cmnWcKW5sCXP+afUj9pQO5bRAItlHoEJtd8RpQG0hkAHmR+NLUfZMifD0YtXTVrJn
         bweXEyfyZHeNcP+ufqVDicpOePn6pDvXv5MbOC76g3hgvml8hX7Jn3OioRtlxI8zex
         ElbX+BDn2ANjA==
Date:   Wed, 16 Jun 2021 09:15:23 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH v2 1/6] iio: imu: mpu6050: Balance runtime pm + use
 pm_runtime_resume_and_get()
Message-ID: <20210616091523.03e17b0b@coco.lan>
In-Reply-To: <20210516162103.1332291-2-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
        <20210516162103.1332291-2-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Em Sun, 16 May 2021 17:20:58 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Remove an unblanced pm_runtime_put_sync_suspend() call
> in inv_pu_pm_disable().  Not this call is not a bug, because the runtime
> pm core will not allow the reference counter to go negative.  It is
> however confusing and serves no purpose.
> 
> pm_runtime_resume_and_get() case found using coccicheck script under
> review at:
> https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/
> 
> pm_runtime_resume_and_get() returns <= 0 only so simplify related checks
> to bring this more inline with nearby calls.
> 
> This is a prequel to taking a closer look at the runtime pm in IIO drivers
> in general.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 19 ++++++-------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++----
>  2 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 6244a07048df..4cae3765e327 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -570,11 +570,9 @@ static int inv_mpu6050_read_channel_data(struct iio_dev *indio_dev,
>  	freq_hz = INV_MPU6050_DIVIDER_TO_FIFO_RATE(st->chip_config.divider);
>  	period_us = 1000000 / freq_hz;
>  
> -	result = pm_runtime_get_sync(pdev);
> -	if (result < 0) {
> -		pm_runtime_put_noidle(pdev);
> +	result = pm_runtime_resume_and_get(pdev);
> +	if (result)
>  		return result;
> -	}
>  
>  	switch (chan->type) {
>  	case IIO_ANGL_VEL:
> @@ -812,11 +810,9 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>  		return result;
>  
>  	mutex_lock(&st->lock);
> -	result = pm_runtime_get_sync(pdev);
> -	if (result < 0) {
> -		pm_runtime_put_noidle(pdev);
> +	result = pm_runtime_resume_and_get(pdev);
> +	if (result)
>  		goto error_write_raw_unlock;
> -	}
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> @@ -930,11 +926,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
>  		result = 0;
>  		goto fifo_rate_fail_unlock;
>  	}
> -	result = pm_runtime_get_sync(pdev);
> -	if (result < 0) {
> -		pm_runtime_put_noidle(pdev);
> +	result = pm_runtime_resume_and_get(pdev);
> +	if (result)
>  		goto fifo_rate_fail_unlock;
> -	}
>  
>  	result = regmap_write(st->map, st->reg->sample_rate_div, d);
>  	if (result)
> @@ -1422,7 +1416,6 @@ static void inv_mpu_pm_disable(void *data)
>  {
>  	struct device *dev = data;
>  
> -	pm_runtime_put_sync_suspend(dev);
>  	pm_runtime_disable(dev);
>  }
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index e21ba778595a..2d0e8cdd4848 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -173,11 +173,9 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
>  
>  	if (enable) {
>  		scan = inv_scan_query(indio_dev);
> -		result = pm_runtime_get_sync(pdev);
> -		if (result < 0) {
> -			pm_runtime_put_noidle(pdev);
> +		result = pm_runtime_resume_and_get(pdev);
> +		if (result)
>  			return result;
> -		}
>  		/*
>  		 * In case autosuspend didn't trigger, turn off first not
>  		 * required sensors.



Thanks,
Mauro
