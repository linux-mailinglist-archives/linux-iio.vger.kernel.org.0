Return-Path: <linux-iio+bounces-26146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F1C47FCB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 17:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2BF24EE83C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56138273D8D;
	Mon, 10 Nov 2025 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJJxqtq2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132A24A047;
	Mon, 10 Nov 2025 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792247; cv=none; b=nFTAwkr0MzOdNMWWv8Aw/559O7nhNvUEBX1dByVr9YS/OGXnpdlVmvzqkdLJf7kJ3RlT7+IZ932gURNrHVLE2VO7/3607p29ycSB97oAFzfuxGOvCEg6iKSH/uSwdDmEviUIXiHJPh5ig6c0t8FT9ol6NRR1FeJS14rsqnUd75U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792247; c=relaxed/simple;
	bh=iK8XFCALGc6e4f7zZ9iu7zB1u7W0l9CGAnuy8SPnocM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baexp9MpaJph+MaioHbvdKs+6JtXBk1nWb8eYnIdHyOOjpfl02occliRDcHDGOa8RQ72H7tIy0+4unyAcwmbmlyirpp4aLXVE6aSGt/uOI5TvEwVWXjLIwnB1fUplVvHvgkCBpzD4CLh7oCk69USU5NMqdMOWbvWq251p0W1duA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJJxqtq2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762792245; x=1794328245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iK8XFCALGc6e4f7zZ9iu7zB1u7W0l9CGAnuy8SPnocM=;
  b=SJJxqtq2aMgXfsOkyhJAGolSlw7Z9jVJAyslZvUnniEJe23HF3ZVnEY8
   upC6NeFePMfWjnc8uPrWyRx2URGwJgP477hTSz7drY2h0Krwp+/sSzXlw
   nG6f/DetcYfdRph5CUPETaesXuZxjiFjSzKNCUtq2InqhHv5OxVh+vIUt
   U/1KDbBxZVxxAwHnVVZVbALR9FFqteuoYsv5cehovdccJMsWv4MzBu48x
   JBBI1nMMDHd7ioWsm2jOSFVKUcwGX/RGKCbRyUi+O8YRYPxUu8lzaVIj8
   J+mBtl7ismGgHRFmT5GeUh6NOfmq3l/TJ17RFnU1hnwoZtSnjW0zinq2x
   Q==;
X-CSE-ConnectionGUID: HblRJgNTT2O9Az3+se8UUA==
X-CSE-MsgGUID: CiNx93ZOSQyY4rh4t5K0kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="76295808"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="76295808"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:30:44 -0800
X-CSE-ConnectionGUID: eSpEjy7KRDiex35tTq0k7Q==
X-CSE-MsgGUID: pFUbbmtyStqKLqRsQ5KHXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="189436364"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:30:40 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIUms-00000007Vsw-0rMZ;
	Mon, 10 Nov 2025 18:30:38 +0200
Date: Mon, 10 Nov 2025 18:30:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] iio: frequency: adf41513: driver implementation
Message-ID: <aRITLaJir-2IoclU@smile.fi.intel.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
 <20251110-adf41513-iio-driver-v1-1-2df8be0fdc6e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-adf41513-iio-driver-v1-1-2df8be0fdc6e@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 03:44:44PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> - ADF41513: 1 GHz to 26.5 GHz frequency range
> - ADF41510: 1 GHz to 10 GHz frequency range
> - Integer-N and fractional-N operation modes
> - Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-N)
> - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> - Programmable charge pump currents with 16x range
> - Digital lock detect functionality
> - Phase resync capability for consistent output phase
> - Clock framework integration for system clock generation

It is like a list from the marketing material. Please
1) make sure you are writing the commit message;
2) implement minimum basic functionality and split features to the next
patches, 1.5kLoCs is hard to review.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

At least types.h is missing. Follow IWYU. Have you passed internal review? I
believe we need to start asking Analog Devices to provide a Rb tag of known
developers on the submitted code to make sure it was passed the internal
review.

...

> +/* Specifications */
> +#define ADF41513_MIN_RF_FREQ			1000000000ULL	/* 1 GHz */
> +#define ADF41510_MAX_RF_FREQ			10000000000ULL	/* 10 GHz */
> +#define ADF41513_MAX_RF_FREQ			26500000000ULL	/* 26.5 GHz */

We have HZ_PER_MHZ, also you can move HZ_PER_GHZ to the units.h and use it here.

> +
> +#define ADF41513_MIN_REF_FREQ			10000000U	/* 10 MHz */
> +#define ADF41513_MAX_REF_FREQ			800000000U	/* 800 MHz */
> +#define ADF41513_MAX_REF_FREQ_DOUBLER		225000000U	/* 225 MHz */
> +
> +#define ADF41513_MAX_PFD_FREQ_INT_N_HZ		250000000U		/* 250 MHz */
> +#define ADF41513_MAX_PFD_FREQ_FRAC_N_HZ		125000000U		/* 125 MHz */
> +#define ADF41513_MAX_PFD_FREQ_INT_N_UHZ		250000000000000ULL	/* 250 MHz */
> +#define ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ	125000000000000ULL	/* 125 MHz */

Ditto.

...

> +#define ADF41513_MIN_CP_VOLTAGE_MV		810
> +#define ADF41513_MAX_CP_VOLTAGE_MV		12960

_mV

...

> +#define ADF41513_MAX_LD_BIAS_UA			40
> +#define ADF41513_LD_BIAS_STEP_UA		10

_uA


...

> +#define ADF41513_MAX_MOD2			((1 << 24) - 1)	/* 2^24 - 1 */

Why not BIT()?

...

> +/* Frequency conversion constants */
> +#define ADF41513_HZ_TO_UHZ			1000000ULL	/* Convert Hz to uHz */

Put it to units.h.

...

> +enum {
> +	ADF41513_FREQ,
> +	ADF41513_POWER_DOWN,
> +	ADF41513_FREQ_RESOLUTION,
> +	ADF41513_FREQ_REFIN

Doesn't sound like a terminator to me, add a comma.

> +};
> +
> +enum adf41513_pll_mode {
> +	ADF41513_MODE_INTEGER_N,
> +	ADF41513_MODE_FIXED_MODULUS,
> +	ADF41513_MODE_VARIABLE_MODULUS,
> +	ADF41513_MODE_INVALID

Ditto.

> +};

...

> +struct adf41513_data {

Run `pahole` and act accordingly.

> +	u64 power_up_frequency;
> +
> +	u8 ref_div_factor;
> +	bool ref_doubler_en;
> +	bool ref_div2_en;
> +
> +	u32 charge_pump_voltage_mv;
> +	bool phase_detector_polarity;
> +
> +	u8 muxout_select;
> +	bool muxout_1v8_en;
> +
> +	u8 lock_detect_precision;
> +	u8 lock_detect_count;
> +	u8 lock_detect_bias;
> +	bool fast_lock_en;
> +
> +	u16 phase_resync_clk_div[2];
> +	bool phase_resync_en;
> +	bool load_enable_sync;
> +
> +	u64 freq_resolution_uhz;
> +};
> +
> +struct adf41513_pll_settings {
> +	enum adf41513_pll_mode mode;
> +
> +	u64 target_frequency_uhz;
> +	u64 actual_frequency_uhz;
> +	u64 pfd_frequency_uhz;
> +
> +	/* pll parameters */
> +	u16 int_value;
> +	u32 frac1;
> +	u32 frac2;
> +	u32 mod2;
> +
> +	/* reference path parameters */
> +	u8 r_counter;
> +	u8 ref_doubler;
> +	u8 ref_div2;
> +	u8 prescaler;
> +};

...

> +static const u32 adf41513_cp_voltage_mv[] = {
> +	810, 1620, 2430, 3240, 4050, 4860, 5670, 6480, 7290, 8100,
> +	8910, 9720, 10530, 11340, 12150, 12960

Make it power-of-two items per line, even with the comments to show
the indexing, like

	810, 1620, 2430, 3240, 4050, 4860, 5670, 6480,	/* 0 - 7 */

> +};

...

> +static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)

My gosh, please, try to check what kernel already has. We try hard to avoid Yet
Another Best Parser in the World to happen, really.

...

In any case, I stopped my review here, you have more than enough to fix.
Please, come next time with a tag from one whose name is in the MAINTAINERS.
From now on it will be my requirement as a reviewer of IIO subsystem.

-- 
With Best Regards,
Andy Shevchenko



