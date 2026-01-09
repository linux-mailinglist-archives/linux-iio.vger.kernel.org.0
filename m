Return-Path: <linux-iio+bounces-27584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC258D0C025
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 20:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7E33028592
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA52DF14C;
	Fri,  9 Jan 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBHtbL/V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBA218845;
	Fri,  9 Jan 2026 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985634; cv=none; b=KnBDJqZueJjW+UVd4NhXTB2tzE6SAHJAEro8cF9At711chr08AUrul3MSZEV4cc6RVc4FXN1FxBCJnS7f9WaepCtClNYtQl7sKnM15MpQf/LpRnxua6+GJR6sfhfYRiYxZGgvEVkvMq8NBPfLHuiNHLJzkkZeckI9DvGHsVTHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985634; c=relaxed/simple;
	bh=KOBnRTPPMxRitdXJ/bzV/177ZSn8//YyDaldxjvFzbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxhKpmZWTAjgx/Vz3qjt/65DA37TM6yp2XPCevmuICpcPe5rOOpuyU112uJJnL3Jv6HI3ZESvDJKy0rY9+hGCLjXqWi6I6/5IEbb5GifNkRdXt11cp+96otNyqjeJ7Ng8XxcXYAe3Tlr4x3aDcfcwrpkZXl6otOpTCz04+XJ+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBHtbL/V; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767985633; x=1799521633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KOBnRTPPMxRitdXJ/bzV/177ZSn8//YyDaldxjvFzbI=;
  b=TBHtbL/V3fEFhF4HgCHRe5I88KOLJMTnCcj4M3qZIelRQxdkTKGaopjW
   2G4o65llm17M/DQOJxF4uN+yiLYPLK4B06VCLrqK6F4sM276y/ETW4x3w
   PeaVlCWpLXlme+JDzTithUP0tQ/SLm0cyDv+UDuQHcSbsI1n8eLLaCo8S
   Mv8QT1C1qo3RcMdaUIgvajLNnFeA9elLiYX/Bq5pualRmZ9rJh9gauyI6
   6nzHCgzDYHGHDSwZST03Qn2dClussNqhzJG74+9qxOZSaXeQgc1hMjkJY
   PJot/DVCVtVZsNfKJOSuexKX3dH7V/ClAkkDMZtSBsnGcN7xQMbR60BJq
   g==;
X-CSE-ConnectionGUID: LVENBcPhRFWkc/i9RB/D4w==
X-CSE-MsgGUID: 9LhZMJYzSry2ReO2wrfqOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="79665095"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="79665095"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:07:13 -0800
X-CSE-ConnectionGUID: YuT3Tw14QP2uCoGVarClVA==
X-CSE-MsgGUID: wm0oLCSAQeKzHvuavTNP6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="208024462"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:07:09 -0800
Date: Fri, 9 Jan 2026 21:07:07 +0200
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
Subject: Re: [PATCH v3 4/6] iio: frequency: adf41513: features on frequency
 change
Message-ID: <aWFR2wTSWLydGN5O@smile.fi.intel.com>
References: <20260108-adf41513-iio-driver-v3-0-23d1371aef48@analog.com>
 <20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108-adf41513-iio-driver-v3-4-23d1371aef48@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 08, 2026 at 12:14:53PM +0000, Rodrigo Alencar via B4 Relay wrote:

> Set Bleed current when PFD frequency changes (bleed enabled when in
> fractional mode). Set lock detector window size, handling bias and
> precision. Add phase resync support, setting clock dividers when
> PFD frequency changes.

...

> +static const u16 adf41513_ld_window_p1ns[] = {
> +	9, 12, 16, 17, 21, 28, 29, 35,			/* 0 - 7 */
> +	43, 47, 49, 52, 70, 79, 115			/* 8 - 14 */

Leave trailing comma.

> +};
> +
> +static const u8 adf41513_ldp_bias[] = {
> +	0xC, 0xD, 0xE, 0x8, 0x9, 0x4, 0xA, 0x5,		/* 0 - 7 */
> +	0x0, 0x6, 0xB, 0x1, 0x2, 0x7, 0x3		/* 8 - 14 */

Ditto.

> +};
> +
>  static const char * const adf41513_power_supplies[] = {
>  	"avdd1", "avdd2", "avdd3", "avdd4", "avdd5", "vp"

Ditto.

>  };

...

> +	bleed_value = div64_u64(st->settings.pfd_frequency_uhz * bleed_value,
> +				1600ULL * HZ_PER_MHZ * MICROHZ_PER_HZ);

> +	u16 ld_window_p1ns = div64_u64(10ULL * NANO * MICROHZ_PER_HZ,
> +				       st->settings.pfd_frequency_uhz << 1);

These multiplications (here and elsewhere) are (very) confusing.

I believe you want to have a frequency in Hz in µHz resolution. The second one
can be close to this if used GIGA instead of NANO. But I think the better way
to have something like the first one but with MICRO instead of MICROHZ_PER_HZ.

Please, put an order in these.

...

> +	/* assuming both clock dividers hold similar values */
> +	total_div = mul_u64_u64_div_u64(st->settings.pfd_frequency_uhz,
> +					st->data.phase_resync_period_ns,
> +					1ULL * MICRO * NANO);

This sounds good as we multiply Hz by ns.

...

> +	st->data.phase_resync_period_ns = 0;

Do we even need this?

> +	ret = device_property_read_u32(dev, "adi,phase-resync-period-ns", &tmp);
> +	if (!ret)
> +		st->data.phase_resync_period_ns = tmp;

Is the _period_ns of type u32? Then simply

	device_property_read_u32(dev, "adi,phase-resync-period-ns", &st->data.phase_resync_period_ns);

-- 
With Best Regards,
Andy Shevchenko



