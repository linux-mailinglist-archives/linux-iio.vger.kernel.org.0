Return-Path: <linux-iio+bounces-21005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C885AEBF18
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7CA3ACB97
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00A2EB5D9;
	Fri, 27 Jun 2025 18:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXROE+DY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD9B1E22FC;
	Fri, 27 Jun 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049318; cv=none; b=ADU/IAEozXYkH1o2SSRqEJYXi/6QXnTkB9G1913HELP1pZJ3GBbNYi909qTxT2evy1OyBuqD/de0QScXOUWISvdWK/EB6ocmEkPzNCycRYyAYKbjCoaAEpHJzSy1OncE4Bog8co+GY0iHFgjRFXuLPSqtXKN0/P9FFslt34+IQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049318; c=relaxed/simple;
	bh=24Rf4fcQhzVQj606dPkJtUuBP6Bx4YPQzEDioizRXAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB+N8Y1bZJsCDAh/qc5+p65gwdp1xIK4Nnb3oZVBFaRTAVy0qHzv+NWK6KZWKjmF8Wh3xj7FFZ6W6Zj4UbEH9HljmWmgkyApiu2XX6JZZQ01YLqe63OABGmHg5glsIehmrGJGK+e34PuUld7omxfrD2HN12E2tsEn5YiZgWqEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXROE+DY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751049315; x=1782585315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=24Rf4fcQhzVQj606dPkJtUuBP6Bx4YPQzEDioizRXAk=;
  b=OXROE+DYL8Da23/djCv8m/Y5dJmiJP//uoeriQKkanpiB/oZQ58LbTci
   mR2P392UmODPtCUclh1rQqmw9j12IHWtK4+Hige/43KPvwk+pUPcWu8iM
   jTItJ7/f20JFpQFArhLbX4e42D9rMsKeRVJQ+IADk4bQ9TGNdwb+Oz63q
   9SeKltKrVE8g2ZLxITbNzvK4siukz1eUu8ji23GRQx/yBjmVjoiXDg8WB
   y3G0302wWw7nkCtD70qizr7KQ0Y+xoyykFA4TcLR0vtsX5msQxeyyRzs2
   limcCG0tsUI68C2iwUnGUA7tmkE4S4VcW4aP466hlxPGib5XRg4kCMtf1
   w==;
X-CSE-ConnectionGUID: xi3AB4dyT72V731xuvwtlw==
X-CSE-MsgGUID: MTvBkacaQxuzbme7z86SKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53454596"
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="53454596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:35:14 -0700
X-CSE-ConnectionGUID: HTPV0Bi2Q1yQYIAVgmgZ+Q==
X-CSE-MsgGUID: s8sB29yzTseJmvQMpyBcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,271,1744095600"; 
   d="scan'208";a="183909918"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 11:35:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uVDum-0000000AYqm-04Jp;
	Fri, 27 Jun 2025 21:35:08 +0300
Date: Fri, 27 Jun 2025 21:35:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdalla Al-Dalleh <abdalla.ahmad@sesame.org.jo>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Message-ID: <aF7kW6xRxRb0VN5H@smile.fi.intel.com>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 08:51:14PM +0300, Abdalla Al-Dalleh wrote:
> - drivers/staging/iio/frequency/ad9832.c: Changed .h file location
> - drivers/staging/iio/frequency/ad9832.h: Removed struct definition

Nothing of the above explains "why you are doing this".

> - include/linux/iio/dac/ad9832.h: Added header file according to the
>   TODO note.

Also it sounds like you put three different things in one basket.

...

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -

This blank line should stay. It will delimit the groups of headers.

> -#include "ad9832.h"
> +#include <linux/iio/dac/ad9832.h>
>  
>  #include "dds.h"

> +++ b/include/linux/iio/dac/ad9832.h
> @@ -0,0 +1,33 @@

Haven't you added -M -C when preparing the patch? This will make sure you are
really copying / moving the context and show only the differences.

...

> +struct ad9832_platform_data {
> +	unsigned long		freq0;
> +	unsigned long		freq1;
> +	unsigned short		phase0;
> +	unsigned short		phase1;
> +	unsigned short		phase2;
> +	unsigned short		phase3;
> +};

Ideally this should be dropped from any global header file. If one needs
something like this, it can be propagated via software nodes.

-- 
With Best Regards,
Andy Shevchenko



