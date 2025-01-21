Return-Path: <linux-iio+bounces-14516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD3A17EC7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F258C7A25E2
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7F31F190E;
	Tue, 21 Jan 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgR30bSi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A761DFD1;
	Tue, 21 Jan 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465929; cv=none; b=b2o7T7IWgMcYqJoVdatMDrNgJQaUS5w+nGiB7g8a4pOwzRaHiu+/WqTP8qOI2iW/P6LRQR6UdH4zjk1dbNUmpS5i0htCOG26xiab/vdyqiWJQuJMgANHUX1Hp/vC6R7RdhDFnaB3e7twMDOTwLhfhLUsNZUljLKUmmDxOZy05bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465929; c=relaxed/simple;
	bh=Arz4PPJUQLkR1zIkgAFQrT6hIY+N/0CloMvqgRfoZaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow21nG2dknhcXJoUuopAVBwPi4ABJfWukkRrCmnJnhUwBiV0HSX/z4S10JlcGN54vMfOazhTeb2VDIxg50i5cef3CK4OiNTC1jlowtvvbKB1Qm/1vj8W6bs3/5qJ7oH4O1UPRbL9g/8VvOo6iewjSUS+Rwq29fjxzXC8TM3ltSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgR30bSi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737465928; x=1769001928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Arz4PPJUQLkR1zIkgAFQrT6hIY+N/0CloMvqgRfoZaA=;
  b=ZgR30bSiewhPgJLoXYHu1EfvtDXV88bPux0e6Tznmp6ZTgyVBomF6sXp
   TUHc5EdCbXSuyHbkgSFaKTVAV1+G2QuMx14hXmw1iU+lfLlyQmMaSAs1i
   HfV1M+zs2BnvKrUC1LK/OUlbuubzGfxICSpKJausm6VaozMUm9P1JBqQy
   a2jFTb66ijISsb2LIcnIOy1aPW90gUV4ybqoDSDpL3BLlhxZ+WaBg2Sed
   qoPEvsB/ay4w/LoHmiC8w+HIBja1FCrnhDsQTAZGzIz/r8tez9vH37p9o
   5wS3XhDjCMISKP0ihX46uc33SHqo7yrpn+5y6lopOeyubT/x7ZEMFUBia
   w==;
X-CSE-ConnectionGUID: IIbWPeEYSzWemet7vDGn2g==
X-CSE-MsgGUID: m3SfdSpfSQqy0OhIQjwAVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37760992"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="37760992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 05:25:26 -0800
X-CSE-ConnectionGUID: 44cpDH+dRVmfNf0aAiLEAA==
X-CSE-MsgGUID: +V2icWPFSJ6dlBPZmXYg0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107701834"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 05:25:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1taEFt-00000003lxz-4BNO;
	Tue, 21 Jan 2025 15:25:21 +0200
Date: Tue, 21 Jan 2025 15:25:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 2/2] iio: imu: st_lsm9ds0: Replace device.h with what
 is needed
Message-ID: <Z4-gQRCIXEpvwTLX@smile.fi.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
 <20241203195340.855879-3-andriy.shevchenko@linux.intel.com>
 <Z484U1gDYolJ8CAm@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z484U1gDYolJ8CAm@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 21, 2025 at 08:01:55AM +0200, Raag Jadav wrote:
> On Tue, Dec 03, 2024 at 09:48:52PM +0200, Andy Shevchenko wrote:

...

> Isn't struct device still used in these files?

Nope. The opaque pointer is used.

-- 
With Best Regards,
Andy Shevchenko



