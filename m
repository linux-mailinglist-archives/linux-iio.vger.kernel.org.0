Return-Path: <linux-iio+bounces-26417-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D4CC7FF32
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 11:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABB394E23AE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D42F7ACA;
	Mon, 24 Nov 2025 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lR4PXTcO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494A321A449;
	Mon, 24 Nov 2025 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980845; cv=none; b=UiGHr4/zfMZVGivOpm9MCzthOjNdjxX2G3X0UKIpw7eKbwwpBHrjatSF33Jmne2DNt8pJqa01Df3d3DbPkdN+QgRQwJgxTdAUIMdFg7SJfNK8y3+vq/tVs26iQFRmGo/Lt6EnWuL+OoLtMmSIBkDindqBFYeM3M2dMLc/UsMAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980845; c=relaxed/simple;
	bh=ODndMX6CiQo0rN0bWUTcqRFHIkrIyq5OhKM+gC7WSlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwEW+mhIKeDJLPcpW04ba6RmickgWCysEW52tM+tOAaa//ZGNw0bNVuNlCEiK/zbL45jyQKJL63oF33gYWWECiphTUrxIxTkdtZja4OJuOHLXhz7iDsp2Bv2JXP4babckS0TobecUlgexcoMwp4OLnQrCizgbZUDXPBd5kNFu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lR4PXTcO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763980844; x=1795516844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODndMX6CiQo0rN0bWUTcqRFHIkrIyq5OhKM+gC7WSlU=;
  b=lR4PXTcO4KdG1S3geKYOcFHMwNaX1P1aKtxCRW42ohzRA5EaQbg0LP0u
   RL+L33ckjBcBzvSAnGkrzspZsA7a0tFEGXvm9NZZRA3TuTfH48QN9tMWv
   mgr1E9T+iWqB0vm8tw/CArMr74JrgArJqhp2s+/enc4e63ESiVbMDHyya
   9lYApFPuxHaONgY3bSN9UONNIWPdGq0tymA5ZP4pwAvXGSpbXtVL31cis
   GFiZsUiQgcrux6a0kK89HBDvm1YVwbvNidLSgjUKsDw67uJ6s088V4U0R
   Tu3g4esSujswxnKrrAMSV9gfqgLiPWMr7/rsD+NBzY57dAuWBKCbmIIJ6
   w==;
X-CSE-ConnectionGUID: 3ZRtXh61STaav41K3ezeqA==
X-CSE-MsgGUID: YxFAtuUnSOm8/AKcKevZ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="65673374"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="65673374"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:40:44 -0800
X-CSE-ConnectionGUID: RfhoPo0NS/CHVVhNnMLJNA==
X-CSE-MsgGUID: P/Kbpg4aSmqK1jS2+CUXoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="197227696"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:40:40 -0800
Date: Mon, 24 Nov 2025 12:40:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 9/9] iio: adc: ad4062: Add GPIO Controller support
Message-ID: <aSQ2JUN05vmMQC1I@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-staging-ad4062-v2-9-a375609afbb7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 10:18:08AM +0100, Jorge Marques wrote:
> When gp0 or gp1 is not taken as an interrupt, expose them as gpo if

GPO

> gpio-contoller is set in the devicetree.

Why can't gpio-regmap be used?

...

> +static int ad4062_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct ad4062_state *st = gpiochip_get_data(gc);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4062_REG_GP_CONF, &reg_val);
> +	if (ret)
> +		return 0;

> +	if (st->gpo_irq[offset])
> +		return -ENODEV;

Consider using valid_mask instead (.init_valid_mask() callback).
Hmm... And it seems it's in place. I didn't get what is here then and
why we need to do it after accessing the HW? If there are side-effects
they must be described.

> +	if (offset)
> +		reg_val = FIELD_GET(AD4062_REG_GP_CONF_MODE_MSK_1, reg_val);
> +	else
> +		reg_val = FIELD_GET(AD4062_REG_GP_CONF_MODE_MSK_0, reg_val);
> +
> +	return reg_val == AD4062_GP_STATIC_HIGH ? 1 : 0;

	return !!(reg_val == AD4062_GP_STATIC_HIGH);

also will work.

> +}

> +static int ad4062_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	struct ad4062_state *st = gpiochip_get_data(gc);
> +
> +	bitmap_zero(valid_mask, ngpios);
> +
> +	if (!st->gpo_irq[0])
> +		set_bit(0, valid_mask);
> +	if (!st->gpo_irq[1])
> +		set_bit(1, valid_mask);

Why atomic bit set:s?


> +	return 0;
> +}
> +
> +static int ad4062_gpio_init(struct ad4062_state *st)
> +{
> +	struct device *dev = &st->i3cdev->dev;
> +	struct gpio_chip *gc;
> +	u8 val, mask;
> +	int ret;

> +	if ((st->gpo_irq[0] && st->gpo_irq[1]) ||
> +	    !device_property_read_bool(dev, "gpio-controller"))
> +		return 0;

Do you need this? valid_mask should take care of this.

> +	gc = devm_kzalloc(dev, sizeof(*gc), GFP_KERNEL);
> +	if (!gc)
> +		return -ENOMEM;
> +
> +	val = 0;
> +	mask = 0;
> +	if (!st->gpo_irq[0]) {
> +		mask |= AD4062_REG_GP_CONF_MODE_MSK_0;
> +		val |= FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_0, AD4062_GP_STATIC_LOW);
> +	}
> +	if (!st->gpo_irq[1]) {
> +		mask |= AD4062_REG_GP_CONF_MODE_MSK_1;
> +		val |= FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_STATIC_LOW);
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ad4062_gpio_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	gc->parent = dev;
> +	gc->label = st->chip->name;
> +	gc->owner = THIS_MODULE;
> +	gc->base = -1;
> +	gc->ngpio = 2;
> +	gc->init_valid_mask = ad4062_gpio_init_valid_mask;
> +	gc->get_direction = ad4062_gpio_get_direction;
> +	gc->set = ad4062_gpio_set;
> +	gc->get = ad4062_gpio_get;
> +	gc->can_sleep = true;
> +
> +	ret = devm_gpiochip_add_data(dev, gc, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to register GPIO chip\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



