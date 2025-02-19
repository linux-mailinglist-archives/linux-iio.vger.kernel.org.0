Return-Path: <linux-iio+bounces-15790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D8FA3C222
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C9C3A63C6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10901F2B88;
	Wed, 19 Feb 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXgnPNuI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55D1EFFAF;
	Wed, 19 Feb 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975233; cv=none; b=lNchhz6GlACihDVAkLhJ6OxScdPOjKDSoVGl4kwGwxU0FTBU8MSgz5wkTXLAcuNht5VDcLZstNQV8V3cso2wV+zQd0Ot1z7Ye3oyyywvlItZSIgmk7YVR7mf4eMFhApgJ62u2gIfyLYeTnKNXbGE4bUAbmq4DydOUHjQG9yulT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975233; c=relaxed/simple;
	bh=vhmxI/qpUsmrpjWohWJgs/TMHfwXta/ulC9P6VHKIyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiQt0lUALPHcKQkTSCGmrcMoi3a8C7SeszpQFY7CobZVytj82YYR/WYXIm1H/lmsfFRgvPet+Vrhd67+Prmebcgjo86/6JMaXSiQc13QovkQHuq4j2SZ4Ap7yqfrGHPhr1riAUjO7gHftqmiccXNegfVkHTLDj6tuk7UaB8K2Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXgnPNuI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739975232; x=1771511232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vhmxI/qpUsmrpjWohWJgs/TMHfwXta/ulC9P6VHKIyA=;
  b=PXgnPNuI3Zt8enFDOO6lW3DIwE+Ma37qC2yKch4wE6kvULdyS0RU38HF
   YW2crhXxV6VvZsKmY9wMydPGG/kuBnr9js9KeNg76anZgzzY4RAMmqIf0
   w1SHboauqv7Lv9W5eKYF8qXdgqP80uqSIN5Kdp1zZEwm5hDUdvDW0ZCph
   +fHyozL78MzHM4iFSXZ3DWUFuWOCK6SRNzyNIgauALUfeYYYGxzV2gGBH
   ypLxWNQ1yM4ykRSqcDjDE6aM8/KwQ9KfVjIs0L9ohmPxAexI5bc2/iZUt
   E9gSyw2u8MVEN3itNEb+HSYpL77EteB+qgXWIZ2d9WJgITPKpl4g7EnOP
   A==;
X-CSE-ConnectionGUID: IXdy6efWSZGse9Jad5BS8w==
X-CSE-MsgGUID: HCwKoiUcTHqXMHScFXiJ/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="66067582"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="66067582"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:26:56 -0800
X-CSE-ConnectionGUID: 5fTf7ojeRZiQzvfXC1fUTQ==
X-CSE-MsgGUID: zkUoBl+eRPGI1IYoJeFrYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145620194"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 06:26:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tkl2H-0000000D2xx-20EC;
	Wed, 19 Feb 2025 16:26:49 +0200
Date: Wed, 19 Feb 2025 16:26:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
Message-ID: <Z7XqKcOUt5niXzpv@smile.fi.intel.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
 <20250218132702.114669-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132702.114669-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 18, 2025 at 03:27:00PM +0200, Svyatoslav Ryhel wrote:
> Remove platform data and fully relay on OF and device tree
> parsing and binding devices.

Thanks for following the advice, but the problem with this change as it does
too much at once. It should be split to a few simpler ones.
On top of that, this removes MFD participation from the driver but leaves it
under MFD realm. Moreover, looking briefly at the code it looks like it open
codes the parts of MFD. The latter needs a very goo justification which commit
message is missing.

...

> +static const struct of_device_id lm3533_als_match_table[] = {
> +	{ .compatible = "ti,lm3533-als" },
> +	{ },

No comma for the terminator entry. I think I already pointed that out earlier.

> +};

...

> +	device_property_read_string(&pdev->dev, "linux,default-trigger",
> +				    &led->cdev.default_trigger);

One prerequisite patch you probably want is an introduction of

	struct device *dev = &pdev->dev;

in the respective ->probe() implementations. This, in particular, makes the
above lines shorter and fit one line.

...

> +static const struct of_device_id lm3533_led_match_table[] = {
> +	{ .compatible = "ti,lm3533-leds" },
> +	{ },

As per above.

> +};

...

> +		if (!strcmp(comatible, "ti,lm3533-als"))
> +			lm3533->have_als = 1;

If you end up having this, it's not the best what we can do. OF ID tables have
a driver_data field exactly for the cases like this.

...

> +		if (!strcmp(comatible, "ti,lm3533-backlight"))
> +			lm3533->have_backlights = 1;

Ditto.

...

> +		if (!strcmp(comatible, "ti,lm3533-leds"))
> +			lm3533->have_leds = 1;

Ditto.

...

> +		ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
> +				    1 << (2 * id + 1), 1 << (2 * id + 1));

BIT() and better to use a temporary variable for this calculation.

> +		if (ret)
> +			return ret;

...

> +		ret = lm3533_update(bl->lm3533, LM3533_REG_OUTPUT_CONF1,
> +				    id | id << 1, BIT(0) | BIT(1));

		mask = GENMASK();
		..., id ? mask : 0, mask);

> +		if (ret)
> +			return ret;
> +	}

...

> +	bd = devm_backlight_device_register(&pdev->dev, pdev->name, pdev->dev.parent,
> +					    bl, &lm3533_bl_ops, &props);


With the advice from above:

	bd = devm_backlight_device_register(dev, pdev->name, dev->parent, bl, &lm3533_bl_ops,
					    &props);


>  	if (IS_ERR(bd)) {
>  		dev_err(&pdev->dev, "failed to register backlight device\n");
>  		return PTR_ERR(bd);

Consider another prerequisite patch (which should come before the firstly
proposed one):

	struct device *dev = &pdev->dev; // yes, this can go in this change
	...

	if (IS_ERR(bd))
		return dev_err_probe(dev, PTR_ERR(bd), "failed to register backlight device\n");

...

> +static const struct of_device_id lm3533_bl_match_table[] = {
> +	{ .compatible = "ti,lm3533-backlight" },
> +	{ },

As per above.

> +};

-- 
With Best Regards,
Andy Shevchenko



