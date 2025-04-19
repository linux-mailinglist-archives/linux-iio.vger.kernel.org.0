Return-Path: <linux-iio+bounces-18338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17656A944B6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2043B34E5
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6A61DE8AD;
	Sat, 19 Apr 2025 16:38:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199445FDA7;
	Sat, 19 Apr 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080692; cv=none; b=jztMmksdY3zgvfebZ2dsyAhkA9NgAymsQHAiFCxS6CPNZFsw5E7Rk0oBSURp18BrAURQ5BL3CwV6MoTZGRSWeDwMquUXXpx9KjXZT0SGuZ7pZjduOSQIf3LEKcQR0LLci/9FKEBUD6uNZdZ/s+Cx8+GbyUgJRziMUKgunyChXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080692; c=relaxed/simple;
	bh=uZShTIWKtHszqF1qKUftQsBG29lyj8rR9vgQVCWlIYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDl+6M9NYLBWkfRtp/3yaaoevqTM2gfTc16xQlsONA2XNi4hrpLgveJQtgP5Eqk9usDmtumZLRGueAhDyUW2CxW9/oggY0le7M8ZBvwJ0Q85ahrDvMaml/dzLmwT7Cdrj4ITQGIpeTITCSPJS71C6ERs0Ow3vlYs3fOy6l6E/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: P3PuIFteRb+z+e2DeHzfZw==
X-CSE-MsgGUID: gpJd4fj9Qs2o02bMsvEb9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="56857061"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="56857061"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:38:11 -0700
X-CSE-ConnectionGUID: LYyXFtNmTtakeuq6ykzJkg==
X-CSE-MsgGUID: u+cJX4vySN2jG9XVodTAuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="132240983"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:38:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6BCg-0000000DrpO-0BLZ;
	Sat, 19 Apr 2025 19:38:06 +0300
Date: Sat, 19 Apr 2025 19:38:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <aAPRbb93lJrnEE5l@smile.fi.intel.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-2-ee0c62a33a0f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-2-ee0c62a33a0f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 05:58:33PM -0500, David Lechner wrote:
> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> and understand.
> 
> AD4695_MAX_CHANNEL_SIZE macro is dropped since it was making the line
> too long and didn't add that much value.
> 
> AD4695_MAX_CHANNELS + 2 is changed to AD4695_MAX_CHANNELS + 1 because
> previously we were overallocating. AD4695_MAX_CHANNELS is the number of
> of voltage channels and + 1 is for the temperature channel.

...

> -/* Max size of 1 raw sample in bytes. */
> -#define AD4695_MAX_CHANNEL_SIZE		2

>  	/* Raw conversion data received. */
> -	u8 buf[ALIGN((AD4695_MAX_CHANNELS + 2) * AD4695_MAX_CHANNEL_SIZE,
> -		     sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
> +	IIO_DECLARE_BUFFER_WITH_TS(u8, buf, (AD4695_MAX_CHANNELS + 1) * 2)
> +		__aligned(IIO_DMA_MINALIGN);

I would rather expect this to be properly written as u16 / __le16 / __be16
instead of playing tricks with u8.

With all comments given so far I would expect here something like:

	IIO_DECLARE_BUFFER_WITH_TS(u16, buf, AD4695_MAX_CHANNELS + 1);


-- 
With Best Regards,
Andy Shevchenko



