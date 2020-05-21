Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87C21DD61A
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgEUSia (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 14:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728240AbgEUSia (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 May 2020 14:38:30 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7AC20738;
        Thu, 21 May 2020 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590086309;
        bh=zuqfqinIjtMlw1CY3fb+lDpVP6odkssn12yJq7ZJnzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nZWlIzxLzbRSdZ6FAN4Hd9Idl5vZAD5WKydXdgYX2QcKrN0zbWdHshHc78e9BhDRl
         rhKyWvZRGqDt4IG1RTqOyRShBcpFv5Epa6YAMWR6DXU7ibEIfU1iE75zEd4qG+N8v6
         Y8+ZNz4ykFnCknkbOxJpLYq/P8LiX+8MYlLddmKg=
Date:   Thu, 21 May 2020 19:38:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio: dac: ad5592r-base: Replace indio_dev->mlock
 with own device lock
Message-ID: <20200521193825.76c36f8a@archlinux>
In-Reply-To: <20200520120207.46034-1-sergiu.cuciurean@analog.com>
References: <20200520061819.29056-1-sergiu.cuciurean@analog.com>
        <20200520120207.46034-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 May 2020 15:02:01 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> This also removes unused iio_dev pointers.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5592r-base.c | 30 +++++++++++++++---------------
>  drivers/iio/dac/ad5592r-base.h |  1 +
>  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index e2110113e884..410e90e5f75f 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -156,7 +156,6 @@ static void ad5592r_gpio_cleanup(struct ad5592r_state *st)
>  static int ad5592r_reset(struct ad5592r_state *st)
>  {
>  	struct gpio_desc *gpio;
> -	struct iio_dev *iio_dev = iio_priv_to_dev(st);
>  
>  	gpio = devm_gpiod_get_optional(st->dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(gpio))
> @@ -166,10 +165,10 @@ static int ad5592r_reset(struct ad5592r_state *st)
>  		udelay(1);
>  		gpiod_set_value(gpio, 1);
>  	} else {
> -		mutex_lock(&iio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		/* Writing this magic value resets the device */
>  		st->ops->reg_write(st, AD5592R_REG_RESET, 0xdac);
> -		mutex_unlock(&iio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  	}
>  
>  	udelay(250);
> @@ -197,7 +196,6 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
>  	const struct ad5592r_rw_ops *ops = st->ops;
>  	int ret;
>  	unsigned i;
> -	struct iio_dev *iio_dev = iio_priv_to_dev(st);
>  	u8 pulldown = 0, tristate = 0, dac = 0, adc = 0;
>  	u16 read_back;
>  
> @@ -247,7 +245,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
>  		}
>  	}
>  
> -	mutex_lock(&iio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	/* Pull down unused pins to GND */
>  	ret = ops->reg_write(st, AD5592R_REG_PULLDOWN, pulldown);
> @@ -285,7 +283,7 @@ static int ad5592r_set_channel_modes(struct ad5592r_state *st)
>  		ret = -EIO;
>  
>  err_unlock:
> -	mutex_unlock(&iio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> @@ -314,11 +312,11 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  		if (!chan->output)
>  			return -EINVAL;
>  
> -		mutex_lock(&iio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = st->ops->write_dac(st, chan->channel, val);
>  		if (!ret)
>  			st->cached_dac[chan->channel] = val;
> -		mutex_unlock(&iio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		if (chan->type == IIO_VOLTAGE) {
> @@ -333,12 +331,12 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  			else
>  				return -EINVAL;
>  
> -			mutex_lock(&iio_dev->mlock);
> +			mutex_lock(&st->lock);
>  
>  			ret = st->ops->reg_read(st, AD5592R_REG_CTRL,
>  						&st->cached_gp_ctrl);
>  			if (ret < 0) {
> -				mutex_unlock(&iio_dev->mlock);
> +				mutex_unlock(&st->lock);
>  				return ret;
>  			}
>  
> @@ -360,7 +358,7 @@ static int ad5592r_write_raw(struct iio_dev *iio_dev,
>  
>  			ret = st->ops->reg_write(st, AD5592R_REG_CTRL,
>  						 st->cached_gp_ctrl);
> -			mutex_unlock(&iio_dev->mlock);
> +			mutex_unlock(&st->lock);
>  
>  			return ret;
>  		}
> @@ -382,7 +380,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&iio_dev->mlock);
> +		mutex_lock(&st->lock);
>  
>  		if (!chan->output) {
>  			ret = st->ops->read_adc(st, chan->channel, &read_val);
> @@ -419,7 +417,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  		} else {
>  			int mult;
>  
> -			mutex_lock(&iio_dev->mlock);
> +			mutex_lock(&st->lock);
>  
>  			if (chan->output)
>  				mult = !!(st->cached_gp_ctrl &
> @@ -437,7 +435,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  	case IIO_CHAN_INFO_OFFSET:
>  		ret = ad5592r_get_vref(st);
>  
> -		mutex_lock(&iio_dev->mlock);
> +		mutex_lock(&st->lock);
>  
>  		if (st->cached_gp_ctrl & AD5592R_REG_CTRL_ADC_RANGE)
>  			*val = (-34365 * 25) / ret;
> @@ -450,7 +448,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
>  	}
>  
>  unlock:
> -	mutex_unlock(&iio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> @@ -625,6 +623,8 @@ int ad5592r_probe(struct device *dev, const char *name,
>  	iio_dev->info = &ad5592r_info;
>  	iio_dev->modes = INDIO_DIRECT_MODE;
>  
> +	mutex_init(&st->lock);
> +
>  	ad5592r_init_scales(st, ad5592r_get_vref(st));
>  
>  	ret = ad5592r_reset(st);
> diff --git a/drivers/iio/dac/ad5592r-base.h b/drivers/iio/dac/ad5592r-base.h
> index 4774e4cd9c11..23dac2f1ff8a 100644
> --- a/drivers/iio/dac/ad5592r-base.h
> +++ b/drivers/iio/dac/ad5592r-base.h
> @@ -52,6 +52,7 @@ struct ad5592r_state {
>  	struct regulator *reg;
>  	struct gpio_chip gpiochip;
>  	struct mutex gpio_lock;	/* Protect cached gpio_out, gpio_val, etc. */
> +	struct mutex lock;
>  	unsigned int num_channels;
>  	const struct ad5592r_rw_ops *ops;
>  	int scale_avail[2][2];

