Return-Path: <linux-iio+bounces-25335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF64BF740B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8F481078
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 15:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1F1342CBA;
	Tue, 21 Oct 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk8U4zQy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F081720;
	Tue, 21 Oct 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059193; cv=none; b=nYjRFQzd37HUxyUv1+WHRkg/UHovEb3E1jObMvarUM1KkMtvvGzzhK5JqnLd2yrOxGifrZSljzZEXh8iyp4AwGt/Rfz3PFb8BLMX64zYnD/7Gi5/KbHOtqnfYLeJXoZg/aN4kU969QntS9MVg5XFYknIKvN4qmYFvjbCFrApyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059193; c=relaxed/simple;
	bh=kaQgFgAUjXn571ByFw9JlPd7Orioww62gS7ZpKn0Vvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaF8NzT/kWxZHXL5zEopgcGuW6eID/lFq7hstfXfWj9ogQJp2g4gKy+EjNSZCM8yEZGAGu1joIVw1HJJdSCisLqgJWo7v0aB/P+nyej487usCLAq/zslXcUJoqf6p+BptyWtu7GPbO9ublGX/Xc852p9aFbtBXEBWoi5hMribM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk8U4zQy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761059192; x=1792595192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaQgFgAUjXn571ByFw9JlPd7Orioww62gS7ZpKn0Vvg=;
  b=Vk8U4zQy1YCLK9QqxueAMmSbZzd1RK/DkkyTraOMnUJsvGbE3u+JEmzj
   k+2sm8l26APp+SR98UD9M5i+2AuO0cwFEewnO9ihFQDAidKE7QZo+Y6tz
   Ad3iF1mr7NTuE7TYnOHKS8kH0OtAH7IPRW28t9j8bnR9CbNLFNeucChpO
   s/CNvFg9gCAUpcongkFlVbYwBg1A8xpMegNpCvLbvm+QTHYgxEASK+Wha
   kY6aTAevd0Ts+SYyLd/7F08P5pCpuTyz4O/Otl3uTFgQqEGqS7LOeVqsz
   DXtGd5hFku/KYRe2bdT104vttGQnYATqTgBPAvuAF1rHc1Jf6zKrR8w48
   w==;
X-CSE-ConnectionGUID: i3OfWAUZTre10mAxfxVQsQ==
X-CSE-MsgGUID: fKt/QxQ7QRaIMOlzoXzsmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74624615"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="74624615"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:29 -0700
X-CSE-ConnectionGUID: tQQvw3RuTnWZ506CmALQMg==
X-CSE-MsgGUID: jOhEaA77R5WgldYhSU3alw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="207285933"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:06:24 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBDwL-00000001We0-1IEe;
	Tue, 21 Oct 2025 18:06:21 +0300
Date: Tue, 21 Oct 2025 18:06:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: adc: clear reference voltage bits before
 configuring vref
Message-ID: <aPehbXMDP5xBBSS-@smile.fi.intel.com>
References: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 01:39:18PM +0800, Billy Tsai wrote:
> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.

> Change-Id: I03c036436f376ced8a19fa5d407b7bbb377ae721

What is this?

...

Shouldn't be a Fixes tag provided?

-- 
With Best Regards,
Andy Shevchenko



