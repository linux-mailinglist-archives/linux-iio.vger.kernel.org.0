Return-Path: <linux-iio+bounces-17749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6138AA7D9BC
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A768188C6AD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8311BBBD4;
	Mon,  7 Apr 2025 09:33:57 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D61A3172
	for <linux-iio@vger.kernel.org>; Mon,  7 Apr 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018437; cv=none; b=GdtwarupUwa9s8Y++lTtjrkJ8nvxPYSrBpXkDV61+Q5vL9l8M27lLTMlpqeBpbCSKk3U8ehiH9dhoZoPh59ILwU5VxDGCf0Y3SpgbqNBG9K0UR4BNQjIFHY2AV6nftOYDStzqdaLBN3zLc7HaZn5BYmwXBb8OROgkbkVa3xjdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018437; c=relaxed/simple;
	bh=4eaCXjFV72NGOBSnKMIqTdeM0I5ethkPpIr0my4mAXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TslAa4LcnRQqehzrLah/V3/pu+RTZz2lNtSXwlh9JL5/bb739+EMWf3RjkcICOg9Zp6Hz9mq5JKYyYR4LXmO45r9ELXak0lEFtJxBwnqCk3zI9a0HTv+LimfLTcaM4ccwJCOF1nmd96Ubby/PpRdtHY3fkTqAOMUuzmNniQjVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: nwYszLYmTHSOp7AX+uFNcA==
X-CSE-MsgGUID: DB6g2GcwTE2oyzUyOvFq2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="56764341"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="56764341"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:33:54 -0700
X-CSE-ConnectionGUID: PBOcne7fTzGuZra/4hGZ7g==
X-CSE-MsgGUID: MpmMx+wLRwiGuwaNYbhKrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="128225814"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 02:33:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u1irW-0000000A1Ig-1W2h;
	Mon, 07 Apr 2025 12:33:50 +0300
Date: Mon, 7 Apr 2025 12:33:49 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/20] iio: accel: Use iio_push_to_buffers_with_ts()
 to provide length for runtime checks.
Message-ID: <Z_Ob_ZqfKk1zCdEL@smile.fi.intel.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
 <20250406172001.2167607-11-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406172001.2167607-11-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Apr 06, 2025 at 06:19:51PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This new function allows us to perform debug checks in the helper to ensure
> that the overrun does not occur.  Use it in all the simple cases where
> either a static buffer or a structure is used in the drivers.

...

> +	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
> +				    sizeof(data->scan), time_ns);

There is room for one parameter on the above line.

-- 
With Best Regards,
Andy Shevchenko



