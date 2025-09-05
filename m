Return-Path: <linux-iio+bounces-23790-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DFFB45F5F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512C87BB586
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9E309EEF;
	Fri,  5 Sep 2025 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+wf9Fc2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29331D736;
	Fri,  5 Sep 2025 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091118; cv=none; b=IfHwOnO6k/B3LCgsSEo2lt6kvONLuB7eVCBWCS2TuZZ/kC6CxDfrFT44bBWpUu0uuJ0wfoiocAnsT2+U8rgY4qYmx+Q2mOOBB7SRDZYE+hT83ZusVUej9+gZT54qWY3AJl3CD9SM89unM80dky3OpyuSf5qfuGTLuPXyEYyWirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091118; c=relaxed/simple;
	bh=Q2NvVrGEL+0/GeOayDpQMKWrprzquXJGtl3FdPmWfso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANN5E8V40d4ckXAoI9PPRqAr+Dw6LIZrftTZKdb9AI+Rnn/t5CUekFmFFWFqDyr+9jaFTxq5stEJCGv1eW4Zjj6HW7y7Gzhd4FcDyX7o01TkXycjj5IigzqhVGpY2whI3sLeGPZLbmjSlSftgd7+hyyYRxXJ8stZUqcAq7CkHgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+wf9Fc2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757091117; x=1788627117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2NvVrGEL+0/GeOayDpQMKWrprzquXJGtl3FdPmWfso=;
  b=j+wf9Fc2F/N9nBNlQdcqVmrgqCbMpDpKt1E17ZLzNDlKxbLlMo62Evb9
   3NTqe7g3LL1UDsVsHqgsWrBJR2ya9TPv8Kflqi7aMxQjDtU+0qVixjgpN
   Fri/fdzGoZ3D06vIGYqodKZI4HK4PfWfvLXTIdYgrFBJ3LL2U2aGo9Pbx
   /m7DEQQNmGON0UwQUwCEoXWiTjc5oMP1L3QbbTsWXo+kJhTBG4iPxrOtL
   Z0X28Ggt8nG23UrmJfaeD3AOHjfKeDZjcqZKIIGy1ZY8V19TIA8j4QLQR
   J2X65iWvsJogxQVP4ELovNyMgFmfK0agKuNKR0cXs44rnGRUcXKA0A74E
   g==;
X-CSE-ConnectionGUID: vgRfJicaTmeAKNUoh9Pvtw==
X-CSE-MsgGUID: 6mLxlJ9KTYWevXJ7+2qlAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70873803"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70873803"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:51:57 -0700
X-CSE-ConnectionGUID: dE/Fp5RbQ8uehYSfrW9X0A==
X-CSE-MsgGUID: RulAsFpER2Wi6WqCD7ni9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="177422147"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 09:51:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uuZfC-0000000BffY-2oy8;
	Fri, 05 Sep 2025 19:51:50 +0300
Date: Fri, 5 Sep 2025 19:51:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
Subject: Re: [PATCH v3 2/4] iio: adc: ad7768-1: introduce chip info for
 future multidevice support
Message-ID: <aLsVJraM57okkP1o@smile.fi.intel.com>
References: <cover.1757001160.git.Jonathan.Santos@analog.com>
 <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098a8b2556ea95fdce5f81cbac98983f91ca1a9d.1757001160.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 05, 2025 at 06:49:21AM -0300, Jonathan Santos wrote:
> Add Chip info struct in SPI device to store channel information for
> each supported part.

...

> +#define AD7768_CHAN(_idx, _msk_avail) { \

I consider slightly better to read

#define AD7768_CHAN(_idx, _msk_avail) \
{ \


> +	.type = IIO_VOLTAGE, \
> +	.info_mask_separate_available = _msk_avail, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \

> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \

In the original code below indentation was not broken.


> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.ext_info = ad7768_ext_info, \
> +	.indexed = 1, \
> +	.channel = _idx, \
> +	.scan_index = _idx, \
> +	.has_ext_scan_type = 1, \
> +	.ext_scan_type = ad7768_scan_type, \
> +	.num_ext_scan_type = ARRAY_SIZE(ad7768_scan_type), \
> +}

...

> +	st->chip = spi_get_device_match_data(spi);

> +	if (!st->chip)
> +		return dev_err_probe(&spi->dev, -ENODEV,
> +				     "Could not find chip info data\n");

Might be useful in some cases, but I don't see its value. Just always provide
a chip_info and no need to care about this. Esp. this just shows that it's
mandatory, but if absent, it will crash on the following line. Since it's about
probe, one will notice it immediately, otherwise it will mean a submission of
the code that has never been tested.

TL;DR: just drop this check.

> +	indio_dev->channels = st->chip->channel_spec;


-- 
With Best Regards,
Andy Shevchenko



