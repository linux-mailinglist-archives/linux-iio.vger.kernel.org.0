Return-Path: <linux-iio+bounces-27960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A8D3AA93
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 227793065DD4
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F4736BCD6;
	Mon, 19 Jan 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoIHZxjH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6C36921C;
	Mon, 19 Jan 2026 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830163; cv=none; b=VFXcM1p1y3zmcQ3PGB5U++TU9y1jgeWmw7KxrdSqbIctVkcv2zOueXWzm96BTI3eFJY4YH2sKjhviWH78G/tYdv1KABT3ch/87S+YoNi+NnAmCvEIbPKO2JvVH/tIfLjxR4eroGuJOOeea9BZ60CZTd6Aqxx1P3v8zz+GZGbYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830163; c=relaxed/simple;
	bh=V4mQ3VlRjiqoBXAOdadem2FcWXV+zUSy7/OHRaRfC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTQBkv9P/uA9OHx3EzIgWzA6GsMzjMSg3Y5ZFjbglBclsND9LVQvSBnZuUhCbWt19db5x3g8jxYsJw+e6iCIK/6EVxbA66SL86G4wWmdpA9Zpi6jjTTjNlblq5hZd/ynq8bCUgBXoedDfRrDN9TLg71yQZUaTQx6aW73Ylwp7LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoIHZxjH; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768830161; x=1800366161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V4mQ3VlRjiqoBXAOdadem2FcWXV+zUSy7/OHRaRfC0k=;
  b=JoIHZxjHhKPFm+wxd23OaaW7eYSNqDqpa7jpZTKw59I+vVR4TcAxluxk
   3qiDXGURiheufRb/iuKTy5/OXqDK3n7u+Gd6xJ928HNlwLPpvxKeB7rxv
   23kePmvX4jAPqUdnKcb2GtVCaVTwsmtCLb1VuAhirln6rFfLKuYnsU8uq
   TOBK5ZmZP+9U9ggovyYL8XGFg0HVsco2GmhjMf7BhLJ/fRvyj+1iXAEAc
   ru0wAa8YPyyjvW3Y6IdOfdLrIM8kGD3ZvAasd4LQOxbiwNwTQs/PXCkKB
   TItwk/LbcUcxTx83i3FE1ASikfSA/6vPr6UqtYR9QFeGFpjLnT5V97CZK
   Q==;
X-CSE-ConnectionGUID: OaK5iY4HSCeHAZcsjTN14A==
X-CSE-MsgGUID: QJV8zTFkQA+xpy5kmaRxkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73669714"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="73669714"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 05:42:40 -0800
X-CSE-ConnectionGUID: MJrvk+3oSqiJnsTZfpnklA==
X-CSE-MsgGUID: ytX4QqSJQNu+cjSfQBWJPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="210372271"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 05:42:36 -0800
Date: Mon, 19 Jan 2026 15:42:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <aW40ylvMwVhqNQMw@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
 <aW3dxuelYDM67pqZ@smile.fi.intel.com>
 <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alencar wrote:
> On 26/01/19 09:31AM, Andy Shevchenko wrote:
> > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > +struct adf41513_pll_settings {
> > > +	enum adf41513_pll_mode mode;
> > 
> > Sounds to me like a room to improve the layout here,
> 
> I am targeting a 32-bit cpu, just moved in_value down:
> would this be fine? (pahole output):

Likely.

> struct adf41513_pll_settings {
>         enum adf41513_pll_mode     mode;                 /*     0     4 */

Wondering if this can be shorter if moved down...

>         u8                         r_counter;            /*     4     1 */
>         u8                         ref_doubler;          /*     5     1 */
>         u8                         ref_div2;             /*     6     1 */
>         u8                         prescaler;            /*     7     1 */
>         u64                        target_frequency_uhz; /*     8     8 */
>         u64                        actual_frequency_uhz; /*    16     8 */
>         u64                        pfd_frequency_uhz;    /*    24     8 */
>         u32                        frac1;                /*    32     4 */
>         u32                        frac2;                /*    36     4 */
>         u32                        mod2;                 /*    40     4 */
>         u16                        int_value;            /*    44     2 */
> 
>         /* size: 48, cachelines: 1, members: 12 */
>         /* padding: 2 */
>         /* last cacheline: 48 bytes */
> };

...at least I have had in mind that "mode" should be moved to be near
to "int_value". But I think it will take 4 bytes still as we don't use
short enums compile wise.

> > > +	/* reference path parameters */
> > > +	u8 r_counter;
> > > +	u8 ref_doubler;
> > > +	u8 ref_div2;
> > > +	u8 prescaler;
> > > +
> > > +	/* frequency parameters */
> > > +	u64 target_frequency_uhz;
> > > +	u64 actual_frequency_uhz;
> > > +	u64 pfd_frequency_uhz;
> > > +
> > > +	/* pll parameters */
> > > +	u16 int_value;
> > > +	u32 frac1;
> > > +	u32 frac2;
> > > +	u32 mod2;
> > > +};

...

> > > +static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)
> > > +{
> > > +	u64 uhz = 0;
> > > +	int f_count = ADF41513_HZ_DECIMAL_PRECISION;
> > > +	bool frac_part = false;
> > > +
> > > +	if (str[0] == '+')
> > > +		str++;
> > > +
> > > +	while (*str && f_count > 0) {
> > > +		if ('0' <= *str && *str <= '9') {
> > > +			uhz = uhz * 10 + *str - '0';
> > > +			if (frac_part)
> > > +				f_count--;
> > > +		} else if (*str == '\n') {
> > > +			if (*(str + 1) == '\0')
> > > +				break;
> > > +			return -EINVAL;
> > 
> > > +		} else if (*str == '.' && !frac_part) {
> > 
> > This can be found by strchr() / strrchr() (depending on the expectations of
> > the input).
> > 
> > > +			frac_part = true;
> > > +		} else {
> > > +			return -EINVAL;
> > > +		}
> > > +		str++;
> > > +	}
> > 
> > With the above the rest becomes just a couple of simple_strtoull() calls with
> > a couple of int_pow(10) calls (and some validation on top).
> > 
> > > +	for (; f_count > 0; f_count--)
> > > +		uhz *= 10;
> > 
> > This is int_pow(10).
> > 
> > > +	*freq_uhz = uhz;
> > > +
> > > +	return 0;
> > > +}
> 
> The current implementation is kind of a stripped version of
> __iio_str_to_fixpoint(). Would you prefer something like this, then?:

Do they have most of the parts in common? If so, why can't we use
__iio_str_to_fixpoint() directly? Or why can't we slightly refactor
that to give us the results we need here?

> static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)
> {
> 	u64 integer_part = 0, fractional_part = 0;
> 	const char *decimal_point;
> 	char *endptr;
> 	int frac_digits;
> 
> 	if (str[0] == '+')
> 	str++;
> 
> 	/* Find decimal point */
> 	decimal_point = strchr(str, '.');
> 	if (decimal_point) {

> 		/* Parse integer part (if exists before decimal point) */
> 		if (decimal_point > str) {

I don't think you need this check, simple_strtoull() should return 0.

Also check the ranges, perhaps you want in some cases simple_strtoul().

> 			integer_part = simple_strtoull(str, &endptr, 10);
> 			if (endptr != decimal_point)
> 				return -EINVAL;
> 		}
> 
> 		/* Parse fractional part */
> 		fractional_part = simple_strtoull(decimal_point + 1, &endptr, 10);

The idea of using the simple strtoull() (second "l") is to check for overflows,
so if the number is > UINT_MAX we probably should return -ERANGE.

We have somewhere already such a code in the kernel, maybe it's a time to have
advanced version of simple_strtouint().

drivers/crypto/intel/qat/qat_common/qat_uclo.c:206:     ae = simple_strtoull(str, &end, 10);
drivers/crypto/intel/qat/qat_common/qat_uclo.c-207-     if (ae > UINT_MAX || str == end || (end - str) > 19)
drivers/crypto/intel/qat/qat_common/qat_uclo.c-208-             return -EINVAL;

> 		if (*endptr != '\0' && *endptr != '\n')
> 			return -EINVAL;
> 
> 		/* Adjust for desired precision */

> 		frac_digits = strcspn(decimal_point + 1, "\n");

This is already precalculated: endptr - decimal_point (+ 1 ?).

> 		if (frac_digits > ADF41513_HZ_DECIMAL_PRECISION)
> 			fractional_part /= int_pow(10, frac_digits - ADF41513_HZ_DECIMAL_PRECISION);
> 		else
> 			fractional_part *= int_pow(10, ADF41513_HZ_DECIMAL_PRECISION - frac_digits);
> 	} else {
> 		/* No decimal point - just parse the integer */
> 		ret = kstrtoull(str, 10, &integer_part);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	/* Combine integer and fractional parts */
> 	*freq_uhz = integer_part * int_pow(10, ADF41513_HZ_DECIMAL_PRECISION) + fractional_part;
> 
> 	return 0;
> }

...

> > > +static int adf41513_uhz_to_str(u64 freq_uhz, char *buf)
> > > +{
> > > +	u32 frac_part;
> > > +	u64 int_part = div_u64_rem(freq_uhz, MICRO, &frac_part);
> > 
> > Perhaps MICROHZ_PER_HZ? This will be consistent with the int_value in
> > _calc_*() below.
> 
> Here, the meaning is different. int_part is in Hz and frac_part in uHz.
> Will add the suffixes to the variables.

Yes, but here it's a constant divisor, and not a multiplier.
Meaning that one divides µHz by µHz.

> > > +	return sysfs_emit(buf, "%llu.%06u\n", int_part, frac_part);
> > > +}

-- 
With Best Regards,
Andy Shevchenko



