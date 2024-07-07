Return-Path: <linux-iio+bounces-7411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B40E9298BB
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2071F2101B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7C2E64B;
	Sun,  7 Jul 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpfkRWkV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928A28EA;
	Sun,  7 Jul 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720368188; cv=none; b=Uyjhgfh1yQ+5vXbaNGvISfNKG7gfdgJsPG5MR1tlwsidmvXyc41wVTHoDZ6E3ctaqCJOYJ2TwQq0Xyskap+zJuZt4NtcJr+wa7XsKPoTUxSm83m1PzL+PHu0JuALompKOVXUxkzdr0bGESY6+9SOjhWqqXULmAA64fNjGr6j2QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720368188; c=relaxed/simple;
	bh=7Zh/BdC70mcdgFjK67+A5h+GYA7oU9qGfd1HQ+JVvb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twKTY+TYjG+U15fXSlGtY+kYeBS65Zmu+/F5HZqq+ypxQPWWzzqGv5HhPX+V4oJnyh7D+4GahUc0BvboX0cJbWSkTmmTBLUkzRxujOqag4z93DVHJoO3R8uMCviPZoI4/KTnrM1VRnkMzuUTMdn35zsFsRhLTXTJLE+hQloJWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpfkRWkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE1DC3277B;
	Sun,  7 Jul 2024 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720368187;
	bh=7Zh/BdC70mcdgFjK67+A5h+GYA7oU9qGfd1HQ+JVvb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpfkRWkVBkHdgXreGQ0CXV4pmoBgFiCmrA4ADKn2pKkV2srCefCJO/zOJyZUPTvBl
	 TUc3m1wYBTQHc+lAm7hUdyMumhKmgwoYosQ4K36t7NohnVSc4EgbNRCV+p3hs+DVei
	 /NZSW5mD2RvM4LbCb5eLn4siYjufwY79bbrZND0AH8Z+3ZRO53YF9QXaZAkEXVdd0X
	 3pIWyKqD9VbX5ktCVXws8NglXUJQvc9zGCrfJG/KRtF/Nyk+vhrQacpfCe7GgV6Fvi
	 CJ44vlO31ADWG4aq8/0IB9XwGJp+XNTAskswZAjGiT/UnGOHjXRyZ0jAuch6MOQOiQ
	 y/NM3/f9ce3cw==
Date: Sun, 7 Jul 2024 17:02:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Greg Kroah-Hartman <gregkh@suse.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <jic23@cam.ac.uk>, jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH v3] iio: adc: ad7606: remove frstdata check for serial
 mode
Message-ID: <20240707170259.5505e8c3@jic23-huawei>
In-Reply-To: <20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com>
References: <20240702-cleanup-ad7606-v3-1-18d5ea18770e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jul 2024 12:52:51 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> The current implementation attempts to recover from an eventual glitch
> in the clock by checking frstdata state after reading the first
> channel's sample: If frstdata is low, it will reset the chip and
> return -EIO.
> 
> This will only work in parallel mode, where frstdata pin is set low
> after the 2nd sample read starts.
> 
> For the serial mode, according to the datasheet, "The FRSTDATA output
> returns to a logic low following the 16th SCLK falling edge.", thus
> after the Xth pulse, X being the number of bits in a sample, the check
> will always be true, and the driver will not work at all in serial
> mode if frstdata(optional) is defined in the devicetree as it will
> reset the chip, and return -EIO every time read_sample is called.
> 
> Hence, this check must be removed for serial mode.
> 
> Fixes: b9618c0cacd7 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")
> 
No blank line here. Fixes is part of the tag block and some tooling
falls over if it sees a blank line. 

There are bots checking this on upstream trees btw.

With that blank line removed, applied to the fixes-togreg branch of iio.git and
marked for stable.  Note I might not do a pull request until the merge window
is over as I don't have anything particularly urgent and it can get messy!

Thanks,

Jonathan

> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
> Changes in v3:
> - Improve commit message.
> - Add Fixes tag: the fixes tag is the initial commit since the issue
>   have been there from then on, probably overlooked because removing
>   frstdata from DT solved the issue.
> - Remove extra linebreak.
> - Link to v2: https://lore.kernel.org/r/20240618-cleanup-ad7606-v2-1-b0fd015586aa@baylibre.com
> 
> iio: adc: ad7606: remove frstdata check for serial modei
> 
> Changes in v2:
>  - Remove frstdata check only for the serial interface as suggested by
>    Michael Hennerich.
>  - Link to v1: https://lore.kernel.org/r/20240417-cleanup-ad7606-v1-1-5c2a29662c0a@baylibre.com
> ---
>  drivers/iio/adc/ad7606.c     | 28 ++------------------------
>  drivers/iio/adc/ad7606.h     |  2 ++
>  drivers/iio/adc/ad7606_par.c | 48 +++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 49 insertions(+), 29 deletions(-)
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
> index d8408052262e..6bc587b20f05 100644
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
> @@ -21,8 +22,29 @@ static int ad7606_par16_read_block(struct device *dev,
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
> +	insw((unsigned long)st->base_address, _buf, num);
>  	return 0;
>  }
>  
> @@ -35,8 +57,28 @@ static int ad7606_par8_read_block(struct device *dev,
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


