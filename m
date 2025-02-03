Return-Path: <linux-iio+bounces-14893-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7690EA25645
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 10:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0767D164F59
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 09:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63D91FFC60;
	Mon,  3 Feb 2025 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZ6c0xfi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8441FE467;
	Mon,  3 Feb 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576279; cv=none; b=udwSMp8eHhu8jz0z0+eVWzEO9kW1S3nJjsBUadeSPs3p91EtWz5vbHgrbW9QG/9WEL2hrf9yTfG3di6pCbsS8BOAkXTsx30GoWVqyiP0k4bWYT2FFt9cSOH9FLzyCKQOmLIlujTZa9JEFVUw0BIO0Z/xIPPlsmhFWLISaDyEs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576279; c=relaxed/simple;
	bh=tDaagPqgjdeaZvJO6vQFKu0qqCUjm6G30ev2Ol0ahbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLbCOGX2imHLW12JCcOSiZ1jLo8C9VhK6gQ/VyAtM+pg5bc2tNibEaUeF9bJ23IYvaIOApPgvLx6sxTIGmzlgJkveTWa4lT4LqnIv1MPODm8xqB+ApYuYIlvh+Q38b4yVy3YjSRYVZ5Y6HcUI0on9LnKk9QPB16LSdzY9DqaZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZ6c0xfi; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738576279; x=1770112279;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tDaagPqgjdeaZvJO6vQFKu0qqCUjm6G30ev2Ol0ahbQ=;
  b=hZ6c0xfinXM62Ca/XVxZr/lqGiZG9h74CjI389KXJvXbDxoWEIsocwqP
   msTHnY7Y0pr7FNc+j1tPFZohJmDnKpHKwH9mFKkGU81Tl9jy0RtBbhamv
   xIrgpFCPNpps8qvjrdY1vaNOYclAvlJyELP/AFPZfiVG//wOHt27QYjiq
   ERM8i+aVtYoSL0zcVYiEUs496md2r5g7Qa/6ifAQnuaRdbg/QoQbWAWLL
   GqjDfo/PWM7gITXUk3AA58WIhKVaz2KHUFNoWuwbDAwZ02yADyfogMm+1
   WAU5J4iI1Ea2ZvWwDCkto5n5wboBoom/JJ6dd2obM/HI2jAT4HcQZfjq7
   w==;
X-CSE-ConnectionGUID: oEGjF2LIS2uxUhXeX1SuNg==
X-CSE-MsgGUID: 1QZi4PP5SAeoGaNr3ckCkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11334"; a="39202358"
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="39202358"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:51:17 -0800
X-CSE-ConnectionGUID: s00HmmrhTDyHT9zUsASxOQ==
X-CSE-MsgGUID: +v/TvZnySoWkfi8x5coqxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,255,1732608000"; 
   d="scan'208";a="110810737"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 01:51:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tet6k-00000007n0i-1kIG;
	Mon, 03 Feb 2025 11:51:10 +0200
Date: Mon, 3 Feb 2025 11:51:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 12/20] regulator: cros-ec: use devm_kmemdup_array()
Message-ID: <Z6CRjgG7y7YOiGpV@smile.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
 <20250203080902.1864382-13-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203080902.1864382-13-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 03, 2025 at 01:38:54PM +0530, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.

...

>  	data->voltages_mV =
> -		devm_kmemdup(dev, resp.voltages_mv,
> -			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
> +		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
> +				   sizeof(u16), GFP_KERNEL);

Wondering if this can be sizeof(*data->voltages_mV) that makes code robust
against type changes.

-- 
With Best Regards,
Andy Shevchenko



