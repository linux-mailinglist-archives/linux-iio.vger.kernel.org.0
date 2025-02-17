Return-Path: <linux-iio+bounces-15715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA5A38D14
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 21:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCF47A409B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B1237179;
	Mon, 17 Feb 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDK02/CC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB53149C41;
	Mon, 17 Feb 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823368; cv=none; b=e4ts5DHqvomVQazSErKTO/nE361Hwp/l2my7hsPXf+Lf2NAw+2dG736SMhzwg0ibsJYFHoHkhe6O3hTuE1FFIt3NS9N5VHNj7BW2nD8Jl0gZ8ouprLhOgx9HHnLL8rNPt8bSvt0dg3FHIeOfIEqilRHuKHUszkg2Vn/1TmOsivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823368; c=relaxed/simple;
	bh=aFKj1rf14/ci2zLh79/Xl5E9PDaxp9QushJOhxMjPjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHXwrqfdNwozjXpdKfnoe7/625bKihSO0lzzU67gUDEV4Ky990AlTvlE+seE6V1OrgaE173HK/lu9s5je79f2A9SAqvD/vFXq83QmAc6/jUmUfO34xm9+Fo2tSv5cdKrQlBwNYuVV3qXHC5jOGtmZ5HCCddjNftySoEOT7o5xOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDK02/CC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739823367; x=1771359367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aFKj1rf14/ci2zLh79/Xl5E9PDaxp9QushJOhxMjPjc=;
  b=DDK02/CCN0e/cHiuPgVqmlcq+yKyjCV7NcokY5VRna58ljjVBPwSZA9x
   MPZhnG1ORHIwKS+lDa041v5IZdczl14VHNt2lsUNJeDFf3nadX+RMTuwH
   VYfBKIDSU7R/Z1k3+J5gXCy0BfPliT6+J2kr/1dZ0HzbU+PsONetqThM+
   m/HkycH3PAXsppCwPyiTw54FZ8cEDcR0OWLjfAYcZ4U6YTtqqTAqVd8q/
   mPykzPIkV6CRw2ECaXlyH3wY0gotw94AuKmPcyF8betT2LN6Bjek2c6iz
   jwbVYCOC3oI7s7qN5Klz7s+jMo17waNiG/cL724gxpIeRX/iEUSws003k
   w==;
X-CSE-ConnectionGUID: clbeycvgSSOxZtxExYNtmg==
X-CSE-MsgGUID: tATNWy9jSE2FPOtTWn1VAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44165852"
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="44165852"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:16:06 -0800
X-CSE-ConnectionGUID: iNnZr2dlT9ySEHSxnFMtAw==
X-CSE-MsgGUID: WDYuwL+ESluM62DgzQKDQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,293,1732608000"; 
   d="scan'208";a="113945290"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 12:16:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tk7X3-0000000CVY9-3Ayc;
	Mon, 17 Feb 2025 22:15:57 +0200
Date: Mon, 17 Feb 2025 22:15:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <Z7OY_b3I1eyxpsIk@smile.fi.intel.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
 <20250217140336.107476-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217140336.107476-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 17, 2025 at 04:03:35PM +0200, Svyatoslav Ryhel wrote:
> AL3000a is a simple I2C-based ambient light sensor, which is
> closely related to AL3010 and AL3320a, but has significantly
> different way of processing data generated by the sensor.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +static void al3000a_set_pwr_off(void *_data)
> +{
> +	struct al3000a_data *data = _data;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, AL3000A_REG_SYSTEM, AL3000A_CONFIG_DISABLE);
> +	if (ret)
> +		dev_err(dev, "failed to write system register\n");
> +
> +	ret = regulator_disable(data->vdd_supply);
> +	if (ret)
> +		dev_err(dev, "failed to disable vdd power supply\n");

I dunno what we can do on errors, but at least user will be informed what was
failed.

> +}

-- 
With Best Regards,
Andy Shevchenko



