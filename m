Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B5AD5027
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJLNpl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfJLNpl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:45:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D885A206CD;
        Sat, 12 Oct 2019 13:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570887940;
        bh=00+UTqPtKvp2pZ3sMrGOIsNlpRUZWfhda2wMEYQlTL4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xg2JbTSV1Hgkc4w+0PqsMsqm//gG467to4D6HTMCQ0Kn4ZLL30hWHV7xEbJq6LsZc
         15JorILEUGROeKj2FWSKNPa0mFXuUd/LpR57e4ryVKloMiq8v6ey03hoJyBU//1BdC
         Iv4pfK2MFrl70i5NeYGoRT7waGheHGNicWxL5UNI=
Date:   Sat, 12 Oct 2019 14:45:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dac: ad7303: replace mlock with own lock
Message-ID: <20191012144536.70eb1c9b@archlinux>
In-Reply-To: <20191007082642.21798-1-alexandru.ardelean@analog.com>
References: <20190919131328.13633-1-alexandru.ardelean@analog.com>
        <20191007082642.21798-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 11:26:42 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change replaces indio_dev's mlock with the driver's own lock. The lock
> is mostly needed to protect state when changing the `dac_cache` info.
> The lock has been extended to `ad7303_read_raw()`, to make sure that the
> cache is updated if an SPI-write is already in progress.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * remove lock from `ad7303_read_dac_powerdown()`
> 
>  drivers/iio/dac/ad7303.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 8de9f40226e6..14bbac6bee98 100644
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
> @@ -79,7 +80,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	if (pwr_down)
>  		st->config |= AD7303_CFG_POWER_DOWN(chan->channel);
> @@ -90,7 +91,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>  	 * mode, so just write one of the DAC channels again */
>  	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return len;
>  }
>  
> @@ -116,7 +117,9 @@ static int ad7303_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
>  		*val = st->dac_cache[chan->channel];
> +		mutex_unlock(&st->lock);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		vref_uv = ad7303_get_vref(st, chan);
> @@ -144,11 +147,11 @@ static int ad7303_write_raw(struct iio_dev *indio_dev,
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
> @@ -211,6 +214,8 @@ static int ad7303_probe(struct spi_device *spi)
>  
>  	st->spi = spi;
>  
> +	mutex_init(&st->lock);
> +
>  	st->vdd_reg = devm_regulator_get(&spi->dev, "Vdd");
>  	if (IS_ERR(st->vdd_reg))
>  		return PTR_ERR(st->vdd_reg);

