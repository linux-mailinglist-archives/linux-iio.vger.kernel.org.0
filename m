Return-Path: <linux-iio+bounces-8991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C29686AD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8F01F213DB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21791DAC59;
	Mon,  2 Sep 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7dSvRiY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9C1D6DDF
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277856; cv=none; b=qbqaLNMRyePSvb1rw0/28DJpflVRDfGlq1dd0n9KWGyvBEoR8G+0t9mR4M2/NyKeXatNF/5PiOF6bOzH9wX/UsMO98EmbG36Gb+Fm53jqFmh9OtxZaGbRiQkF291suq8YX+DJTOAzH3IMC8vpstjzyNQhN7Sh0RrcnWJkS4AeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277856; c=relaxed/simple;
	bh=nk6cuRoGekBw+hZrWspu8G8kjV0ptdE9sZSjh2MEFqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP8tmcd+ETZer1n2Phr2KiJBpdjr0oFieIPRChh+qDo6yYU1zb+j6EnyUxgY+6EsF0Vt7LfGiNSvI8pqOeHtSu1dH9Vdv+iwZ9yW3UBe307AWJrKwiM5PaYeAox4I2g/s9I0dHdlIIk3cpqKz1LyuXoJ2gFL4Um/JWAm+YjQhjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7dSvRiY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725277856; x=1756813856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nk6cuRoGekBw+hZrWspu8G8kjV0ptdE9sZSjh2MEFqA=;
  b=W7dSvRiYEWIwp0aZ2JIJ637lfQvC+YL1SdTF8kVOjB2wzeYPHkO9Dg7X
   qk7Wz+slpaXMJ26SqCy5afCZzv7TPj/gH+fsNu2UAA79jPXTJgYRvRs9D
   MCVugseSQ4tzVk/ASmGzb0n/en/4casY02CP7WS8ozGxsj6skPnyNTczr
   8G/74RMxmXKWmH9CXcnITH2crB/iGIRaoKLWSznAEO9yPQ8QUmNZboARH
   vpAq89W3ZVxaP3LMDGF50pKa3gysB64jwq/yUMQezxt+M5/5itKV51oZc
   z4DsEknGCrnS0Ou5h3SSbivAlJ8SJcrCIZ4B6n6+mWvfSWHRAlDfF5NkO
   A==;
X-CSE-ConnectionGUID: owK0yWKIT5yjXO6DKD1aNw==
X-CSE-MsgGUID: NMBpKyNLQP6o7VC8OMbOlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="27642313"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="27642313"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:49:30 -0700
X-CSE-ConnectionGUID: Ah8aTBs/T3mmQtCGVaeVJw==
X-CSE-MsgGUID: 4Smqm3uSTyOW0931MdQeEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="65306161"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 04:49:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sl5Yd-00000004Lal-3FGW;
	Mon, 02 Sep 2024 14:49:19 +0300
Date: Mon, 2 Sep 2024 14:49:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rui Miguel Silva <rui.silva@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Danila Tikhonov <danila@jiaxyga.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/15] IIO: use irq_get_trigger_type() instead of
 opencoding.
Message-ID: <ZtWmP76X95AWb4Xd@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240901135950.797396-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 01, 2024 at 02:59:35PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Andy pointed out in a review that there is an irq_get_trigger_type()
> helper that first gets the irq data then extracts the type from it.
> This saves on opencoding those two steps when the irq data isn't used
> for anything else.
> 
> Update all the sites this pattern occurs in IIO to use the helper.
> In a few cases there will be a slightly different error message is
> somehow there is a valid irq number passed to this call and it doesn't
> have the data associated with it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are some nit-picks, up to you how to proceed with them (only one seems
better to address is where the reversed xmas tree ordering is broken).

-- 
With Best Regards,
Andy Shevchenko



