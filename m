Return-Path: <linux-iio+bounces-19586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0364BAB98CD
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB730170A0F
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6F2230274;
	Fri, 16 May 2025 09:29:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639417B425;
	Fri, 16 May 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387753; cv=none; b=VSt7b/0KQqHulrFzg3SIuJWhPOBdh/Alt0iJiJEzOGfAFw7OnduJ0+4UOh4BJvNHqAACVnuEWfRqK/oFqPW9OIxd6FeQA7zfR/RsqFzVKzGUxmoVpkN4bkrwBk/o4qbRjHhCc23Cs/2/Sl7Fd7rar9zekkkjAhiBNOPebRLWJ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387753; c=relaxed/simple;
	bh=lgfOvw9PRaqqITI17nzxDUTefwJZlD2RgByKAPpT1ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlQtoZ1DPKzYlVLGqsmtzQUaIUEj0inJves6FE/34uuwxP61BP6N4dyzRdSwCq/rsE8acFIko3L9PDFyRLpyHtQYzB7dwdYPpWGr60p5otG1q4moAC8ntiEZMsXh1bLMIY6M6DO60aMTHiY/NoWMfC11OZCDiPLfFk2P6vyeyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 3YMIodAjS4CWJ19p23DZPA==
X-CSE-MsgGUID: OM2rux11Sdad360Aas7vYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49280051"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49280051"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:29:10 -0700
X-CSE-ConnectionGUID: Gd+nHPp3TqWMD3UeMg6bgg==
X-CSE-MsgGUID: b4W4da++RHGZZFDlb50H4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143870626"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:29:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uFrNH-0000000267I-0bOR;
	Fri, 16 May 2025 12:29:03 +0300
Date: Fri, 16 May 2025 12:29:02 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v8 08/11] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aCcFXolH0FVBSP11@smile.fi.intel.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <59f45c9af16fa68f2a479f824129f5a9f2cd0997.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f45c9af16fa68f2a479f824129f5a9f2cd0997.1747175187.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 06:13:56PM -0300, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> 
> Use trigger-sources property to enable device synchronization over SPI
> and multi-device synchronization while replacing sync-in-gpios property.

...

> +static int ad7768_trigger_sources_get_sync(struct device *dev,
> +					   struct ad7768_state *st)
> +{
> +	struct fwnode_reference_args args;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	int ret;
> +
> +	/*
> +	 * The AD7768-1 allows two primary methods for driving the SYNC_IN pin
> +	 * to synchronize one or more devices:
> +	 * 1. Using an external GPIO.
> +	 * 2. Using a SPI command, where the SYNC_OUT pin generates a
> +	 *    synchronization pulse that drives the SYNC_IN pin.
> +	 */
> +	if (!fwnode_property_present(fwnode, "trigger-sources")) {

I'm wondering if you can split the below to a separate function and do something like

	if (fwnode_property_present(...))
		return setup_trigger_source(...);

	...
	en_spi_sync = true;
	return 0;

> +		/*
> +		 * In the absence of trigger-sources property, enable self
> +		 * synchronization over SPI (SYNC_OUT).
> +		 */
> +		st->en_spi_sync = true;
> +		return 0;
> +	}
> +
> +	ret = fwnode_property_get_reference_args(fwnode,
> +						 "trigger-sources",
> +						 "#trigger-source-cells",
> +						 0,
> +						 AD7768_TRIGGER_SOURCE_SYNC_IDX,
> +						 &args);


__free(fwnode_handle) ?

> +	if (ret)
> +		return ret;
> +
> +	fwnode = args.fwnode;
> +	/* First, try getting the GPIO trigger source */
> +	if (fwnode_device_is_compatible(fwnode, "gpio-trigger")) {
> +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, fwnode,
> +							       NULL,
> +							       0,
> +							       GPIOD_OUT_LOW,
> +							       "sync-in");
> +		ret = PTR_ERR_OR_ZERO(st->gpio_sync_in);
> +		goto out_put_node;
> +	}
> +
> +	/*
> +	 * TODO: Support the other cases when we have a trigger subsystem to
> +	 * reliably handle other types of devices as trigger sources.
> +	 *
> +	 * For now, return an error message. For self triggering, omit the
> +	 * trigger-sources property.
> +	 */
> +	ret = dev_err_probe(dev, -EOPNOTSUPP, "Invalid synchronization trigger source\n");
> +
> +out_put_node:

The above will allow to get rid of this label.

> +	fwnode_handle_put(args.fwnode);
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko



