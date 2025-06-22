Return-Path: <linux-iio+bounces-20871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA29DAE307E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152833B1CC5
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86C61E376C;
	Sun, 22 Jun 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knJEdRzy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F94C92;
	Sun, 22 Jun 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750604464; cv=none; b=F3lmw4EOR4oHigOlQxsJtRgirPyEFYPgiR8kFxZDN/X7gZgHpUMlTp29ZJd39AfmmUr0W+iAam6wv4r9acmBtgBH3B3G2e/3J1j6sTns/LuyR8LXiXpBi0G3k4e5yRk0fkvpK831j9RYi1IUykEtHc5NONolYhwt7Ucmp2nIND0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750604464; c=relaxed/simple;
	bh=sJ2/YKvAq4zAkGzGocx1GG/np9WXkdppXLhIs/TekLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vhd+D7IipNjmhUSGdsp3hmyzOc/VNHp+sJIgqowbxeqYxD8SG2og31zm7b8Jw108Syalqzygc8MJy0s0l5Ygcxh46saotSZpcvTWFqjwNy30hkJjnT4y9Yyjwh9NXAcTgfOii9j7RvG6KRVvxJLrDihDjw9TKIIp+ic0ZF3UPes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knJEdRzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE509C4CEE3;
	Sun, 22 Jun 2025 15:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750604464;
	bh=sJ2/YKvAq4zAkGzGocx1GG/np9WXkdppXLhIs/TekLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knJEdRzyKcdSZg9qK7QOMZcVbTnVd3l2qnWWxKbHoQqIeX+1sPUnZQ2QErD75yEAw
	 b+6BRShnIJczJeBSOPxMOCrWPJBslMT56o/MDDP2QB416XuGRX9fY0IBfTfW1uDi5B
	 m/aBVlfPNVLLoo/RwXceA5n6CmH4a5+Hx3+/l1mlO4I34Qt2e0wFNXX473rDQDbXo/
	 pFaMePkF7DUqh67oBBomB7EolbdGZE2VMKvQkZXcsTRLYLRHjhwXoWLLx7bxB7VKx4
	 PElydmi67/Lzcy+eI0f+1FNRtP6q0/rbnP8PQ0xHDkpw9RupsPaypu8X2qnTE2IcJk
	 phqlSclQ17nrQ==
Date: Sun, 22 Jun 2025 16:00:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 8/9] iio: adc: ad_sigma_delta: add SPI offload support
Message-ID: <20250622160054.31cc5103@jic23-huawei>
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
	<20250620-iio-adc-ad7173-add-spi-offload-support-v1-8-0766f6297430@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 17:20:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add SPI offload support to the ad_sigma_delta module.
> 
> When the SPI controller has SPI offload capabilities, the module will
> now use that for buffered reads instead of the RDY interrupt trigger.
> 
> Drivers that use the ad_sigma_delta module will have to opt into this
> by setting supports_spi_offload since each driver will likely need
> additional changes before SPI offload can be used. This will allow us
> to gradually enable SPI offload support for each driver.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

A few queries inline that again are more about the original code than what
you change here.

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 160 +++++++++++++++++++++++----------
>  include/linux/iio/adc/ad_sigma_delta.h |  14 +++
>  2 files changed, 129 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index a9b97f5d4107a2e1bb74877d30403445e9b04a44..449b0756be96d3f864a6e7f070467ad7311bf7d5 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -14,11 +14,13 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <linux/spi/offload/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
>  #include <linux/unaligned.h>
>  
>  #include <linux/iio/adc/ad_sigma_delta.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -460,8 +462,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
>  	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
>  	struct spi_transfer *xfer = sigma_delta->sample_xfer;
> -	unsigned int i, slot, samples_buf_size;
> -	unsigned int channel, scan_size;
> +	unsigned int i, slot, channel;
>  	u8 *samples_buf;
>  	int ret;
>  
> @@ -489,23 +490,33 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	sigma_delta->active_slots = slot;
>  	sigma_delta->current_slot = 0;
>  
> -	if (sigma_delta->active_slots > 1) {
> -		ret = ad_sigma_delta_append_status(sigma_delta, true);
> -		if (ret)
> -			return ret;
> -	}
> +	if (ad_sigma_delta_has_spi_offload(sigma_delta)) {
> +		xfer[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +		xfer[1].bits_per_word = scan_type->realbits;
> +		xfer[1].len = spi_bpw_to_bytes(scan_type->realbits);
> +	} else {
> +		unsigned int samples_buf_size, scan_size;
>  
> -	samples_buf_size = ALIGN(slot * scan_type->storagebits, 8);
> -	samples_buf_size += sizeof(int64_t);
> -	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
> -				    samples_buf_size, GFP_KERNEL);
> -	if (!samples_buf)
> -		return -ENOMEM;
> +		if (sigma_delta->active_slots > 1) {
> +			ret = ad_sigma_delta_append_status(sigma_delta, true);
> +			if (ret)
> +				return ret;
> +		}
>  
> -	sigma_delta->samples_buf = samples_buf;
> -	scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
> -	xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
> -	xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
> +		samples_buf_size = ALIGN(slot * scan_type->storagebits, 8);

The code I queried earlier is moved here, so make sure to carry through
any changes if it is indeed wrong!

> +		samples_buf_size += sizeof(int64_t);
> +		samples_buf = devm_krealloc(&sigma_delta->spi->dev,
> +					    sigma_delta->samples_buf,
> +					    samples_buf_size, GFP_KERNEL);
> +		if (!samples_buf)
> +			return -ENOMEM;
> +
> +		sigma_delta->samples_buf = samples_buf;
> +		scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
> +
> +		xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
> +		xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
> +	}
>  	xfer[1].cs_change = 1;
>  
>  	if (sigma_delta->info->has_registers) {

> @@ -670,7 +700,8 @@ static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
>  	if ((!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_gpiod)) &&
>  	    ad_sd_disable_irq(sigma_delta)) {
>  		complete(&sigma_delta->completion);
> -		iio_trigger_poll(sigma_delta->trig);
> +		if (sigma_delta->trig)

Is this defensive or can we actually get here with out a trigger?
I would have thought in the offload case (so no trigger here) we'd not call this
function at all.  Mind you, can't we get here with no trigger when doing
a calibration or simple read normally?  

> +			iio_trigger_poll(sigma_delta->trig);
>  
>  		return IRQ_HANDLED;
>  	}



