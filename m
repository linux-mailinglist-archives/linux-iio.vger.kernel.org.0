Return-Path: <linux-iio+bounces-26554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EFBC92FD4
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147C93AA321
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6938E2C08B6;
	Fri, 28 Nov 2025 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFUnQw53"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142F1FC8;
	Fri, 28 Nov 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764356584; cv=none; b=i7LU+iZNEln1WtiLVRRrPzZjaR+AMZrNqX7f4l9aiWxOAZ1+MiPJh+RAnhfVNTCNt2rX54jpLyXCPcG4aeS//R9DDMjNS1LaJJHDMovtgDU6KvQDzdayu0TZZBNFvOOoe8wHWDlGmxjzIWSA7Ptv+0irlRSw/BJGI9IHb4CmMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764356584; c=relaxed/simple;
	bh=YZ4w++dkpbOrQeBCo+a2Ok1MtqTH5ApF2dwBHe8drnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzbdHwq3+1nmj9tiVUVV3JbggDmxLwVvkjpdmie0xGIOe9wj9SL7TGztoxOOFZUPI1GDZmFD4RJKb3XaV2Uk7Rzi+DJq6MPWMuwgvS0FL/XVCRi44sbVpOPRbVD4qW+dMSMWEtgOeOkno3jSOKhf+8nVaMuFOFyCHj7/LkyFrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFUnQw53; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764356583; x=1795892583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YZ4w++dkpbOrQeBCo+a2Ok1MtqTH5ApF2dwBHe8drnc=;
  b=DFUnQw53VgVjHyX7fn7Kr+lYnL1az9Dzav3U42k1O1onXSwhX4WDzpoB
   ZKQy0boiFt2fZCgphSZH3LYH/6QYNBVfaRkMIwY0I8RjCziT9DmMDT9OE
   hoRQN3ViI9rqE1Hc1Oe6RwsSIXVYrjNPvxJ1J8+roF4It2D9YDT40p3Ga
   4onJlt1iowFgAsJzGhhCsiYpqG5S0nwHGVF0pUCRcNAvLKVUPCBD+iAty
   r/nolZudronwtDf9r4Y0Pa6cI1BtflmaBffVbP8Rm4P9c8cXhmWsat00N
   6wJfVAHfsJTFfJmz0UKjkX0TNfaG99Wz7J8vmfCgLjaQZdQTdmf2kobjA
   Q==;
X-CSE-ConnectionGUID: YwnKITJvQ42AGTFwFmiHVQ==
X-CSE-MsgGUID: MXxXwzGQQU6coCDebx/qWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="66420725"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66420725"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:03:01 -0800
X-CSE-ConnectionGUID: 0UpS/3SgTnik0jZtlMpeZA==
X-CSE-MsgGUID: sVnC/4/JR1uT6tBhqBWqhw==
X-ExtLoop1: 1
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.17])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 11:02:57 -0800
Date: Fri, 28 Nov 2025 21:02:55 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aSnx3zjBIbNvslba@smile.fi.intel.com>
References: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
 <20251127-ads1x18-v2-2-2ebfd780b633@gmail.com>
 <aSlxSj7XEq7PUxsk@smile.fi.intel.com>
 <DEKIF0XIN34S.97S95Z0Q5SL1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DEKIF0XIN34S.97S95Z0Q5SL1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 12:38:44PM -0500, Kurt Borja wrote:
> On Fri Nov 28, 2025 at 4:54 AM -05, Andy Shevchenko wrote:
> > On Thu, Nov 27, 2025 at 10:37:11PM -0500, Kurt Borja wrote:


Please, remove context you are agree with, no need to keep long message
which is harder to parse for what has been asked, answered, or discussed.

That said, I assume non-commented remarks will be addressed in the next
version as suggested.

...

> >> +static unsigned long ads1018_calc_delay(struct ads1018 *ads1018)
> >> +{
> >> +	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
> >> +	unsigned long mode = chip_info->num_data_rate_mode_to_hz - 1;
> >> +	int hz = chip_info->data_rate_mode_to_hz[mode];
> >
> > Can frequency be negative?
> 
> I hope not 0.0
> 
> I return data_rate_mode_to_hz[] values directly in __ads1018_read_raw(),
> which uses `int *`. That's why I chose int, but I can just make it
> unsigned if that's preferred.

Keep it unsigned wherever it's possible.

...

> > static void ads1018_set_trigger_enable(struct ads1018 *ads1018)
> > {
> > 	spi_bus_lock(ads1018->spi->controller);
> > 	ads1018_read_locked(ads1018, NULL, true);
> > 	enable_irq(ads1018->drdy_irq);
> > }
> >
> > static void ads1018_set_trigger_disable(struct ads1018 *ads1018)
> > {
> > 	disable_irq(ads1018->drdy_irq);
> > 	ads1018_read_locked(ads1018, NULL, false);
> > 	spi_bus_unlock(ads1018->spi->controller);
> > }
> >
> > Or if you make _read_locked() to return the data, just ignoring it as in
> >
> > 	ads1018_read_locked(ads1018, ...);
> 
> Sure, I like this.

I noticed that it may return also an error, with that in mind the NULL pointer
is the easiest way to go.

...

> >> +static const int ads1018_gain_table[][2] = {
> >> +	ADS1018_FSR_TO_SCALE(6144, 11),
> >
> > This won't (hmm... might not? see below for the details) work on 32-bit.
> >
> >> +	ADS1018_FSR_TO_SCALE(4096, 11),
> >> +	ADS1018_FSR_TO_SCALE(2048, 11),
> >> +	ADS1018_FSR_TO_SCALE(1024, 11),
> >> +	ADS1018_FSR_TO_SCALE(512, 11),
> >> +	ADS1018_FSR_TO_SCALE(256, 11),
> >> +};
> >> +
> >> +static const int ads1118_gain_table[][2] = {
> >> +	ADS1018_FSR_TO_SCALE(6144, 15),
> >
> > Ditto.
> >
> >> +	ADS1018_FSR_TO_SCALE(4096, 15),
> >> +	ADS1018_FSR_TO_SCALE(2048, 15),
> >> +	ADS1018_FSR_TO_SCALE(1024, 15),
> >> +	ADS1018_FSR_TO_SCALE(512, 15),
> >> +	ADS1018_FSR_TO_SCALE(256, 15),
> >> +};
> >
> > To address that you need to divide MICRO at least by 2
> > (note, by 2⁶ is also possible without loosing in precision).
> >
> > // Assuming that you want to keep the initialisers as is now:
> > #define ADS1018_FSR_TO_SCALE(_fsr, _res) \
> > 	{ 0, ((_fsr) * (MICRO >> 6)) / BIT((_res) - 6) }
> >
> > OTOH, these all are constants, so the clever compiler (even 32-bit compiler)
> > may do it for you and won't complain as there is no overflow in the result.
> >
> > TL;DR: Try to compile this with 32-bit compiler on 32-bit machine before
> > changing as suggested.
> 
> I didn't consider 32-bit here... I'll test it for v3!

Every time you have a division in the code with (potentially) bit numbers
in the numerator and/or denominator always think about 32-bit case.

...

> Ack, for everything else. Thank you, Andy!

Okay, I assumed correctly in the top, but again, please remove the unneeded
context when replying.

-- 
With Best Regards,
Andy Shevchenko



