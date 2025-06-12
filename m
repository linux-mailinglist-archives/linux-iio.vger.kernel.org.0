Return-Path: <linux-iio+bounces-20554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0CDAD7187
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AF67A4073
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18925B2E3;
	Thu, 12 Jun 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aegjPuSn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BF25A62D;
	Thu, 12 Jun 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734145; cv=none; b=Usx987s1O2CfkG79RMOuEUloBvKAjZaDNvb7dQrfECt36eslligNnwNaivFJVKNGua2hgc9VjtfBHtdYWUGepW7VpyNPaOXns6PD6uQzAVk17KNY3k0YPVJV4JLJi2XT6Fs+3YyC7IX0ygF3QZLQmWLatLgklGowlP53X2I6fxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734145; c=relaxed/simple;
	bh=LMUOc2RdYNDJK4nYvLILKjg7NqLsPsWS+vgJ82GlO9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMmM753mVP7fAK/0Wn9cwZhRvaY40BMlfTNDU3mrffRzERRGp0T4ePSpq3gJZtKaSSIir8OWk0Tt0zWTxjytTSqVfXtuj3xyXyR4n0g6Q++NB9N9sX3wnJRno7OLgFEyUj/iCl4Zzdzt8seLLIHmMTxX1wWyEV6ptBk4uJIEdKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aegjPuSn; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749734142; x=1781270142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LMUOc2RdYNDJK4nYvLILKjg7NqLsPsWS+vgJ82GlO9c=;
  b=aegjPuSngi5VStxqLTGKAlufNAmKJsBjf+6embY06L1KtEnHPuhATwz8
   uiAG0GPmHrKWuDlORQsz6LPpdV9uFR4AGiKiB7I5WDSkm0wYVt+mDVZS5
   w9MsUQpn+5tZl2o/Dk4BivWNk4E1mW+NCuSN+8hQ0dNmLz0lF7GboziJc
   aHd3Zcn33NzRaDwh+BfV9CbdqGblC0VN9yu8PvMfjFDx9VH3SzkkFGIhQ
   9WsFHbQClyUwBMWhKVC61x/KnqPehbLHpFDze0ZEVsGEKVhbymvTxtawU
   KJJlWbnd9aOeJZZQR4xiFSLwwmZcJZWRGcC2/Jcd5pdqxi83USADWHFWk
   Q==;
X-CSE-ConnectionGUID: JfP3WiV7Rn2v0IM4uBxyIg==
X-CSE-MsgGUID: G7+f7ZQDQuSwd9SoN4qwVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51138991"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51138991"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:15:41 -0700
X-CSE-ConnectionGUID: YcM4vTLgSe+aq1A9LpR7Ug==
X-CSE-MsgGUID: 3Xl/sVAJSbytpyaFde8TCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="152663513"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:15:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhmK-00000005xQy-1COj;
	Thu, 12 Jun 2025 16:15:36 +0300
Date: Thu, 12 Jun 2025 16:15:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: surajsonawane0215@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: chemical: Add driver for Sharp GP2Y1010AU0F
Message-ID: <aErS-HQkO5pMw3ph@smile.fi.intel.com>
References: <20250612100758.13241-1-surajsonawane0215@gmail.com>
 <20250612100758.13241-4-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612100758.13241-4-surajsonawane0215@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 12, 2025 at 03:37:46PM +0530, surajsonawane0215@gmail.com wrote:
> 
> Implement support for the Sharp GP2Y1010AU0F optical dust sensor which
> measures particulate matter concentration using infrared scattering.
> The sensor requires precise 320μs LED pulses with ADC sampling at 280μs
> after LED activation (as specified in datasheet section 6-1).
> 
> The driver provides:
> - Raw density readings via IIO_DENSITY channel type
> - Hardware-agnostic operation via GPIO and IIO ADC interfaces
> - Power management through regulator framework
> - Device Tree binding support

> Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au_appl_e.pdf
> 
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>

No blank line(s) in the tag block.

> ---

...

> config PMS7003

>  	  To compile this driver as a module, choose M here: the module will
>  	  be called pms7003.
> +
> +config GP2Y1010AU0F

Shouldn't this be alphabetically ordered?

> +	tristate "Sharp GP2Y1010AU0F optical dust sensor"
> +	depends on IIO

Is it needed? Nothing is missed?

...

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

No of.h in a new code, please. Also follow IWYU principle, there are missed inclusionfs.

> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>

...

> +struct gp2y1010_data {
> +	struct gpio_desc *led_gpio;
> +	struct iio_channel *adc_chan;
> +	int v_clean;  /* Calibration: voltage in clean air (mV) */

clean_air_uV is much better naming, most of the comment won't be needed with it.

> +};

...

> +static int gp2y1010_read_raw(struct iio_dev *indio_dev,
> +							 struct iio_chan_spec const *chan,
> +							 int *val, int *val2, long mask)
> +{
> +	struct gp2y1010_data *data = iio_priv(indio_dev);
> +	int ret, voltage_mv;

_mV

Also I recommend to split them as they are not semantically the same.

> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	gpiod_set_value(data->led_gpio, 1);
> +	udelay(GP2Y1010_SAMPLE_DELAY_US);

flseep() and explain the need of it.

> +
> +	ret = iio_read_channel_processed(data->adc_chan, &voltage_mv);
> +
> +	/* Wait remaining time to complete 320 µs total LED pulse width */
> +	udelay(GP2Y1010_LED_PULSE_US - GP2Y1010_SAMPLE_DELAY_US);

fsleep()

> +	gpiod_set_value(data->led_gpio, 0);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = voltage_mv;
> +	return IIO_VAL_INT;
> +}

...

> +static int gp2y1010_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct gp2y1010_data *data;
> +	enum iio_chan_type ch_type;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->v_clean = 900;

The default must be defined with a comment as constant.

> +	data->led_gpio = devm_gpiod_get(dev, "led", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->led_gpio))
> +		return dev_err_probe(dev, PTR_ERR(data->led_gpio), "Failed to get LED GPIO\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return ret;
> +	udelay(100);
> +
> +	data->adc_chan = devm_iio_channel_get(dev, "dust");
> +	if (IS_ERR(data->adc_chan))
> +		return dev_err_probe(dev, PTR_ERR(data->adc_chan), "Failed to get ADC channel\n");
> +
> +	ret = iio_get_channel_type(data->adc_chan, &ch_type);
> +	if (ret < 0)
> +		return ret;
> +	if (ch_type != IIO_DENSITY)
> +		return dev_err_probe(dev, -EINVAL, "ADC channel is not density type\n");
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &gp2y1010_info;
> +	indio_dev->channels = gp2y1010_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gp2y1010_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



