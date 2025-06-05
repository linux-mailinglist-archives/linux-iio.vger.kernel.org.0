Return-Path: <linux-iio+bounces-20233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE32ACE9D5
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575671701AC
	for <lists+linux-iio@lfdr.de>; Thu,  5 Jun 2025 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F291F150B;
	Thu,  5 Jun 2025 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HS98DPHh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A551CB518;
	Thu,  5 Jun 2025 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103823; cv=none; b=IY1RDr6WgRAczo6mnA0WbNC1tC4n6r5yG9Tse64HGXZtIwu1iUvzVVEUM1owS+wtKU8vUsAPFALcjW0RZFDvppwv2Zq5AVLzxvYZmk95WBPrfnNe1ZsANiKcoQpm81NECfqYsWNETv1X0HFUIFlMpuH/y7nsOMx0BbydPC3es7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103823; c=relaxed/simple;
	bh=nROcGeiYRY/H5lkZ0J6NaY35TmK2WZ7VN8/JY9+zPd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sscZH6oChmhmpi+WuzqnG5tP/eWKSsFWAyJmNlJkj4AmDPcc9at1YvDSpOZULiMVLTQWeWzVMhzartqzUsMVRCH1C0AMJa/pCUoNrbTLgHu0SG2Ts6jxXG7FWxrOwxINpZHJQ/2TDDjTOVoVeFvoXTIVX4nTznD8jd4EGia2AKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HS98DPHh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749103822; x=1780639822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nROcGeiYRY/H5lkZ0J6NaY35TmK2WZ7VN8/JY9+zPd0=;
  b=HS98DPHhve0H5s6XCnpvQqYvDmcI8GFdMn9PTOQx2Ws0CSspa0OKM36X
   sSy7FrEmKmGk6dQEgz4kyiwrD+YCrMqFibZho2tNhQRySzcBJyGCMNyvI
   byTpSDQnZgg+cpXLUW1XIN0THSAiQGAjUYVMEhmKuxWKLr6aQIrxAClDF
   d7jd4Tb9VS+t8dSz0aFCfkv4iOTSYLrBkF+1n9uogxd/MP1CFUvYWzwv9
   R0OxY/uY4hoNuldW667pbEe0W/wrO5fP+oECZeDuzEynQzqFZJkCGVrAk
   xstYSgpfi9UsGEhkS9eLssSn3i1w/ZCbM2CnfFvJtW8pU0sPBijNBBrBn
   g==;
X-CSE-ConnectionGUID: /fxNvKeCSU6X72SEr7hPKQ==
X-CSE-MsgGUID: +7Sn/rUHQFefMDXN6qEwEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51355133"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51355133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:10:21 -0700
X-CSE-ConnectionGUID: uAG7L7RqQpGKYW3p8PKxnQ==
X-CSE-MsgGUID: qeNaF68KR2Ct6BJqqvBwPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="150282772"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 23:10:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uN3nq-00000003mGF-2UcD;
	Thu, 05 Jun 2025 09:10:14 +0300
Date: Thu, 5 Jun 2025 09:10:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v10 09/12] iio: adc: ad7768-1: add support for
 Synchronization over SPI
Message-ID: <aEE0xiCp1IIt9c0M@smile.fi.intel.com>
References: <cover.1749063024.git.Jonathan.Santos@analog.com>
 <4c8cce58c3f5d84423dffee23c260b94c4cb6c36.1749063024.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c8cce58c3f5d84423dffee23c260b94c4cb6c36.1749063024.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 04, 2025 at 04:37:09PM -0300, Jonathan Santos wrote:
> The synchronization method using GPIO requires the generated pulse to be
> truly synchronous with the base MCLK signal. When it is not possible to
> do that in hardware, the datasheet recommends using synchronization over
> SPI, where the generated pulse is already synchronous with MCLK. This
> requires the SYNC_OUT pin to be connected to the SYNC_IN pin.
> 
> Use trigger-sources property to enable device synchronization over SPI
> and multi-device synchronization while replacing sync-in-gpios property.

...

> +static int ad7768_trigger_sources_sync_setup(struct device *dev,
> +					     struct fwnode_handle *fwnode,
> +					     struct ad7768_state *st)
> +{
> +	struct fwnode_reference_args args;
> +	struct fwnode_handle *ref __free(fwnode_handle) = NULL;
> +	int ret;
> +
> +	ret = fwnode_property_get_reference_args(fwnode, "trigger-sources",
> +						 "#trigger-source-cells", 0,
> +						 AD7768_TRIGGER_SOURCE_SYNC_IDX, &args);
> +	if (ret)
> +		return ret;
> +
> +	ref = args.fwnode;
> +	/* First, try getting the GPIO trigger source */
> +	if (fwnode_device_is_compatible(ref, "gpio-trigger")) {

> +		st->gpio_sync_in = devm_fwnode_gpiod_get_index(dev, ref, NULL,
> +							       0,

This 0 is close to NULL semantically, please move it to the above line to make
the split more logical.

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

-- 
With Best Regards,
Andy Shevchenko



