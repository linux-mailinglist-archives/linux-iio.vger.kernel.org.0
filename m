Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5F117CE90
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 14:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGN7J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 08:59:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgCGN7J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 08:59:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34F5C20675;
        Sat,  7 Mar 2020 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583589548;
        bh=ZDHRxEJyaK6Bw9uLKcgDGwKFmfcDiBWHIuRPkkTPMvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wRdEeigQLp1IHRxh54A8BXjaD0kye4J2Xmh0I//Vjk3DNM3czxJquHzIiavkLw5hn
         ie5Nws7d1LP+/S7wHsYbs5/DVSu0DtcHUXi2H+xE74ds+QtH/fw5VP4+dV6zCcY+4Z
         ewXzZn7Qj5G8adV6M0I40fRMJEIjyUxlXk4pOVso=
Date:   Sat, 7 Mar 2020 13:59:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, dragos.bogdan@analog.com,
        jonathon.cameron@huawei.com, alexandru.ardelean@analog.com
Subject: Re: [PATCH v3] iio: adc: max1363: replace uses of mlock
Message-ID: <20200307135904.40e332f4@archlinux>
In-Reply-To: <5e633519.1c69fb81.ec43c.6809@mx.google.com>
References: <5e633519.1c69fb81.ec43c.6809@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 7 Mar 2020 11:15:58 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Replace usage indio_dev's mlock with either local lock or
> iio_device_claim_direct_mode.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>

If sending patches for which there is already a version on the list
which hasn't been commented on please do 2 things.

1) Reply to the previous patch email to highlight what was wrong - stops
   me missing the updated version and picking up the old one.

2) change log below the ---

> ---
>  drivers/iio/adc/max1363.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..d26f68d23250 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -150,6 +150,7 @@ struct max1363_chip_info {
>   * @current_mode:	the scan mode of this chip
>   * @requestedmask:	a valid requested set of channels
>   * @reg:		supply regulator
> + * @lock            lock to ensure state is consistent
>   * @monitor_on:		whether monitor mode is enabled
>   * @monitor_speed:	parameter corresponding to device monitor speed setting
>   * @mask_high:		bitmask for enabled high thresholds
> @@ -169,6 +170,7 @@ struct max1363_state {
>  	const struct max1363_mode	*current_mode;
>  	u32				requestedmask;
>  	struct regulator		*reg;
> +	struct mutex			lock;
>  
>  	/* Using monitor modes and buffer at the same time is
>  	   currently not supported */
> @@ -364,7 +366,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret < 0)
> +		goto error_ret;
>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -372,7 +376,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	 *
>  	 * Also, cannot read directly if buffered capture enabled.
>  	 */
> -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> +	if (st->monitor_on) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -404,8 +408,9 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  		data = rxbuf[0];
>  	}
>  	*val = data;
> +
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	iio_device_release_direct_mode(indio_dev);
>  	return ret;
>  
>  }
> @@ -705,9 +710,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
>  	if (!found)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	st->monitor_speed = i;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return 0;
>  }
> @@ -810,12 +815,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
>  	int val;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (dir == IIO_EV_DIR_FALLING)
>  		val = (1 << number) & st->mask_low;
>  	else
>  		val = (1 << number) & st->mask_high;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return val;
>  }
> @@ -962,7 +967,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  	u16 unifiedmask;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	iio_device_claim_direct_mode(indio_dev);
>  	unifiedmask = st->mask_low | st->mask_high;
>  	if (dir == IIO_EV_DIR_FALLING) {
>  
> @@ -989,7 +994,7 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  
>  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	iio_device_release_direct_mode(indio_dev);	
>  
>  	return ret;
>  }
> @@ -1587,6 +1592,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> +	mutex_init(&st->lock);
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(st->reg)) {
>  		ret = PTR_ERR(st->reg);

