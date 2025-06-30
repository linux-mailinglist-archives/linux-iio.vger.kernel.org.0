Return-Path: <linux-iio+bounces-21147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36D7AED825
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 11:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADC4175BDE
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF22397BE;
	Mon, 30 Jun 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaFHb001"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E23219A7D;
	Mon, 30 Jun 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274349; cv=none; b=offim8auFAZ/aG1r2fFl4LbvJvXwhZry2U1tJGy/HSfHfd9apSnDrRDPu6VVSa/mEkL3BgKqV+fMBA46qALroN/PmA/caNGST01NY1G5CG/oBD+PezZYgn2jsOqT69GI7lclHoZ6P1nEVAEb2Zkeym9p7v8vEyERTeAeHMpft74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274349; c=relaxed/simple;
	bh=mYC1xCNYBu74yU4BwfJYqv32o55MMiW/+sqA7P6XlFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAzBUMQny/Ay4uU1mMjYvCCkfRVk4rrR/n354iKxiwRF1fg4pgQFUU3GefzvkOkCKJaZJu9iIdC4ymwOff0q3BAP7eULWY8EwRHVW+QJ5agaoVUtGJpIA3X6By2QzWMxqYj53Cb753MV6wUw+bvUnLrua6/nC79mrEQwIjdxaSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaFHb001; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751274348; x=1782810348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mYC1xCNYBu74yU4BwfJYqv32o55MMiW/+sqA7P6XlFg=;
  b=ZaFHb001r0KrxU9jH/MSquiah756Z5AYmBN7uwvZpPecV3QwYJRYU041
   /kyArYCSjdjQ4nS9sn8HChMnFB8LH0RO38wcQV3f502eqMfPh4WCcFZlW
   ufCN5GtP5cweuDpCoiYTUgyB41lSz8xohhox6kqAM+TWmcN0L2KqeCewb
   dybNuPTP3uOhg34xorZrZ7otpgjEsxP/dBz8HzWUIb1sjb0m1c/Z/HsA3
   Jmw2+V3AnjWBqL1Ak1SsiqXj000ysKGwiORUFt1IJwswlINQ3g8qos+9J
   wU3nFNm/4E68nHA7SesAPBvcRIhZdLwMHG917WSF7sPdgA+q/dLb0xIBQ
   Q==;
X-CSE-ConnectionGUID: gcu+lR18TgiGJ/GA0leWsw==
X-CSE-MsgGUID: yspC2+uCTt2qEB394KGD1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="41120887"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="41120887"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:05:48 -0700
X-CSE-ConnectionGUID: glyxd75iQj6aOTNwbxIJIQ==
X-CSE-MsgGUID: L9bxpayLTsK3lWku09M2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="153035679"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:05:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWASM-0000000BFuY-0c74;
	Mon, 30 Jun 2025 12:05:42 +0300
Date: Mon, 30 Jun 2025 12:05:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 09/11] spi: offload trigger: add ADI Util Sigma-Delta
 SPI driver
Message-ID: <aGJTZeYYHLgIMmcb@smile.fi.intel.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-9-f49c55599113@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-9-f49c55599113@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 06:40:05PM -0500, David Lechner wrote:
> Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.
> 
> This is used to trigger a SPI offload based on a RDY signal from an ADC
> while masking out other signals on the same line.

...

> +#include <linux/clk.h>

> +#include <linux/device.h>

Really? I though about dev_printk.h...

+ err.h

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/spi/offload/provider.h>

+ types.h

-- 
With Best Regards,
Andy Shevchenko



