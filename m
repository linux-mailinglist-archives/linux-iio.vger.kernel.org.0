Return-Path: <linux-iio+bounces-19767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B0ABF109
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1734E4B9E
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 10:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF64125A353;
	Wed, 21 May 2025 10:11:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1218253942;
	Wed, 21 May 2025 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822267; cv=none; b=X9vsTfVkBnaMffX1ODoUyF1oRO6LW59NIYxTveGmcWDjvlFZ3B6wsbEPmZpItAYLQoUA9ZD3/uE+XuZ09V+kkcH14TXJggJG9ZZAVXsdGV6I+yzC8iJmYDUdgSlhATe2HCxo5Wut+XDGH2Ta2cDCPq0s1rEgNKAC8iYzIwb3iEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822267; c=relaxed/simple;
	bh=p5lvnCxJZsOj9IRV2bP2CrAbllA0fpK9isXfu2QCnxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8cvfgEvma07bSyVzIoXTgI6GMTXLT8+7jNHoKM/+T3s1DtvXum21vsbBMorXFRhbSZ6j0CZ9udmw/lyB9j4MO1E8dkx5sCyDe6m5F+fg/7ypvfXnSD3i3B1lhM0j3b68yj3GQvJc3xJqhWlJxomjR1h/whM/ZKYJ9a9ZxjfCT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 6DMPKo8TTIG9btYwtt/1IQ==
X-CSE-MsgGUID: J/0tW6nfT2C7UzcS5CrUIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49852114"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49852114"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:11:05 -0700
X-CSE-ConnectionGUID: m+wgmH1cQ8OB9we3D62UBA==
X-CSE-MsgGUID: 51mi4tIhSmWU4p/o7xolNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="141054690"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 03:11:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uHgPc-00000003aD2-0rOs;
	Wed, 21 May 2025 13:11:00 +0300
Date: Wed, 21 May 2025 13:10:59 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/12] iio: accel: adxl313: add basic interrupt
 handling
Message-ID: <aC2ms5zZ3kC9cQUs@smile.fi.intel.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
 <20250520225007.10990-8-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520225007.10990-8-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 20, 2025 at 10:50:02PM +0000, Lothar Rubusch wrote:
> Prepare the interrupt handler. Add register entries to evaluate the
> incoming interrupt. Add functions to clear status registers and reset the
> FIFO.

...

> +static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
> +{
> +	size_t count;

> +	int i;

Does it need to be signed?

> +	int ret;
> +
> +	count = sizeof(data->fifo_buf[0]) * ADXL313_NUM_AXIS;
> +	for (i = 0; i < samples; i++) {
> +		ret = regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
> +				       data->fifo_buf + (i * count / 2), count);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}

...

> +static void adxl313_fifo_reset(struct adxl313_data *data)
> +{
> +	int regval;

Incorrect type. Please, go through your whole code and check that for regmap
returned value you use the same type. Using signed might lead to subtle and
hard-to-hunt mistakes due to integer promotion rules in C language.

> +	int samples;
> +
> +	adxl313_set_measure_en(data, false);
> +
> +	/* clear samples */
> +	samples = adxl313_get_samples(data);
> +	if (samples)
> +		adxl313_fifo_transfer(data, samples);
> +
> +	/* clear interrupt register */
> +	regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &regval);

No error check? At least comment why it's okay to go like this.

> +	adxl313_set_measure_en(data, true);
> +}

...

> +static irqreturn_t adxl313_irq_handler(int irq, void *p)
> +{
> +	struct iio_dev *indio_dev = p;
> +	struct adxl313_data *data = iio_priv(indio_dev);
> +	int int_stat;
> +
> +	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
> +		return IRQ_NONE;
> +
> +	if (FIELD_GET(ADXL313_INT_OVERRUN, int_stat))
> +		goto err;
> +
> +	return IRQ_HANDLED;

> +err:
> +	adxl313_fifo_reset(data);
> +
> +	return IRQ_HANDLED;

Seems you ignored my comment in previous review round. Please, re-read that
thread and discuss all the stuff you disagree with (I want to know why).

> +}

...

> +		ret  = devm_iio_kfifo_buffer_setup(dev, indio_dev,

One space too many.

> +						   &adxl313_buffer_ops);
> +		if (ret)
> +			return ret;

-- 
With Best Regards,
Andy Shevchenko



