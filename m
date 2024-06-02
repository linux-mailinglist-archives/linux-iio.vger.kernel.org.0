Return-Path: <linux-iio+bounces-5600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BDD8D74AA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B142B20D33
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF9436AEC;
	Sun,  2 Jun 2024 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAYVDWjx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD262E83F;
	Sun,  2 Jun 2024 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717321623; cv=none; b=i45F0RaeB+q7cNh2YzBnL8PLtWvCpgQXk60R7OCfdKlJi0vCSoF7A3xam/0Qj3IblyKiXU1eJXSaCe5gxRhFHENzf08V4Yb9hsmNEGvYovWzNmxunSDLJBcK58llMTvJ6qUzRwQgVlzmDDNF/z+Mv2Bmu0RSyWpe4RiCMIJA5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717321623; c=relaxed/simple;
	bh=e/MmA0lqNIytmpj8MKctzTRAhRhDttTY7BgrLSVLdcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QthvF7naIhmi4lsGQ2w3+d7ztNvEM24vHs2cxccVNvCBMghsVBhFQwEsNgbJiU7aXsgVq4+tXzka7ADNXcq2sM45qhfsE0a33+YQ4ankg/pBqnBvPaOQJ1mqxq/2QSO6o98i/92xyE821LhUSeHkcjHZL5I2YeahrpL5Kzm80TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAYVDWjx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717321622; x=1748857622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e/MmA0lqNIytmpj8MKctzTRAhRhDttTY7BgrLSVLdcM=;
  b=SAYVDWjxym4oyUhBdFIE7xWIsxRwRjahDV09FJ6UWE+/h3vOTe9V9Zdg
   YS92BveK8hXolsJkpXH7m/NIXImUFAk201qb9zY0+LVJWiTpKnVQ3AFUF
   HFuLOUxzP7cgnaL5O1vRuNYJJcMVysKsXu/aTjZNLxxWDGQhlz43UnnY1
   XGzT8IMVniQAMJiwnnq+KcAfgfSHKZEPF1ww89dKlQKJk6agvTir8uIet
   PSlIb0B8z4O1QD+yRxJANr5tdSo1hYJ3sHTHK6Efwc5Dr3XtDJO8/+MgT
   SoXWCndCjxN8Nu46QEItfRKSpPpIx/5FBXzuI04TzCRRF+PTWoJVXozNu
   Q==;
X-CSE-ConnectionGUID: p1h2xrb4RNm1Mt61L0+56w==
X-CSE-MsgGUID: 1ofNRL8DR86W+KmffbWLtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="14013857"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="14013857"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 02:47:01 -0700
X-CSE-ConnectionGUID: hB+Y+hpcRFO514COcgAVVQ==
X-CSE-MsgGUID: rCz+UrgQSRGFTu/loLXfMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="41516784"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 02:46:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sDhnh-0000000Cz9y-40jX;
	Sun, 02 Jun 2024 12:46:53 +0300
Date: Sun, 2 Jun 2024 12:46:53 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v1 2/4] iio: light: lm3533-als: Remove the driver
Message-ID: <Zlw_jVoJ7w3bTFYX@smile.fi.intel.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
 <20240531170844.1595468-3-andriy.shevchenko@linux.intel.com>
 <20240601140508.0466386e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601140508.0466386e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Jun 01, 2024 at 02:05:08PM +0100, Jonathan Cameron wrote:
> On Fri, 31 May 2024 19:56:14 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > The driver has no in kernel users and requires a board file
> > to be instantiated. Remove basically a dead code.
> > 
> > If ever needed, it can be reinstantiated and converted to one
> > that uses firmware node interfaces.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Given the header removal in patch 4, I assume these all need to go together
> via mfd.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thank you! We are waiting for Johan to tell what his plans about the driver.
If it comes to removal, I add your tag to the new version of this mini-series.

-- 
With Best Regards,
Andy Shevchenko



