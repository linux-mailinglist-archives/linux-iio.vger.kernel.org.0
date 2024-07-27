Return-Path: <linux-iio+bounces-7972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4E93DF9A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEADB20EE8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7571386B4;
	Sat, 27 Jul 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnJKXSXh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE221B86F6;
	Sat, 27 Jul 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088239; cv=none; b=WLEC3GDee4guBIXJh6VdaUMsFkILV8zpACBcSMxxdS3mlfnFL/y/LWdxvmYeCZuulW8iClWlmJ6yiP8qWVs0FLzU439KOlGmz0rTJ2doA4VxTeofZPAtj0LALucOdBXDGpZ5Xukv1/3HFSNx1R9eX2ZFOxd6gBdK3FxB/YfS554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088239; c=relaxed/simple;
	bh=pB+c8yVWKT+jBbj4QT6+v8mQ1KImQN6ppDg/5rASphA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ3Gh5muU/GhL6GYtMNRl/MdKbKc1nMcd9n4SddIt7LOwVkpJcLLMvMK80o+RwuAw/RItpzrgFQwZiF1Gigcdfc7o7AKTxDr/RbTZ4mFKfdiwaJOYQJwaX388aUUqLgJ+8tOZ5A/wWb99SnXlMT7Fm7QaT6SM3m86arfsI2KS28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnJKXSXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8306DC32781;
	Sat, 27 Jul 2024 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088238;
	bh=pB+c8yVWKT+jBbj4QT6+v8mQ1KImQN6ppDg/5rASphA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mnJKXSXhNwgvqgXl5Lp2/vo8DwxDzCSfda0GPX5D+q7ECjZHZYztCqFKt9XhfLYKe
	 Vp6bHOVRTNA/usluMpZ4xiy2mSUVwsjoU8FJTC4h254o+o+P2ne8qyTGrrMdW4E2pY
	 aFJV5Z9gdU3geU/QOcmKyHMKzwo7rAZReYxZdY77RQitaiQrcMaj4ZJrkahJQn3cU3
	 Y6Ej2nm34BfnUr5dXM0S094jzPKR+h2t3wWigPa5ewKxMg0j7DaZV8U0DscyimtCki
	 8AcJDtIPvdoulF0bmEEj25MrhngQyz8G4dO44HqKChECpVg3B2g31GGpuye3JB+uIx
	 ijAXMwViuzy0Q==
Date: Sat, 27 Jul 2024 14:50:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v3 9/9] iio: adc: ad7944: add support for SPI
 offload
Message-ID: <20240727145029.07b19fd5@jic23-huawei>
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-9-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
	<20240722-dlech-mainline-spi-engine-offload-2-v3-9-7420e45df69b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 16:57:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for SPI offload to the ad7944 driver. This allows
> reading data at the max sample rate of 2.5 MSPS.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I think you can easily make the sampling frequence attribute disappear for
cases where we can't provide a real value back for a read.

> ---
> 
> Note: in v2 we discussed if we should make the SPI offload use buffer1
> instead of buffer0 as to not break userspace. I'm still on the fence
> about if we should do that or not. Mainly because many userspace tools
> aren't aware of multiple buffers yet, so would make it harder to
> use the driver. And technically, the way it is implemented right now
> is not going to change anything for existing users since they won't
> be using the offload feature. So the argument could be made that this
> isn't really breaking userspace after all.
> 
> v3 changes:
> * Finished TODOs.
> * Adapted to changes in other patches.
> 
> v2 changes:
> 
> In the previous version, there was a new separate driver for the PWM
> trigger and DMA hardware buffer. This was deemed too complex so they
> are moved into the ad7944 driver.
> 
> It has also been reworked to accommodate for the changes described in
> the other patches.
> ---
>  drivers/iio/adc/ad7944.c | 173 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 166 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 0f36138a7144..43674ff439d2 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -9,6 +9,7 @@
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -21,6 +22,7 @@
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer-dmaengine.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> @@ -54,6 +56,8 @@ struct ad7944_adc {
>  	enum ad7944_spi_mode spi_mode;
>  	struct spi_transfer xfers[3];
>  	struct spi_message msg;
> +	struct spi_transfer offload_xfers[3];
> +	struct spi_message offload_msg;
>  	void *chain_mode_buf;
>  	/* Chip-specific timing specifications. */
>  	const struct ad7944_timing_spec *timing_spec;
> @@ -65,6 +69,8 @@ struct ad7944_adc {
>  	bool always_turbo;
>  	/* Reference voltage (millivolts). */
>  	unsigned int ref_mv;
> +	/* Clock that triggers SPI offload. */
> +	struct clk *trigger_clk;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
> @@ -81,6 +87,8 @@ struct ad7944_adc {
>  
>  /* quite time before CNV rising edge */
>  #define T_QUIET_NS	20

I'd prefer these prefixed as AD7944_T_QUIET_NS etc

> +/* minimum CNV high time to trigger conversion */
> +#define T_CNVH_NS	20
>  
>  static const struct ad7944_timing_spec ad7944_timing_spec = {
>  	.conv_ns = 420,
> @@ -123,6 +131,7 @@ static const struct ad7944_chip_info _name##_chip_info = {		\
>  			.scan_type.endianness = IIO_CPU,		\
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
>  					| BIT(IIO_CHAN_INFO_SCALE),	\
> +			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),\

So this gets registered for all cases, but may return -EIOPNOTSUPPORTED?

That's not ideal.  If we can we should hide this file if we aren't going
to be able to read it.
Whilst it may seem overkill that's a separate iio_chan_spec array etc
that is picked based on whether we are using spi offloading or not.

>  		},							\
>  		IIO_CHAN_SOFT_TIMESTAMP(1),				\
>  	},								\
> @@ -236,6 +245,54 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
>  	return devm_spi_optimize_message(dev, adc->spi, &adc->msg);
>  }
>  
> +static void ad7944_offload_unprepare(void *p)
> +{
> +	struct ad7944_adc *adc = p;
> +
> +	spi_offload_unprepare(adc->spi, NULL, &adc->offload_msg);
> +}

>  static int ad7944_probe(struct spi_device *spi)
>  {
>  	const struct ad7944_chip_info *chip_info;
> @@ -554,13 +682,11 @@ static int ad7944_probe(struct spi_device *spi)
>  		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
>  		if (ret)
>  			return ret;	
> -
>  		break;
>  	case AD7944_SPI_MODE_SINGLE:
>  		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
>  		if (ret)
>  			return ret;
> -
Don't edit unrelated white space in a patch that is doing more important things.
Just noise...
>  		break;


