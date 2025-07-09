Return-Path: <linux-iio+bounces-21471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21431AFE31D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3B44E419D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 08:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B627F182;
	Wed,  9 Jul 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klGITQAs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F97072613;
	Wed,  9 Jul 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752050893; cv=none; b=nLJEJMaGPRRFCYVbC68LKfEgdCm/dPH4NlayGXQjBSnwizCFn/WCX3tLUWuIIWOBW24Pm6HjN2lEGSqnOsacGNVPw69S6zZmWLMxOd6VFHpfw//zEL2ToO2ane5/rWWv1Dj6aKoYQHAGagIroyYP2iyUwY+q2oDJpkGsz5PVr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752050893; c=relaxed/simple;
	bh=ApbaFaUdVgbCLb3e8EMfbruCyFj7sOIBzssDOASSRBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAPrZ5W57CLGtvKrs7HyIkMU4XSGcaeUchC/cPmzu0SnfLvULT67CkPPlbiVH6PCZYQ2VQnaBEGoXaUGmh7G1ttdy1zHdp1kCeYtx8harzU9A5aG+sfJsTVQF30/pCopwALGGK3Hf+cwVkUbll6i6z8d0xkRdCBQhxbXWmkEr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klGITQAs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752050892; x=1783586892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApbaFaUdVgbCLb3e8EMfbruCyFj7sOIBzssDOASSRBU=;
  b=klGITQAsuxbl5fOAYj72hSAaovfBcXWJwLV9L5r4AwZa4nG9h1AJAh+9
   fPqyILBOvibzhXRnvHJPRfninozqUQgp2Cewo8mfo+U9f0dqTYwDvjV53
   xD55v9wr3aVEybN76TCJuBeKfvvZ7RmP2RhegmAWkWEMrQgDhcWfqMNBX
   EI0r5QSxSXGAb8AwR0V7gI8xc7HaNhVE2AZTXmRSIX31wxrHKdrnfoZhh
   VQ6FRDwYZCXSQIuME/2GgrrAKer7Puc4cr+ThYGh7QGMbgIYuh7dWgasP
   Bfgdt3VkA8pJhXGce9T6XbG2Zs1xaBCPaMvcXXdONDYwK2gk/SjijSE5F
   Q==;
X-CSE-ConnectionGUID: +jQxkHcTRmqW88gONaCqLg==
X-CSE-MsgGUID: vcfxMOvHQvq9qjnKlIMFVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65366321"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="65366321"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:48:11 -0700
X-CSE-ConnectionGUID: HJKTXCCZRRaFCsDbctY33g==
X-CSE-MsgGUID: zEhTeGJUQDGJ+h9nL519UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160029510"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 01:48:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZQTE-0000000DoRa-3oNF;
	Wed, 09 Jul 2025 11:48:04 +0300
Date: Wed, 9 Jul 2025 11:48:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] iio: dac: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <aG4sxEtXRw982Z9q@smile.fi.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
 <20250708231152.971550-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708231152.971550-1-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 09, 2025 at 02:11:52AM +0300, Sakari Ailus wrote:
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().

...

> -	if (!enable) {
> -		pm_runtime_mark_last_busy(dev);
> +	if (!enable)
>  		pm_runtime_put_autosuspend(dev);
> -	}
>  
>  	return 0;
>  
>  err_put_pm:
> -	if (enable) {
> -		pm_runtime_mark_last_busy(dev);
> +	if (enable)
>  		pm_runtime_put_autosuspend(dev);
> -	}
>  
>  	return ret;


Hmm... Why not simply

	ret = 0;

err_put_pm:
	if (enable)
		pm_runtime_put_autosuspend(dev);

	return ret;

instead of the duplication?

-- 
With Best Regards,
Andy Shevchenko



