Return-Path: <linux-iio+bounces-24156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4FB59720
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 15:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661B43209F5
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EC312835;
	Tue, 16 Sep 2025 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD5aPMys"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A278310771;
	Tue, 16 Sep 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028366; cv=none; b=gOklAjXq7nHFhb9MXRpei8VM8NPe/9koIQlNX3yxTZcMVPAjoLOUOQbZxQm5PSJFDe/OPCficoHl9AIL/52BBVZ+gWxLcAXPdP614jRCvK3RqQEOUciQCgNFDpyqt3i0VzYIaupMc6F+VhZPZWYcCEbU1CbHHKU3tovw/hZQpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028366; c=relaxed/simple;
	bh=POMKWbvGESg9MUeo7Y5Y5rEjhFBEabdQMSGd/YV9ejw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfXFdnSUjy7GotogkqZHCSCiC+5L5zyT4Vb4TwQ0BpsMHXVHLIvUP0JwFCZ8h0ewebB0EBolWWhFoKI7ZecugyEpN4pl8h4XC1UCJ5N8lYf225ayMqgwk5uTQMxwEIzQ6Ru7+yHJHLIUAHXBxts9aqnQsC8SvxmmOVtxsY6c9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OD5aPMys; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758028365; x=1789564365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=POMKWbvGESg9MUeo7Y5Y5rEjhFBEabdQMSGd/YV9ejw=;
  b=OD5aPMys2aINe0VXj0NaeY60cH1SG/2uWqPnMYUtbKb++14BqICTjcNR
   Sp6FKdKXd2hJ6nOGxAF/Pf3jxUAjbIn1edvVBuGi2Xt5wqRv52aFA5sXf
   AxqdfMbROWmZzZ262XBxwfQ8iArCNScVsgILf4xjomaSeBHIqgUxcBzOo
   nx5nh6KGxenJ45skRycfL/SzV2w/QGJtJiSuvZErOaWZpcZe5kTQtNJJR
   ABjw/V3n+fHBlw5zSo1IpA8QrV8AkDFAmZ6pdIvQM0dAdHAPfkQnDNPfU
   f20IsxXiwPz+TUHLbazmNHl+8IN1pkh9crfFTocE2IjMzDpcIelm6Kw2P
   Q==;
X-CSE-ConnectionGUID: mHmMzmDMTnqo/ZOQYVZohg==
X-CSE-MsgGUID: YUsRvgdyQ96I3ix9OI6/1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64125739"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="64125739"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:12:44 -0700
X-CSE-ConnectionGUID: OZtg13w1QAejcaNOHzccKw==
X-CSE-MsgGUID: EmsxI3CdQUmlMEkAAknqLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="198627841"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 06:12:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uyVU6-00000003X6j-0qUp;
	Tue, 16 Sep 2025 16:12:38 +0300
Date: Tue, 16 Sep 2025 16:12:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: Support the LTM8054 voltage regulator
Message-ID: <aMliRTuUDNPkeM8C@smile.fi.intel.com>
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-3-fd4e781d33b9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-ltm8054-driver-v1-3-fd4e781d33b9@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 16, 2025 at 12:24:08PM +0200, Romain Gantois wrote:
> Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
> regulator. This version only supports enabling/disabling the regulator via
> a GPIO, and reporting the output voltage level from the resistor divider
> values given in the device tree.

...

> +#include <linux/module.h>
> +#include <linux/of.h>

I think we have already something agnostic in regulator API to get a regulator
from a firmware node (rather than from specific OF/etc one).

> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>

Can you keep it ordered? This way it's easy to maintain and avoid potential
duplication (note, there are also many headers are missing here, but Mark
usually not insisting in following IWYU principle [1])

...

> +/* The LTM8054 regulates its FB pin to 1.2V */
> +#define LTM8054_FB_V 1200000

It's actually _mV

#define LTM8054_FB_mV	1200000

...

> +static int ltm8054_scale(unsigned int uV, u32 r1, u32 r2)
> +{
> +	u64 tmp;
> +
> +	tmp = (u64)uV * r1;
> +	do_div(tmp, r2);
> +
> +	return uV + (unsigned int)tmp;

Why one needs a casting here?

> +}

...

> +static const struct regulator_ops ltm8054_regulator_ops = {
> +};

Why it can be simply as

static const struct regulator_ops ltm8054_regulator_ops;

...

> +static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
> +			    struct regulator_config *config)
> +{
> +	struct device_node *np = dev->of_node;
> +	u32 r[2];
> +	int ret;
> +
> +	config->of_node = np;
> +
> +	ret = of_property_read_u32_array(np, "lltc,fb-voltage-divider", r, 2);

device_property_read_u32_array() ?

ARRAY_SIZE() instead of 2

> +	if (ret) {
> +		dev_err(dev, "Failed to parse voltage divider\n");
> +		return ret;
> +	}
> +
> +	priv->rdesc.fixed_uV = ltm8054_scale(LTM8054_FB_V, r[0], r[1]);
> +	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
> +	priv->rdesc.n_voltages = 1;
> +
> +	config->init_data = of_get_regulator_init_data(dev,
> +						       np,
> +						       &priv->rdesc);
> +	if (!config->init_data) {
> +		dev_err(dev, "failed to parse init data\n");
> +		return -EINVAL;
> +	}
> +
> +	config->ena_gpiod = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(config->ena_gpiod)) {
> +		dev_err(dev, "unable to acquire enable gpio\n");
> +		return PTR_ERR(config->ena_gpiod);

All messages in cases of EPROBE_DEFER are problematic (for sure with GPIO),
as it may well flood the logs.
Solution: Use

		return dev_err_probe(...);

pattern instead,

> +	}
> +
> +	return 0;
> +}

...

> +static int ltm8054_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config config = { 0 };

'0' is not required. The { } will have the same effect.

> +	struct regulator_dev *rdev;
> +	struct ltm8054_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->rdesc.name = "ltm8054-regulator",
> +	priv->rdesc.ops = &ltm8054_regulator_ops,
> +	priv->rdesc.type = REGULATOR_VOLTAGE,
> +	priv->rdesc.owner = THIS_MODULE,
> +
> +	config.dev = &pdev->dev;
> +	config.driver_data = priv;
> +
> +	ret = ltm8054_of_parse(&pdev->dev, priv, &config);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to parse device tree\n");
> +
> +	rdev = devm_regulator_register(&pdev->dev, &priv->rdesc, &config);
> +	if (IS_ERR(rdev))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rdev), "failed to register regulator\n");

Using

	struct device *dev = &pdev->dev;

at the top will allow to make a few lines shorter.

> +	return 0;
> +}
> +
> +static const struct of_device_id __maybe_unused ltm8054_of_match[] = {
> +	{ .compatible = "lltc,ltm8054", },

Inner comma is not required.

> +	{},

Drop the trailing comma here as it's a terminator entry. The absence of it will
give a hint to the compiler as well.

> +};

...

> +static struct platform_driver ltm8054_driver = {
> +	.probe = ltm8054_probe,
> +	.driver = {
> +		.name  = "ltm8054",
> +		.of_match_table = of_match_ptr(ltm8054_of_match),

Please, do not use of_match_ptr() and/or ACPI_PTR() in a new code.

> +	},
> +};

> +

Unneeded blank line.

> +module_platform_driver(ltm8054_driver);

-- 
With Best Regards,
Andy Shevchenko



