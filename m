Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536581D61E4
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEPPVU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgEPPVU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:21:20 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA93B2065C;
        Sat, 16 May 2020 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642479;
        bh=LVxp+/ayanEJJ26cFKX6UdrnhoIwfCg61e8m+b2QBFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdOsYxyCTzVjGieGd/j8mjWZMUWoPR2ObHRMm1/YwRDVbiC17LoA65OVNqmF7I4LL
         n8AGFNzVJK99B1pEpIwz6VF2eG4DsF3vZoKDNUZ+QUMB12YxIwj9MSaPBrGc2nsIyp
         SA3PZAGm/jSaWjRPDRVu3yzAnjSzWFm8dCzQG2SU=
Date:   Sat, 16 May 2020 16:21:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5755: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516162114.1d58ddea@archlinux>
In-Reply-To: <20200514090608.80521-1-sergiu.cuciurean@analog.com>
References: <20200514090608.80521-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:06:05 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> This also changes some internal functions to pass the pointer to the
> state-struct vs a ref to indio_dev just to access the state-struct again.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git.

An observation on this one is that, with the local lock we always
have the iio_priv() structure where we are calling the various
write functions.  Those take the indio_dev and use it just to get
the iio_priv().  May be worth a follow up to tidy that up and just
pass the private state structure directly into the various write
functions.

Jonathan

> ---
>  drivers/iio/dac/ad5755.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index 388ddd14bfd0..7723bd313fc6 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -82,6 +82,7 @@ struct ad5755_chip_info {
>   * @pwr_down:	bitmask which contains  hether a channel is powered down or not
>   * @ctrl:	software shadow of the channel ctrl registers
>   * @channels:	iio channel spec for the device
> + * @lock	lock to protect the data buffer during SPI ops
>   * @data:	spi transfer buffers
>   */
>  struct ad5755_state {
> @@ -90,6 +91,7 @@ struct ad5755_state {
>  	unsigned int			pwr_down;
>  	unsigned int			ctrl[AD5755_NUM_CHANNELS];
>  	struct iio_chan_spec		channels[AD5755_NUM_CHANNELS];
> +	struct mutex			lock;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -174,11 +176,12 @@ static int ad5755_write_ctrl_unlocked(struct iio_dev *indio_dev,
>  static int ad5755_write(struct iio_dev *indio_dev, unsigned int reg,
>  	unsigned int val)
>  {
> +	struct ad5755_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad5755_write_unlocked(indio_dev, reg, val);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -186,11 +189,12 @@ static int ad5755_write(struct iio_dev *indio_dev, unsigned int reg,
>  static int ad5755_write_ctrl(struct iio_dev *indio_dev, unsigned int channel,
>  	unsigned int reg, unsigned int val)
>  {
> +	struct ad5755_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = ad5755_write_ctrl_unlocked(indio_dev, channel, reg, val);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -211,7 +215,7 @@ static int ad5755_read(struct iio_dev *indio_dev, unsigned int addr)
>  		},
>  	};
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	st->data[0].d32 = cpu_to_be32(AD5755_READ_FLAG | (addr << 16));
>  	st->data[1].d32 = cpu_to_be32(AD5755_NOOP);
> @@ -220,7 +224,7 @@ static int ad5755_read(struct iio_dev *indio_dev, unsigned int addr)
>  	if (ret >= 0)
>  		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -246,7 +250,7 @@ static int ad5755_set_channel_pwr_down(struct iio_dev *indio_dev,
>  	struct ad5755_state *st = iio_priv(indio_dev);
>  	unsigned int mask = BIT(channel);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	if ((bool)(st->pwr_down & mask) == pwr_down)
>  		goto out_unlock;
> @@ -266,7 +270,7 @@ static int ad5755_set_channel_pwr_down(struct iio_dev *indio_dev,
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return 0;
>  }
> @@ -746,6 +750,8 @@ static int ad5755_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->num_channels = AD5755_NUM_CHANNELS;
>  
> +	mutex_init(&st->lock);
> +
>  	if (spi->dev.of_node)
>  		pdata = ad5755_parse_dt(&spi->dev);
>  	else

