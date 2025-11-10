Return-Path: <linux-iio+bounces-26118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B62C45014
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 06:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D7D188E301
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 05:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B842E8B78;
	Mon, 10 Nov 2025 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl+2SZRI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6002E5B3D;
	Mon, 10 Nov 2025 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752390; cv=none; b=JmBLd6pi0/Dw52RLLAy2dDAgwy1X++8+wY7K19b6UiiFJa8KVI/U7uHwGGyv0EGAV/fbeY9yfFmHtpNcN3eWzyrp/XEL73s7FFIgRBqM0nMUnvgnFXBCHf6uXYFNS91Njx93ILWo6KEtq+GqomClmdbaNFjv4egW9gJLMEQdRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752390; c=relaxed/simple;
	bh=wL5I5CT+0Sw7TlLK9lpIO1ktLGl5C5Cx/Oz2HSvRTuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD6PUbhV9OZUrjAm1Thgz2wOLJIfv/cQ5Bx1J1nhCgDHiM+8QcCOgdOY3zadICXztc8DXPxqX+at7PLlw0EH64AeNL/uEhPD9QgHafLxIa8Yx6B/w1phwI4BiGu8TEJ7htNGtXl28bUrSqaDyyjOjv+UZ/bqQpEvH+f3vSwnFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl+2SZRI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762752389; x=1794288389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wL5I5CT+0Sw7TlLK9lpIO1ktLGl5C5Cx/Oz2HSvRTuA=;
  b=Wl+2SZRID0BYDT953JMpVnT2MCrDoUmRiRIJfqjIUD9DiqTtavBw+8za
   m3Sown2YrUeZS9BPW1r50M6Cei4GYRH62aUntmhk7DK4B16fDxgnK5fB4
   Ea6LOgBGg33QFa44ZG2I6OTaXCpMCbuT49oGk6eQ8YPVrDTH3xIiYj1ui
   ohTM3ZnUk+5aOa7J/6T8qYaJsPWHMuUuWlHzx3QjwLE/KJOY0RRYa41ZH
   BVUEaTFkJc5dsCgI1rEVoFDx3/sQzxd4NC7ZYtJy+nSWoLK7i1GOUSaan
   EQi+wltMcRxa26L8hcSgf3CheE9QDz1b/rDqURXlNDcfHg1Kk6VPUBh5i
   g==;
X-CSE-ConnectionGUID: zipJisqGRQWKTwh6O5enjw==
X-CSE-MsgGUID: 8yLgHbn/ToaFDX3kkLRrqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="87429397"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="87429397"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 21:26:28 -0800
X-CSE-ConnectionGUID: lyN/dndFTY+1Uj/vKCqYTA==
X-CSE-MsgGUID: nrSbbf2hSraEoB1wjOby6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192691430"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.185])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 21:26:26 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIKQ2-00000007Llr-3v7s;
	Mon, 10 Nov 2025 07:26:22 +0200
Date: Mon, 10 Nov 2025 07:26:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v4 1/2] iio: trigger: add missing mutex_destroy in
 iio_trig_release
Message-ID: <aRF3fokq4u0-JYd9@smile.fi.intel.com>
References: <20251110035701.36691-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110035701.36691-1-make24@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 11:57:01AM +0800, Ma Ke wrote:
> Add missing mutex_destroy() call in iio_trig_release() to properly
> clean up the mutex initialized in viio_trigger_alloc(). Ensure proper
> resource cleanup and follows kernel practices.
> 
> Found by code review.

First of all, the patches should form the series and include a cover letter,
usually it can be done by running

	git format-patch -v<X> --cover-letter --base ...

against the branch where changes are located on top of.

Then, here makes sense to add

Suggested-by:: Andy Shevchenko <andriy.shevchenko@intel.com>

The change otherwise LGTM (no need to resend this time),

Reviewed-by:: Andy Shevchenko <andriy.shevchenko@intel.com>


-- 
With Best Regards,
Andy Shevchenko



