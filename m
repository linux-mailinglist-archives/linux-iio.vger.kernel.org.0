Return-Path: <linux-iio+bounces-16775-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3667A5F4A0
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 13:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C42F3BEA75
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF681EEA59;
	Thu, 13 Mar 2025 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyFE2HiU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F11FBC9A;
	Thu, 13 Mar 2025 12:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869275; cv=none; b=RHxDT3rqoDGVq0uAGwJedMca6iBJ3965t+ucE4SpGL64Tg+oQ2+Kf9OFmwY2vPk6YFxal2rcGajaBQEllBXV3pOA8gw6BA99sWv6XRts4vbyHQ/ICZGtXwgf/bEMdKEYKwYyAwUb8pO1KcP3k+Z3TMcI5uUJNHKtBolWBjGe/YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869275; c=relaxed/simple;
	bh=143J5LtMmgVhQahwflzcYxzA/PDJtG6Xbkjg/ZRiK1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNe9keWptffx23RSo5CCEaQ9kjtDMJnLtzMbnU0Y5ul8gPfhsQwMFsuZgen6jZQVMrqEGhwGJaBxg06qS6E4cccd5vxReIYI+2nFB5PyoiXZ8CdcWi8iw8Hf/1UC+Zkcq4eJ30XpVcrRVzpuq1ej3nKI7Edu8demHHoHeACiueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyFE2HiU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869273; x=1773405273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=143J5LtMmgVhQahwflzcYxzA/PDJtG6Xbkjg/ZRiK1A=;
  b=iyFE2HiUsycdzMyhJEHKP97pvOhdPxPcN4SkrIu883PuFB8b/V+1LwpQ
   EE0wdtpApSF3+0nMhLVW82WPnAUl49RxQQfWkSPIO2brDQRbATZp4JUZ8
   /lB8tpWzU8IpkmY1MhOEWx4o/GnNiHhrBmuFeNw23Wjc43YUCIBXsmXz9
   LOnclKOdHEkcknzjg8MkOnOvPAkfiX4Hb/0dRexz91Km5feWIsRbikXGK
   YR1GmQ7IXavLr8InptVUCnGW+73ESVJnizEWOah07DQARTuauGyWLQrL5
   /YA2xBNwBBkimOBE4XA78kH4qyFLXqWDy3sjh9DOWRY6tB55E6KTFeObc
   w==;
X-CSE-ConnectionGUID: q7hNtk+ESEaLA8klpVxXKg==
X-CSE-MsgGUID: 18K61Q9CShuRCuWEYN7mxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53619356"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53619356"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:34:32 -0700
X-CSE-ConnectionGUID: vtTlx5mcQCaxsKLpv0N+WA==
X-CSE-MsgGUID: zXqPsfRgRTC8lqLrj9YpFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="120933374"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:34:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tshlY-00000002AeF-412s;
	Thu, 13 Mar 2025 14:34:24 +0200
Date: Thu, 13 Mar 2025 14:34:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <Z9LQ0O34EUM8WZku@smile.fi.intel.com>
References: <cover.1741849323.git.mazziesaccount@gmail.com>
 <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0b2b53affbef5ccb7219328cc15db3ba843737.1741849323.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 13, 2025 at 09:18:49AM +0200, Matti Vaittinen wrote:
> The new devm_iio_adc_device_alloc_chaninfo_se() -helper is intended to
> help drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -properties to channel identification numbers, used in the struct
> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the sun20i-gpadc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the in-tree .dts seem to have
> channel IDs between 0..num of channels.
> 
> Use the new helper.

...

> +	num_channels = devm_iio_adc_device_alloc_chaninfo_se(dev,
> +				&sun20i_gpadc_chan_template, -1, &channels);
> +	if (num_channels < 0)
> +		return num_channels;
> +
>  	if (num_channels == 0)
>  		return dev_err_probe(dev, -ENODEV, "no channel children\n");

Note, this what I would expected in your helper to see, i.e. separated cases
for < 0 (error code) and == 0, no channels.

Also, are all users going to have this check? Usually in other similar APIs
we return -ENOENT. And user won't need to have an additional check in case of
0 being considered as an error case too.




-- 
With Best Regards,
Andy Shevchenko



