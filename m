Return-Path: <linux-iio+bounces-25460-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AABC0D756
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35B404F3AEE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9722F6914;
	Mon, 27 Oct 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8xm93v+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6142417C6;
	Mon, 27 Oct 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567366; cv=none; b=K4lK8DHzIvXG1BdgS3mWAzY6YXF4pALluV7XOnroFMTGZfnUD2+Zx1WD6rhnwxF8Arhm3CeEvHje6nGK7TzaxtlvUocG6ALCYApCwOK7JdV1o/vUFIvedpvwhYxgU6kg8Sd60WFgGR+/I0GUuQtgQNLfk8o33vdo04rXCRxkc8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567366; c=relaxed/simple;
	bh=8REW9LKAMBJhiS0mstI+h8mwfhMdGAOr9OXOtnMD0Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSDn62nkFrr6xIo4ENdmM/vhZPjXRKXOFsoHDQ27PeSO9L/LRPVPq96BLZOaZ5Pwra0Ec5TTWV5MZaXSqytVYnlqOxlk9OT1HxTUPC+6NQ5+w+SJ/pOOKhAzDcICDvPtGgvlcvQ4vhCdGdQxgGc2Ulf4c12+kdix2UStfUQ1+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8xm93v+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761567363; x=1793103363;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8REW9LKAMBJhiS0mstI+h8mwfhMdGAOr9OXOtnMD0Uk=;
  b=e8xm93v+66fqVBJf6Cb+M3YTTxA7aEvPirSvSbbKNL0o0smVFH4dENqV
   GJNQoFYvw6i3WFZk/EqE3wBUEW3AoicJ49/grkYdwLNJHAPTn221+aZ3T
   mkBcV5kX21XKFO+EWBfPauDDKysEGkvSPlJ4T3uT5NsomJWRqZtszAlpt
   8TkmtUEyJ38QU00yB3x7wQJIHXV8QeTwzugV6YG7AHcRtLkpTMPm7tjWa
   gz7W7fiOq31hWZEL0ibDIBh9y9QIZ/tNTiOinQhCcDuHGVHjr460kMaFT
   RW1qofgdKD133hZXKh7Z3gICRVLUWP5ePMulELva5Xit9HNzSh4+CoLbX
   A==;
X-CSE-ConnectionGUID: Tc2q9bcqTcClu3hKqswe5g==
X-CSE-MsgGUID: 80O+vkqqTpK38000zhvywA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74318623"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="74318623"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:16:02 -0700
X-CSE-ConnectionGUID: kdjWm1B2Qb+/jb+kz3dkCQ==
X-CSE-MsgGUID: TzrTW4HSTBGRQ7bZdVSNpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185113205"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:16:01 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDM8k-000000030ZN-19vW;
	Mon, 27 Oct 2025 14:15:58 +0200
Date: Mon, 27 Oct 2025 14:15:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7124: change setup reg allocation strategy
Message-ID: <aP9ifk-ms8RJi5ff@smile.fi.intel.com>
References: <20250923-iio-adc-ad7124-change-setup-reg-allocation-strategy-v2-1-d9bf01bb3ad8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-iio-adc-ad7124-change-setup-reg-allocation-strategy-v2-1-d9bf01bb3ad8@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 23, 2025 at 04:48:04PM -0500, David Lechner wrote:
> Change the allocation strategy of the 8 SETUP registers from a least-
> recently-used (LRU) to a first-come-first-served basis.
> 
> The AD7124 chips can have up to 16 channels enabled at a time in the
> sequencer for buffered reads, but only have 8 SETUP configurations
> (namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
> shared among the 16 channels.  This means some of the channels must use
> the exact same configuration parameters so that they can share a single
> SETUP group of registers.  The previous LRU strategy did not keep track
> of how many different configurations were requested at the same time,
> so if there were more than 8 different configurations requested, some
> channels would end up using the incorrect configuration because the slot
> assigned to them would also be assigned to a different configuration
> that wrote over it later.
> 
> Adding such tracking to solve this would make an already complex
> algorithm even more complex.  Instead we can replace it with a simpler
> first-come-first-serve strategy.  This makes it easy to track how many
> different configurations are being requested at the same time.  This
> comes at the expense of slightly longer setup times for buffered reads
> since all setup registers must be written each time when a buffered read
> is enabled.  But this is generally not considered a hot path where
> performance is critical, so should be acceptable.
> 
> This new strategy also makes hardware debugging easier since SETUPs are
> now assigned in a deterministic manner and in a logical order.

...

> +#define AD7124_CFG_SLOT_UNASSIGNED	~0U

Perhaps one of Uxx_MAX should be used instead?

-- 
With Best Regards,
Andy Shevchenko



