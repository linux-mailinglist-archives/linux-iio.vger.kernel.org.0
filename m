Return-Path: <linux-iio+bounces-13527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3213A9F262D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 22:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B816A18855C8
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2F81BD4F7;
	Sun, 15 Dec 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKm1wPAf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DE189F20
	for <linux-iio@vger.kernel.org>; Sun, 15 Dec 2024 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297140; cv=none; b=lElzE7yIfgvqEZZY2GfsAHCOpmA1M2RVPtfkrBrmj7tNLzmGqOhVZeZhdUzL4V8bUb7vOUn+xQ9/uaFpuG0FaOL7CMHh0aJXxtQcYTuwllDV5VKZlH+jF5GS9TgCPIHlU5uqxqbX0a0q4/NWjvw8PX2nnLzL7UK0S/uege+NVNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297140; c=relaxed/simple;
	bh=Tpw5iRm6VgLVkD1I/6laPfjnKSz7f2X/zU4JuuCQLfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXXjsbxKM7rOSVR+a3Vuu3KIsK/exZTfhBsZ4b3L7tIHeS0funINiRHVGDKSgUK9JI7Exjl8DlyympDogRy7YFTF2y5+1l1OJm2p8R2GWXt1gzN57OBLZgNz9mtubD+JO6Y3F+gLKG/XnL2NdJmRkVpOlgGSfJEevXUqTTeyvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKm1wPAf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734297139; x=1765833139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tpw5iRm6VgLVkD1I/6laPfjnKSz7f2X/zU4JuuCQLfI=;
  b=VKm1wPAfHzLsiOLeR6shHXWPxmK2xjTl75JTq7MOyQAfsr4O26fXPzJd
   DRDxl9+KgA1GA2uaCz19E7evf1RrqsgSYuzWqNlZbOvvgYsQhJqMJN5D3
   VX4x0P+VE/ZFp85QMudULENKmiiyu1ncD840x3TdLgAObgR80E7vGFJ8D
   mcm1fWfygNTuuPh3rESeQ4XZsbi974IHHmZtq5rhZo76A2XVijEeOViA+
   G5g40W3Bmr/TbdKo1ZNEBvPHGacPGtDDtarlS0Tk5mYzvRkLHxg8A+hQW
   pVn5Kvr713vATWQBcWvCK6DrhDDesiK50e4xTR1TWaxsW6hOMbNTOGbvn
   A==;
X-CSE-ConnectionGUID: Ffqyw4/jR8yGiAhc/XGr7A==
X-CSE-MsgGUID: x8NqzhFWRhicNvRqbXQbmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34834862"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34834862"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:12:18 -0800
X-CSE-ConnectionGUID: ApaW9hT0R6uJ36NfOUCbpg==
X-CSE-MsgGUID: /G9BFGNFTqWn5b/PJI2W7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="96924080"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 13:12:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tMvuP-00000008KAq-2w6G;
	Sun, 15 Dec 2024 23:12:13 +0200
Date: Sun, 15 Dec 2024 23:12:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 15/20] iio: buffer: Make timestamp s64 in
 iio_push_to_buffers_with_timestamp()
Message-ID: <Z19GLcY8m6ErkHk1@smile.fi.intel.com>
References: <20241215182912.481706-1-jic23@kernel.org>
 <20241215182912.481706-16-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241215182912.481706-16-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Dec 15, 2024 at 06:29:06PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This is a bit of a corner case for selecting between the in kernel types
> and standard c integer types we tend to prefer for userspace interfaces.

s/c/C/

> The interface is entirely within the kernel but in many cases the data
> ultimately ends up in userspace (via some time in a kfifo).  On balance
> the value passed is almost always an s64, so standardize on that.
> Main reason to change this is that it has led to some inconsistency in
> the storage type used.  The majority use aligned_s64 rather than
> int64_t __aligned(8) and this will ensure there is one obvious choice.

...

>  static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
> -	void *data, int64_t timestamp)
> +	void *data, s64 timestamp)

Hmm... Is it the indentation used for other static inline definitions there?
Otherwise I would fix it to follow standard pattern (use same column as the
first argument).

...

>  	if (indio_dev->scan_timestamp) {
> -		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
> -		((int64_t *)data)[ts_offset] = timestamp;
> +		size_t ts_offset = indio_dev->scan_bytes / sizeof(s64) - 1;

sizeof(timestamp) ?

> +		((s64 *)data)[ts_offset] = timestamp;
>  	}

-- 
With Best Regards,
Andy Shevchenko



