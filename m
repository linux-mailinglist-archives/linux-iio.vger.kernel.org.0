Return-Path: <linux-iio+bounces-28003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F95D3B6A8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BC8E3010650
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390EE38BDA7;
	Mon, 19 Jan 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L32wixaP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F297938E131;
	Mon, 19 Jan 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849435; cv=none; b=RTy6HvjuBmFaebK3t1xOMWxe4cbbIayixNe4ahiW5BUvwt+TBY+NARRiIuWhZ7a9nIL0V98MMNEb7kdnO2kxIvP8scCHK4iPQfqQyWLJaIBAVokX2oC5MAIxCSCLA9xhfqaZBOrYM8L7uIChgZ4ZOkHIbqow3gVIvFfZGmz7xfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849435; c=relaxed/simple;
	bh=4yz3B/tXTSGwq4EUu6T9yN/gjOCgR+W+WDGk6tiURU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fChyLmiKwW2udvCIg1+Oz9HAGgFjVrVKogqJ8LWmdpO7j1RyiFgd8Gramri7Q5abCbkcomuEGKgPE8jQp7NQsLPlgv+2TzgQjDliqPKF9rJzkGsfWOIve9IZLPCmq3QioQIA/Fgj7liMCgX+3LPF57C/nwrAAYsyf1B2l4swTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L32wixaP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768849433; x=1800385433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yz3B/tXTSGwq4EUu6T9yN/gjOCgR+W+WDGk6tiURU0=;
  b=L32wixaPkqAVkJIOKCSJbmEMCyOZNujLB3g3x3Ur3WqRvQa8wcpix14D
   DstIONBWXyijBiQZad6HyHfuzXpZFTa7NcHaQnAUAab9Mt7VMm1tUQ4nM
   M15y/HfEwUnKPr4EIZ+zq/PRxFs6rvg4wKdpj8QhEUkD4fQmnIgnke7o9
   Sscgwap6no6rdb1MPnHtKivxYCyvXsCvBGPUUWNICUY0jNqdoAM/LkHCi
   c9tyXZophQMwKl2nS0UZERqIqwlA3wQ4JicAM2phWKiSL9LEPJECPXgJv
   CklBz+J8RDLI8b0T9cKv/oAHI8P06oEl/dSXZq9FGoDFPrTFPBINnM8WR
   g==;
X-CSE-ConnectionGUID: 16lOav+MTNCmktm2tlQ/hg==
X-CSE-MsgGUID: wxj7N2WTT3uSaOj1fLUQyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69971941"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="69971941"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:03:52 -0800
X-CSE-ConnectionGUID: USVNSxneRlWz1PicI0mm1A==
X-CSE-MsgGUID: PGtE6QkBRy+X3vLWmu/J6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205728268"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:03:49 -0800
Date: Mon, 19 Jan 2026 21:03:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 4/8] iio: dac: ds4424: reject -128 RAW value
Message-ID: <aW6AEszfRQzuHf6j@smile.fi.intel.com>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-5-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 07:24:20PM +0100, Oleksij Rempel wrote:
> The DS442x DAC uses sign-magnitude encoding, so -128 cannot be
> represented in hardware.
> 
> With the previous check, userspace could pass -128, which gets converted
> to a magnitude of 128 and then truncated by the 7-bit DAC field. This
> ends up programming a zero magnitude with the sign bit set, i.e. an
> unintended output (effectively 0 mA instead of -128 steps).
> 
> Reject -128 to avoid silently producing the wrong current.

...

> -		if (val < S8_MIN || val > S8_MAX)
> +		if (val <= S8_MIN || val > S8_MAX)
>  			return -EINVAL;

Hmm... So the range is [ -127 .. 0 .. 127 ] ?

I think in such case the plain numbers would be more specific than
the type related limits.

-- 
With Best Regards,
Andy Shevchenko



