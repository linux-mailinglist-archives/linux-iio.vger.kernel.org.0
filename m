Return-Path: <linux-iio+bounces-12070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E29C2D86
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 14:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FB31F21CBD
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2024 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC218EFC1;
	Sat,  9 Nov 2024 13:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdXblRqd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E313822083;
	Sat,  9 Nov 2024 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731158856; cv=none; b=mY44koSM4LS58uwxBolh2ovA5Eqwk4fNsJquoOX/vuFixb3XipWM9BdhJa+S4YsakRf3UB/UsX3vMwvtmvZ9wplh/ajhs2fK4B8mibNPVBPsTCyCaKktUOSSxdIze8OWnEoDda7Hozrb89ZFb3JSD5+FpxrKTQvFWPt12c8pxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731158856; c=relaxed/simple;
	bh=8gLKa8jowajasZQ5CeY9jgmzVXqM23mtZ1YyTqitf0A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg6AwOj8NKbHOMobev+V5ayhqH6kFg848hu6mbeeWBiChXzjvXcm7uCxpdGUig36pIA/bGdXEYYrWg2DcH9qAkOH5QCYYS3PZd8cd9vfwTJMsPywRdqxeK6i/xxHAfWJ76fgCKKseXK2dRq5ZicbdmKEZWY10mlHbFa07tvDgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdXblRqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F9C4CECE;
	Sat,  9 Nov 2024 13:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731158855;
	bh=8gLKa8jowajasZQ5CeY9jgmzVXqM23mtZ1YyTqitf0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdXblRqdpTO8S4KkGQIUqLM7uUiSt3z0uFNcRPmvQ4ryI20qOFx9wq7aIaIth87oJ
	 uzQAQKpEC7NtHE/LlmFRfdz9VHq1FL+MopJfrHBOCUx/Cp2RBxLNVgcwJ1YLoY4Jgr
	 ZGrG6VBuKVX0jqmTfz2aiWYbicjwGcW+OdZN210a7ywJzoKY6SaAXPoruAsGEmUBNX
	 u19RgN5o8geC9bfTnsRTrsBRC5te9aVmQpbPPIEl+S3cGa9UVGg0vCsb9eR+gmv4Cg
	 066YzeCF5gAJaz2peFw1Q2jrcziaGSD1fk+wII5zw7Fx6Yum1JdIC5cWYocGE+c+nb
	 a4vjcMvFB8YTQ==
Date: Sat, 9 Nov 2024 13:27:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: add support for triggered buffer
Message-ID: <20241109132729.1459cf0a@jic23-huawei>
In-Reply-To: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
References: <20241107-veml6030_triggered_buffer-v1-1-4810ab86cc56@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 07 Nov 2024 21:22:45 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> All devices supported by this driver (currently veml6030, veml6035
> and veml7700) have two 16-bit channels, and can profit for the same
> configuration to support data access via triggered buffers.
> 
> The measurements are stored in two 16-bit consecutive registers
> (addresses 0x04 and 0x05) as little endian, unsigned data.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

Some comments inline below.

Thanks,

Jonathan

> ---
>  drivers/iio/light/Kconfig    |  2 ++
>  drivers/iio/light/veml6030.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 29ffa8491927..0e2566ff5f7b 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -683,6 +683,8 @@ config VEML3235
>  config VEML6030
>  	tristate "VEML6030 and VEML6035 ambient light sensors"
>  	select REGMAP_I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	depends on I2C
>  	help
>  	  Say Y here if you want to build a driver for the Vishay VEML6030
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index ccb43dfd5cf7..d57ae0c4cae3 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -28,6 +28,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/events.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  /* Device registers */
>  #define VEML6030_REG_ALS_CONF   0x00
> @@ -37,6 +39,7 @@
>  #define VEML6030_REG_ALS_DATA   0x04
>  #define VEML6030_REG_WH_DATA    0x05
>  #define VEML6030_REG_ALS_INT    0x06
> +#define VEML6030_REG_DATA(ch)   (VEML6030_REG_ALS_DATA + (ch))
>  
>  /* Bit masks for specific functionality */
>  #define VEML6030_ALS_IT       GENMASK(9, 6)
> @@ -56,6 +59,18 @@
>  #define VEML6035_INT_CHAN     BIT(3)
>  #define VEML6035_CHAN_EN      BIT(2)
>  
> +enum veml6030_scan {
> +	VEML6030_SCAN_ALS,
> +	VEML6030_SCAN_WH,
> +	VEML6030_SCAN_TIMESTAMP,
> +};
> +
> +static const unsigned long veml6030_avail_scan_masks[] = {
> +	(BIT(VEML6030_SCAN_ALS) |
> +	 BIT(VEML6030_SCAN_WH)),

I'd not wrap the two lines above.  Also outer brackets don't add much
so maybe drop them.

> +	0
> +};
> +
>  struct veml603x_chip {
>  	const char *name;
>  	const int(*scale_vals)[][2];
> @@ -86,6 +101,10 @@ struct veml6030_data {
>  	int cur_gain;
>  	int cur_integration_time;
>  	const struct veml603x_chip *chip;
> +	struct {
> +		__le16 chans[2];
> +		aligned_s64 timestamp;
> +	} scan;

This is pretty small and as it's i2c, you don't need to be careful with alignment
(everything is bounce buffered anyway). So you could just have it on the stack
in the trigger_handler function.

>  };
>  
>  static const int veml6030_it_times[][2] = {
> @@ -242,6 +261,14 @@ static const struct iio_chan_spec veml6030_channels[] = {
>  						     BIT(IIO_CHAN_INFO_SCALE),
>  		.event_spec = veml6030_event_spec,
>  		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
> +		.scan_index = VEML6030_SCAN_ALS,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
>  	},
>  	{
>  		.type = IIO_INTENSITY,
> @@ -253,7 +280,16 @@ static const struct iio_chan_spec veml6030_channels[] = {
>  				BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>  						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6030_SCAN_WH,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
>  };
>  
>  static const struct iio_chan_spec veml7700_channels[] = {
> @@ -266,6 +302,14 @@ static const struct iio_chan_spec veml7700_channels[] = {
>  				BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>  						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6030_SCAN_ALS,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,

Don't bother specifying shift when the value is 0 and obvious.
C spec will deal with setting that to 0 for you.

> +			.storagebits = 16,
> +			.endianness = IIO_LE,

As per other branch of the thread, seems this should be IIO_CPU

> +		},
>  	},
>  	{
>  		.type = IIO_INTENSITY,
> @@ -277,7 +321,16 @@ static const struct iio_chan_spec veml7700_channels[] = {
>  				BIT(IIO_CHAN_INFO_SCALE),
>  		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
>  						     BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = VEML6030_SCAN_WH,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.shift = 0,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		},
>  	},
> +	IIO_CHAN_SOFT_TIMESTAMP(VEML6030_SCAN_TIMESTAMP),
>  };
>  
>  static const struct regmap_config veml6030_regmap_config = {
> @@ -889,6 +942,30 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t veml6030_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6030_data *data = iio_priv(iio);
> +	int i, ret, reg;
> +	int j = 0;
> +
> +	iio_for_each_active_channel(iio, i) {
Given you've set the available_scan_masks such that all channels are on
or off, you should be able to read them unconditionally.
The IIO core demux code will break them up if the user requested a subset.

If it makes sense to allow individual channels (looks like it here)
then don't provide available_scan_masks.

A bulk read may make sense (I've not checked register values).

> +		ret = regmap_read(data->regmap, VEML6030_REG_DATA(i), &reg);
> +		if (ret)
> +			goto done;
> +
> +		data->scan.chans[j++] = reg;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(iio, &data->scan, pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}

