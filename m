Return-Path: <linux-iio+bounces-26102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB8AC44310
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025133A37CF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38AF3009D5;
	Sun,  9 Nov 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXS8QS+W"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F4C883F;
	Sun,  9 Nov 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707843; cv=none; b=C51koEtqnW8NyOBl7pVa195AQDwEV5Bj4/SfTNpRWrIwfmKJDBDKFI5uok7ehPqe25RPhanY6j1gG4O3r9JV2Kr1zGUg2+qSqw8Cd2NA7Et4IjIJtLtb8/YU1V7fMUiILBBtcMiX2kRV+cDy6g4j5ZrqXmsugzdJm+FbNBljGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707843; c=relaxed/simple;
	bh=2SoqEBC5cVetOqljionOBfjcJgmVzVrriPxCpv+k60U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fam9+mUaoSHvyLglW+jdznl/eRP1QpJDAV4DGUOFvPuVxQLzkigAavO7EJo8bJqWQOBkEe/utZvk4yVRvUvouSAhbx6EVJk6eOXajPa/rTDztKZv74uUPkFWLoXdLBtNfcL9n201gCEgatmTXHZSaunrps1x65DAPV3HAnao23E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXS8QS+W; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762707842; x=1794243842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2SoqEBC5cVetOqljionOBfjcJgmVzVrriPxCpv+k60U=;
  b=VXS8QS+WUaSbbfMQ89sSw8kQqvDVL70loFultFIlewLNBov+jPiXK9/o
   7fKey4LZQJPm9Rnpvp3/OS4V5cTo24RmmL6I5caX+EahoCbAPHsxI3er0
   Lh7u7zKdksDvEU+kjBsEh1DSRwMxGC/1ZLAaAZ45kLqMX9J4uWxZ4vpe0
   p1hHDnC6yUhLlJn/7sdM8eQtzYWug9WuU+l8uR1Gw5hyJ4jfub+X08yCf
   iw6VFTia8zWy2ZFfeudI6MP2JPjlBNk3yFsl15nQPSt5TvQ7ONsMmtzZf
   nFuKQDeUst9kc2+8vQyQe2XEhULD5sBikIKofkcnuxXG3VvB6aSqza86z
   Q==;
X-CSE-ConnectionGUID: dUHUEPbeR0eeESMlhjKh/Q==
X-CSE-MsgGUID: kOT+Q7fXRA60rGyOHS120g==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75884742"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="75884742"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 09:04:02 -0800
X-CSE-ConnectionGUID: WN+GQ+8+SXWKSDu3w2jueA==
X-CSE-MsgGUID: 2MudgvCARauTHhahPgMC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="187784274"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 09:03:58 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vI8pY-000000074hl-0p7G;
	Sun, 09 Nov 2025 19:03:56 +0200
Date: Sun, 9 Nov 2025 19:03:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
Message-ID: <aRDJexPYkIDoE9nc@smile.fi.intel.com>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-3-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109141119.561756-3-ajithanandhan0406@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 09, 2025 at 07:41:19PM +0530, Ajith Anandhan wrote:
> Add driver for the Texas Instruments ADS1120, a precision 16-bit
> analog-to-digital converter with an SPI interface.
> 
> The driver supports:
> - Differential and single-ended input channels
> - Configurable gain (1-128 for differential, 1-4 for single-ended)
> - Internal 2.048V reference
> - Single-shot conversion mode

> Also update MAINTAINER document.

Unneeded sentence in the commit message (may be located in the comment block,
though).

...

Many are still missing... Please, follow IWYU principle.

> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

Not see why you need this and not

dev_printk.h
device/devres.h

instead.

> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>

...

> +/* Internal reference voltage in millivolts */
> +#define ADS1120_VREF_INTERNAL_MV	2048

_mV

*Yes, it's okay to use small letter in this case (it's all about proper units).

...

> +struct ads1120_state {
> +	struct spi_device	*spi;
> +	struct regmap		*regmap;

I'm not sure why do you need separate regmap and spi transactions at the same
time. The commit message also kept silent about this. Needs a justification.

In any case the spi device can be derived from regmap, so definitely you don't
need both.

> +	/*
> +	 * Protects chip configuration and ADC reads to ensure
> +	 * consistent channel/gain settings during conversions.
> +	 */
> +	struct mutex		lock;

No header for this type.

> +	int vref_mv;

_mV

> +	/* DMA-safe buffer for SPI transfers */
> +	u8 data[4] __aligned(IIO_DMA_MINALIGN);

No header for this type and __aligned attribute.

> +};

...

> +	struct spi_transfer xfer[2] = {

You may leave []

> +		{
> +			.tx_buf = st->data,
> +			.len = 1,
> +		}, {
> +			.rx_buf = st->data,
> +			.len = 2,
> +		}
> +	};
> +
> +	*val = sign_extend32(get_unaligned_be16(st->data), 15);

No header for this API.

> +	return 0;
> +}

...

> +static int ads1120_read_measurement(struct ads1120_state *st,
> +				    const struct iio_chan_spec *chan, int *val)
> +{
> +	int ret;
> +
> +	ret = ads1120_set_mux(st, chan->address);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1120_write_cmd(st, ADS1120_CMD_START);
> +	if (ret)
> +		return ret;

Needs a comment explaining this rather big delay.

> +	msleep(ADS1120_CONV_TIME_MS);
> +
> +	return ads1120_read_raw_adc(st, val);
> +}

...

> +/* Regmap write function for ADS1120 */
> +static int ads1120_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ads1120_state *st = context;
> +	const u8 *buf = data;
> +
> +	if (count != 2)
> +		return -EINVAL;
> +
> +	/* WREG command: 0100rr00 where rr is register address */
> +	st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
> +	st->data[1] = buf[1];
> +
> +	return spi_write(st->spi, st->data, 2);

Wondering if there is a correlation between count == 2 and this 2. If it has
1:1 relationship, perhaps use count directly here?

> +}

...

> +static const struct regmap_config ads1120_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ADS1120_REG_CONFIG3,

> +	.cache_type = REGCACHE_FLAT,

Why not MAPPLE? Or scattered FLAT?

> +};

...

> +static int ads1120_init(struct ads1120_state *st)
> +{
> +	int ret;

	struct device *dev = ... // from regmap

> +	ret = ads1120_reset(st);
> +	if (ret)
> +		return dev_err_probe(&st->spi->dev, ret,
> +					"Failed to reset device\n");

		return dev_err_probe(dev, ret, "Failed to reset device\n");

> +	/*
> +	 * Configure Register 0:
> +	 * - Input MUX: AIN0/AVSS
> +	 * - Gain: 1
> +	 * - PGA bypass enabled. When gain is set > 4, this bit is
> +	 *   automatically ignored by the hardware and PGA is enabled,
> +	 *   so it's safe to leave it set.
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG0,
> +			   FIELD_PREP(ADS1120_CFG0_MUX_MASK,
> +				      ADS1120_CFG0_MUX_AIN0_AVSS) |

I would do it on a single line...

> +			   FIELD_PREP(ADS1120_CFG0_GAIN_MASK,
> +				      ADS1120_CFG0_GAIN_1) |

...and this despite being long, But it's up to you and maintainers.
Same for all similar cases.

> +			   ADS1120_CFG0_PGA_BYPASS);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 1:
> +	 * - Data rate: 20 SPS (for single-shot mode)
> +	 * - Operating mode: Normal
> +	 * - Conversion mode: Single-shot
> +	 * - Temperature sensor: Disabled
> +	 * - Burnout current: Disabled
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG1,
> +			   FIELD_PREP(ADS1120_CFG1_DR_MASK,
> +				      ADS1120_CFG1_DR_20SPS) |
> +			   FIELD_PREP(ADS1120_CFG1_MODE_MASK,
> +				      ADS1120_CFG1_MODE_NORMAL) |
> +			   FIELD_PREP(ADS1120_CFG1_CM_MASK,
> +				      ADS1120_CFG1_CM_SINGLE) |
> +			   FIELD_PREP(ADS1120_CFG1_TS_EN, 0) |
> +			   FIELD_PREP(ADS1120_CFG1_BCS_EN, 0));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 2:
> +	 * - Voltage reference: Internal 2.048V
> +	 * - 50/60Hz rejection: Off
> +	 * - Power switch: Disabled
> +	 * - IDAC current: Off
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG2,
> +			   FIELD_PREP(ADS1120_CFG2_VREF_MASK,
> +				      ADS1120_CFG2_VREF_INTERNAL) |
> +			   FIELD_PREP(ADS1120_CFG2_REJECT_MASK,
> +				      ADS1120_CFG2_REJECT_OFF) |
> +			   FIELD_PREP(ADS1120_CFG2_PSW_EN, 0) |
> +			   FIELD_PREP(ADS1120_CFG2_IDAC_MASK,
> +				      ADS1120_CFG2_IDAC_OFF));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Configure Register 3:
> +	 * - IDAC1: Disabled
> +	 * - IDAC2: Disabled
> +	 * - DRDY mode: Only reflects data ready status
> +	 */
> +	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG3,
> +			   FIELD_PREP(ADS1120_CFG3_IDAC1_MASK,
> +				      ADS1120_CFG3_IDAC1_DISABLED) |
> +			   FIELD_PREP(ADS1120_CFG3_IDAC2_MASK,
> +				      ADS1120_CFG3_IDAC2_DISABLED) |
> +			   FIELD_PREP(ADS1120_CFG3_DRDYM_MASK,
> +				      ADS1120_CFG3_DRDYM_DRDY_ONLY));
> +	if (ret)
> +		return ret;
> +
> +	st->vref_mv = ADS1120_VREF_INTERNAL_MV;
> +
> +	return 0;
> +}

...

> +static int ads1120_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads1120_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	st->regmap = devm_regmap_init(dev, &ads1120_regmap_bus, st,
> +				      &ads1120_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +					"Failed to initialize regmap\n");
> +
> +	indio_dev->name = "ads1120";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1120_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1120_channels);

No header for ARRAY_SIZE().

> +	indio_dev->info = &ads1120_info;
> +
> +	ret = ads1120_init(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					"Failed to initialize device\n");

Besides broken indentation this may be a single line.

> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



