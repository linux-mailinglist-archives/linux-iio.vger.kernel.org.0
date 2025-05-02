Return-Path: <linux-iio+bounces-18981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797FAA6ED9
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 12:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA60998228F
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A022E3F9;
	Fri,  2 May 2025 10:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3nHkOqO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFE915350B;
	Fri,  2 May 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180454; cv=none; b=rUXyAH2IWhUaeTn1k6CU5dvDA7KdRPB1KDGUBUoOkm7djNHrX0UzlAMYHb5hSR5YcUk90R22VvnfdLCDE7lPw/W6BTDFjLmkV9yEOnbOve+u7SOpsth3/hMkkpPczGd+LU+2nH27FGi1EjU6aFrsS+4fs6YxlsVauilOCUS2MNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180454; c=relaxed/simple;
	bh=ABTJzmirhXJNfdMrrzRqDK9d4R4fuVLD8Yt2bg5MhM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxl3MRzV5capB97EOgL3APQxsLQnjR5lCe0nobJUIJ/Onb6KoI+3OabquY5k8zqLK+EpIovBwh0ChTdM/1vwBKxNVFSEy+JwfaAJxCTNWH00i/gTw67UwPJVGAPy+LVS0eLi/YTYhUkMkhiNRT85cAWsrA6/p+4r895yvXnJcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S3nHkOqO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746180453; x=1777716453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABTJzmirhXJNfdMrrzRqDK9d4R4fuVLD8Yt2bg5MhM8=;
  b=S3nHkOqO43g+p9Q+4v2E0GbZA69j2bSYtKVErU8Yzq0YtHN7BFDh2IxQ
   3w70tT5EkP1s5OhZl+94naZY+1EmVUxD8brB5AV13yGRuoS40nXxe11uI
   DAIRIFwhDXo1ZrxOde6zFRbb4wxgQFZ/N4QcHTfryEDfY4WBJCBHTFjGo
   iQLU89J/UGHm3HMRYAT6ZsBD4T0flt4rkbp0HWtq2uGiugAyD5a0rJmML
   3X1j70pv59fja7Vb9hilUJ0wHHRmEgF6m2gFxGuDMj310aJx4rKbUnvX+
   nF8fGVYhFNagU1bBMHfN5qfK4TRbEC1f8nm4CSX19K9emVbuSNTbCvIxe
   w==;
X-CSE-ConnectionGUID: Jd9v1WTFSlmRkWGxGqzPgQ==
X-CSE-MsgGUID: 4ZpMxNjPSxKPwfD/B//YTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="65270948"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="65270948"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:07:32 -0700
X-CSE-ConnectionGUID: LYFtxGDlRIu6hCEzWP6bfg==
X-CSE-MsgGUID: tilehn2yQyu1xZRohk+8Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="139785170"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 03:07:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uAnIh-000000029ep-0tO8;
	Fri, 02 May 2025 13:07:23 +0300
Date: Fri, 2 May 2025 13:07:22 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Sayyad Abid <sayyad.abid16@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, olivier.moysan@foss.st.com,
	gstols@baylibre.com, tgamblin@baylibre.com, alisadariana@gmail.com,
	eblanc@baylibre.com, antoniu.miclaus@analog.com,
	stefan.popa@analog.com, ramona.gradinariu@analog.com,
	herve.codina@bootlin.com, tobias.sperling@softing.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] iio: adc: ti-ads1262.c: add initial driver for
 TI ADS1262 ADC
Message-ID: <aBSZWs_rWNHZbU7V@smile.fi.intel.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
 <20250501100043.325423-2-sayyad.abid16@gmail.com>
 <01cb0333-1ca7-46b3-9f32-5e81b8a53537@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cb0333-1ca7-46b3-9f32-5e81b8a53537@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 01, 2025 at 12:37:30PM -0500, David Lechner wrote:
> On 5/1/25 5:00 AM, Sayyad Abid wrote:
> > Add the core driver file `ti-ads1262.c` for the TI ADS1262 ADC.
> > This initial version implements basic IIO functionality for device
> > probe via SPI and reading raw voltage samples from input channels.

...

> > +#include <linux/kernel.h>
> 
> This header includes too much, please use more specific headers.
> 
> > +#include <linux/device.h>

Ditto for this one. Include it only if really required, otherwise we have often
used dev_printk.h, device/devres.h.

> > +#include <linux/module.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/delay.h>
> 
> Alphabetical order is preferred.

> > +#include <linux/spi/spi.h>
> > +#include <linux/unaligned.h>

Also many headers are missing (probably due to inclusion of kernel.h).

...

> > +#define ADS1262_SETTLE_TIME_USECS	10000

_US is fine (no need to have longer _USECS, which is not so standard).

Also
(10 * USEC_PER_MSEC)

...

> > +/* The Read/Write commands require 4 tCLK to encode and decode, for speeds
> > + * 2x the clock rate, these commands would require extra time between the
> > + * command byte and the data. A simple way to tacke this issue is by
> > + * limiting the SPI bus transfer speed while accessing registers.
> > + */

/*
 * Wrong style for multi-line comments, please use
 * this as an example. Fix all comments in the file
 * accordingly.
 */

...

> > +/* For reading and writing we need a buffer of size 3bytes*/

Missing space.

...

> > +/**
> > + * struct ads1262_private - ADS1262 ADC private data structure
> > + * @spi: SPI device structure
> > + * @reset_gpio: GPIO descriptor for reset pin
> > + * @prev_channel: Previously selected channel for MUX configuration
> > + * @cmd_buffer: Buffer for SPI command transfers
> > + * @rx_buffer: Buffer for SPI data reception
> > + */
> > +struct ads1262_private {
> > +	struct spi_device *spi;

Is it really used? Or is struct device *dev just enough?

> > +	struct gpio_desc *reset_gpio;
> > +	u8 prev_channel;
> > +	u8 cmd_buffer[ADS1262_SPI_CMD_BUFFER_SIZE];
> > +	u8 rx_buffer[ADS1262_SPI_RDATA_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
> 
> cmd_buffer is also used with SPI, so __aligned(IIO_DMA_MINALIGN); needs to go
> there instead.
> 
> > +};

...

> > +#define ADS1262_CHAN(index)						\
> > +{									\
> > +	.type = IIO_VOLTAGE,						\
> > +	.indexed = 1,							\
> > +	.channel = index,						\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> > +	.scan_index = index,						\
> > +	.scan_type = {							\
> > +		.sign = 's',						\
> > +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> > +		.storagebits = 32,					\
> > +		.endianness = IIO_CPU					\

Leave trailing comma here and in the similar cases (when it's not a clear
terminator entry).

> > +	},								\
> > +}

...

> > +static int ads1262_write_cmd(struct ads1262_private *priv, u8 command)
> > +{
> > +	struct spi_transfer xfer = {
> > +		.tx_buf = priv->cmd_buffer,
> > +		.rx_buf = priv->rx_buffer,
> > +		.len = ADS1262_SPI_RDATA_BUFFER_SIZE,
> > +		.speed_hz = ADS1262_CLK_RATE_HZ,
> > +	};
> > +
> > +	priv->cmd_buffer[0] = command;
> > +
> > +	return spi_sync_transfer(priv->spi, &xfer, 1);
> > +}
> > +
> > +static int ads1262_reg_write(void *context, unsigned int reg, unsigned int val)
> > +{
> > +	struct ads1262_private *priv = context;
> > +
> > +	priv->cmd_buffer[0] = ADS1262_CMD_WREG | reg;
> > +	priv->cmd_buffer[1] = 0;
> > +	priv->cmd_buffer[2] = val;
> > +
> > +	return spi_write(priv->spi, &priv->cmd_buffer[0], 3);
> > +}

Can't you use regmap SPI instead?

...

> > +static int ads1262_reg_read(void *context, unsigned int reg)
> > +{
> > +	struct ads1262_private *priv = context;
> > +	struct spi_transfer reg_read_xfer = {
> > +		.tx_buf = priv->cmd_buffer,
> > +		.rx_buf = priv->cmd_buffer,
> > +		.len = 3,
> > +		.speed_hz = ADS1262_CLK_RATE_HZ,
> > +	};
> > +	int ret;
> > +
> > +	priv->cmd_buffer[0] = ADS1262_CMD_RREG | reg;
> > +	priv->cmd_buffer[1] = 0;
> > +	priv->cmd_buffer[2] = 0;
> > +
> > +	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> 
> Why not use regmap? You will still custom read/write functions similar to these
> because of needing the lower SCLK rate, but it will give you a bunch of other
> nice features for free.

Ah, same comment above :-)

...

> > +static int ads1262_reset(struct iio_dev *indio_dev)
> > +{
> > +	struct ads1262_private *priv = iio_priv(indio_dev);
> > +
> > +	if (priv->reset_gpio) {
> > +		gpiod_set_value(priv->reset_gpio, 0);
> > +		usleep_range(200, 300);
> 
> Use fsleep(). Also, could make this clear that it is 4 tCLK cycles (the hard-
> coded value would have to be changed if external clock support was added).
> 
> > +		gpiod_set_value(priv->reset_gpio, 1);
> 
> The DT bindings will take care of active low, so this looks backwards. Also
> st->reset_gpio is never assigned, so this is dead code.
> 
> > +	} else {

Redundant else. Just return from the conditional and have the below outside of
it.

> > +		return ads1262_write_cmd(priv, ADS1262_CMD_RESET);
> > +	}

Missing blank line, but see above.

> > +	return 0;
> > +}

-- 
With Best Regards,
Andy Shevchenko



