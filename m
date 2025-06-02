Return-Path: <linux-iio+bounces-20151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2602AACB586
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D557ABA05
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C106D22FAFD;
	Mon,  2 Jun 2025 14:55:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F2227E95;
	Mon,  2 Jun 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876155; cv=none; b=EFAUgxg+5VUSeNNjQmsb99PSJ2xdAHFYSxz/NVN6e5t9wP550FTRTJN/Cwu9Ag/oXzrLCKsYaDHfRLoMeRwBL5FmgLroUEAPBBOS2HHm1gCQ8M+GbZ0j6QjGJNl0wtLrQyltML+u6XGp7CxlPR162vqgU7YT/Wn7IvIb8HuGPDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876155; c=relaxed/simple;
	bh=OTDnDpz91oo7TI10WrL8VLx5msdpHQhefrkAOSWO9kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyjwvd4eohEL1lDSmIopkhTkxbKHkIyVdEacw0FLaqFkXE1JQBqkeqBb1p67jVwt+nbUeKYVm7oLjHPj9ycd2EyuGGn11exaUB6cPLSfHkRtsSutZkbNie+y62znA526wzwy7tOwdtR8/txsaJO9fOVaxlZ8NC4vR0Z0SbsQzTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: FbKZ4WJ2Rj6hHvo7IvWwCQ==
X-CSE-MsgGUID: hstPhcp2RTeA4P8obRJ0yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68436266"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="68436266"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 07:55:53 -0700
X-CSE-ConnectionGUID: oHYVTvX5T8WyxghHliO4Ag==
X-CSE-MsgGUID: dtO+QBWoQlKFsWE9GPPfHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="148422996"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 07:55:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uM6Zm-00000002sAx-2EuP;
	Mon, 02 Jun 2025 17:55:46 +0300
Date: Mon, 2 Jun 2025 17:55:46 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aD27cobHWeBX8o30@smile.fi.intel.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
 <e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79f9a126672b33b8a7c01f650fee43a68c74029.1748829860.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Jun 02, 2025 at 08:36:47AM -0300, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> analog to digital converter. The AD4170 design offers a flexible data
> acquisition solution with crosspoint multiplexed analog inputs,
> configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
> digital filtering, wide range of configurable output data rates, internal
> oscillator and temperature sensor, four GPIOs, and integrated features for
> interfacing with load cell weigh scales, RTD, and thermocouple sensors.
> 
> Add basic support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Differential and pseudo-differential input configuration.

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>

> +#include <linux/bitops.h>
> +#include <linux/bits.h>

bitmap.h guarantees to include the two above, but it;s not a big deal to leave
them.

> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

+ types.h

> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>

...

> +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> +{
> +	/*
> +	 * The use of static_assert() here is to make sure that the comparison
> +	 * is adapted whenever struct ad4170_setup is changed.
> +	 */
> +	static_assert(sizeof(*a) ==
> +		      sizeof(struct {
> +				     u16 misc;
> +				     u16 afe;
> +				     u16 filter;
> +				     u16 filter_fs;
> +				     u32 offset;
> +				     u32 gain;
> +			     }));

I think it doesn't make much sense unless one uses memcpy().

> +	if (a->misc != b->misc ||
> +	    a->afe != b->afe ||
> +	    a->filter != b->filter ||
> +	    a->filter_fs != b->filter_fs ||
> +	    a->offset != b->offset ||
> +	    a->gain != b->gain)
> +		return false;
> +
> +	return true;
> +}

...

> +static int ad4170_soft_reset(struct ad4170_state *st)
> +{
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4170_CONFIG_A_REG,
> +			   AD4170_SW_RESET_MSK);
> +	if (ret)
> +		return ret;
> +
> +	/* AD4170-4 requires 1 ms between reset and any register access. */
> +	fsleep(MILLI);

1 * USEC_PER_MSEC

(need time.h)

...

> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);

+ blank line here.

> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;

> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	indio_dev->name = chip->name;
> +	indio_dev->info = &ad4170_info;

> +	st->spi = spi;

Can be grouped with above st = ...

> +	st->regmap = devm_regmap_init(dev, NULL, st, &ad4170_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");

-- 
With Best Regards,
Andy Shevchenko



