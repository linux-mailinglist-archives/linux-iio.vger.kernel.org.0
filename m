Return-Path: <linux-iio+bounces-15489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12100A3451D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 16:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DB43B3750
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756DF24167D;
	Thu, 13 Feb 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJZbL/Ao"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044D026B087;
	Thu, 13 Feb 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458633; cv=none; b=rclch2K2F/mxErD4GL/23PEo82s1puYdIguj3NcKCH0i+c8GLjd2Z2x46iXGHMEzbgrc/+J/gsp6jatBD1hamM7z72sX53eFKM3ClJIZmI5fZ1UdKhPm/WlF4E2FMf6wphBWsUfZ/kMrICj4JN/uI/TyWAAYVXv6jh1F2lNuG5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458633; c=relaxed/simple;
	bh=u9H5hASb0bFlWgjfQ65pbcl32piRiKCbtRg09AnSW/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPsIq0Sf6hXpShUtvpCylmavqx6rSmTqgjKanhOBCDFHTnoOjZ1jx1Cm8o/8YFSC5wiG/LV4Qx/zWTxnD1P1NNXYGYPoWzq4rXX5Ai5Kp/s76HVLgy63uJ8dX6hZySiwat1OKbQVc0gkufCz9R0X8/Pfh2SyFj8GpP3nJv1lDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJZbL/Ao; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739458631; x=1770994631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u9H5hASb0bFlWgjfQ65pbcl32piRiKCbtRg09AnSW/U=;
  b=eJZbL/AotpPHkNYCCrArhgMQbY81uOw8/3IRkDZ3tez5knm8Vh+Vzzer
   qXz2I/xlEapGZOFT9PRHt/2JoCRoIkyknSv0udjCs3ZcnS926HEX8LqZY
   vDe++q/lP7/i1L7TEsTpgMx9mwbLSrjGF82lvSwBBoy+q8qMupFvAQ+Oc
   65M85ZUiUVq0cVq/QfY4OOjSDaL62wulmuyxrhoJn08don7SJuwhQw3Ke
   PEFA+KUsv17lRsavWLQEj0ZsZ3NqabJsM0p/nFCMOA0rWAgmu1D5mjwEp
   v8CUn0wTo8CqhqX0m0p+jXJ/axPSTQ906xY2og0AwcTT6OslrRfJ+HmL+
   Q==;
X-CSE-ConnectionGUID: /sC+1XwDSZ6ZyND56QLSsA==
X-CSE-MsgGUID: yyfSYY9STBaArq8PlvkhzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="39394783"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="39394783"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:57:10 -0800
X-CSE-ConnectionGUID: kXZ3mwCtQPOP4Q90HTKLTg==
X-CSE-MsgGUID: WkNpHyZDTgKPZ0hBWyz7GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114060485"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 06:57:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiaeE-0000000BC52-1z9C;
	Thu, 13 Feb 2025 16:57:02 +0200
Date: Thu, 13 Feb 2025 16:57:02 +0200
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
Subject: Re: [PATCH v1 2/2] mfd: lm3533: convert to use OF
Message-ID: <Z64IPpW5Uhad4HjU@smile.fi.intel.com>
References: <20250212075845.11338-1-clamor95@gmail.com>
 <20250212075845.11338-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212075845.11338-3-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 09:58:42AM +0200, Svyatoslav Ryhel wrote:
> Add ability to fill pdata from device tree. Common stuff is
> filled from core driver and then pdata is filled per-device
> since all cells are optional.

...

>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mfd/core.h>

> +#include <linux/of.h>

Is it used? In any case, please no OF-centric APIs in a new (feature) code.

>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>

...

> +static int lm3533_pass_of_node(struct platform_device *pdev,

pass_of_node sounds a bit awkward.
Perhaps you thought about parse_fwnode ?

> +			       struct lm3533_als_platform_data *pdata)
> +{
> +	struct device *parent_dev = pdev->dev.parent;
> +	struct device *dev = &pdev->dev;
> +	struct fwnode_handle *node;
> +	const char *label;
> +	int val, ret;
> +
> +	device_for_each_child_node(parent_dev, node) {
> +		fwnode_property_read_string(node, "compatible", &label);
> +
> +		if (!strcmp(label, pdev->name)) {

This is a bit strange. Why one need to compare platform device instance (!)
name with compatible which is part of ABI. This looks really wrong approach.
Needs a very good explanation on what's going on here.

Besides that the label is usually filled by LEDS core, why do we need to handle
it in a special way?

> +			ret = fwnode_property_read_u32(node, "reg", &val);
> +			if (ret) {
> +				dev_err(dev, "reg property is missing: ret %d\n", ret);
> +				return ret;
> +			}
> +
> +			if (val == pdev->id) {

> +				dev->fwnode = node;
> +				dev->of_node = to_of_node(node);

No direct access to fwnode in struct device, please use device_set_node().

> +			}
> +		}
> +	}
> +
> +	return 0;
> +}

...

>  	pdata = dev_get_platdata(&pdev->dev);
>  	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		ret = lm3533_pass_of_node(pdev, pdata);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed to get als device node\n");

With

	struct device *dev = &pdev->dev;

at the top of the function will help a lot in making the code neater and easier
to read.

> +		lm3533_parse_als(pdev, pdata);
>  	}

...

>  #include <linux/leds.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mutex.h>

> +#include <linux/of.h>

Cargo cult? "Proxy" header? Please follow IWYU principle.

>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>

...

> +static void lm3533_parse_led(struct platform_device *pdev,
> +			     struct lm3533_led_platform_data *pdata)
> +{
> +	struct device *dev = &pdev->dev;
> +	int val, ret;
> +
> +	ret = device_property_read_string(dev, "default-trigger",
> +					  &pdata->default_trigger);
> +	if (ret)
> +		pdata->default_trigger = "none";

Isn't this done already in LEDS core?

> +	/* 5000 - 29800 uA (800 uA step) */
> +	ret = device_property_read_u32(dev, "max-current-microamp", &val);
> +	if (ret)
> +		val = 5000;
> +	pdata->max_current = val;
> +
> +	/* 0 - 0x3f */
> +	ret = device_property_read_u32(dev, "pwm", &val);
> +	if (ret)
> +		val = 0;
> +	pdata->pwm = val;
> +}

...

> +static int lm3533_pass_of_node(struct platform_device *pdev,
> +			       struct lm3533_led_platform_data *pdata)

I think I already saw exactly the same piece of code. Please make sure
you have no duplications.

> +}

...

>  	pdata = dev_get_platdata(&pdev->dev);
>  	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		ret = lm3533_pass_of_node(pdev, pdata);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed to get led device node\n");
> +
> +		lm3533_parse_led(pdev, pdata);

Ditto.

>  	}

...

> -	led->cdev.name = pdata->name;
> +	led->cdev.name = dev_name(&pdev->dev);

Are you sure it's a good idea?

...

> -	if (!pdata->als)
> +	if (!pdata->num_als)
>  		return 0;
>  
> -	lm3533_als_devs[0].platform_data = pdata->als;
> -	lm3533_als_devs[0].pdata_size = sizeof(*pdata->als);
> +	if (pdata->num_als > ARRAY_SIZE(lm3533_als_devs))
> +		pdata->num_als = ARRAY_SIZE(lm3533_als_devs);

Looks like you want

	pdata->num_als = clamp(pdata->num_als, 0, ARRAY_SIZE(lm3533_als_devs));
	if (!pdata->num_als)
		return 0;

instead of the above. You would need minmax.h for that.

...

> +	if (pdata->leds) {

This is strange. I would expect num_leds == 0 in this case

> +		for (i = 0; i < pdata->num_leds; ++i) {
> +			lm3533_led_devs[i].platform_data = &pdata->leds[i];
> +			lm3533_led_devs[i].pdata_size = sizeof(pdata->leds[i]);
> +		}
>  	}

...

> +static void lm3533_parse_nodes(struct lm3533 *lm3533,
> +			       struct lm3533_platform_data *pdata)
> +{
> +	struct fwnode_handle *node;
> +	const char *label;
> +
> +	device_for_each_child_node(lm3533->dev, node) {
> +		fwnode_property_read_string(node, "compatible", &label);
> +
> +		if (!strcmp(label, lm3533_bl_devs[pdata->num_backlights].name))
> +			pdata->num_backlights++;
> +
> +		if (!strcmp(label, lm3533_led_devs[pdata->num_leds].name))
> +			pdata->num_leds++;
> +
> +		if (!strcmp(label, lm3533_als_devs[pdata->num_als].name))
> +			pdata->num_als++;
> +	}
> +}

Oh, I don't like this approach. If you have compatible, you have driver_data
available, all this is not needed as it may be hard coded.

...

>  	if (!pdata) {

I would expect actually that legacy platform data support will be simply killed
by this patch(es). Do we have in-kernel users? If so, they can be easily
converted to use software nodes, otherwise we even don't need to care.

> -		dev_err(lm3533->dev, "no platform data\n");
> -		return -EINVAL;
> +		pdata = devm_kzalloc(lm3533->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		ret = device_property_read_u32(lm3533->dev,
> +					       "ti,boost-ovp",
> +					       &pdata->boost_ovp);
> +		if (ret)
> +			pdata->boost_ovp = LM3533_BOOST_OVP_16V;
> +
> +		ret = device_property_read_u32(lm3533->dev,
> +					       "ti,boost-freq",
> +					       &pdata->boost_freq);
> +		if (ret)
> +			pdata->boost_freq = LM3533_BOOST_FREQ_500KHZ;
> +
> +		lm3533_parse_nodes(lm3533, pdata);
> +
> +		lm3533->dev->platform_data = pdata;
>  	}

...

> +static const struct of_device_id lm3533_match_table[] = {
> +	{ .compatible = "ti,lm3533" },
> +	{ },

No comma in the terminator entry.

> +};

...

> +static void lm3533_parse_backlight(struct platform_device *pdev,

pdev is not actually used, just pass struct device *dev directly.
Same comment to other functions in this change. It will make code more
bus independent and reusable.

> +				   struct lm3533_bl_platform_data *pdata)
> +{
> +	struct device *dev = &pdev->dev;
> +	int val, ret;
> +
> +	/* 5000 - 29800 uA (800 uA step) */
> +	ret = device_property_read_u32(dev, "max-current-microamp", &val);
> +	if (ret)
> +		val = 5000;
> +	pdata->max_current = val;

> +	/* 0 - 255 */
> +	ret = device_property_read_u32(dev, "default-brightness", &val);
> +	if (ret)
> +		val = LM3533_BL_MAX_BRIGHTNESS;
> +	pdata->default_brightness = val;

Isn't handled by LEDS core?

> +	/* 0 - 0x3f */
> +	ret = device_property_read_u32(dev, "pwm", &val);
> +	if (ret)
> +		val = 0;
> +	pdata->pwm = val;
> +}

...

> +static int lm3533_pass_of_node(struct platform_device *pdev,
> +			       struct lm3533_bl_platform_data *pdata)
> +{

3rd dup?

> +}

...

>  	pdata = dev_get_platdata(&pdev->dev);
>  	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> +		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		ret = lm3533_pass_of_node(pdev, pdata);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed to get backlight device node\n");
> +
> +		lm3533_parse_backlight(pdev, pdata);
>  	}

Ditto.

> -	bd = devm_backlight_device_register(&pdev->dev, pdata->name,
> -					pdev->dev.parent, bl, &lm3533_bl_ops,
> -					&props);
> +	bd = devm_backlight_device_register(&pdev->dev, dev_name(&pdev->dev),

I'm not sure the dev_name() is a good idea. We usually try to rely on the
predictable outcome, something like what "%pfw" prints against a certain fwnode.

> +					    pdev->dev.parent, bl,
> +					    &lm3533_bl_ops, &props);

...

Also I feel that this change may be split to a few separate logical changes.

-- 
With Best Regards,
Andy Shevchenko



