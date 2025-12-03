Return-Path: <linux-iio+bounces-26662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA9C9E640
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB86C346FB9
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265442D9EF9;
	Wed,  3 Dec 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxUSDQ4Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07410257431;
	Wed,  3 Dec 2025 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752655; cv=none; b=Kh1qVbSnLGrSVlUekvGlHK8UbbyxXS7oSR2f4lYlaqT1VmnJs3bVA2HV9ch7sAsXpSQZ5wfg+ccY47T0mUZqGzxeLN2j2wrC21Q2nXBTfHAuoMb7D7wXRIj6DNuJmUfMAMbAexYbTuJ9rBtICEAGXyToI3s2wAheyB4v0AZhljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752655; c=relaxed/simple;
	bh=b2sk3duwoNE9H2KK2expw74SH44y7GQ2lYs8ssrQsLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvOxJzmzsHhIJcnaKH5yTloznzZ+mW9Tt0lXF9lflCm2LHcb/2Xi1svERZboEdV7zAh3ntSvbyaEVlMVubo7FH09XoVpARe4pGG9EZKSQtHxApv1E8mBkiptqWVd9EwXT508QxrkXBh2Rv7VbyPHiBEYXwzXpohTg+g6dIoQYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxUSDQ4Q; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764752655; x=1796288655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2sk3duwoNE9H2KK2expw74SH44y7GQ2lYs8ssrQsLg=;
  b=DxUSDQ4Qm5t1o68mi5vcIcSgokgRfGzsJ3TxeKDlV71y+KlQuEmSjsxd
   a7nhrGEC3vLcSuM1bwjMgFiVK4FmfHSo6Avo71TFuyEYg0OLqPVzz3Dwr
   N18V2ttTuAiy5viQBPaYNI+ye7Zsm1NZ/CJisQL9lNMbjBLI8u3133Tq2
   EnIlOEBVonDLqBJSfsVnqgLNE4GHAWFrmUw7lOlOLBYgNtBpGT0ZmRQCt
   Qlkq/cD8Jfo/gR2TxH3OxRpO1pk56fA1kYuzINm+Ul8kD97FacvUfcw0w
   5Pu0i1PkRrYYDhXMb73cQpjOOTStiEYdN5pFZVt1LIT3YVfSI86qjlwTF
   Q==;
X-CSE-ConnectionGUID: qr/UlcSyT2GTmqKA4qI71w==
X-CSE-MsgGUID: fwlhXfHxTAKqZVvYPF4vMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66781089"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="66781089"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:04:14 -0800
X-CSE-ConnectionGUID: 4E56NDC2QPO08Jg+Ema02w==
X-CSE-MsgGUID: 697kwrfQRjWsBpHoISpQrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="194301438"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 01:04:10 -0800
Date: Wed, 3 Dec 2025 11:04:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
Message-ID: <aS_9CB9sQc2s1LMI@smile.fi.intel.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
 <aS7zf3ZGVEdTrNvF@smile.fi.intel.com>
 <c1cce165-0c34-4277-89b4-b0117ebb4bba@vaisala.com>
 <4a64c388-f141-4998-96e0-f6840d70f139@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a64c388-f141-4998-96e0-f6840d70f139@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Dec 03, 2025 at 09:28:23AM +0200, Tomas Melin wrote:
> On 02/12/2025 17:01, Tomas Melin wrote:
> > On 02/12/2025 16:11, Andy Shevchenko wrote:
> >> On Tue, Dec 02, 2025 at 12:53:09PM +0000, Tomas Melin wrote:

...

> >>>  static const struct iio_chan_spec ad9434_channels[] = {
> >>> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> >>> +	{
> >>> +		.type = IIO_VOLTAGE,
> >>> +		.indexed = 1,
> >>> +		.channel = 0,
> >>> +		.info_mask_shared_by_type =
> >>> +		BIT(IIO_CHAN_INFO_SCALE) |
> >>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> >>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> >>
> >> Wrong indentation.
> > 
> > Can you please provide example of your preferred indentation for this
> > particular case? This is used in several places around the code and
> > seemed like one of the more readable.
> 
> Would this be the preferred indentation?

Almost LGTM, thanks.

> {
> 	.type = IIO_VOLTAGE,
> 	.indexed = 1,
> 	.channel = 0,
> 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> 				    BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> 				    BIT(IIO_CHAN_INFO_CALIBBIAS),
> 	.info_mask_shared_by_type_available =
> 		BIT(IIO_CHAN_INFO_SCALE) |
> 		BIT(IIO_CHAN_INFO_CALIBBIAS),

	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) |
					      BIT(IIO_CHAN_INFO_CALIBBIAS),

It's still less than 80.

_OR_

rake the style consistent with the second one

	.info_mask_shared_by_type =
		BIT(IIO_CHAN_INFO_SCALE) |
		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
		BIT(IIO_CHAN_INFO_CALIBBIAS),

But I dunno which one is preferred. These two are fine with me.

> 	.scan_index = 0,
> 	.scan_type = {
> 		.sign = 's',
> 		.realbits = 12,
> 		.storagebits = 16,
> 	},
> },

> >>> +		.info_mask_shared_by_type_available =
> >>> +		BIT(IIO_CHAN_INFO_SCALE) |
> >>> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> >>
> >> Ditto.
> >>
> >>> +		.scan_index = 0,
> >>> +		.scan_type = {
> >>> +			.sign = 's',
> >>> +			.realbits = 12,
> >>> +			.storagebits = 16,
> >>> +		},
> >>> +	},
> >>>  };

-- 
With Best Regards,
Andy Shevchenko



