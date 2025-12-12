Return-Path: <linux-iio+bounces-27057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC89CB98E3
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 19:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC36A3009F29
	for <lists+linux-iio@lfdr.de>; Fri, 12 Dec 2025 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8130214E;
	Fri, 12 Dec 2025 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oh4Q+JzR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D8299A87;
	Fri, 12 Dec 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563818; cv=none; b=O7heNtmRP4srd++KYwrFU89IITRing5xrE98uPjQk9P3c/biV7ualOjajxvWINMbiVZTa5cyvP0rHBs4CR0KmN17ucXoi+OE2bJfwmB72LSc0+X2qCIG1vHl5XfUYczCVIJ6jyXI1knEXmjMTH4Kf+e+UsoruYUB0naixkUC8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563818; c=relaxed/simple;
	bh=LDZKA87CQd/YAIYflLuJidy2QUVbTHlaYwKSiF2SI3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMxp9r/t0r76+Kfz81W28xxTbdDPdFLoCjVyrLgZNvox+6zjZ5JgkDIkBO3GYQjHIaBpZwoOaTNefP7mT1KMjFxlIXMChhwVgsKkJ9OPJfs/0klXQC0gBgsgO/KbmZGHCYg506O56Ucdrghwq54/mLLtgFflAPyG042SX4MlyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oh4Q+JzR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765563816; x=1797099816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LDZKA87CQd/YAIYflLuJidy2QUVbTHlaYwKSiF2SI3w=;
  b=Oh4Q+JzR3/+5PaPIngkWZVFa51HApiBQnRHO0PkzHBkWv8sja3TRRTaO
   aKWRFQcHqWZMhezC65uWx/IAtnG/kd2l4+jdc4ld60Qvrzf/gMiSqjtK2
   IDBM65ighatvOVd8QiFg1bfLJzJS3smkbQBk2swD9iaQPtKpcuRAmoG/T
   mK/nMV/4HPw3WjslIRVzWC55LuPuW9Yx2spsG/FHvZCrfJBuvo48JkOy+
   uY3AHcZQ46mpXnpn6To+wsSfeqIYwUUZrV4po2SyS5fgh5tzO5Iwfdxyk
   ssNsnCovDFqkzAH+d36H1wM2n7B8VM2Df5nD14Nvaq4tIML/6Up09nC+W
   g==;
X-CSE-ConnectionGUID: j823c9UNQ1CxZCYTuVPD/A==
X-CSE-MsgGUID: /Q0MXM1iS2OsjFOO9T+Xiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="79029002"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="79029002"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:23:36 -0800
X-CSE-ConnectionGUID: 3Te7P2jUQOGeLd6MUOBgmw==
X-CSE-MsgGUID: 3KeP3mwRR96cSWtnhTMJ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="196226718"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:23:33 -0800
Date: Fri, 12 Dec 2025 20:23:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Message-ID: <aTxdopX4X1hKKUPr@smile.fi.intel.com>
References: <20251211-lock-impr-v2-0-6fb47bdaaf24@gmail.com>
 <20251211-lock-impr-v2-2-6fb47bdaaf24@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251211-lock-impr-v2-2-6fb47bdaaf24@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 11, 2025 at 09:45:20PM -0500, Kurt Borja wrote:
> In order to eventually unify the locking API, implement
> iio_device_claim_direct() fully inline, with the use of
> __iio_dev_mode_lock(), which takes care of sparse annotations.

...

> +/**
> + * iio_device_claim_direct - Keep device in direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * If the device is in direct mode it is guaranteed to stay
> + * that way until iio_device_release_direct() is called.
> + *
> + * Use with iio_device_release_direct().

Nice.

> + * Returns: true on success, false on failure.
>   */

...


> +/**
> + * iio_device_release_direct - Releases claim on direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * Release the claim. Device is no longer guaranteed to stay
> + * in direct mode.
> + *
> + * Use with iio_device_claim_direct()

Not nice — missed period.

> + */

-- 
With Best Regards,
Andy Shevchenko



