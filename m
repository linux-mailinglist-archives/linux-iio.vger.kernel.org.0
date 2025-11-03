Return-Path: <linux-iio+bounces-25859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0EC2DE83
	for <lists+linux-iio@lfdr.de>; Mon, 03 Nov 2025 20:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8AC64E6FE0
	for <lists+linux-iio@lfdr.de>; Mon,  3 Nov 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD334D3AE;
	Mon,  3 Nov 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVcPP52j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440EF1F5842
	for <linux-iio@vger.kernel.org>; Mon,  3 Nov 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198252; cv=none; b=kZ8D9T7EJOcituRarqCkA9pkFscjs7cxhOudKvv37y17vDPumlcFhjS81kGGLGXiLnW4i4R52rHxegrEodnCLtWK6lrj1l4Von/fBn/RFLor9sqYII9DpdicpOi/2731u4cEfX227q1/+fg8RMjyElyjb5Oae0nREx7YHF38pZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198252; c=relaxed/simple;
	bh=YHBAC6juqzw9QNKr8JnqHv6/9+EyVEJoViTpmSKU51E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmwqSTjuDtVbOzU/EDyoB6Zhlfx+qcWyHTRX1OilZt2YXRyo4Y2y9Cgw83xqhy2uzJg7+EhZqtGwrd7TtL9IvZNNEqoY8awR6eyGIEViGrfJAQFELtTrVxtRLfOhVs4n5PA2eb15GaoVO7EJRo502eFDsixpheXr3W/WQeuNUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVcPP52j; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762198250; x=1793734250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YHBAC6juqzw9QNKr8JnqHv6/9+EyVEJoViTpmSKU51E=;
  b=GVcPP52jRhCBMnNikaAxVgagPSWTGObyRIY4UOAK3imfCpm3qY4yVgRs
   212epVyUWXuDclT4QKmZXpz3cdhFet05pQubVq3K/MLbJh3tEMJzTFM5d
   H0XfD6znrRcESg1uEeoErNGdY8WkLuXxiXZBguHKE8+RgXQkZYdhiaz78
   grU0FzQPqx7xD0xbsUllzXqMnxQDGd+u3h7TXVczgP8ngf5l1dKbrIvQn
   6kYuWziiLJfD+Y1ZO2GI3rLtgtN8Z0TUx+DfFvEp761obExNtLmskkI0E
   ttFs532BNdwEfNmU214F2sJYfA3F2jMf734cG+zdmv6XRZb08TUIyXt9V
   g==;
X-CSE-ConnectionGUID: A+OjbNldTAmI3981XKTjFQ==
X-CSE-MsgGUID: TsKH7yCQQOSz9/hwX+Howw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63485847"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="63485847"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:30:49 -0800
X-CSE-ConnectionGUID: sN2cPSdYRxiAZ+a/5eeeWA==
X-CSE-MsgGUID: Wj7QQOk2QD+BaylHIYFZEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="191044392"
Received: from smoehrl-linux.amr.corp.intel.com (HELO ashevche-desk.local) ([10.124.220.216])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 11:30:48 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vG0GJ-00000005FZR-0h56;
	Mon, 03 Nov 2025 21:30:43 +0200
Date: Mon, 3 Nov 2025 21:30:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <aQkC4kev0hR9-yQU@smile.fi.intel.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
 <20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
 <20251101164612.449606c2@jic23-huawei>
 <aQhcFl4fE5Akn397@smile.fi.intel.com>
 <3c82c959e714ec8507d2c28494bb24d9146cfee3.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c82c959e714ec8507d2c28494bb24d9146cfee3.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 03, 2025 at 10:40:20AM +0000, Nuno Sá wrote:
> On Mon, 2025-11-03 at 09:39 +0200, Andy Shevchenko wrote:
> > On Sat, Nov 01, 2025 at 04:46:12PM +0000, Jonathan Cameron wrote:
> > > On Fri, 31 Oct 2025 12:31:27 +0000
> > > Nuno Sá via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

...

> > > > +	st->d16 = cpu_to_be16(val);
> > > 
> > > Should have an include for this.  Probably
> > > 
> > > linux/byteorder/generic.h
> > > though the kernel (and iio) has a random mix of that and
> > > asm/byteorder.h
> 
> Yeah, I did tried linux/byteorder/generic.h but it fails to compile if it's the first 
> thing we include so I did not wanted to go that way :)
> > Can somebody go and fix all of them to be asm/byteorder.h? Yeah, it might need
> > some thinking as in some _rare_ cases the author might imply the explicit
> > choice of the algo in use. But then it might be problematic on some architectures
> > as well...
> > 
> > > Hmm. linux/unaligned.h is using asm/byteorder.h so maybe that's the better choice
> > 
> > Yes.
> 
> Hmm, so linux/unaligned.h or asm/byteorder.h? For the spi version I do have
> linux/unaligned.h beacuse we use some APIs but for i2c there's no use on unaligned so
> it feels a bit odd to include it?

Maybe I misread what Jonathan said, but I meant that asm/byteorder.h is a
better choice over other *byteorder*.h variants.

-- 
With Best Regards,
Andy Shevchenko



