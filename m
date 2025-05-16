Return-Path: <linux-iio+bounces-19587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA9AB9900
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 11:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D346D7A5267
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 09:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4850123183F;
	Fri, 16 May 2025 09:34:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7604E2309BD;
	Fri, 16 May 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388088; cv=none; b=bp004soj0sTUmDp8FpPpon34u9Rc8em19eu2FcUPiUvp+LWTH9j4KsJEVqDPbdHE7Y285vbC6yKWLbgR1LuBLfU3Y4LsFsH3gzOp1Pzy0aUjPILjJUCy1VoWReVKy5ms9OcJ9SPCwoVqEMcMAVUQ+NDgxKj2OGM6L3ut3FIL/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388088; c=relaxed/simple;
	bh=LPH3ITaFyNefo+OblDhxJ0ojDQcLwWHzXvs37vIVZp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6V0/LDslEPCWJdVlotQYYCLnfkBVtl39G77emuqaAC/SZPNdj9jzTAb6zfZwBXrZAqHT3MgtVQNBDkKbcQ6HDc9uV9AecX9NdmPM7J/mY7udStLobvIr7h8QGhGYQLfkXbm6/eyeJ1kat1UCdGFogRrS+HusSukeABIFO9Mvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: RA+nlMiRRvi8hhhwuQu69Q==
X-CSE-MsgGUID: +21mhxjdQmWxtSUsd2xg+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="60377799"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="60377799"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:34:45 -0700
X-CSE-ConnectionGUID: fLaAG/btR5SMA2g4YFPH5Q==
X-CSE-MsgGUID: dq6PJxrSRra9fXN6iR/toQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138531481"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:34:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uFrSe-000000026C6-3j2d;
	Fri, 16 May 2025 12:34:36 +0300
Date: Fri, 16 May 2025 12:34:36 +0300
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
Subject: Re: [PATCH v8 10/11] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <aCcGrKEIdvnPRq-w@smile.fi.intel.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aff0f813bb3fee55c5483be860b6885abdb81e5.1747175187.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 06:14:21PM -0300, Jonathan Santos wrote:
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

> +	/*
> +	 * Maximum dec_rate is limited by the MCLK_DIV value and by the ODR.
> +	 * The edge case is for MCLK_DIV = 2, ODR = 50 SPS.
> +	 * max_dec_rate <= MCLK / (2 * 50)
> +	 */
> +	max_dec_rate = st->mclk_freq / 100;
> +	dec_rate = clamp(dec_rate, 32, max_dec_rate);
> +	/*
> +	 * Calculate the equivalent value to sinc3 decimation ratio
> +	 * to be written on the SINC3_DEC_RATE register:
> +	 *  Value = (DEC_RATE / 32) -1

- 1
(mind the space)

> +	 */
> +	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;

...

>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  
> -	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
> +	return st->oversampling_ratio == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
>  		AD7768_SCAN_TYPE_NORMAL;

With the proposed change in the previous patches this change will become
clearer to read, i.e. no-one needs to check if the actual value was changed.

>  }

-- 
With Best Regards,
Andy Shevchenko



