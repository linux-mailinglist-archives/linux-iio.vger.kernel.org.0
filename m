Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341C3CCAA1
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfJEOyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfJEOyM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:54:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A465120862;
        Sat,  5 Oct 2019 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570287251;
        bh=i4+TesrGaM8uHPvYouZJoRu4LeDIdYBEiw88S9fGSYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gKU7KCaBgiHWRJ4a7+OyOax8mpz+o+znm+0icEy5EwtJ6PPszWH5+XCaNU8uLjY/j
         0L7bnd+c7q9CpQN98LyKMH25F3XeAQL4Fub52H0kycSuoNFfEpeDycWr5U6rE40jX5
         8oKze8ZKV2TrnKH/lah3rMhv3EtzMIo0yx/gwUIY=
Date:   Sat, 5 Oct 2019 15:54:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad7303: replace mlock with own lock
Message-ID: <20191005155252.1bfa52da@archlinux>
In-Reply-To: <20190919131328.13633-1-alexandru.ardelean@analog.com>
References: <20190919131328.13633-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Sep 2019 16:13:28 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change replaces indio_dev's mlock with the driver's own lock. The lock
> is mostly needed to protect state when changing the `config` & `dac_cache`
> fields. As such, the lock has been extended to covert the read of these
> fields.
This last bit would be needed if we had anywhere that needed to see a consistent
state across those two fields. I can't immediately see where that happens.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
See below.

> ---
>  drivers/iio/dac/ad7303.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 8de9f40226e6..f45352e80db7 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -41,6 +41,7 @@ struct ad7303_state {
>  	struct regulator *vdd_reg;
>  	struct regulator *vref_reg;
>  
> +	struct mutex lock;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -62,9 +63,13 @@ static ssize_t ad7303_read_dac_powerdown(struct iio_dev *indio_dev,
>  	uintptr_t private, const struct iio_chan_spec *chan, char *buf)
>  {
>  	struct ad7303_state *st = iio_priv(indio_dev);
> +	int val;
>  
> -	return sprintf(buf, "%d\n", (bool)(st->config &
> -		AD7303_CFG_POWER_DOWN(chan->channel)));
> +	mutex_lock(&st->lock);
> +	val = (bool)(st->config & AD7303_CFG_POWER_DOWN(chan->channel));
> +	mutex_unlock(&st->lock);

I think the read of st->config should be atomic anyway so you'll either
get the value before or after some concurrent write. That's true
even with the locks, so I don't htink they are needed here.

> +
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
> @@ -79,7 +84,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	if (pwr_down)
>  		st->config |= AD7303_CFG_POWER_DOWN(chan->channel);
> @@ -90,7 +95,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>  	 * mode, so just write one of the DAC channels again */
>  	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return len;
>  }
>  
> @@ -116,7 +121,9 @@ static int ad7303_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
>  		*val = st->dac_cache[chan->channel];
> +		mutex_unlock(&st->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		vref_uv = ad7303_get_vref(st, chan);
> @@ -144,11 +151,11 @@ static int ad7303_write_raw(struct iio_dev *indio_dev,
>  		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = ad7303_write(st, chan->address, val);
>  		if (ret == 0)
>  			st->dac_cache[chan->channel] = val;
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -211,6 +218,8 @@ static int ad7303_probe(struct spi_device *spi)
>  
>  	st->spi = spi;
>  
> +	mutex_init(&st->lock);
> +
>  	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
>  	if (IS_ERR(st->vdd_reg))
>  		return PTR_ERR(st->vdd_reg);

