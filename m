Return-Path: <linux-iio+bounces-23794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC686B45FFC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 19:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD455C8671
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F503191BE;
	Fri,  5 Sep 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwJJYTS8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A643191AB;
	Fri,  5 Sep 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093022; cv=none; b=O36Mphux3zvUylhPfDX4sT6Gz+Un3epzwQUDtytrF/K+FAtJ++JbU+BOsqk7i7/kNS9hhrYABUb6eSTeg1ivspoOeaKr7WNk56Nce8ud5Z7zka6SOCDJBkNpsrYpkn1+oGAGd+POU9dfcMSQRflKetCE5b3k4plyGIcTeuj68js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093022; c=relaxed/simple;
	bh=4ZcCkaiQQPavITJO9m5ynY8fi9Nvdi0aWphpBntRLl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xmp1JcgjXFSWLa/opQ91joLq5KOMlgy7oC4Rd2nB/TojRxQoPBkVC6lEhHwiDT7ooDhgByaMhTqfLMFMNWOU1ShHYiURPYDSCgghgf/4aj+wAopcRCgKijKdZPtIrL9vOmKI0Yiyaim553glEsJ5GP/P4BKsJdYOezdujHbfEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwJJYTS8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757093021; x=1788629021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZcCkaiQQPavITJO9m5ynY8fi9Nvdi0aWphpBntRLl0=;
  b=hwJJYTS8doi2yCUpxq0eWUGsgvfnLtrp+EY2dSx0PQec8PaAoAxgodbf
   Uu0tQtTgB1psH0EY+/vgIr49cH2h/pVKRwK2zWwloIjsgxHcjDCYX3aG0
   O1fkmLFUMmwEhfbqpLjkLz+CYCBltmpFc3khVez0CNaZlYWDmc80pM6zY
   7ol3o+xfa5nzH7cMqZx8sSFT4z5cxQ7RWnqMqlBWN/gTuT4ZqDyqfTx+b
   CDM0aaFnpJ/HRshnLf3ROs9+q3b3O7+0IVbhDO3OiktkXMcyvkHbKnrWV
   eHMJ8cm3DzvqlpuOqVJc9oyhhN9vds9rpak6AJpFnm0mwq9/zrsfW62c5
   g==;
X-CSE-ConnectionGUID: y2Dn/hmhQ2SjJVysoKjflg==
X-CSE-MsgGUID: WEnrPWfzTLyTsyuMqXJcUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59400882"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59400882"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 10:23:40 -0700
X-CSE-ConnectionGUID: LNp+1ToGSgWwq9+rscWsiQ==
X-CSE-MsgGUID: IxKrcvBNT5KwSn+VpzxAyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="203023491"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 10:23:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uua9t-0000000Bg21-1f5R;
	Fri, 05 Sep 2025 20:23:33 +0300
Date: Fri, 5 Sep 2025 20:23:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Subject: Re: [PATCH v3 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1
 ADC Family
Message-ID: <aLsclc2WHsbR1jfa@smile.fi.intel.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6228c10d731b6946a68e1c3c95643065cc81329a.1757001160.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 05, 2025 at 06:49:42AM -0300, Jonathan Santos wrote:
> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains. Unlike the AD7768-1, they do not
> provide a VCM regulator interface.
> 
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. PGA is enabled and controlled by the GPIO
> controller (GPIOs 0, 1 and 2) provided by the device with the SPI
> interface.
> 
> The AAF gain is defined by hardware connections and should be specified
> in the device tree.

...

> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +	struct ad7768_state *st = iio_priv(dev);
> +	const struct iio_scan_type *scan_type;
> +	int val, val2, tmp0, tmp1, i;
> +	struct u64_fract fract;
> +	unsigned long n, d;
> +	u64 tmp2;
> +
> +	scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);

Is it usual patter in IIO? Otherwise it can be written as

	scan_type = iio_get_current_scan_type(dev, dev->channels);

> +	if (scan_type->sign == 's')
> +		val2 = scan_type->realbits - 1;
> +	else
> +		val2 = scan_type->realbits;

Wasn't smatch happy about this check?

> +	for (i = 0; i < st->chip->num_pga_modes; i++) {
> +		/* Convert gain to a fraction format */
> +		fract.numerator = st->chip->pga_gains[i];
> +		fract.denominator = MILLI;
> +		if (st->chip->has_variable_aaf) {
> +			fract.numerator *= ad7768_aaf_gains_bp[st->aaf_gain];
> +			fract.denominator *= 10000;
> +		}

My question also was: Are these overflow u32? If not, the second patch is not
needed. Otherwise, how is the previous version supposed to work with unsigned
long type (if I am not mistaken) on 32-bit platforms?

> +		rational_best_approximation(fract.numerator, fract.denominator,
> +					    INT_MAX, INT_MAX, &n, &d);
> +
> +		val = mult_frac(st->vref_uv, d, n);
> +		/* Would multiply by NANO here, but value is already in milli */
> +		tmp2 = shift_right((u64)val * MICRO, val2);
> +		tmp0 = div_u64_rem(tmp2, NANO, &tmp1);
> +		st->scale_tbl[i][0] = tmp0; /* Integer part */
> +		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
> +	}
> +}

...

> +static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
> +				int gain_fract, int precision)
> +{
> +	u64 gain_nano;
> +	u32 tmp;
> +
> +	gain_nano = gain_int * NANO + gain_fract;
> +	gain_nano = clamp(gain_nano, 0, ADAQ776X_GAIN_MAX_NANO);
> +	tmp = DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
> +	gain_nano = DIV_ROUND_CLOSEST(st->vref_uv, tmp);
> +	if (st->chip->has_variable_aaf)
> +		gain_nano = DIV_ROUND_CLOSEST_ULL(gain_nano *  10000,

One space too many.

> +						  ad7768_aaf_gains_bp[st->aaf_gain]);
> +
> +	return find_closest(gain_nano, st->chip->pga_gains,
> +			    (int)st->chip->num_pga_modes);

Is casting needed?

> +}

...

> +	case IIO_CHAN_INFO_SCALE:  {

One space too many.

> +		int gain_mode;
> +
> +		if (!st->chip->has_pga)
> +			return -EOPNOTSUPP;
> +
> +		if (scan_type->sign == 's')
> +			gain_mode = ad7768_calc_pga_gain(st, val, val2,
> +							 scan_type->realbits - 1);
> +		else
> +			gain_mode = ad7768_calc_pga_gain(st, val, val2,
> +							 scan_type->realbits);
> +
> +		return ad7768_set_pga_gain(st, gain_mode);
> +	}

...

> +static int ad7768_parse_aaf_gain(struct device *dev, struct ad7768_state *st)
> +{
> +	bool aaf_gain_provided;
> +	u32 val;
> +	int ret;

> +	st->aaf_gain = AD7768_AAF_IN1;

> +	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
> +	aaf_gain_provided = (ret == 0);

Hmm... It seems rather incorrect check. You should actually return an error
code in case it's provided but can't be read.

I would expect something like

	ret = device_property_read_u32(dev, "adi,aaf-gain-bp", &val);
	if (ret == -EINVAL)
		_gain_provided = false;
	else if (ret)
		return dev_err_probe(...);
	else
		_gain_provided = true;

> +	if (!aaf_gain_provided && st->chip->has_variable_aaf) {
> +		dev_warn(dev, "AAF gain not specified, using default\n");
> +		return 0;
> +	}
> +
> +	if (aaf_gain_provided && !st->chip->has_variable_aaf) {
> +		dev_warn(dev, "AAF gain not supported for %s\n", st->chip->name);
> +		return 0;
> +	}

We can refactor these to have one level indentation less for the switch-case.

	if (aaf_gain_provided && !st->chip->has_variable_aaf) {
		dev_warn(dev, "AAF gain not supported for %s\n", st->chip->name);
		return 0;
	}

	if (!aaf_gain_provided) {
		if (st->chip->has_variable_aaf)
			dev_warn(dev, "AAF gain not specified, using default\n");
		return 0;
	}

> +	if (aaf_gain_provided) {

So this one may be dropped.

> +		switch (val) {
> +		case 10000:
> +			st->aaf_gain = AD7768_AAF_IN1;
> +			break;
> +		case 3640:
> +			st->aaf_gain = AD7768_AAF_IN2;
> +			break;
> +		case 1430:
> +			st->aaf_gain = AD7768_AAF_IN3;
> +			break;
> +		default:
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid firmware provided AAF gain\n");
> +		}
> +	}
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



