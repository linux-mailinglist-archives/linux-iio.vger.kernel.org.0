Return-Path: <linux-iio+bounces-21908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D48B0F56F
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 16:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8287AC5032
	for <lists+linux-iio@lfdr.de>; Wed, 23 Jul 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B52F49FC;
	Wed, 23 Jul 2025 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efwwPUby"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376D23BD1F;
	Wed, 23 Jul 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281293; cv=none; b=R8IHjK8OBaypyQs3U2PH3xJ95OLyww9x6C2ywoA7za+wTgOFIZCIls0w7asX1CmB6oCccZV4XyB8tEQgS/PzL3UVNnRQw0Zw7o2X1ja7dxQ/LWPlsBIz/DDYD04m3lRNnfCIWIijUW/pXsxBp7mS85eYxcvp6MmmEQMkEjvRflQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281293; c=relaxed/simple;
	bh=a7Wl6Hu1yG6irRzac4k+rBoiFOJEo/rF0YecZangH3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pEM/GZvPPcNGZn+ZyIanrq9VdqS58vVotEBdvVc3De227E2J09KD/eO6Unnr9psfuB3/ovYSenT+VC9CIg4ljH3RarkKMMwe5TZ0WjUlkunwflDdXgLG2LmXYZpDJwtSpNDRwZFajNbFkCiE7tUcQ24R57+NR5dkP2Ng+asn17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efwwPUby; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753281292; x=1784817292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7Wl6Hu1yG6irRzac4k+rBoiFOJEo/rF0YecZangH3w=;
  b=efwwPUbysLuVKSyf8OBjEnkKn3pLYmnETBGmtko9il1EG9zQpUPejwY3
   FZAFRokdAytLrChs1SOJr/uiSRWPrRecknUB8getGPPx8yngJrvD9Br9r
   TWEAWh0d00Id00jLfqLjGuL9F939KWxfm5CutsO2019P6y5MmadCueKCt
   PDj5qj9rcKeYwV4dEpdxkpvv0JBJTW8RRAoVWLPRMj60z5SMkwRWnJ7Sn
   x+VorENeR0xjcwUIho3qpYVxwHlvVR4zZGogeSLskukSGFB7pkUA0ytbD
   Tqj5m3xrOgS56Ip/6ZNljkqiDXMuLxbUAyiLZC+1mPulgJsbWD4lhLzo6
   g==;
X-CSE-ConnectionGUID: tQiZY6wSRcia+3k/9xoFyw==
X-CSE-MsgGUID: QKo7/3ZaQCSmvQyPOfcMDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="58181307"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="58181307"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:34:48 -0700
X-CSE-ConnectionGUID: +h2Bk6JjS5GJYf9LBIIeqA==
X-CSE-MsgGUID: cLHVUgJJS3qfaeqWk31VoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159565064"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 07:34:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueaYN-00000000JX5-0sst;
	Wed, 23 Jul 2025 17:34:43 +0300
Date: Wed, 23 Jul 2025 17:34:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7173: prevent scan if too many setups
 requested
Message-ID: <aIDzAiQT0S0-ZcQo@smile.fi.intel.com>
References: <20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 22, 2025 at 02:20:07PM -0500, David Lechner wrote:
> Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
> the maximum number of unique channel configurations.
> 
> In the AD7173 family of chips, there are some chips that have 16
> CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
> GAINx and OFFSETx registers). Since commit 92c247216918 ("iio: adc:
> ad7173: fix num_slots"), it is possible to have more than 8 channels
> enabled in a scan at the same time, so it is possible to get a bad
> configuration when more than 8 channels are using unique configurations.
> This happens because the algorithm to allocate the setup slots only
> takes into account which slot has been least recently used and doesn't
> know about the maximum number of slots available.
> 
> Since the algorithm to allocate the setup slots is quite complex, it is
> simpler to check after the fact if the current state is valid or not.
> So this patch adds a check in ad7173_update_scan_mode() after setting up
> all of the configurations to make sure that the actual setup still
> matches the requested setup for each enabled channel. If not, we prevent
> the scan from being enabled and return an error.
> 
> The setup comparison in ad7173_setup_equal() is refactored to a separate
> function since we need to call it in two places now.

...

> + * ad7173_setup_equal - Compare two channel setups

Better naming is
ad7173_is_setup_equal().

-- 
With Best Regards,
Andy Shevchenko



