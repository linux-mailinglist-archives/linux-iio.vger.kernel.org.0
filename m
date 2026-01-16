Return-Path: <linux-iio+bounces-27864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0BD3343E
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D12930DC232
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAD21ABB9;
	Fri, 16 Jan 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfnztrdS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAA32AAA2;
	Fri, 16 Jan 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577770; cv=none; b=POEeQuHGP8zEDrnMJUyInx6MsftJvWwDckemwDFwgEywphALEYmBLaahooO+bGKX9U37awkwNaMNWs77zdarxiIpgpnXLoODzM9vCm/OqpvlRfaGKIXg+TMnn4bBlAHs41/4xFNBSbD10TbzwE8L4zWU5QGWUGfO7oRNJS0w/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577770; c=relaxed/simple;
	bh=GJwdW800GznqW1CUb1bMuwCBh1lbTvD+02usxtCCeF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhbMe4WWeLKw8qHJPGHRlb6p7oNQ7KPWn7lagTFeVFG/i8Asu/KDz40WiI5mBdecWGt+WnCAKGtc84de0PSZ/YbxRzFChLFokQffLW47WimUL+5OYSWMgU+Ghu5xiY4IDysqEaWXLpQXunG/j31Ck9YnZjINjNoKtE7/fviIDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfnztrdS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768577769; x=1800113769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GJwdW800GznqW1CUb1bMuwCBh1lbTvD+02usxtCCeF8=;
  b=LfnztrdSEtn0AaeG5MhsF/VMvTl784dnvGr3T9+Pfwpgqp72drvThr1x
   SoAhOj15ArCPd/t2qL1aGbcnvRClG+Eu58LYanDZFUwmmKT+xUvPtNQLe
   JnxVbWVDl6M9YCyhgzjQFnbzMUcgbAzUFGlIvXjwPJNcRQIf3JZM6xdWV
   16wdXLx3LTlCwiQxjcGnQQZEBN/Do+WmO+FxqNwgX7tug86gFKgmIC6ey
   kdshmRTrAnjQ/tstIXFHr50wXi3vM/S4mDzVgwsl4xJ7fh4KqwqLt3Qbl
   P0riEf0R68KlA+aoLTD/iB2j2/uJEBHv/VjOp8PtdAcvKKnYl88Agb1Gs
   w==;
X-CSE-ConnectionGUID: Xp4qSWq9SvGBxZ0HjJsaZg==
X-CSE-MsgGUID: V6tDDQlDRP+hbGhMUw5x8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69094578"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="69094578"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:36:08 -0800
X-CSE-ConnectionGUID: cmP8qWClS2SXzZEAZ2tDJA==
X-CSE-MsgGUID: q+gQDhUuS1u0U19Of09mjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="242809246"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 07:36:05 -0800
Date: Fri, 16 Jan 2026 17:36:01 +0200
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
Subject: Re: [PATCH v4 5/7] iio: frequency: adf41513: features on frequency
 change
Message-ID: <aWpa4XbFVsz9qQ9U@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-5-dbb7d6782217@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116-adf41513-iio-driver-v4-5-dbb7d6782217@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 16, 2026 at 02:32:24PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Set Bleed current when PFD frequency changes (bleed enabled when in
> fractional mode). Set lock detector window size, handling bias and
> precision. Add phase resync support, setting clock dividers when
> PFD frequency changes.

...

> +static void adf41513_set_bleed_val(struct adf41513_state *st)
> +{
> +	u32 bleed_value;
> +
> +	if (st->data.phase_detector_polarity)
> +		bleed_value = 90;
> +	else
> +		bleed_value = 144;
> +
> +	bleed_value *= 1 + FIELD_GET(ADF41513_REG5_CP_CURRENT_MSK,
> +				     st->regs[ADF41513_REG5]);

I think it's better to have yet another temporary variable for this multiplier...

> +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,

...and here three operands instead.

	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * curr * bleed_value,

> +				1600ULL * MEGA * MICROHZ_PER_HZ);
> +
> +	FIELD_MODIFY(ADF41513_REG6_BLEED_CURRENT_MSK, &st->regs[ADF41513_REG6],
> +		     bleed_value);
> +}
> +
> +static void adf41513_set_ld_window(struct adf41513_state *st)
> +{
> +	/*
> +	 * The ideal lock detector window size is halfway between the max
> +	 * window, set by the phase comparison period t_PFD = (1 / f_PFD),
> +	 * and the minimum is set by (I_BLEED/I_CP) × t_PFD
> +	 */
> +	u16 ld_window_10x_ns = div64_u64(10ULL * NSEC_PER_SEC * MICROHZ_PER_HZ,
> +					 st->settings.pfd_frequency_uhz << 1);

Okay, if we go this direction...

> +	u8 ld_idx, ldp, ld_bias;
> +
> +	if (st->settings.mode != ADF41513_MODE_INTEGER_N) {
> +		/* account for bleed current (deduced from eq.6 and eq.7) */
> +		if (st->data.phase_detector_polarity)
> +			ld_window_10x_ns += 4;
> +		else
> +			ld_window_10x_ns += 6;
> +	}
> +
> +	ld_idx = find_closest(ld_window_10x_ns, adf41513_ld_window_x10_ns,
> +			      ARRAY_SIZE(adf41513_ld_window_x10_ns));
> +	ldp = (adf41513_ldp_bias[ld_idx] >> 2) & 0x3;
> +	ld_bias = adf41513_ldp_bias[ld_idx] & 0x3;
> +
> +	FIELD_MODIFY(ADF41513_REG6_LDP_MSK, &st->regs[ADF41513_REG6], ldp);
> +	FIELD_MODIFY(ADF41513_REG9_LD_BIAS_MSK, &st->regs[ADF41513_REG9], ld_bias);
> +}
> +
> +static void adf41513_set_phase_resync(struct adf41513_state *st)
> +{
> +	u32 total_div, clk1_div, clk2_div;
> +
> +	if (!st->data.phase_resync_period_ns)
> +		return;
> +
> +	/* assuming both clock dividers hold similar values */
> +	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
> +					st->data.phase_resync_period_ns,
> +					1ULL * MICRO * NANO);

...for the consistency we may also use the same approach here

					1ULL * MICROHZ_PER_HZ * NSEC_PER_SEC);

At least it will be consistent with the annihilated units.

> +	clk1_div = clamp(int_sqrt(total_div), 1,
> +			 ADF41513_MAX_CLK_DIVIDER);
> +	clk2_div = clamp(DIV_ROUND_CLOSEST(total_div, clk1_div), 1,
> +			 ADF41513_MAX_CLK_DIVIDER);
> +
> +	FIELD_MODIFY(ADF41513_REG5_CLK1_DIV_MSK, &st->regs[ADF41513_REG5],
> +		     clk1_div);
> +	FIELD_MODIFY(ADF41513_REG7_CLK2_DIV_MSK, &st->regs[ADF41513_REG7],
> +		     clk2_div);
> +
> +	/* enable phase resync */
> +	st->regs[ADF41513_REG7] |= ADF41513_REG7_CLK_DIV_MODE_MSK;
> +}

-- 
With Best Regards,
Andy Shevchenko



