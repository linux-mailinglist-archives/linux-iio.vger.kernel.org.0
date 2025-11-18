Return-Path: <linux-iio+bounces-26306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE60C6B966
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 21:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D056E363300
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 20:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5B230101E;
	Tue, 18 Nov 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTAfL3OU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD472F9DAD;
	Tue, 18 Nov 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763497146; cv=none; b=nGklBjZ9JDLjEdHaXP51HJb38hwGARjY/LSKaSk+xxpdDhCrSZ+2mw23GAyY6KfQfn4+96tN358kGllb19s9JHpMxit9PWSbAQh9D+iAF6ap/QnxV6aDkCoInM9PI0xq/MnLO2fNfq4fI9BkX0MK00WVa2gohgYKY+h400zc2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763497146; c=relaxed/simple;
	bh=DxMARyKfJDyqUAKbJFfjf/c6B+plFfSLeUMvIEGnFAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7vS0qkWNqmFviP3031bF7BIjTJtBLq9CRAzIP2Z7LnCGYy0UqtfFXbjhrseoh4ljyA34gnIhNbSgvmVGK3mXUwoMbZHCvarDd30FomgnryrIs29SVayAeJ4hn5sYAk+5A68fR6YfaVaF3UYMC4eQpcTFNDZdZPl1gS7xqvaLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTAfL3OU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763497145; x=1795033145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DxMARyKfJDyqUAKbJFfjf/c6B+plFfSLeUMvIEGnFAk=;
  b=eTAfL3OUieRcXqlK0eKb4rbUI4wPimI4zkDJKsGiXTPBiqw3fWWE7bko
   0el/Z2NpbDKwyeD8XgFUACatN4vVn+pGfGTH5it4eipFVPiUwYZTwlMDj
   aUzFhrgCEbdB9XTzCIJgBQEymMdXykrQZ/ZU2qqnCWaCqCZpPNxIfvBcC
   qN0gWznqqEpqM43iewQkVwo5y9kOY5jhQJBbSiiFAQqOEZblN7H+VtYUC
   LFK8yE1aKmVex4jBF984KNRBas27L37V8zMAy0OpHr7OCqAg4Uzk3PHSC
   1YcE1vwwQ+eI8Dfn55YQfjqXBUq3O9hul3C/ztEqbWngeSysB1DFnN7WS
   g==;
X-CSE-ConnectionGUID: WDs7PqHbRL+NjRGhDMSiWw==
X-CSE-MsgGUID: fzxCeRkIQaWi+uXKA2odOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65472869"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65472869"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:19:03 -0800
X-CSE-ConnectionGUID: qLJxK4DYRuiKznyaaQ5KIQ==
X-CSE-MsgGUID: vpegkBsIS4iAGXcrG1QhVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195988087"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 12:18:58 -0800
Date: Tue, 18 Nov 2025 22:18:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	cosmin.tanislav@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 2/3] iio: adc: Initial support for AD4134
Message-ID: <aRzUsMb4i3M7HoN7@smile.fi.intel.com>
References: <cover.1763478299.git.marcelo.schmitt@analog.com>
 <f88fd2bda5b93ca0c0f8a892b501e9ff7ac1574c.1763478299.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88fd2bda5b93ca0c0f8a892b501e9ff7ac1574c.1763478299.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 18, 2025 at 02:32:43PM -0300, Marcelo Schmitt wrote:
> AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> analog-to-digital converter (ADC). The device can be managed through SPI or
> direct control of pin logical levels (pin control mode). The AD4134 design
> also features a dedicated bus for ADC sample data output. Though, this
> initial driver for AD4134 only supports usual SPI connections.
> 
> Add basic support for AD4134 that enables single-shot ADC sample read.

Thanks for an update! My comments below.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>

bitops.h implies bits.h and the latter can be omitted. But it's up to you, I'm
fine with the current way.

> +#include <linux/clk.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

> +struct ad4134_state {

> +	struct spi_device *spi;
> +	struct device *dev;
> +	struct regmap *regmap;

We have a duplication here, I believe. Either struct device or struct regmap
may be dropped. If it's not the case, the fields needs a good description /
justification.

> +	unsigned long sys_clk_hz;
> +	struct gpio_desc *odr_gpio;
> +	int refin_mv;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
> +	 */
> +	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
> +};

...

> +static int ad4134_regulator_setup(struct ad4134_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	bool use_internal_ldo_regulator;
> +	int ret;
> +
> +	/* Required regulators */
> +	ret = devm_regulator_bulk_get_enable(dev, 3, ad4143_regulator_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable power supplies\n");
> +
> +	/* Required regulator that we need to read the voltage */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage.\n");

> +	st->refin_mv = ret / MILLI;

I think the divisor should be (MICRO / MILLI). This what Jonathan suggested
last time I remember (in some other reviews).

> +	/*
> +	 * If ldoin is not provided, then avdd1v8, dvdd1v8, and clkvdd are
> +	 * required.
> +	 */
> +	ret = devm_regulator_get_enable_optional(dev, "ldoin");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable ldoin supply\n");
> +
> +	use_internal_ldo_regulator = ret == 0;

> +	if (!use_internal_ldo_regulator) {

Can it be

	if (use_internal_ldo_regulator)
		return 0;

with the dropped indentation level for the below?


> +		ret = devm_regulator_get_enable(dev, "avdd1v8");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable avdd1v8 supply\n");
> +
> +		ret = devm_regulator_get_enable(dev, "dvdd1v8");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable dvdd1v8 supply\n");
> +
> +		ret = devm_regulator_get_enable(dev, "clkvdd");
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable clkvdd supply\n");
> +	}
> +
> +	return 0;
> +}

...

> +static int ad4134_clock_select(struct ad4134_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct clk *sys_clk;
> +	int ret;

> +	sys_clk = devm_clk_get_optional_enabled(dev, "xtal1-xtal2");

> +	if (IS_ERR_OR_NULL(sys_clk)) {

I don't understand the choice of _optional() with the _NULL here.
Also note, we missed the deferred probe case here.

Was it me who suggested this? :-)

One solution may be to check the clock name presence in the clock-names or
whatever the name of that DT property before trying to get this clock.

> +		ret = PTR_ERR_OR_ZERO(sys_clk);
> +		sys_clk = devm_clk_get_enabled(dev, "clkin");
> +		if (IS_ERR(sys_clk))

Yeah, v1 might look better, but I don't remember by heart.

> +			return dev_err_probe(dev, PTR_ERR(sys_clk),
> +					     "failed to get xtal1-xtal2: %d, clkin: %ld\n",
> +					     ret, PTR_ERR(sys_clk));

No need to have a duplicated error code being printed.

> +	}
> +
> +	st->sys_clk_hz = clk_get_rate(sys_clk);
> +	if (st->sys_clk_hz != AD4134_EXT_CLOCK_MHZ)
> +		dev_warn(dev, "invalid external clock frequency %lu\n",
> +			 st->sys_clk_hz);
> +
> +	return 0;
> +}

...

> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "failed to find reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		fsleep(AD4134_RESET_TIME_US);

> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	}

Can we use reset-gpio driver instead of custom implementation?

-- 
With Best Regards,
Andy Shevchenko



