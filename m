Return-Path: <linux-iio+bounces-20591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE8AD8C6F
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110A37AED81
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA2DDD3;
	Fri, 13 Jun 2025 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXDWy6K5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A0125B9;
	Fri, 13 Jun 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818859; cv=none; b=RkK1uSObYIcQjTC2m4ZQlpHj31eFqt/v+HnE4MZcnJDx4n/TWqbSM8mOjNqza6OseAoWNnCU/LolMr5HPyR0pVnwhdsQV4QSquNNfBH37FB1QViSaKur9Ac3dUfQPUudAd7AAM+E/D6Ib+91NaEYAttqD8SmhNE60MeZ5kk7HzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818859; c=relaxed/simple;
	bh=5mk3F0ocPUMcuaVsmdoVLDWViyRIeQim/i1Xpz+fTFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsiNZGEePnRSNZM9hmD9mjE1zpVg1bH6do8DLsAl8IbNlE/vG39cKGzMon6K2JKcRKNvpwCf7CFTxkxo/KnGVxX4Z2sqnCvq8ShBi/8v2ys7D4KA/yOUNqIQ2me7FH91y0kd/s+hGoTC/0CBSnHvGeOFCoLq0MdjwZQiq1Qw9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXDWy6K5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749818858; x=1781354858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5mk3F0ocPUMcuaVsmdoVLDWViyRIeQim/i1Xpz+fTFE=;
  b=gXDWy6K5S/leQU6FAT053Xhl/g4IKrgl9o4aLyKv6v49KsTR8uVIJ/HY
   jL+UHydzuObgivAlLn10ROMf4oOEWAIqGmaMkSubbLiUjxdIFkts7Obw+
   bZ4kOem5sRq98FkGAfruyaSf3ZDkbL9ItRYdS6b30d5zYFTuXgTo3cTtK
   WyrWgf5EqWEGEMB1RxQbVAniCDbEflJkyjBz291n+9HJ1S7hdzHKDV6qt
   sJaFCu6XWQudmVGbygaickIn7Ke97NYC9QKF6cAXfrIc2RCMlssy+vJSR
   jS2wIhl6G/e1/e+ubeFihzTumpj/y80ckts4LEN8eSH0a30hTRE9lLyTt
   w==;
X-CSE-ConnectionGUID: A61/o5loQBeivdkPV59+dA==
X-CSE-MsgGUID: PbD5Ye+0S9S0jJDt2n1xcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="63386316"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="63386316"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:47:37 -0700
X-CSE-ConnectionGUID: USdByUw8THa5lIoi+6/lmA==
X-CSE-MsgGUID: +jwK5CYjQaqwZEctRuWepQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="147721964"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 05:47:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uQ3of-00000006FO3-3SxN;
	Fri, 13 Jun 2025 15:47:29 +0300
Date: Fri, 13 Jun 2025 15:47:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v11 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff
 attribute
Message-ID: <aEwd4cS7j0Vvypg8@smile.fi.intel.com>
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
 <804d66f1858014d7278aec3344d81c223661e878.1749569957.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804d66f1858014d7278aec3344d81c223661e878.1749569957.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 08:52:03AM -0300, Jonathan Santos wrote:
> Ad7768-1 has a different -3db frequency multiplier depending on
> the filter type configured. The cutoff frequency also varies according
> to the current ODR.
> 
> Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> the user which bandwidth is being allowed depending on the filter
> configurations.

> +/* -3dB cutoff frequency multipliers (relative to ODR) for each filter type. */
> +static const int ad7768_filter_3db_odr_multiplier[] = {
> +	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */
> +	[AD7768_FILTER_SINC3] = 262,		/* 0.2617 */
> +	[AD7768_FILTER_SINC3_REJ60] = 262,	/* 0.2617 */
> +	[AD7768_FILTER_WIDEBAND] = 433,		/* 0.433 */

Just to be sure, is it 0.433 or 0.4333(3) actually? Sometimes datasheets have
rounding that even may lead to problems (see TSC issues for some of the Intel
CPUs in the past). That's behind my question.

> +};

...

> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		temp = st->samp_freq * ad7768_filter_3db_odr_multiplier[st->filter_type];
> +		*val = DIV_ROUND_CLOSEST(temp, 1000);

MILLI? KILO/ MICRO/MILLI? ...?

-- 
With Best Regards,
Andy Shevchenko



