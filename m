Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D427818EB38
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgCVRyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 13:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgCVRyD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Mar 2020 13:54:03 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C677C20722;
        Sun, 22 Mar 2020 17:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584899642;
        bh=IbnMkokmwANNVNyVve0MZWZs9yyQOEDjN+hvjAgaEmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gjve1YMxMAsb3iU8Z6K2aSHA6JMrCFSwmsyEbUtGbMwATYBKKBHkZ2NgmSVrVuq2X
         a1EjaYxSQG5N9J5Z4YuZfUAnxwlcZI0+kP/8uX1lhXZaaOBb3SVY+cTMi3U5/hAPnx
         N8sv9T5J3WYqQDc4GQVeZQzz8x/UXp2wSpg1SDd4=
Date:   Sun, 22 Mar 2020 17:53:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dragos.bogdan@analog.com
Subject: Re: [PATCH v7] iio: adc: max1363: replace uses of mlock
Message-ID: <20200322175358.51e6c586@archlinux>
In-Reply-To: <5e6e522d.1c69fb81.10f54.f95c@mx.google.com>
References: <5e6e522d.1c69fb81.10f54.f95c@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 15 Mar 2020 21:34:58 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Replace usage indio_dev's mlock with either local lock or
> iio_device_claim_direct_mode.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
> Changelog v6 -> v7
> * Fix failure handling logic
> 
> Changelog v5 -> v6
> * Minor failure handling fixes
> 
> Changelog v4 -> v5
> * Use local lock too at places where driver state needs to be protected.
> 
> Changelog v3 -> v4
> * Fix indentation
> 
> Changelog v2 -> v3
> * use iio_device_claim_direct when switching modes
> * replace mlock usage in max1363_write_event_config
> 
> Changelog v1 -> v2
> * Fix indentation
> 
>  drivers/iio/adc/max1363.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..12d72bf3f12a 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -150,6 +150,7 @@ struct max1363_chip_info {
>   * @current_mode:	the scan mode of this chip
>   * @requestedmask:	a valid requested set of channels
>   * @reg:		supply regulator
> + * @lock		lock to ensure state is consistent
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
> @@ -364,7 +366,13 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -372,7 +380,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	 *
>  	 * Also, cannot read directly if buffered capture enabled.
>  	 */
> -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> +	if (st->monitor_on) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -404,8 +412,10 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  		data = rxbuf[0];
>  	}
>  	*val = data;
> +
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  	return ret;
>  
>  }
> @@ -705,9 +715,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
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
> @@ -810,12 +820,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
> @@ -962,7 +972,14 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  	u16 unifiedmask;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
> +
>  	unifiedmask = st->mask_low | st->mask_high;
>  	if (dir == IIO_EV_DIR_FALLING) {
>  
> @@ -989,7 +1006,8 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  
>  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -1587,6 +1605,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> +	mutex_init(&st->lock);
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(st->reg)) {
>  		ret = PTR_ERR(st->reg);

