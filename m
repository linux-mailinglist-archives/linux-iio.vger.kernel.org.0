Return-Path: <linux-iio+bounces-17747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690C5A7D9A7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7AD3AF48B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308D227BA4;
	Mon,  7 Apr 2025 09:26:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729B2253F2
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017981; cv=none; b=cwdaTQwWcs+ct1gktuGljUipgb7Se6DQbx6hQO0VyoXNBvRgCrmXHh64FmA5ea0zzow5mE2Czv+WkhAH6XX73YC59arfs+wBSOqfh1boWcBXxsmaEV2WSKtA1uF/7I5fgFdsExk04Iz4AOQm8IHaCkEiecOel1bVd/ppnXtU1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017981; c=relaxed/simple;
	bh=AjWh8qOsDKVMglC2B7a5S1CMiH6dkiddKUIJipDhjXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvv22I/lkh7gxLI+4sGOfFDYXXAeQUSBQY4rAvtMVBkNQArRxA+kMDN+6eGNEMRFnV2W7bLTfazbPvatrrWByO3MaTWfltTXMxOJCE6UX+H+O0VEFnnLq2eLAdF/cFCMXcN0qMmeFDPu/erxY63Hr5L+ilV5RMBH0ot0TEPTr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: NViTNrBoSSepUyqA+gP+Gw==
X-CSE-MsgGUID: oaEZ45HlSa6kbvB5T8D1Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45281965"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45281965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:26:19 -0700
X-CSE-ConnectionGUID: Oa4hNxoNReCZrY6ZrQTx2A==
X-CSE-MsgGUID: CI3ULAzXSQGQobqR8Faedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128400520"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:26:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1ikB-0000000A1Ba-0OFx;
	Mon, 07 Apr 2025 12:26:15 +0300
Date: Mon, 7 Apr 2025 12:26:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 08/20] iio: adc: ti-ads131e08: Use new
 iio_push_to_buffers_with_ts() to provide length sanity check.
Message-ID: <Z_OaNqjCR8mZF0CN@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-9-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-9-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:49PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By providing the size of the buffer used, runtime checks can be performed
> to ensure not overrun.
> 
> Also change the pushed data pointer to be that of the structure that also
> contains the timestamp.  Not an actual bug but semantically incorrect
> to push the channel data when we want the storage with the timestamp
> as well.

...

> +	iio_push_to_buffers_with_ts(indio_dev, &st->tmp_buf,
> +				    sizeof(st->tmp_buf),

Still can be on the previous line (81 characters altogether)

> +				    iio_get_time_ns(indio_dev));

-- 
With Best Regards,
Andy Shevchenko



