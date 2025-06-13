Return-Path: <linux-iio+bounces-20581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A7AD859A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 10:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0177A95ED
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34452727EA;
	Fri, 13 Jun 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T48YS3Uj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD02DA745;
	Fri, 13 Jun 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749803374; cv=none; b=f4mNvJaThz9YGptlwXCzIQl275ZvF2som9/wK262kzlJvQv0uWOeD4woCbywj4lDAu5l3I9pj4T8x/0Wae+0LqWTbg+hkekyrVUEvO0MZmH/WDzUYkSBesbgRwM+KMdAIelXSQBd5TqS95v1VVE0OFYbNYohwXjVlZEiclvsr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749803374; c=relaxed/simple;
	bh=ynppvBS7PNRniwt6jOu2/9HHz7kUhD/2Ep+aNoLGk94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzLe9Lvz5tvqtvusSw2am03d2NYaT82EcF9lDB1KSWy3SmjZ+cpKrqP71eYyNbwdlJpYAoZB4F460tqdwrjAQ8X9su+k9f3SsbvxPLyFm77P/deJWo6iLHXw4l4cnhqCnOJBZo/mcQD7z5Y4WrIWfcqn9jdT0fOhoB1h+TYZT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T48YS3Uj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749803373; x=1781339373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ynppvBS7PNRniwt6jOu2/9HHz7kUhD/2Ep+aNoLGk94=;
  b=T48YS3UjLwtUBFlyp1arXQKhymPfIgskQcFLi01Y4SQpWIjkxHR6RMC+
   sScvZNh9tdLeawYs5IOHmLDFeM+ZqzGhLSfhLKXB64n5txDDWObm3x4OF
   kVqU2YBQOG7nV2CXXMuxu4VlfpD4J6h8WYEyevinUyVBDc7oYjNBy7MQT
   4X+U5b8gkyNlV/np3u9xPyuw0CYwh1M/V3JwH2F0P+epW+x5bos4bMZEq
   nvHtVfuAVs2fVblyhnM45oPql/SOnJSBn+StvJ8VW4DLQR5l5UyafBB6k
   d4KovBlbta/gURdWbipCAzrQWtGnE/UZuw7ZSi4R/d/3ce07GJpZfk0Rh
   A==;
X-CSE-ConnectionGUID: 07QNFQfxQ5K6oSgKFsD1uA==
X-CSE-MsgGUID: g8kz78nYRWeUPWswP1UjSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55682058"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="55682058"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:29:32 -0700
X-CSE-ConnectionGUID: s9SNfEIzSs2VTbCEU2SyUQ==
X-CSE-MsgGUID: 4rQClN4nQmGiI9l0dJIRuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="151592123"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 01:29:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPzmw-00000006BfK-40rq;
	Fri, 13 Jun 2025 11:29:26 +0300
Date: Fri, 13 Jun 2025 11:29:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <aEvhZiXHLLIRe41-@smile.fi.intel.com>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
 <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 13, 2025 at 09:34:26AM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:
> 
> Add WoM as accel roc rising x|y|z event.

...

> +	if (sleep_ms)
> +		msleep(sleep_ms);

I still wonder if we can get rid of the conditional here.
Would the

	fsleep(sleep_ms * USEC_PER_MSEC)

actually work as expected?

Ditto for other case(s) like this.

...

Overall, looking to this patch again, I think it would be better to prepend it
by replacing *int*_t types by the respective uXX ones. Because in this patch
we add dozens of new ones which increases an unneeded churn in the future.

-- 
With Best Regards,
Andy Shevchenko



