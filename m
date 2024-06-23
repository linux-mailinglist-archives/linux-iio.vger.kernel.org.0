Return-Path: <linux-iio+bounces-6769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB2913C92
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BE0B20CDA
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628261822D8;
	Sun, 23 Jun 2024 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHHbpAe1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC27604F;
	Sun, 23 Jun 2024 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719158071; cv=none; b=get12O+542U83vIm7CzoYjsjQH7VUBb4CY1iyIL/BwyFF03s23gr6ZsGOh8PD41qdLz3NymbAkYju8/GhhgmoPebz0PmAYTzRvfAWglA2w4XhEGQieP23ZeumBgxLj3QAv/qFQIMAReG/LlZrJx9wwmsrERXEp3AVeQ41enakLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719158071; c=relaxed/simple;
	bh=nYST2THypDow2mf3vfJ+nDdMhwMtzgZAP3rTHr81Pok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA4FJ/TAT9XoaiHAA1C7WsgOJslJ2i7BIP6uHA/lZCz5hFkyRZtmJcx8qGrYdSFfWJHlzAPQoQiyJgNn4v3sAbknGflnPJMrEScZm3Fwq3ErLsog+accwciHbUAz6gC3wRJL3RPqCywzLKsmKt5bGZVotZAwq9UCixdJfkESva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHHbpAe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B618FC2BD10;
	Sun, 23 Jun 2024 15:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719158070;
	bh=nYST2THypDow2mf3vfJ+nDdMhwMtzgZAP3rTHr81Pok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YHHbpAe16Bz24HR4E4/lrDJH90eA4WAzHe7SYNHSw1s7AMTL7oFMvjCipvuBXJOa8
	 xSz/CLFh4Hui7NRSEO9Qy42mRzorBL6AD7okuqkOs8hb36luCN+0cVY5acFEOFsdr3
	 eh64xxCpVGTgphAjQlaiUvZ+XHhn9bMrID10BGO/fVB1SWjKFmAVCE6fUeVoorhjzK
	 L63DFEWRBkkh4ZmrQHguJkO/blC3/I37LQXUZ1M+Xo9Q2YV/fMEcokTVvbEzHSCtI0
	 oaieL52NHt9B2VlOBNLShIHfVJIoUqM3mYbC+ig5eSbvSBcGLtxlO5s3jko2BgeJMr
	 Q7WcVXbV69/eQ==
Date: Sun, 23 Jun 2024 16:54:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v2] iio: adc: ad7606: remove frstdata check for serial
 mode
Message-ID: <20240623165424.164b341b@jic23-huawei>
In-Reply-To: <20240618-cleanup-ad7606-v2-1-b0fd015586aa@baylibre.com>
References: <20240618-cleanup-ad7606-v2-1-b0fd015586aa@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 13:45:00 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Frstdata pin is set high during the first sample's transmission and then
> set low.  This code chunk attempts to recover from an eventual glitch in
> the clock by checking frstdata state after reading the first channel's
> sample.  Currently, in serial mode, this check happens AFTER the 16th
> pulse, and if frstdata is not set it resets the device and returns EINVAL.
> According to the datasheet, "The FRSTDATA output returns to a logic low
> following the 16th SCLK falling edge.", thus after the 16th pulse, the
> check will always be true, and the driver will not work as expected.  Thus
> it must be removed for serial mode.

when you say will not work as expected, is this is normal circumstances, or
when dealing with a clock glitch?  i.e. should this have a fixes tag and
got upstream asap or is it just cleaning up a corner case and can wait for
now?

One trivial comment inline.

Jonathan

> 
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
> Changes in v2:
>  - Remove frstdata check only for the serial interface as suggested by
>    Michael Hennerich.
>  - Link to v1: https://lore.kernel.org/r/20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com
> ---
>  drivers/iio/adc/ad7606.c     | 28 ++-----------------------
>  drivers/iio/adc/ad7606.h     |  2 ++
>  drivers/iio/adc/ad7606_par.c | 49 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 50 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 3a417595294f..c321c6ef48df 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -49,7 +49,7 @@ static const unsigned int ad7616_oversampling_avail[8] = {
>  	1, 2, 4, 8, 16, 32, 64, 128,
>  };
>  
> -static int ad7606_reset(struct ad7606_state *st)
> +int ad7606_reset(struct ad7606_state *st)
>  {
>  	if (st->gpio_reset) {
>  		gpiod_set_value(st->gpio_reset, 1);
> @@ -60,6 +60,7 @@ static int ad7606_reset(struct ad7606_state *st)
>  
>  	return -ENODEV;
>  }
> +EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
>  
>  static int ad7606_reg_access(struct iio_dev *indio_dev,
>  			     unsigned int reg,
> @@ -88,31 +89,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
>  {
>  	unsigned int num = st->chip_info->num_channels - 1;
>  	u16 *data = st->data;
> -	int ret;
> -
> -	/*
> -	 * The frstdata signal is set to high while and after reading the sample
> -	 * of the first channel and low for all other channels. This can be used
> -	 * to check that the incoming data is correctly aligned. During normal
> -	 * operation the data should never become unaligned, but some glitch or
> -	 * electrostatic discharge might cause an extra read or clock cycle.
> -	 * Monitoring the frstdata signal allows to recover from such failure
> -	 * situations.
> -	 */
> -
> -	if (st->gpio_frstdata) {
> -		ret = st->bops->read_block(st->dev, 1, data);
> -		if (ret)
> -			return ret;
> -
> -		if (!gpiod_get_value(st->gpio_frstdata)) {
> -			ad7606_reset(st);
> -			return -EIO;
> -		}
> -
> -		data++;
> -		num--;
> -	}
>  
>  	return st->bops->read_block(st->dev, num, data);
>  }
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 0c6a88cc4695..6649e84d25de 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -151,6 +151,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops);
>  
> +int ad7606_reset(struct ad7606_state *st);
> +
>  enum ad7606_supported_device_ids {
>  	ID_AD7605_4,
>  	ID_AD7606_8,
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index d8408052262e..1f7050297b64 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  #include <linux/err.h>
> @@ -21,8 +22,30 @@ static int ad7606_par16_read_block(struct device *dev,
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
> -	insw((unsigned long)st->base_address, buf, count);
>  
> +	/*
> +	 * On the parallel interface, the frstdata signal is set to high while
> +	 * and after reading the sample of the first channel and low for all
> +	 * other channels.  This can be used to check that the incoming data is
> +	 * correctly aligned.  During normal operation the data should never
> +	 * become unaligned, but some glitch or electrostatic discharge might
> +	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
> +	 * allows to recover from such failure situations.
> +	 */
> +	int num = count;
> +	u16 *_buf = buf;
> +
> +	if (st->gpio_frstdata) {
> +		insw((unsigned long)st->base_address, _buf, 1);
> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> +			ad7606_reset(st);
> +			return -EIO;
> +		}
> +		_buf++;
> +		num--;
> +	}
> +	insw((unsigned long)st->base_address, _buf, num)
> +;

Seems this slipped onto the next line.
Make sure to run checkpatch which I would have thought would catch this.

>  	return 0;
>  }
>  
> @@ -35,8 +58,28 @@ static int ad7606_par8_read_block(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
> -
> -	insb((unsigned long)st->base_address, buf, count * 2);
> +	/*
> +	 * On the parallel interface, the frstdata signal is set to high while
> +	 * and after reading the sample of the first channel and low for all
> +	 * other channels.  This can be used to check that the incoming data is
> +	 * correctly aligned.  During normal operation the data should never
> +	 * become unaligned, but some glitch or electrostatic discharge might
> +	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
> +	 * allows to recover from such failure situations.
> +	 */
> +	int num = count;
> +	u16 *_buf = buf;
> +
> +	if (st->gpio_frstdata) {
> +		insb((unsigned long)st->base_address, _buf, 2);
> +		if (!gpiod_get_value(st->gpio_frstdata)) {
> +			ad7606_reset(st);
> +			return -EIO;
> +		}
> +		_buf++;
> +		num--;
> +	}
> +	insb((unsigned long)st->base_address, _buf, num * 2);
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 07d4d0bb4a8ddcc463ed599b22f510d5926c2495
> change-id: 20240416-cleanup-ad7606-161e2ed9818b
> 
> Best regards,


