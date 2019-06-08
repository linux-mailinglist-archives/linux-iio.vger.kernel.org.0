Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8263D3A016
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfFHNzm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:55:42 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:32982 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHNzm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 09:55:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 096089E9163;
        Sat,  8 Jun 2019 14:55:39 +0100 (BST)
Date:   Sat, 8 Jun 2019 14:55:38 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: amplifiers: ad8366: use own lock to guard
 state
Message-ID: <20190608145538.0107f3ce@archlinux>
In-Reply-To: <20190530131812.3476-2-alexandru.ardelean@analog.com>
References: <20190530131812.3476-1-alexandru.ardelean@analog.com>
        <20190530131812.3476-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 16:18:09 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This driver is still using iio_dev's mlock to guard against inconsistent
> state. This has been discouraged for some time.
> 
> This change switches to using it's own mutex, defined on the state struct.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/ad8366.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 82ac15914ff3..24ff5475d9f2 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -21,6 +21,7 @@
>  struct ad8366_state {
>  	struct spi_device	*spi;
>  	struct regulator	*reg;
> +	struct mutex            lock; /* protect sensor state */
>  	unsigned char		ch[2];
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -58,7 +59,7 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	unsigned code;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch (m) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		code = st->ch[chan->channel];
> @@ -73,7 +74,7 @@ static int ad8366_read_raw(struct iio_dev *indio_dev,
>  	default:
>  		ret = -EINVAL;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  };
> @@ -99,7 +100,7 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  
>  	code = (code - 4500) / 253;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		st->ch[chan->channel] = code;
> @@ -108,7 +109,7 @@ static int ad8366_write_raw(struct iio_dev *indio_dev,
>  	default:
>  		ret = -EINVAL;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -151,6 +152,7 @@ static int ad8366_probe(struct spi_device *spi)
>  	}
>  
>  	spi_set_drvdata(spi, indio_dev);
> +	mutex_init(&st->lock);
>  	st->spi = spi;
>  
>  	indio_dev->dev.parent = &spi->dev;

