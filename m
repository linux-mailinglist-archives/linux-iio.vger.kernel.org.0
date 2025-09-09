Return-Path: <linux-iio+bounces-23901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AA894B4AC4B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 13:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9620D4E2ADF
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5386132275E;
	Tue,  9 Sep 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkyQYxWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938773218C7;
	Tue,  9 Sep 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417960; cv=none; b=Kp5KuBiCNYclU6Pox90E5IYhVlQOow0ym8i9mE8H3wWx6kkLurA+FnXwfo0JYxUV0ACvorr6lEsHy+p7DMb23P5VbDd9ZYJclE/4bEXpM0nGSkGhskZgco9iHNpr0NLWeFxVuyIXQk/X0QYsE/U+a3wVpQ8Dwj3YuJ3lwGfnPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417960; c=relaxed/simple;
	bh=/lQPn8R9xF5EP26Yw19J4XYjAXrahPPIh8/YXIx3HiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWV1bwnDLEKxdSQx1RrEovK8Q9+qdjxpw6+1dIGu0MqRRtX2jJojZVkh35hMX4ImcBrSJ0jjjEuNkF/WesjApk4ARFpOafr/cxJZdJgh93VU0pZ4bsph0oppdVwTC97OP2QkJYEKNG7TdYw1eElK3QnsVgc2Ml9UIVDRXpEDWz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkyQYxWb; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757417959; x=1788953959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lQPn8R9xF5EP26Yw19J4XYjAXrahPPIh8/YXIx3HiY=;
  b=OkyQYxWbkAQMB7ukdQbxXcL41zwyNLj5lGFlzvIN3sS2kNta5KQ4Mner
   Io1QBoiWZpJWflT3CaNxC30cmOqcR6r2M1lBQaliYjLsYKKBXvtPN1ywu
   sycndcqCzVh4p+k/qiuFuNhwaotGArdvkI1B6l8VpQVRKv++vhSZTPnBb
   QYr2eTd+1LHjK2Zj4i87kXjOXlsD0RGsuNPDRpU2NqWdW9NMvHDi/KtYd
   K6AGsLCZ5CXxqa8ZLmjWdpjLGpa/hrWLjBdhZQ1WafDPevTNyEYTlmPOr
   DJaPCJO6hr6fJcZBOBBcwLVFEH60JfgUt0ytUiPD9UWvqqEKDb8LxPXKS
   w==;
X-CSE-ConnectionGUID: NhFTDtjUQi2k/b1KqxJv9Q==
X-CSE-MsgGUID: 6ttpKTHnTj6m54WDMtSAhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="71072876"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="71072876"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:39:18 -0700
X-CSE-ConnectionGUID: BaPjKtCAQWKpUWbsyb3AOw==
X-CSE-MsgGUID: 6QhrmVOxSlW3s04C9Z9qjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="177412667"
Received: from smile.fi.intel.com ([10.237.72.51])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:39:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uvwgq-00000001QS8-1aCJ;
	Tue, 09 Sep 2025 14:39:12 +0300
Date: Tue, 9 Sep 2025 14:39:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	rafael@kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42600: use guard() to release
 mutexes
Message-ID: <aMAR4Jx3pWQ1_rjX@smile.fi.intel.com>
References: <20250909-icm42pmreg-v4-0-2bf763662c5c@geanix.com>
 <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-icm42pmreg-v4-5-2bf763662c5c@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 09, 2025 at 09:11:11AM +0200, Sean Nyekjaer wrote:
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.

...

>  	/* exit if FIFO is already on */
>  	if (st->fifo.on) {
> -		ret = 0;
> -		goto out_on;

Probably you wanted the same comment here

	/* increase FIFO on counter */

> +		st->fifo.on++;
> +		return 0;
>  	}

...

>  	/* exit if there are several sensors using the FIFO */
>  	if (st->fifo.on > 1) {
> -		ret = 0;
> -		goto out_off;

In the similar way

	/* decrease FIFO on counter */

> +		st->fifo.on--;
> +		return 0;
>  	}

-- 
With Best Regards,
Andy Shevchenko



