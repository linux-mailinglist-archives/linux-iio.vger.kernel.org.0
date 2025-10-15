Return-Path: <linux-iio+bounces-25246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28253BED580
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15FA64ECEEB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A002586C5;
	Sat, 18 Oct 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CN9MLKxk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D5F16F288;
	Sat, 18 Oct 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808855; cv=none; b=gydpl9D8RrTd6uT0fB/9WlyNoWmGjFyXYkOEoI1Eujkf+cDtyn1ORV1g/o5KynBY6NZObV62ndDSzP50tJhgGD47G5TWAuXV7roSIQJTskgC/nXk3IQl6XuH+lpV/1UJU/HoYG5OTWGJ2wLWLSBas5BZ1k8rWWhtV+3JHgo0e6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808855; c=relaxed/simple;
	bh=nHoTrqYFaKW8NNAmMWR6D+P7bywiSiWIvgb9YI2McWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEdWTYNGfe1MWhNxpz3UWBHshJHuo6cVvawvux7WAOY/2nUZLVdYyoF6tHasVGIQGcZZJg7/WcDXx2tbKYLGoC501FXPqX9YEc5rM3g0rRyLy28cWAN3WC01nPMDFDjLHrX/VofSsDZ9W9m6lUMbZChkHu7Qzearyba1accme2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CN9MLKxk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808854; x=1792344854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nHoTrqYFaKW8NNAmMWR6D+P7bywiSiWIvgb9YI2McWE=;
  b=CN9MLKxkoXm9MyduGVaF1J4esvo8jkjJlUDiyWQ/xYCkCx9Q9bu0h9Be
   vTLZEdzJ1Nm7eQV9k0eD8EkKp9Q95YRrKzaZ6Jd+tyIdK6uhvru2R9DAs
   vJd/XiBBh0NxhU/Q8hLTqQNsYt23CYUF36ZaOIoUdJDvZ3Z5E+l4gegQo
   GoxIFG/HtF0B1UHZL5JndDMoQA0lHAWv7B3wsnEyQkrWf2EiEcW53iTS3
   T1KW364GIOJ6uwe2q/pEbT8tho1gylwrehbwsv1xQpEaA/vg9VCytMDZ2
   IPZrkDHCRgysgXDFPdEzm10+0uVPX6XIAfutlZrthyKYt8tWHr+i3RLCY
   g==;
X-CSE-ConnectionGUID: fL0xe26BTm6IZWhbZ0HqvA==
X-CSE-MsgGUID: uK8FMVaMRmeEwNMw2Cq8nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="65614251"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="65614251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:13 -0700
X-CSE-ConnectionGUID: vQwJsY48R3WuVzqEsjMvSA==
X-CSE-MsgGUID: +IcFpLG2RvWeQvNyM8IYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="187237737"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:08 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v92ug-00000000L2n-2bEP;
	Wed, 15 Oct 2025 17:55:38 +0300
Date: Wed, 15 Oct 2025 17:55:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Eberhard <pascal.eberhard@se.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aO-16hC5r7-FB9Pw@smile.fi.intel.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015142816.1274605-3-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 15, 2025 at 04:28:14PM +0200, Herve Codina (Schneider Electric) wrote:

Thanks for the contribution, my comments below.

TL;DR: seems like somebody just submitted a driver without doing an internal
review with the kernel developers familiar with the upstream (and I believe
there are such in your company). This is not good. You, guys, should try your
best and not put a burden on the maintainer's/reviewers' shoulders.

> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ACD cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.

...

> +#include <linux/kernel.h>

Definitely big no for this one.

> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/mutex.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/bits.h>

> +#include <linux/of.h>

And simple "no" to this one.

> +#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>

In IIO we do
1) follow IWYU principle;
2) keep headers ordered (with possible grouping of iio/* ones or others if more
than one and specific to a domain);

...

> +#define RZN1_ADC_CONTROL_REG	0x2c
> +#define RZN1_ADC_CONTROL_ADC_BUSY	BIT(6)
> +#define RZN1_ADC_FORCE_REG		0x30
> +#define RZN1_ADC_SET_FORCE_REG		0x34
> +#define RZN1_ADC_CLEAR_FORCE_REG	0x38
> +#define RZN1_ADC_FORCE_VC(_n)		BIT(_n)

Please, make sure _REG definition values are on the column, same for bitfield
defs (some people like indent them slightly differently to the regs).

> +#define RZN1_ADC_CONFIG_REG	0x40
> +#define RZN1_ADC_CONFIG_ADC_POWER_DOWN	BIT(3)

...

> +#define RZN1_ADC_VC_REG(_n)	(0xc0 + 0x4 * (_n))

0x4 --> 4 as it's just a stride. Same for the rest of the similar cases.

...

> +struct rzn1_adc_core {
> +	int is_used;
> +	struct regulator *avdd;
> +	struct regulator *vref;

Possible waste of 4 bytes on some architectures. Please, run `pahole` and see
the opportunities to improve all data structure types in the driver.

> +};

...

> +static int rzn1_adc_core_power_on(struct rzn1_adc_core *adc_core)
> +{
> +	int ret;
> +
> +	if (!adc_core->is_used)
> +		return 0;
> +
> +	ret = regulator_enable(adc_core->avdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_enable(adc_core->vref);
> +	if (ret) {
> +		regulator_disable(adc_core->avdd);
> +		return ret;
> +	}

Don't we have bulk API? Can't it be used here? Why?

> +	return 0;
> +}

...

> +static int rzn1_adc_core_get_regulators(struct rzn1_adc *rzn1_adc,
> +					struct rzn1_adc_core *adc_core,
> +					const char *avdd_name, const char *vref_name)
> +{
> +	struct device *dev = rzn1_adc->dev;
> +	int ret;
> +
> +	adc_core->avdd = devm_regulator_get_optional(dev, avdd_name);

	ret = PTR_ERR_OR_ZERO(...);

might simplify the below.

> +	if (IS_ERR(adc_core->avdd)) {
> +		ret = PTR_ERR(adc_core->avdd);
> +		if (ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get '%s' regulator\n",
> +					     avdd_name);
> +		adc_core->avdd = NULL;
> +	}

Like
	if (ret == -ENODEV)
		...
	else if (ret)
		return dev_err_probe(...);

> +	adc_core->vref = devm_regulator_get_optional(dev, vref_name);
> +	if (IS_ERR(adc_core->vref)) {
> +		ret = PTR_ERR(adc_core->vref);
> +		if (ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get '%s' regulator\n",
> +					     vref_name);
> +		adc_core->vref = NULL;
> +	}

Ditto. (However see above about bulk API)

I'm so much wondering when somebody provides a wrapper that _optional() for
regulator will be optional from device source code pattern so we won't see
anymore these checks for ENODEV (with chance > 0 of a mistake in some cases as
it's usually an unintuitive for use API if you need to test for the specific
error code).

> +	/*
> +	 * Both regulators (avdd and vref) need to be available to have the
> +	 * related adc_core used.
> +	 */
> +	adc_core->is_used = adc_core->vref && adc_core->avdd;
> +	return 0;
> +}

...

> +static int rzn1_adc_core_get_vref_mv(struct rzn1_adc_core *adc_core)
> +{
> +	int vref_uv;

_uV ?

> +
> +	if (!adc_core->vref)
> +		return -ENODEV;
> +
> +	vref_uv = regulator_get_voltage(adc_core->vref);
> +	if (vref_uv < 0)
> +		return vref_uv;
> +
> +	return vref_uv / 1000;

Hmm... (MICRO/MILLI) ?

> +}

...

> +static int rzn1_adc_power(struct rzn1_adc *rzn1_adc, bool power)
> +{
> +	u32 v;
> +
> +	writel(power ? 0 : RZN1_ADC_CONFIG_ADC_POWER_DOWN,
> +	       rzn1_adc->regs + RZN1_ADC_CONFIG_REG);
> +
> +	/*
> +	 * Wait for the ADC_BUSY to clear.

> +	 * On timeout, ret is -ETIMEDOUT, otherwise it will be 0.

Useless comment. It might be something else in some cases, we don't need to
explain this in every caller.

> +	 */
> +	return readl_poll_timeout_atomic(rzn1_adc->regs + RZN1_ADC_CONTROL_REG,
> +					 v, !(v & RZN1_ADC_CONTROL_ADC_BUSY),
> +					 0, 500);
> +}

...

> +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
> +					 int adc1_ch, int adc2_ch)
> +{
> +	u32 vc = 0;
> +
> +	if (adc1_ch != -1)

The >= 0 is more robust in case the value gets an error pointer or -err code.

> +		vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch);
> +
> +	if (adc2_ch != -1)
> +		vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(adc2_ch);
> +
> +	writel(vc, rzn1_adc->regs + RZN1_ADC_VC_REG(ch));
> +}

> +static int rzn1_adc_vc_wait_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
> +				       u32 *adc1_data, u32 *adc2_data)
> +{
> +	u32 data_reg;
> +	int ret;
> +	u32 v;
> +
> +	/*
> +	 * When a VC is selected, it needs 20 ADC clocks to perform the
> +	 * conversion.
> +	 *
> +	 * The worst case is when the 16 VCs need to perform a conversion and
> +	 * our VC is the lowest in term of priority.
> +	 *
> +	 * In that case, the conversion is performed in 16 * 20 ADC clocks.
> +	 *
> +	 * The ADC clock can be set from 4MHz to 20MHz. This leads to a worst
> +	 * case of  16 * 20 * 1/4Mhz = 80us.
> +	 *
> +	 * Round it up to 100us

Missing period.

> +	 */
> +
> +	/*
> +	 * Wait for the ADC_FORCE_VC(n) to clear.
> +	 *
> +	 * On timeout, ret is -ETIMEDOUT, otherwise it will be 0.
> +	 */
> +	ret = readl_poll_timeout_atomic(rzn1_adc->regs + RZN1_ADC_FORCE_REG,
> +					v, !(v & RZN1_ADC_FORCE_VC(ch)),
> +					0, 100);
> +	if (ret)
> +		return ret;
> +
> +	if (adc1_data) {
> +		data_reg = readl(rzn1_adc->regs + RZN1_ADC_ADC1_DATA_REG(ch));
> +		*adc1_data = RZN1_ADC_ADCX_GET_DATA(data_reg);
> +	}
> +
> +	if (adc2_data) {
> +		data_reg = readl(rzn1_adc->regs + RZN1_ADC_ADC2_DATA_REG(ch));
> +		*adc2_data = RZN1_ADC_ADCX_GET_DATA(data_reg);
> +	}
> +
> +	return 0;
> +}

I almost stopped here, see TL;DR above why.

...

> +static const struct of_device_id rzn1_adc_of_match[] = {
> +	{ .compatible = "renesas,rzn1-adc" },
> +	{ /* sentinel */ },

No comments, no commas in terminator entry. This is a common style in IIO.

> +};

> +

Unneeded blank line.

> +MODULE_DEVICE_TABLE(of, rzn1_adc_of_match);

...

> +static struct platform_driver rzn1_adc_driver = {
> +	.probe = rzn1_adc_probe,
> +	.remove = rzn1_adc_remove,
> +	.driver = {
> +		.name = "rzn1-adc",
> +		.of_match_table = of_match_ptr(rzn1_adc_of_match),

New code shouldn't use of_match_ptr().

> +		.pm = pm_ptr(&rzn1_adc_pm_ops),
> +	},
> +};

> +

Unneeded blank line.

> +module_platform_driver(rzn1_adc_driver);

-- 
With Best Regards,
Andy Shevchenko



