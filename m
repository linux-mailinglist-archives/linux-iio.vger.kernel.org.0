Return-Path: <linux-iio+bounces-25248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA1BED5A7
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 19:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C6B19A81CB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5522609FC;
	Sat, 18 Oct 2025 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GaooJ1gX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE189260565;
	Sat, 18 Oct 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808902; cv=none; b=iLTIJ3h7+4AXmzYL4/66i8s5N1zazV8HEUFLYfVEv0rIiiFOdGI8DWnWlw6e5v6H6gEIPvxDao4xZ42tGEeIPs9UxWE4pA9wI53ThLjUaV20l2vtc1Vgwr2jhYRtYlBZ5UOu5NZILypt/nKZGsaiGyl+lJJtzossxdoeadijvkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808902; c=relaxed/simple;
	bh=D7mV+zmZC3wuEle8DQN1MruwEgQyGxFbqz4chTTNZik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmknxdaN4lkuQLEQZoXUHgboBCHfW3ll+Q9B6Z2s8IywKxZW0U1no55beg/H9+1RbTUhzYka9K4DPS7C9IInPkZyRt7fUS48o9JLvUzV1QGQ5KOBbP6xGm6bdKMTcr1PO2HWPHjX+DaEIa73CswwTZc6vGsUfjaqhieQ4/nr5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GaooJ1gX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760808901; x=1792344901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D7mV+zmZC3wuEle8DQN1MruwEgQyGxFbqz4chTTNZik=;
  b=GaooJ1gX5J+0pXFXiyhYccSbH6ifcJQyYRNz/K+JIfaBHVE6zWP4CMmS
   A7C47mZUFcrVFIQAqiRPK8IS+2DOPEVU88woVh3DmuJz82fRgi8aHzvKi
   8Wx9XrbRU/oXw+S6tbQg1VDojnQGhQbpQ7y2gTknJ9hrapULrtRndAqlo
   jesiB9ZxuigNvCbVsliegDH6wm95kUH3ALI8Ia3hP20b77ecUkippcz5B
   Nu4ZrEho9uIXwD1blQ27r/fGAEQ/LVT1ogfStOqLj5abPtMCjg8KFyj3n
   icPeHIybVLkS9r2+ChXY4aywnDRhtoaoZ8d3/2rIeHDTJzmqTgsv1MN+y
   A==;
X-CSE-ConnectionGUID: mNJ2vFINRTyELCmGMq1BcA==
X-CSE-MsgGUID: nhs3n0w0Qy66SF9secjGzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74111578"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="74111578"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:35:01 -0700
X-CSE-ConnectionGUID: mH2URQepScuZi8/AaOBoHQ==
X-CSE-MsgGUID: Sn7M7bSoT6uEMXS8NfKTLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="186994482"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.194])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 10:34:57 -0700
Received: from andy by ashevche-desk with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1v91zO-00000000KbG-3l2U;
	Wed, 15 Oct 2025 16:56:26 +0300
Date: Wed, 15 Oct 2025 16:56:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 7/7] iio: adc: ad4030: Add support for ADAQ4216 and
 ADAQ4224
Message-ID: <aO-oCoCLNY7fPQEB@smile.fi.intel.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <95db7ffb928f4707c2e68a906a35b826c6a1d29b.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95db7ffb928f4707c2e68a906a35b826c6a1d29b.1760479760.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 14, 2025 at 07:22:51PM -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030, but feature a PGA circuitry
> that scales the analog input signal prior to it reaching the ADC. The PGA
> is controlled through a pair of pins (A0 and A1) whose state define the
> gain that is applied to the input signal.
> 
> Add support for ADAQ4216 and ADAQ4224. Provide a list of PGA options
> through the IIO device channel scale available interface and enable control
> of the PGA through the channel scale interface.

...

> +/*
> + * Gains computed as fractions of 1000 so they can be expressed by integers.
> + */
> +static const int adaq4216_hw_gains_vpv[] = {
> +	MILLI / 3,		/* 333 */
> +	(5 * MILLI / 9),	/* 555 */
> +	(20 * MILLI / 9),	/* 2222 */
> +	(20 * MILLI / 3),	/* 6666 */

Redundant parentheses, or do you mean to make multiplication first?
E.g., (5 * MILL) / 9 ?

> +};

...

> +static void ad4030_fill_scale_avail(struct ad4030_state *st)
> +{
> +	unsigned int mag_bits, int_part, fract_part, i;
> +	u64 range;
> +
> +	/*
> +	 * The maximum precision of differential channels is retrieved from the
> +	 * chip properties. The output code of differential channels is in two's
> +	 * complement format (i.e. signed), so the MSB is the sign bit and only
> +	 * (precision_bits - 1) bits express voltage magnitude.
> +	 */
> +	mag_bits = st->chip->precision_bits - 1;
> +
> +	for (i = 0; i < ARRAY_SIZE(adaq4216_hw_gains_frac); i++) {
> +		range = mult_frac(st->vref_uv, adaq4216_hw_gains_frac[i][1],
> +				  adaq4216_hw_gains_frac[i][0]);
> +		/*
> +		 * If range were in mV, we would multiply it by NANO below.
> +		 * Though, range is in µV so multiply it by MICRO only so the
> +		 * result after right shift and division scales output codes to
> +		 * millivolts.
> +		 */
> +		int_part = div_u64_rem(((u64)range * MICRO) >> mag_bits, NANO, &fract_part);

The "range" is of type u64. Any specific reason why cast?

> +		st->scale_avail[i][0] = int_part;
> +		st->scale_avail[i][1] = fract_part;
> +	}
> +}

...

> +static int ad4030_setup_pga(struct device *dev, struct iio_dev *indio_dev,
> +			    struct ad4030_state *st)
> +{
> +	/* Setup GPIOs for PGA control */
> +	st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pga_gpios))
> +		return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +				     "Failed to get PGA gpios.\n");
> +
> +	if (st->pga_gpios->ndescs != ADAQ4616_PGA_PINS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Expected 2 GPIOs for PGA control.\n");

2 --> %d and constant or __stringify(MY_COOL_CONSTANT). However, I am not sure
if the latter is acceptable in IIO.

> +
> +	st->scale_avail_size = ARRAY_SIZE(adaq4216_hw_gains_vpv);
> +	st->pga_index = 0;
> +
> +	return 0;
> +}


-- 
With Best Regards,
Andy Shevchenko



