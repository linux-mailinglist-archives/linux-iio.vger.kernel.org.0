Return-Path: <linux-iio+bounces-27360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC08CDFE18
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E4A5300D413
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 14:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1AF230BD5;
	Sat, 27 Dec 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+mfgtPW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582541EB5E1;
	Sat, 27 Dec 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766847320; cv=none; b=JG74vk72LNDno5x84IyZxdrjV8PjK1V7blHgz0Q3qV1JfE+34htSAOFRpejWQrGmdWJvu0Gt1h/dZyg6lpmm3TrMKN4loCQ66pXMtg7hlo6HHwOAMZeTYsAMQXvV+5DQ0vaoaWlgKTbz1F3lzFkUIHUjtsGDh5OVSpPCpiHEObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766847320; c=relaxed/simple;
	bh=R6WxrvMX6oOiEmx/EvbM3Jp36QwKH12p/bsx5qeusno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfAV+o9ARgov/bqzJFJrsEN1u0WnmfEfsjnETog6tmLkyOexrQ0715NgBb3uk9KwZ5bFPEDJnGcvf/PHptiJbH4/kwVwKv79wCMWit5QR94PHkVaP1FLM9hvUkOfFMMOQS2yEYOJXFvqao45gbIR43MlTN5jlj18sH1YumN8wp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+mfgtPW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766847319; x=1798383319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R6WxrvMX6oOiEmx/EvbM3Jp36QwKH12p/bsx5qeusno=;
  b=Z+mfgtPWjzwY5myI00NTCEeQLubojmYkBVBqYaPvd+kHg8sNLVYcXMPp
   VorDEKdBsEt+j9hM9PHM6AA32yx9z+LbG+PzZkGMBMMtIL77HXyyvkdqu
   WGwnIiuqSb0SwfPKjekZEqQLrFtv0FwBUw7FeFdOQ2hh45tuNX/Yw7t2T
   dq1148g1AJOnWiiBS6uNvKlqaMksWDw7agCIh6yoAuKADCEWBNCAnaAht
   npC6oUkq8v6LxZ09I9QZOrpqoXwIuFQTY6cuUS3lUIkRCtkXwe4CmdRr7
   Z+dNcdTqagSudXSDKj1YwyPxoFEyDu074D9IPcWYewFfA9Nuwl6qERZtt
   w==;
X-CSE-ConnectionGUID: vZEtG1ieQDWp8enycAQ0ng==
X-CSE-MsgGUID: riqGlUgkTUqDNvkGrlSqXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="91198262"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="91198262"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:55:18 -0800
X-CSE-ConnectionGUID: NTforWPoTDOU+xn7NOsJMw==
X-CSE-MsgGUID: JiqAdTcQQ9+RLVJGhW/1Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="200479670"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:55:14 -0800
Date: Sat, 27 Dec 2025 16:55:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ltc2309: add support for ltc2305
Message-ID: <aU_zUI8xOt7Cl5vP@smile.fi.intel.com>
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
 <20251224-add_ltc2305_driver-v2-2-061f78cf45a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224-add_ltc2305_driver-v2-2-061f78cf45a3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 24, 2025 at 01:37:15PM +0800, Kyle Hsieh wrote:
> Add support for the 2-channel LTC2305 ADC in the existing LTC2309 driver.
> The LTC2305 and LTC2309 share similar features: both are 12-bit,
> low-noise, low-power SAR ADCs with an I2C interface.
> The main difference is the number of channels: LTC2305 has 2 channels,
> while LTC2309 has 8 channels.

>  /* Order matches expected channel address, See datasheet Table 1. */
> +enum ltc2305_channels {
> +	LTC2305_CH0_CH1 = 0,
> +	LTC2305_CH1_CH0,
> +	LTC2305_CH0,
> +	LTC2305_CH1,

When it's hardware defined, assign all of them explicitly. Otherwise drop the
unneeded 0 which is guaranteed by the C standard.

> +};

...

> +	chip_info = i2c_get_match_data(client);

> +	if (!chip_info)
> +		return -EINVAL;

I consider this check redundant. There is shouldn't be a production code that
works nicely when there is a clear mistake in it (absence of the mandatory
static initialiser). The author of the change should have been testing this
and hence it will Oops the kernel, which means that the initial code is b0rken.
So, drop the dead check.

-- 
With Best Regards,
Andy Shevchenko



