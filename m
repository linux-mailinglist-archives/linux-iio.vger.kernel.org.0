Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1889F185D79
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 15:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgCOOP6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 10:15:58 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53810 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgCOOP6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 10:15:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 13E439E77F2;
        Sun, 15 Mar 2020 14:15:55 +0000 (GMT)
Date:   Sun, 15 Mar 2020 14:15:53 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: adc: max1363: replace uses of mlock
Message-ID: <20200315141553.3efc968c@archlinux>
In-Reply-To: <5e653c4a.1c69fb81.e805f.b62a@mx.google.com>
References: <5e653c4a.1c69fb81.e805f.b62a@mx.google.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 9 Mar 2020 00:11:06 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> Replace usage indio_dev's mlock with either local lock or
> iio_device_claim_direct_mode.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
Nearly there.  A few minor issues around handling failure to claim direct
mode (which will happen if the buffer is enabled).

Jonathan

> ---
> Changelog v4 -> v5
> Use local lock too at places where driver state needs to be protected.
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
>  drivers/iio/adc/max1363.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..856f523e7018 100644
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
> @@ -364,7 +366,11 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	ret = iio_device_claim_direct_mode(indio_dev);

If this fails, no locks are held, so return directly here.
You don't want to call iio_device_release_direct_mode in that case.

General rule of thumb in kernel is that a function returning an error
should have no 'side effects' - it should be as if it never ran.

> +	mutex_lock(&st->lock);
> +
> +	if (ret < 0)
> +		goto error_ret;
>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -372,7 +378,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	 *
>  	 * Also, cannot read directly if buffered capture enabled.
>  	 */
> -	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
> +	if (st->monitor_on) {
>  		ret = -EBUSY;
>  		goto error_ret;
>  	}
> @@ -404,8 +410,10 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
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
> @@ -705,9 +713,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
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
> @@ -810,12 +818,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
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
> @@ -962,7 +970,9 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  	u16 unifiedmask;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	iio_device_claim_direct_mode(indio_dev);

You have to check the result claim_direct_mode.  It will fail if we are in buffered
mode.  If that happens just return -EBUSY and don't do anything else.

> +	mutex_lock(&st->lock);
> +
>  	unifiedmask = st->mask_low | st->mask_high;
>  	if (dir == IIO_EV_DIR_FALLING) {
>  
> @@ -989,7 +999,8 @@ static int max1363_write_event_config(struct iio_dev *indio_dev,
>  
>  	max1363_monitor_mode_update(st, !!(st->mask_high | st->mask_low));
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -1587,6 +1598,7 @@ static int max1363_probe(struct i2c_client *client,
>  
>  	st = iio_priv(indio_dev);
>  
> +	mutex_init(&st->lock);
>  	st->reg = devm_regulator_get(&client->dev, "vcc");
>  	if (IS_ERR(st->reg)) {
>  		ret = PTR_ERR(st->reg);

