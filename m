Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54BF3FB3AB
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 12:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhH3KOR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 06:14:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhH3KOR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 06:14:17 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC4260C40;
        Mon, 30 Aug 2021 10:13:21 +0000 (UTC)
Date:   Mon, 30 Aug 2021 11:16:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-iio@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/16] iio: adc: max1027: Create a helper to configure
 the trigger
Message-ID: <20210830111633.686bd55d@jic23-huawei>
In-Reply-To: <20210818111139.330636-8-miquel.raynal@bootlin.com>
References: <20210818111139.330636-1-miquel.raynal@bootlin.com>
        <20210818111139.330636-8-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Aug 2021 13:11:30 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> There are two ways to physically trigger a conversion:
> - A falling edge on the cnvst pin
> - A write operation on the conversion register
> 
> Let's create a helper for this.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Trivial comments inline.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/max1027.c | 52 ++++++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index a6ebc951c09a..59914fcfd320 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -232,10 +232,37 @@ struct max1027_state {
>  	struct iio_trigger		*trig;
>  	__be16				*buffer;
>  	struct mutex			lock;
> -

Avoid white space changes in a patch doing something else.
In this case, I'd imagine the reg had a blank line before it to more
strongly indicate the cacheline_aligned nature meaning there would be
a bit of padding inserted here.

> +	bool				cnvst_trigger;

I'd expect a cnvst_trigger named variable to be a pointer to the trigger.  Perhaps
call it use_cnvst_trigger or something like that?

>  	u8				reg ____cacheline_aligned;
>  };
>  
> +static int max1027_configure_trigger(struct iio_dev *indio_dev)
> +{
> +	struct max1027_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	st->reg = MAX1027_SETUP_REG | MAX1027_REF_MODE2;
> +
> +	/*
> +	 * Start acquisition on:
> +	 * MODE0: external hardware trigger wired to the cnvst input pin
> +	 * MODE2: conversion register write
> +	 */
> +	if (st->cnvst_trigger)
> +		st->reg |= MAX1027_CKS_MODE0;
> +	else
> +		st->reg |= MAX1027_CKS_MODE2;
> +
> +	ret = spi_write(st->spi, &st->reg, 1);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev,
> +			"Failed to configure register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int max1027_read_single_value(struct iio_dev *indio_dev,
>  				     struct iio_chan_spec const *chan,
>  				     int *val)
> @@ -248,14 +275,9 @@ static int max1027_read_single_value(struct iio_dev *indio_dev,
>  		return -EBUSY;
>  	}
>  
> -	/* Start acquisition on conversion register write */
> -	st->reg = MAX1027_SETUP_REG | MAX1027_REF_MODE2 | MAX1027_CKS_MODE2;
> -	ret = spi_write(st->spi, &st->reg, 1);
> -	if (ret < 0) {
> -		dev_err(&indio_dev->dev,
> -			"Failed to configure setup register\n");
> +	ret = max1027_configure_trigger(indio_dev);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	/* Configure conversion register with the requested chan */
>  	st->reg = MAX1027_CONV_REG | MAX1027_CHAN(chan->channel) |
> @@ -363,12 +385,10 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
>  	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
>  		return -EINVAL;
>  
> +	st->cnvst_trigger = state;
>  	if (state) {
> -		/* Start acquisition on cnvst */
> -		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE0 |
> -			  MAX1027_REF_MODE2;
> -		ret = spi_write(st->spi, &st->reg, 1);
> -		if (ret < 0)
> +		ret = max1027_configure_trigger(indio_dev);
> +		if (ret)
>  			return ret;
>  
>  		/*
> @@ -382,10 +402,8 @@ static int max1027_set_cnvst_trigger_state(struct iio_trigger *trig, bool state)
>  			return ret;
>  	} else {
>  		/* Start acquisition on conversion register write */
> -		st->reg = MAX1027_SETUP_REG | MAX1027_CKS_MODE2	|
> -			  MAX1027_REF_MODE2;
> -		ret = spi_write(st->spi, &st->reg, 1);
> -		if (ret < 0)
> +		ret = max1027_configure_trigger(indio_dev);
> +		if (ret)
>  			return ret;
>  	}
>  

