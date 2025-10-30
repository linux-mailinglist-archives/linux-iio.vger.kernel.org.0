Return-Path: <linux-iio+bounces-25656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7480C1F2CC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 10:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C418950FA
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D6233A03A;
	Thu, 30 Oct 2025 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRAc3mGT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8093338939;
	Thu, 30 Oct 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814821; cv=none; b=Tt6yQfICCdWXbJ3iHvNQZwmsy6zVhqFq3rl4Xj+b2/BSyfPxvitbGdaeEwGBzoSYeCipWXPK7VOpiJI8bbSh+H6fJaQMqzLz9LUjH3kng+1SW2bLPL97wjgn/xeCqzhUyp9HO6WSARs72mErI6AbzFobb8VJRBem451gjS5ib+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814821; c=relaxed/simple;
	bh=ai41Jj4Xl6lRV/HU9xvnUaP6ftQHoXPpEmIqxKoyHJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HopzkDNs+nbL1e9yHMhJV1yDgvxqOJCEfPkrERy4A1vCmr89S5+6M0hWY9l3t39oe84QZIAvWhor+k6cDIbA4zi/yQ1ph0jEzWUO5XKKfFa1nafogLaDiIFVgeuUCs2Xqu735jRtt+UzZex9CllLmm71BHovljuxCvUCpF4EV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRAc3mGT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761814820; x=1793350820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ai41Jj4Xl6lRV/HU9xvnUaP6ftQHoXPpEmIqxKoyHJA=;
  b=NRAc3mGTk7ckcEO1e6kH8QVGeaC02LOx9bnd55PtN6EXdsLiVQJArBL8
   HF2k5MpvNksJFo1xvhTOLVU26DImjr+qoR9Xp38FlIFHd+QtycQrlH1L1
   qAuKHpVCBpSlmOSKRYMhNQjZIz8PaZzOpLdVOPIukWC5xcp7ZL72SVCz3
   rQqPKJio3ywnDdkQLHhdkO7ypfVEDmPqdci7Y2Giv7QUQhSxjqbq4gS/R
   zhNUGyEMDMXvF8CPDU2O87f7LSLO9EyjCEwvk3nOBPWAsPpsYTHDwzlii
   ClwFRI6hCMSDjfKtsKQMdGSUOOOdRdG1KSN+hkVDqiJ1nt6SA+tTs2CmO
   g==;
X-CSE-ConnectionGUID: 8grLYYtHTU+WYfbHWppb0Q==
X-CSE-MsgGUID: xEJvB6USQ9SOLnKdhW5BZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63834735"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63834735"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:00:19 -0700
X-CSE-ConnectionGUID: LlAPZNzKRUKocnZDa90K9w==
X-CSE-MsgGUID: Ewza8RhnSqGbuaZCQhbgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186344479"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:00:15 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vEOVw-00000003qtu-1deL;
	Thu, 30 Oct 2025 11:00:12 +0200
Date: Thu, 30 Oct 2025 11:00:12 +0200
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
Subject: Re: [PATCH v2 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <aQMpHDwCqcrNrnT9@smile.fi.intel.com>
References: <20251029144644.667561-1-herve.codina@bootlin.com>
 <20251029144644.667561-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029144644.667561-3-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 29, 2025 at 03:46:42PM +0100, Herve Codina (Schneider Electric) wrote:
> The Renesas RZ/N1 ADC controller is the ADC controller available in the
> Renesas RZ/N1 SoCs family. It can use up to two internal ADC cores (ADC1
> and ADC2) those internal cores are not directly accessed but are handled
> through ADC controller virtual channels.

Looks much better, thanks! My comments below.

...

+ array_size,h

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>

+ dev_printk.h
+ err.h

> +#include <linux/iio/iio.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>

+ mutex.h

> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regulator/consumer.h>

+ types.h

...

> +#define RZN1_ADC_CONTROL_REG			0x2c

I would go with fixed-width values, e.g., 0x02c for the register definitions.

> +#define RZN1_ADC_CONTROL_ADC_BUSY		BIT(6)
> +
> +#define RZN1_ADC_FORCE_REG			0x30
> +#define RZN1_ADC_SET_FORCE_REG			0x34
> +#define RZN1_ADC_CLEAR_FORCE_REG		0x38

> +#define RZN1_ADC_CONFIG_REG			0x40

> +
> +#define RZN1_ADC_VC_REG(_n)			(0xc0 + 4 * (_n))

> +#define RZN1_ADC_ADC1_DATA_REG(_n)		(0x100 + 4 * (_n))
> +#define RZN1_ADC_ADC2_DATA_REG(_n)		(0x140 + 4 * (_n))

...

> +static int rzn1_adc_get_vref_mv(struct rzn1_adc *rzn1_adc, unsigned int chan)
> +{
> +	/*
> +	 * chan 0..7 use ADC1 ch 0..7. Vref related to ADC1 core
> +	 * chan 8..15 use ADC2 ch 0..7. Vref related to ADC2 core
> +	 */

Split it to two one line comments per each conditional.

> +	if (chan < 8)
> +		return rzn1_adc->adc1_vref_mv;
> +	else if (chan < 16)

Redundant 'else'.

> +		return rzn1_adc->adc2_vref_mv;
> +
> +	return -EINVAL;
> +}

...

> +static int rzn1_adc_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = rzn1_adc_read_raw_ch(rzn1_adc, chan->channel, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = rzn1_adc_get_vref_mv(rzn1_adc, chan->channel);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;

> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

	default:
		return -EINVAL;

> +}

...

> +static const struct iio_info rzn1_adc_info = {
> +	.read_raw = &rzn1_adc_read_raw

Leave trailing comma, this is not a terminator entry.

> +};

...

> +	if (rzn1_adc->adc1_vref_mv >= 0) {

Can we call it _mV?

...

> +	if (rzn1_adc->adc2_vref_mv >= 0) {

Ditto.


...

> +	ret = devm_regulator_get_enable_optional(dev, avdd_name);
> +	if (ret < 0) {
> +		if (ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get '%s' regulator\n",
> +					     avdd_name);
> +		return 0;
> +	}

	if (ret == -ENODEV)
		return dev_err_probe(); // takes less LoCs
	if (ret < 0) // do we need ' < 0' part?
		return 0;

> +	ret = devm_regulator_get_enable_read_voltage(dev, vref_name);
> +	if (ret < 0) {
> +		if (ret != -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to get '%s' regulator\n",
> +					     vref_name);
> +		return 0;
> +	}

In the same way as above.

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(rzn1_adc_pm_ops,
> +				 rzn1_adc_pm_runtime_suspend,
> +				 rzn1_adc_pm_runtime_resume, NULL);

Please, split it based on logic:

static DEFINE_RUNTIME_DEV_PM_OPS(rzn1_adc_pm_ops,
				 rzn1_adc_pm_runtime_suspend, rzn1_adc_pm_runtime_resume, NULL);

OR

static DEFINE_RUNTIME_DEV_PM_OPS(rzn1_adc_pm_ops,
				 rzn1_adc_pm_runtime_suspend,
				 rzn1_adc_pm_runtime_resume,
				 NULL);

-- 
With Best Regards,
Andy Shevchenko



