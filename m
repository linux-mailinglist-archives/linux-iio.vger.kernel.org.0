Return-Path: <linux-iio+bounces-18979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D9DAA6E8C
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22479A7CE8
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 09:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5BA235069;
	Fri,  2 May 2025 09:55:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862C51EBFFF;
	Fri,  2 May 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746179745; cv=none; b=X9+BKZ3nDZhdiNo6u6I3NQxG7pU/Wi5xCl9RVrXnQq6EnbsIY6/DITFw8wTIBKivX7P9cDXasezCXrVL8C+KepP1i+RH07DUr7vracz+c49DfA4AQgq4P1nis/Jx0ATWM3U8eLAxXeFAZUPH6ORwF33p+b0B1wYQRpSY1AQbisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746179745; c=relaxed/simple;
	bh=18nnLX0/C8KF+jNYA79xjt+DAQ8iglHtX24j5mr2qNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksuxz243CvdviguNcvVY/GwcEXI2upbFYlVUFZK1uAdyibbaCaKsFhPTR5gP3exlnMK+p9jI2Cy9w+JrleZYsC/4mtA4OnzUSPgjMxjYd3kLXkl5aYQG+dlB4oN6kXUafHC0vNGI8Kgxc/3ElziUwNiob22J1aUtHW59W4M6H7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: +jaR3ltJT4i6A1rtbSelxw==
X-CSE-MsgGUID: kWItGplbSlGnoSRqchiYmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58527996"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="58527996"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:55:43 -0700
X-CSE-ConnectionGUID: lHVdCa2QQsaYrCwCaMQDnQ==
X-CSE-MsgGUID: rLft6Zf9RrO9hCzZprvvIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134519616"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 02:55:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uAn7J-000000029Vd-1HiT;
	Fri, 02 May 2025 12:55:37 +0300
Date: Fri, 2 May 2025 12:55:37 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7606_spi: add offload scan mask check
Message-ID: <aBSWmeRaPg5U8f7v@smile.fi.intel.com>
References: <20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v1-1-8b165d9d6c0e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430-iio-adc-ad7606_spi-fix-offload-scan-mask-check-v1-1-8b165d9d6c0e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 30, 2025 at 04:41:58PM -0500, David Lechner wrote:
> Validate the scan mask when SPI offloading is being used.
> 
> Since this family of ADCs is simultaneous sampling, there isn't a way
> to selectively disable channels when reading sample data. (Technically,
> AD7616 has a sequencer so could have some control, but that is for
> another day).
> 
> For "regular" IIO triggered buffer reads, this isn't a problem and the
> IIO core will demux the data and ignore data from disabled channels.
> However, since SPI offloading is done completely in hardware, we don't
> have a way to do the same. So before this patch, if less than all
> channels were enabled, the data would be misplaced in the buffer.
> 
> By adding a check in update_scan_mode, we can fail to enable the buffer
> instead of having bad data returned to userspace.

...

> +static int ad7606_spi_update_scan_mode(struct iio_dev *indio_dev,
> +				       const unsigned long *scan_mask)
> +{
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +
> +	if (st->offload_en) {
> +		DECLARE_BITMAP(bitmap, AD760X_MAX_CHANNELS);
> +
> +		bitmap_fill(bitmap, AD760X_MAX_CHANNELS);
> +
> +		/*
> +		 * SPI offload requires that all channels are enabled since
> +		 * there isn't a way to selectively disable channels that get
> +		 * read (this is simultaneous sampling ADC) and the DMA buffer
> +		 * has no way of demuxing the data to filter out unwanted
> +		 * channels.
> +		 */
> +		if (!bitmap_equal(bitmap, scan_mask,
> +				  st->chip_info->num_adc_channels))
> +			return -EINVAL;


No need to have the local variable, just make sure that bitmap_weigth(FOO) == FOO.

	if (... && bitmap_weight(FOO) != FOO)
		return -EINVAL;

> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



