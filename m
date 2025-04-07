Return-Path: <linux-iio+bounces-17745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D53A7D9A3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFAF3AC22B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C122FE18;
	Mon,  7 Apr 2025 09:23:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B622FE11
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017802; cv=none; b=XzdwD+W6vQZjHZwbMPdCrko64thjtR5oApK1Rt5akTnlxdbhfJc6UjTwvAPzFouoCoCh5ztdyx7opZTv3LlmwRXv8uE1xg9+8by00qsSmCTC4h5V7o8wyd8iE5RGACDJcDaSr9JTyrVe7fEXxGSMdtQA3ZFQ0k/5xzo+wwR+AgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017802; c=relaxed/simple;
	bh=nzHN8a3/dUQzlLk8mZXv/lG5bPQ3jENceUytwh0BiDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1l8w24hXdvZiz7TnZP1MHKHqZUMtmTBO1s3bRnBHVI0vjxEL/HeDRuGJB4t7ZSdgS8hreh24838xT3Sfujj0sPAN1NsGKZGUYtqlo/1+IWvnXVmVbWEG/IiOvQ4hqtqXG+7KTslKHzPZ/j3kJakOisivyNXoEHoasiAKL2akk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: VVQMGeEdQqiTzQx848nLYw==
X-CSE-MsgGUID: wsrSMAkXSEaui1zp4ZyLAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45283006"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45283006"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:23:20 -0700
X-CSE-ConnectionGUID: tSel0hgtSc+NsQIrtf64Wg==
X-CSE-MsgGUID: sbpmHOEpT8ytjzWy0x//Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="158861193"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:23:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1ihH-0000000A18e-0cWP;
	Mon, 07 Apr 2025 12:23:15 +0300
Date: Mon, 7 Apr 2025 12:23:14 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/20] iio: dummy: Use a fixed structure to build up
 scan to push to buffers.
Message-ID: <Z_OZgoORPl_6J01m@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-7-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-7-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:47PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> It has long been discouraged for drivers to make use of iio_dev->scan_bytes
> directly as that is an implementation detail of the core. As such our
> example driver should definitely not be doing so.
> 
> A simple anonymous structure definition suffices here as even though
> we have a mixture of signed and unsigned channels only the signed ones
> use the full storage so the unsigned channels can used signed types as
> well.

...

> ---
> v2: Add a comment about stack buffers not being DMA safe.

> -	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (!data)
> -		goto done;
> +	/*
> +	 * Note that some buses such as SPI require DMA safe buffers which
> +	 * cannot be on the stack.
> +	 */
> +	struct {
> +		s16 data[ARRAY_SIZE(fakedata)];
> +		aligned_s64 timestamp;
> +	} scan;

But why not continue using kmemdup() / kzalloc() for this and put
ithe comment there, which would make more sense? Then the device
driver developer will choose either to use the on-stack or heap one?

Or didn't I get the idea behind all this?

-- 
With Best Regards,
Andy Shevchenko



