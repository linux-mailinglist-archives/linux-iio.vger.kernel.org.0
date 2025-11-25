Return-Path: <linux-iio+bounces-26472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64677C87142
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38273B108E
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1898B2D5419;
	Tue, 25 Nov 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4WWgWLU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB5F22D7A9;
	Tue, 25 Nov 2025 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764103086; cv=none; b=ulxSUg0qhmza9TH6Vy5o/Hh4gvtMPr6BkGTNw5hueUlv8Vat2YbEf72xFxK/icpX7ABIkgDaKHbQtE7PFKLYM5THuTlBmsqz4OikMixRDOiG59RtS/DIKiv8O/81ZtVZ26qi0fB9Hd2+TsXZhxsxYlwmkfJmZBR6TUiQ9ZwtWME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764103086; c=relaxed/simple;
	bh=8xpvt79m2P3o/4iW9PtUDwW0MW3vseH0PKSudd7s8ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuualzdOL2gMOHRqyXjTG7KMRW7VrTVOxMTyVlIFC7gFBs7uNoEB9akVYfNGhaukF3ZCL9Eng3Pa5Aw/FIcLlypzTVBajHs2IrNyZwBir5ZZU1fs1REmXMVpJvO5gSOTua7oE8T+4AwxzKtpC+raYrc0xKKBdcnpn6qkCwmC+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4WWgWLU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764103085; x=1795639085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8xpvt79m2P3o/4iW9PtUDwW0MW3vseH0PKSudd7s8ls=;
  b=l4WWgWLUv3yutvfQ/dzghUj/+TJBXmI1JDffZBWopQJih2/1xfCVRlcj
   Sj+vgPZ/e/tYzBTXmHfs2FtxC5XD8nkQdkixVown45xa5lb/2yfIAa9IH
   8T/uvqcYYiNmCNDGiOJ9iYRTjY+NPiecSanEVciryHueshHF9s1KiccBd
   2fUOJ/w/D+lW7kiGgGfke9GxGfhsPDzEaUsV/JpRv5GieUkNpQ0SUTUd8
   N4CKPYUoFzQyGeG3Fz1DtV3xD2ZVd4GWJdiZFWL3vNKayuhrD+dXG5DY1
   pGil4x1a4oMOvJyV6CK9CzRL0cZ6vnMW71zikQN85wF6v857IqbUq21x4
   w==;
X-CSE-ConnectionGUID: kkWCbeCSTw2U8fd3MxU/EA==
X-CSE-MsgGUID: hbzrWfexSrevCTMUvU6HMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="83522744"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="83522744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:38:05 -0800
X-CSE-ConnectionGUID: /UI6LBPjSz2GFbAY5Cn1Ug==
X-CSE-MsgGUID: TPsMXwzISXaiaBuujoCKiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="196902566"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.22])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 12:38:02 -0800
Date: Tue, 25 Nov 2025 22:37:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] iio: imu: st_lsm6dsx: add event configurability
 on a per axis basis
Message-ID: <aSYTpxnMLFamU4zC@smile.fi.intel.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
 <20251125202307.4033346-8-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125202307.4033346-8-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 25, 2025 at 09:23:05PM +0100, Francesco Lavra wrote:
> In order to be able to configure event detection on a per axis
> basis (for either setting an event threshold/sensitivity value, or
> enabling/disabling event detection), add new axis-specific fields
> to struct st_lsm6dsx_event_src, and modify the logic that handles
> event configuration to properly handle axis-specific settings when
> supported by a given event source.
> A future commit will add actual event sources with per-axis
> configurability.

...

> +	/*
> +	 * If the set of axes for which the event source is enabled does not
> +	 * change from empty to non-empty or vice versa, there is nothing else
> +	 * to do.
> +	 */
> +	old_enable = hw->enable_event[event];
> +	new_enable = state ? (old_enable | BIT(axis)) :
> +			     (old_enable & ~BIT(axis));
> +	if (!!old_enable == !!new_enable)
> +		return 0;

Sorry, I had no time to answer to you on previous round.
I read and found that I was mistaken assuming that the axis
is the bit that appears to be last when doing something here.
Without that assumption my approach (obviously) won't work.

However, the !! here is also not needed, the

	if (!old_enable == !new_enable)

will work the same way. This will address my concerns about double negation and
makes code easier to understand as we don't need to implicitly convert integers
to booleans and than back to integers.

(and yes, I run the updated test cases to see it works as expected).

-- 
With Best Regards,
Andy Shevchenko



