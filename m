Return-Path: <linux-iio+bounces-19348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29BAB03C4
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BE77ABD82
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320828A72C;
	Thu,  8 May 2025 19:39:43 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1722256E;
	Thu,  8 May 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746733182; cv=none; b=T1HLW4sKgOJJYNPy0BRSvZwoYDnpprEKgIYW5sVOkpi8dlJ0Mq6FBH9DXvlF+dJ0o4KhEIdWKJbTthPnMVDw7UqHIZgmtnRKBdD4jYg3poOGMGP8IQfqKoG7dyKQ3I/F/O2Ory7cYFP5ov1xzGiwOHIfkGdEWyI/QIdouo2AnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746733182; c=relaxed/simple;
	bh=hAilNBFFJjfHY8ctZm9ZWAdpUqW4veJAA4tcgJfcKv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4f/QOvWbMXEseimM+coCZNwMmWRVxAHLEsx0d2mi1fL56BLYnprT9IZSir9AClkrTQmjRDSo5x7oBkCNN/vVBiADKxp8dBmhmaKwoCnJ7jkNlyJoEwlaoEBKM1vfOmNVK2RtvNf4n2dox8UDeTjymlOKRIo4s4nFmYJ3rPyGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: j6okXO7BRz+Cfm7u87GUiA==
X-CSE-MsgGUID: XpOIHBKOSQuSNC1DV0v1sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52346031"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="52346031"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:39:39 -0700
X-CSE-ConnectionGUID: KWulWhzJQRmiBZud12T51w==
X-CSE-MsgGUID: vbSx4htURVmghGEyUAS0wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="167470398"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 12:39:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uD75g-00000004DLl-1R5F;
	Thu, 08 May 2025 22:39:32 +0300
Date: Thu, 8 May 2025 22:39:32 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	Pop Paul <paul.pop@analog.com>
Subject: Re: [PATCH v7 11/12] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aB0IdPcjtcGFp6o-@smile.fi.intel.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <2180d8774a2fdef3900f86fbc8f25886503df479.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2180d8774a2fdef3900f86fbc8f25886503df479.1746662899.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 08, 2025 at 02:05:26PM -0300, Jonathan Santos wrote:
> Separate filter type and decimation rate from the sampling frequency
> attribute. The new filter type attribute enables sinc3, sinc3+rej60
> and wideband filters, which were previously unavailable.
> 
> Previously, combining decimation and MCLK divider in the sampling
> frequency obscured performance trade-offs. Lower MCLK divider
> settings increase power usage, while lower decimation rates reduce
> precision by decreasing averaging. By creating an oversampling
> attribute, which controls the decimation, users gain finer control
> over performance.
> 
> The addition of those attributes allows a wider range of sampling
> frequencies and more access to the device features. Sampling frequency
> table is updated after every digital filter parameter change.
> 
> Changes in the sampling frequency are not allowed anymore while in
> buffered mode.

...

>  static void ad7768_fill_samp_freq_tbl(struct ad7768_state *st)
>  {
> -	unsigned int i;
> +	unsigned int i, freq_filtered, len = 0;
> +
> +	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
> +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {

> +		st->samp_freq_avail[len] = DIV_ROUND_CLOSEST(freq_filtered,
> +							     ad7768_mclk_div_rates[i]);

Same comment as per previous patch.

> +		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
> +		if (st->samp_freq_avail[len] >= 50)
> +			len++;

Actually I would rather see the assignment once.

	... samp_freq_avail;

	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
		samp_freq_avail = DIV_ROUND_CLOSEST(freq_filtered, ad7768_mclk_div_rates[i]);
		if (samp_freq_avail < 50)
			continue;

		st->samp_freq_avail[len++] = samp_freq_avail;
	}

> +	}
> +
> +	st->samp_freq_avail_len = len;
> +}

...

> +	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
>  
>  	/* Find the closest match for the desired sampling frequency */
> +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> +		diff_new = abs(res - ad7768_mclk_div_rates[i]);
>  		if (diff_new < diff_old) {
>  			diff_old = diff_new;
>  			idx = i;
>  		}
>  	}

Hmm... Wasn't the point to include util_macros.h to replace the above?

-- 
With Best Regards,
Andy Shevchenko



