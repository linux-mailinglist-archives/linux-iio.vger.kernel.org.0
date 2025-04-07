Return-Path: <linux-iio+bounces-17744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EFA7D97C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4C41793CE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AD31B6D08;
	Mon,  7 Apr 2025 09:18:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0422E40E
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017503; cv=none; b=up+//cZuahoQKk4UrNvoSzYrk4PlKM6BUnVAdmhE53QV3xF27nGcfc+K3KeQQy4lOdrd9Vhw6F2GeZ8TlAUK7Q//sfHi4yIWvjNbiDjmqxhpYbMrzEv2l4K+6hdxXpamvtlwySWXN+TDo3kvyFUG7FsULJLC/4Py5ahHtStjLPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017503; c=relaxed/simple;
	bh=hZX79WeCKQ9WUO9aBybTjuqOaBMBc5+6hXE79AFkulg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P95Oq0jqpWC0uqqDa38R7X5EOWZXkYAZmLu3anZhP52/7Wg3l9qtt2PKPOjhUaCNf9X0lppnZqwwz3D0Uq12yfrnyI/3jNq8hf13k/S2vGq23IbQtuBltdqsjjDN5XVJy2nSCBaEa9FQSUUddFtD2hBTqteL2ynL07tfi6Gcvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: WzhL3blORRWjGA2DfNpWrw==
X-CSE-MsgGUID: pcsu0M1TTKuvX32COziVJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45410898"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45410898"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:18:21 -0700
X-CSE-ConnectionGUID: JorrVydeTU+LyLZ4tRQO4g==
X-CSE-MsgGUID: h0hfeDufTYanZ/xL2Nh5nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132040916"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:18:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1icS-0000000A14p-31zR;
	Mon, 07 Apr 2025 12:18:16 +0300
Date: Mon, 7 Apr 2025 12:18:16 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/20] iio: introduced iio_push_to_buffers_with_ts()
 that takes a data_total_len argument.
Message-ID: <Z_OYWKli6qVPgW2_@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-6-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-6-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:46PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Check that data_total_len argument against iio_dev->scan_bytes.
> 
> The size needs to be at least as big as the scan. It can be larger,
> which is typical if only part of fixed sized storage is used due to
> a subset of channels being enabled.

...

> +static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
> +					      void *data, size_t data_total_len,
> +					      int64_t timestamp)

Do we still need to inherit int64_t type? Can't it be s64 instead?

> +{
> +	if (unlikely(data_total_len < indio_dev->scan_bytes)) {

> +		dev_err(&indio_dev->dev,
> +			"Undersized storage pushed to buffer\n");

One line, even for the fanatics of 80.

> +		return -ENOSPC;
> +	}
> +
> +	return iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> +}

-- 
With Best Regards,
Andy Shevchenko



