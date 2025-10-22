Return-Path: <linux-iio+bounces-25346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A952ABFCB45
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A97626032
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6C32B994;
	Wed, 22 Oct 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSrRvcnz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91624728F;
	Wed, 22 Oct 2025 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761144261; cv=none; b=A8xhlkWd1fMaMRl+SOTVqmBglj/r5wiwi81SLP5roE3c33bcoSbhm0c90cYvYNh3LGDgojlcqwEUbPSLUDMEGxPPTFaFHZjTX0lKaKvqRqAZ7uiYV58zxY8i9IincvvGdoVKddS8MKFTvPEk330UWxzNPa6/MbUWltsMN6web4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761144261; c=relaxed/simple;
	bh=tCZTO0W751GktTbJXelH69v6OSj5y2VH2L80rPuRgHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2NJFdwbGYS0JnZnXfeMHoFp78ev7Jt3QMzOtM6No/SWf0HKWTHKH2DY/PWjE9UMZSAZYWT/P7vGUf73XQDdqWd1T78GhbZ6xjIYKawuBII2n40J+ME6xoR45KXi7HPodrsZL9JIu1FqEGc/IT7Xo+vdxpZGa8KJAajHeeGIH20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSrRvcnz; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761144259; x=1792680259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tCZTO0W751GktTbJXelH69v6OSj5y2VH2L80rPuRgHA=;
  b=SSrRvcnze3nxJSaeS7cUFgNeFkRjHKqEgmF3cbh3Z4HPs1g79FkNvNIq
   o6eXmNH8sLC+PeZUk/63+jN0wHnRDo7eYZFuQnZySgMUD5Yzjt+7ve3ZD
   5fUtpAdXqU9Z8ofZ56WX5YVoM6LN3eVfwhD38d0DE3LuVY4MkwcHjJ2dZ
   tUSjeLu//i/3cjJsRcZ01Oko/aY1rI8/97ZChz7ox6tHY0Ub9lduN4Gem
   95ySCCn5KpirvnCA/JYHoWxUAFExiS3GQMVjSU/3/Z1dyZC7T5cSf9IKX
   Yww6ko3yKbyqq0se+9Hp6LZVNGiuC4oascq6mZKbSgN4Je5QJhHQPHHWq
   Q==;
X-CSE-ConnectionGUID: VJXOwtJ1RR6/J7d6waKqqg==
X-CSE-MsgGUID: 7Bm+5fyQSqOgCuIoY8TVhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85918196"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="85918196"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 07:44:19 -0700
X-CSE-ConnectionGUID: 9Wg7VTI7Q2OOgnCwuxUASA==
X-CSE-MsgGUID: v2vMYJCrQm6A7dQNpHXWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183596475"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 07:44:15 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBa4S-00000001iaZ-3dG1;
	Wed, 22 Oct 2025 17:44:12 +0300
Date: Wed, 22 Oct 2025 17:44:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/5] regulator: Support the LTM8054 voltage regulator
Message-ID: <aPjtvPmc_7IBV7og@smile.fi.intel.com>
References: <20250925-ltm8054-driver-v2-0-bb61a401a0dc@bootlin.com>
 <20250925-ltm8054-driver-v2-4-bb61a401a0dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-ltm8054-driver-v2-4-bb61a401a0dc@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 25, 2025 at 02:37:36PM +0200, Romain Gantois wrote:
> Add a stub driver for the  Linear Technology LTM8054 Buck-Boost voltage
> regulator. This version only supports enabling/disabling the regulator via
> a GPIO, and reporting the output voltage level from the resistor divider
> values given in the device tree.

...

It's a bit an interesting grouping of headers...

> +#include <asm/div64.h>

...starting with leading asm/*.

> +#include <linux/array_size.h>
> +
> +#include <linux/device.h>
> +#include <linux/device/devres.h>
> +#include <linux/device/driver.h>
> +
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>

I would expect above to be (but not limited to)

#include <linux/array_size.h>
#include <linux/device.h>
#include <linux/device/devres.h>
#include <linux/device/driver.h>
#include <linux/dev_printk.h>
#include <linux/err.h>

#include <linux/errno.h>

#include <linux/gpio/consumer.h>
#include <linux/math64.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/platform_device.h>
#include <linux/property.h>

Also missing
types.h

> +#include <linux/regulator/consumer.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/of_regulator.h>

...

> +static int ltm8054_of_parse(struct device *dev, struct ltm8054_priv *priv,
> +			    struct regulator_config *config)
> +{
> +	struct device_node *np = dev->of_node;

No need, see below how.

> +	u32 r[2];
> +	int ret;

> +	config->of_node = np;

Better to move it...

> +
> +	ret = device_property_read_u32_array(dev, "lltc,fb-voltage-divider", r, ARRAY_SIZE(r));
> +	if (ret)
> +		return ret;
> +
> +	priv->rdesc.fixed_uV = ltm8054_scale(LTM8054_FB_uV, r[0], r[1]);
> +	priv->rdesc.min_uV = priv->rdesc.fixed_uV;
> +	priv->rdesc.n_voltages = 1;

...here and reuse.

> +	config->init_data = of_get_regulator_init_data(dev,
> +						       np,
> +						       &priv->rdesc);

	config->of_node = dev_of_node(dev);
	config->init_data = of_get_regulator_init_data(dev,
						       config->of_node,
						       &priv->rdesc);

> +	if (!config->init_data)
> +		return -EINVAL;
> +
> +	config->ena_gpiod = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(config->ena_gpiod))
> +		return PTR_ERR(config->ena_gpiod);
> +
> +	return 0;
> +}

> +static int ltm8054_probe(struct platform_device *pdev)
> +{
> +	struct regulator_config config = { };
> +	struct device *dev = &pdev->dev;
> +	struct regulator_dev *rdev;
> +	struct ltm8054_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->rdesc.name = "ltm8054-regulator",
> +	priv->rdesc.ops = &ltm8054_regulator_ops,
> +	priv->rdesc.type = REGULATOR_VOLTAGE,
> +	priv->rdesc.owner = THIS_MODULE,

The commas should be replaced by semicolons.

> +	config.dev = dev;
> +	config.driver_data = priv;
> +
> +	ret = ltm8054_of_parse(dev, priv, &config);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> +
> +	rdev = devm_regulator_register(dev, &priv->rdesc, &config);
> +	if (IS_ERR(rdev))
> +		return dev_err_probe(dev, PTR_ERR(rdev), "failed to register regulator\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



