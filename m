Return-Path: <linux-iio+bounces-18336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A9DA944A6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7DA3B3FAA
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 16:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C671DF72E;
	Sat, 19 Apr 2025 16:33:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F31DED78;
	Sat, 19 Apr 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745080402; cv=none; b=At64G0t7PZ7Q2P1STZ9G7s1qp6+T0jNOq7+2ofIG4MYtdlLCLVSWUGY7d4aeIL6TGKil1i9Swmcx+VqDSg1Q3JSQ3aWJ1p5S+HThQlRTuQOVP6S0PiPpDB+n0H8OAYr+AoTBFg7sV5DtQatzRvAXh0ZUjXPJK6Q/rh/W/NbJvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745080402; c=relaxed/simple;
	bh=yY9W0ojEDLmAT+Td9NIvjlNjnssciPuXBbu6Wmyb3AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSGP6ZcVSPtXSXxi+AbMwyJNatCdaFg3Byqv5+6fzn80rqRbDWPUFgl+SvfURVRv8rrrXQnyCY8usRQYchy6StUxD2ocQlF/8JSEfqw1mcWMOS+zIgV1JQng1TpQsQTtChMfs7/ZS2WO8aII6XmoaGTRGs0satH5cV53ngVuR6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: pLV9lDiRSB+L2ISYFLnAXQ==
X-CSE-MsgGUID: eJ4w/L3kRK+sMnZRn3R8XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="50509882"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="50509882"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:33:20 -0700
X-CSE-ConnectionGUID: DY71s9bqQ5W9fFIWDotggg==
X-CSE-MsgGUID: /egytB7AQIS+PpJKJe4F8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="162402446"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 09:33:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u6B7z-0000000DrlO-21AE;
	Sat, 19 Apr 2025 19:33:15 +0300
Date: Sat, 19 Apr 2025 19:33:15 +0300
From: Andy Shevchenko <andy@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <aAPQS9xY4603PJmU@smile.fi.intel.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-1-ee0c62a33a0f@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 05:58:32PM -0500, David Lechner wrote:
> Add a new macro to help with the common case of declaring a buffer that
> is safe to use with iio_push_to_buffers_with_ts(). This is not trivial
> to do correctly because of the alignment requirements of the timestamp.
> This will make it easier for both authors and reviewers.

...

> +/**
> + * IIO_DECLARE_BUFFER_WITH_TS() - Declare a buffer with timestamp
> + * @type: element type of the buffer
> + * @name: identifier name of the buffer
> + * @count: number of elements in the buffer
> + *
> + * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
> + * addition to allocating enough space for @count elements of @type, it also
> + * allocates space for a s64 timestamp at the end of the buffer and ensures
> + * proper alignment of the timestamp.
> + */
> +#define IIO_DECLARE_BUFFER_WITH_TS(type, name, count) \
> +	type name[ALIGN((count), sizeof(s64) / sizeof(type)) \
> +		  + sizeof(s64)/ sizeof(type)] __aligned(sizeof(s64))

Missing space and I would rather to see [...] on the same line independently on
the size as it will give better impression on what's going on here.

-- 
With Best Regards,
Andy Shevchenko



