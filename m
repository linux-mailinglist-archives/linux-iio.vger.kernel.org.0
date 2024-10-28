Return-Path: <linux-iio+bounces-11442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DEA9B2BD3
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F541C21E96
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1377E1CC890;
	Mon, 28 Oct 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCiOpm6t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7419067C;
	Mon, 28 Oct 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108967; cv=none; b=GZ63M7I3RbNxqzRpLeob18QniMTtSsDxuoYwdia/Pv3i2ZNXmLAb4XzjS84iIeRDdJim/QiKACN3MQIsIdl6VUg9zqSWHWwYNY7+Z4b72FeT54Q0Lq2mZ0AQ1p8yWnC3IWD90zutUHXat0khYVtvSOFO7yPFwX7tDW1g/rxoxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108967; c=relaxed/simple;
	bh=njCutSTTOldfFN3W+Aa1C0i8GPO6lAFUvUePMhrmeyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZdBNg14h4y221pABGexkJyZ42+lozcBCQybAu++qc3CQMv3VMVXjvd5jsCQXRGTkUOzGb2zRHxxYKZivPItFSAn6SUy/sgQOw4wsOEXi/fYERVA7n6/4bCzgJr0P9tfgd5mJxn83MeLhLR+h5/jcnue1232wo44ObQDX0tfW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCiOpm6t; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730108967; x=1761644967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njCutSTTOldfFN3W+Aa1C0i8GPO6lAFUvUePMhrmeyQ=;
  b=SCiOpm6txSNm2a2LLmAYwFQeyPvXukI8BPJnkaHBEWEua4pp7i2w1Iwf
   Wm4FvVNW1/ML6F0EwjblfXlWnMChEuUQKGlqsSB662iHqyjfcZ3La8m3g
   E2n2ihKal92V6mpK8PU8S347a9+u+5WSXFQJIUa+dZBOdeE+T+JVuLT1B
   ZH86U9Lr02P0PHrpGyEI+xzDEhiGk1QCCYiAVI2gybkuBJyy/SWkM/6L3
   MuWlSX/+enQjkSPZFdcHVFSp4npoZcIukMemGtMYZgy/wRe8aXDeki93t
   TgVHtfaGVpdN7lObPsFOxkl36O51jj+ztsGBueJOWvQGWrXOGp3jyZrEK
   Q==;
X-CSE-ConnectionGUID: EjFr0VX1T8WUog0gn8E75A==
X-CSE-MsgGUID: dBY+SziPQjukO09V19dCeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33395155"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33395155"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:49:26 -0700
X-CSE-ConnectionGUID: mN1dhXhYRTGNGRLgBOEIsA==
X-CSE-MsgGUID: /c5Pbqy7SLaR+NevEcR8NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82384208"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:49:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5MNE-00000007tlC-0MMM;
	Mon, 28 Oct 2024 11:49:20 +0200
Date: Mon, 28 Oct 2024 11:49:19 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 12/24] iio: accel: kxcjk-1013: Move odr_start_up_times
 up in the code
Message-ID: <Zx9eHz2yMMN5UFz4@smile.fi.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
 <20241024191200.229894-13-andriy.shevchenko@linux.intel.com>
 <20241026122957.3fcbd863@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026122957.3fcbd863@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Oct 26, 2024 at 12:30:12PM +0100, Jonathan Cameron wrote:
> On Thu, 24 Oct 2024 22:05:01 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > While at it, make it clear what values from enum are being used for
> > the respective array entries.
> I did some cheeky white space additions in this one as well.
> Bit naughty in a code move patch, but I really want to get this
> stuff cleaned up across IIO and it seems silly to chase your series
> with another one changing the same code.

I like you change, thanks!

...

> > +		{0, 80000},
> I changed this to
> 		{ 0x00, 80000 }
> as I think it helps readability to have them
> all aligned
> 
> Spaces added to all entries.

Got it, please also add/fold the patch I sent today.

-- 
With Best Regards,
Andy Shevchenko



