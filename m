Return-Path: <linux-iio+bounces-27583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 688DFD0BF97
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 19:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6BA43075F28
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474922E0402;
	Fri,  9 Jan 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOrmegke"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD32DAFBE;
	Fri,  9 Jan 2026 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984923; cv=none; b=u6+HV7K8qQqipEptjeRSnlVVVkVAJX2RZrgTCduMpsUf6o1GiBJnRmTxgo7cV90ONUc+UXA+0acV0lRI8k9RLavTvszeiD4Z8ZTR2F5dobvkUb3JtrhVRy1TjbJa4LIjKyxTmL38AYLUm+ZEsBJKRP8PZ2pgGLNqwkO/iah08jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984923; c=relaxed/simple;
	bh=tug3tpSyfr89QQYKaGWxzXYBfZYBge2qpQ8k2uT5V/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqpBkZykGvEIZFgX1/d89zDRby0anDepJfAxJcCf5LYLBAV1D/np3ALUKdqOjdeeNiiLeLuWMwG0rukTtkJYa3PHhUIJk74BZhMOPbMDaOUbpw5bnFwrfADYMJOBIZJ0R8hrPO1vHwwT+UeEQcyZ0FnOYgnSnEFKr4F7jA0d1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOrmegke; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767984920; x=1799520920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tug3tpSyfr89QQYKaGWxzXYBfZYBge2qpQ8k2uT5V/w=;
  b=aOrmegkeiRdZHebzPYjAmxGpuC63EUIZoc18h0fvrJULF+0tjhkEdLdd
   8aZl2Hd29E/i/wEsAinvELT9dkUBKmShADopoDsIiW9H6n838zQJCeXwF
   Kc8cMYREFu80W5FV/GlHAGhSP37V1ltRXAt0QCLvmGq3UUO83GD3TAvH6
   wpU6Q3aDTbgGSVFZkUll4ji9aits6lZGBhemHW2P3pVzyp39eyRLeCbEH
   2S3Uz3f2zkpD/3/fbft7zfEh2qtaFvRKcDeO2WSqEEUOJa/EQJy5fexI6
   BEgLOY4DU0YCww04gNfEqSWu4u153+P8aQA1pMw0zsiIzzD/W4rF7A40u
   A==;
X-CSE-ConnectionGUID: Y4A/bBFjRkGbhwpLpzLRBg==
X-CSE-MsgGUID: SUa65eNUTui0E+7GAuNddA==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="69353637"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="69353637"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 10:55:18 -0800
X-CSE-ConnectionGUID: 4r3rK8zgTNW2zA8Jo7XIaA==
X-CSE-MsgGUID: zzGXgLS1TwaXJZjwuZfG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="234733637"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 10:55:15 -0800
Date: Fri, 9 Jan 2026 20:55:13 +0200
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
Subject: Re: [PATCH v3 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <aWFPEa9HI4wmYLpn@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108-adf41513-iio-driver-v3-2-23d1371aef48@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 08, 2026 at 12:14:51PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> The driver is based on existing PLL drivers in the IIO subsystem and
> implements the following key features:
> 
> - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> - High-resolution frequency calculations using microhertz (µHz) precision
>   to handle sub-Hz resolution across multi-GHz frequency ranges
> - IIO debugfs interface for direct register access
> - FW property parsing from devicetree including charge pump settings,
>   reference path configuration and muxout options
> - Power management support with suspend/resume callbacks
> - Lock detect GPIO monitoring
> 
> The driver uses 64-bit microhertz values throughout PLL calculations to
> maintain precision when working with frequencies that exceed 32-bit Hz
> representation while requiring fractional Hz resolution.

...

> +/* Specifications */
> +#define ADF41510_MAX_RF_FREQ			(10000ULL * HZ_PER_MHZ)
> +#define ADF41513_MIN_RF_FREQ			(1000ULL * HZ_PER_MHZ)
> +#define ADF41513_MAX_RF_FREQ			(26500ULL * HZ_PER_MHZ)

We need HZ_PER_GHZ. I think it's easy to have one be present in units.h.

...

> +#define ADF41513_MIN_REF_FREQ			(10U * HZ_PER_MHZ)
> +#define ADF41513_MAX_REF_FREQ			(800U * HZ_PER_MHZ)
> +#define ADF41513_MAX_REF_FREQ_DOUBLER		(225U * HZ_PER_MHZ)

How does "U" help here?

...

> +#define ADF41513_MIN_INT_4_5			20
> +#define ADF41513_MAX_INT_4_5			511
> +#define ADF41513_MIN_INT_8_9			64
> +#define ADF41513_MAX_INT_8_9			1023

Not sure if we want (BIT(x) - 1) for the limits as we have non-0 minimums.

...

> +#define ADF41513_MAX_CLK_DIVIDER		4095

Sounds like a candidate for (BIT(12) - 1).

...

> +#define ADF41513_MAX_PHASE_MICRORAD		6283185UL

Basically I'm replying to this just for this line. 180° is PI radians, which is
something like 31415926... Can we use here (2 * 314...) where PI is provided in
one of the used form? This will help to grep and replace in case we will have a
common PI constant defined in the kernel (units.h).

-- 
With Best Regards,
Andy Shevchenko



