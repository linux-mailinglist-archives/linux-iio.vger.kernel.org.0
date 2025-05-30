Return-Path: <linux-iio+bounces-20052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE27AC94EC
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0893C4A5FE3
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADBD24678D;
	Fri, 30 May 2025 17:45:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020622F768;
	Fri, 30 May 2025 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627144; cv=none; b=jWSLPlUR9jvB4gMNbw6sNCqQJNMrUpgAeiRC+GGyKL6OEbUetTrmzwmEzYFV9U6cTRslOb4ZiQ9OUSoAlJ6YQxR4Ejhh3m7CWdjv/lvxH1Zc4DZ6ymiooDfw1GfjTL4iID9v8s7x9iazCp7G3izTdGad25ja9WYA6/8YBQB2Ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627144; c=relaxed/simple;
	bh=KCuQIxE/UbX7bNhWPslmmbXQbkL9HQAVn32a/t8FsGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBA4w8OGgJJ7UKUJbUxT9dUI3uVdqBu10yDHaC5mLB3Y22HGF7xCwG0VU0MJ10fXljzwtiwN6Rk/kp3zNrRahSGmCBEGBMSosFkG/8475SNXBeg7W3kSWE8SWDhCxhdVuiF+Vkc9vMcH7mt5BUMVqaEvLs93OKR41Xgf7IJ+oyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: mchwAGlZT/+Ek9uY72rrpw==
X-CSE-MsgGUID: FMGMifi3RBWBEChEpM5xKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="76118855"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="76118855"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:45:40 -0700
X-CSE-ConnectionGUID: v38ue9yQThCTQBuMxdq/qg==
X-CSE-MsgGUID: IVoxASSqQx2QwsVCPT4q6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="174812793"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:45:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uL3nQ-000000024VO-35JF;
	Fri, 30 May 2025 20:45:32 +0300
Date: Fri, 30 May 2025 20:45:32 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	rafael@kernel.org, djrscally@gmail.com
Subject: Re: [PATCH v9 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aDnuvAdkcTAP2tMt@smile.fi.intel.com>
References: <cover.1748447035.git.Jonathan.Santos@analog.com>
 <27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27cccb51cc56f1bb57cb06d279854a503d779e25.1748447035.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 29, 2025 at 07:50:29PM -0300, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> 
> Use trigger-sources property to enable device synchronization over SPI
> and multi-device synchronization while replacing sync-in-gpios property.

...

> struct ad7768_state {

>  	struct iio_trigger *trig;
>  	struct gpio_desc *gpio_sync_in;
>  	struct gpio_desc *gpio_reset;

> +	bool en_spi_sync;

I'm wondering if moving this...

>  	const char *labels[ARRAY_SIZE(ad7768_channels)];
>  	struct gpio_chip gpiochip;

...to here saves a few bytes in accordance to `pahole`.

>  };

...

> +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> +					     struct fwnode_handle *dev_fwnode,
> +					     struct ad7768_state *st)
> +{
> +	struct fwnode_reference_args args;
> +
> +	struct fwnode_handle *fwnode __free(fwnode_handle) =
> +		fwnode_find_reference_args(dev_fwnode, "trigger-sources",
> +					   "#trigger-source-cells", 0,
> +					   AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);

I don't see how args are being used. This puts in doubt the need of the first
patch.

> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);
> +
> +	/* First, try getting the GPIO trigger source */
> +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> +							       NULL,
> +							       0,
> +							       GPIOD_OUT_LOW,
> +							       "sync-in");
> +		return PTR_ERR_OR_ZERO(st->gpio_sync_in);
> +	}
> +
> +	/*
> +	 * TODO: Support the other cases when we have a trigger subsystem
> +	 * to reliably handle other types of devices as trigger sources.
> +	 *
> +	 * For now, return an error message. For self triggering, omit the
> +	 * trigger-sources property.
> +	 */
> +	return dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> +}

...

> +static int ad7768_trigger_sources_get_sync(struct device *dev,
> +					   struct ad7768_state *st)
> +{
> +	struct fwnode_handle *dev_fwnode = dev_fwnode(dev);

Call it just fwnode.

> +	/*
> +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> +	 * to synchronize one or more devices:
> +	 * 1. Using an external GPIO.
> +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> +	 *    synchronization pulse that drives the SYNC_IN pin.
> +	 */
> +	if (fwnode_property_present(dev_fwnode, "trigger-sources"))
> +		return ad7768_trigger_sources_sync_setup(dev, dev_fwnode, st);
> +
> +	/*
> +	 * In the absence of trigger-sources property, enable self
> +	 * synchronization over SPI (SYNC_OUT).
> +	 */
> +	st->en_spi_sync = true;
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



