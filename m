Return-Path: <linux-iio+bounces-26133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670AC46CCE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C638D1889090
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC2311C10;
	Mon, 10 Nov 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JC9gLDB5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDB24293C;
	Mon, 10 Nov 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780402; cv=none; b=MkZHdGmVKht6HbKwwv72kZR94/cevhWTdCZ5jPjwMSgr+5uwjHAFe4n31R9cnDDPds7N+IqEWXBh+sGc0wpbz47geVOajWKbA5nOEVAY2UgxM/A4DpW4dPcv76vqoDT5gEw+5MQXTGx7RsW68vmIkuFQpBczQI+uTUHbGYSrnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780402; c=relaxed/simple;
	bh=4BLOQZU0YLZMi/FlMwOE5oIZ4y6RDYik4LCwxFdXGiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+zDTVniGjyQEURounwsgpFDLoY4Qts82vER/5TR5yDxu8r2TIpPwu4SP6xlQjV9wg6JvPtARhCvhVnFqF9+viJ+BswXJ8rHpuCzWXs+/QxMQbXEz/wxK+CXdpw5mRtEBh8Zg2mWGVZYD9HQc9+SKD3y6eM1RHiRU8vaxQnVIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JC9gLDB5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762780400; x=1794316400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4BLOQZU0YLZMi/FlMwOE5oIZ4y6RDYik4LCwxFdXGiM=;
  b=JC9gLDB5os+2EfkabcsQNsiGpTyk8xM/jT7ORJL5Q7Qrj/lGNWhxQrRu
   qJINsgbwIsLdOGd4OtgMp1wY9WqHVmiHmK4gwfoCR98LAtcQjNvT0d1RX
   3sJ35DzM24UjgZ5lJkTFxSwLzrcIpfXO6/x5peR3PxPJPtHkfdYML9CPn
   RxX0O2SXAyHOZVu9RYFBv0quOwPJgzf23Y4WHBUJN7Sp6IvWYPfhpj0v8
   vaToA7p959DUSkk5EZYBbDWKuLiwFtjPqMkmTgqwxYsdl+enbG7qLo888
   xldMW6J++qEugIN8SyQMwGbJCqbMArL0feK9GzI0boSLzZElsOeRspTue
   g==;
X-CSE-ConnectionGUID: Mq4NxTVcTpiq29bIauoG+g==
X-CSE-MsgGUID: SCOB9gLxRK6kvBug1zpH1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87459958"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="87459958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:13:19 -0800
X-CSE-ConnectionGUID: cdSMeNQRTIqUNl5bfYgEog==
X-CSE-MsgGUID: LanU0SlWSd2BApwi58ivWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="193054409"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 05:13:15 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIRho-00000007T58-3B51;
	Mon, 10 Nov 2025 15:13:12 +0200
Date: Mon, 10 Nov 2025 15:13:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	cosmin.tanislav@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 2/3] iio: adc: Initial support for AD4134
Message-ID: <aRHk6KZqQP-PAFuY@smile.fi.intel.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
 <86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 09:45:40AM -0300, Marcelo Schmitt wrote:
> AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> analog-to-digital converter (ADC). The device can be managed through SPI or
> direct control of pin logical levels (pin control mode). The AD4134 design
> also features a dedicated bus for ADC sample data output. Though, this
> initial driver for AD4134 only supports usual SPI connections.
> 
> The different wiring configurations will likely require distinct software
> to handle.

> So, the code specific to SPI is enclosed in ad4134-spi.c, while
> functionality that may be useful to all wiring configuration is set into
> ad4134-common.h and ad4134-common.c.

This part is good for comment or cover letter, I dunno what it gives to the Git
history. Perhaps you want to rephrase it somehow?

> Add basic support for AD4134 that allows single-shot ADC sample read.

Below is my review based on the assumption that there is a good justification
for a brand new driver.

...

> +obj-$(CONFIG_AD4134_SPI) += ad4134-spi.o

This can be split also to the separate patch.

...

Please, follow IWYU principle, many are missing here.

+ array_size.h
+ bitfield.h

> +#include <linux/clk.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

I don't see the use of this, rather dev_printk.h should be put here.

> +#include <linux/err.h>

+ export.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

+ types.h

...

> +static const char * const ad4143_regulator_names[] = {
> +	"avdd5", "dvdd5", "iovdd", "refin",	/* Required supplies */
> +	"avdd1v8", "dvdd1v8", "clkvdd",		/* Required if ldoin not provided */
> +	"ldoin",

Make them equal in count (2 lines by 4 in each sounds really good choice
to me).

> +};

...

> +static const char *const ad4134_clk_sel[] = {
> +	"xtal1-xtal2", "clkin"

Leave trailing comma here.

> +};

...

> +#define __DRIVERS_IIO_ADC_AD4134_COMMON_H__

Do we need DRIVERS_ part?

...

> +#include <linux/array_size.h>
> +#include <linux/bits.h>

> +#include <linux/compiler_attributes.h>

No need when we have types.h listed.

> +#include <linux/crc8.h>

Is this being used?

> +#include <linux/iio/iio.h>

+ regmap.h

> +#include <linux/units.h>
> +#include <linux/types.h>

Again, follow IWYU.

...

> +#define AD4134_RESET_TIME_US			(10 * MICRO)

We have USEC_PER_SEC (include time.h for that).

...

> +#define AD4134_EXT_CLOCK_MHZ			(48 * MEGA)

We have HZ_PER_MHZ.

...

> +#define AD4134_SCAN_TYPE(_realbits, _storebits) {				\
> +	.sign = 's',								\
> +	.realbits = (_realbits),						\
> +	.storagebits = (_storebits),						\
> +	.shift = ((_storebits) - (_realbits)),					\
> +	.endianness = IIO_BE							\

Missing comma, this might make an addition churn in the future changes.

> +}

...

> +struct device;

What about struct gpio_desc?

...


> +#endif /* __DRIVERS_IIO_ADC_AD4134_COMMON_H__ */

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/crc8.h>

> +#include <linux/device.h>

Is it being used? Perhaps dev_printk.h is enough?

> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +#include <linux/module.h>

+ mod_devicetable.h

> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

...

> +static int ad4134_calc_spi_crc(u8 inst, u8 data)
> +{
> +	u8 buf[] = {inst, data};

Better

	u8 buf[] = { inst, data };

> +	return crc8(ad4134_spi_crc_table, buf, ARRAY_SIZE(buf),
> +		    AD4134_SPI_CRC_INIT_VALUE);
> +}

...

> +static const struct spi_device_id ad4134_id[] = {
> +	{ "ad4134", (kernel_ulong_t)&ad4134_min_io_bus_info },
> +	{ },

No comma for the terminator entry. It's even inconsistent with the below ID
table.

> +};
> +MODULE_DEVICE_TABLE(spi, ad4134_id);
> +
> +static const struct of_device_id ad4134_of_match[] = {
> +	{ .compatible = "adi,ad4134", .data = &ad4134_min_io_bus_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4134_of_match);

-- 
With Best Regards,
Andy Shevchenko



