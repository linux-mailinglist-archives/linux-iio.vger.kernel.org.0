Return-Path: <linux-iio+bounces-5895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C93968FE410
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 12:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786AC1F235AF
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F8194C95;
	Thu,  6 Jun 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UiyYus/d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B8194C70;
	Thu,  6 Jun 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669067; cv=none; b=bXck0rA//It1ShO0jz5BS9gAwd2ljpjOx2V2zu/CJuC3h9u8FVmxrJEJ/CkRPtB440tfxXiS2L5uUYT0t+uukQ92Vvt3wB7hV5F89f3FW33OLWUjr9s1+j3LSKDS/hJ6mm6MBFzRdw6ucbXRKjAY6sP/9Sy+BhkVd7H1KdzN6l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669067; c=relaxed/simple;
	bh=izQg9vdBQ3XHJ+BM/CW9WhLY3IAzyIj2Vi9Wn6+3sKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCAINWIAYWzB43Nfxl4rOX0WYlraD5GZZVPzqbqUcpMc3cGWs3VwYN5gM2kKbBA16F67xnBIJzHIhB/fyyx9V249/Sga7rm6J4iJBupLDNenN9dStPKARcl5l64iYzXAisDB07l3T5MvZPkezGy07YT9kwRhXzh7Ve8qZHx6uDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UiyYus/d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717669066; x=1749205066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izQg9vdBQ3XHJ+BM/CW9WhLY3IAzyIj2Vi9Wn6+3sKA=;
  b=UiyYus/dCpbzaiW6z/TQi4yq5dKehwHd4BopldaZAmwEnvLoArcevq8l
   qOTtZ5e0xWtSNJaLlmusxts5Wa7jxaAn9Scy3XpPswN03BmRz7BI/vYfz
   NSbEDxf9I+xB5rW207+W4nGp6x3d29ioaJ6uVERoDhi82i1qMRsNYN9nn
   NcQYEBkWgMT6wsh8gD3KTwmX7gu/DeRl2CFUDBHi25QSPa4x165//K7ms
   IZcbtPqlbWtAqkkau+eTvFqinV+JEpVAM+ds9/zNpcrafce6kPiHzRLiB
   d/pyekLDXv0iWeBBbpxcoscfQfyUFbTRk/VhSAeWObho6VqVmyen7Fmj0
   Q==;
X-CSE-ConnectionGUID: Xwh2F62+SCS9h5C1RW6ueg==
X-CSE-MsgGUID: 8U2WxuKbSnGbi1Vggzo5dQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14130021"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14130021"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:17:45 -0700
X-CSE-ConnectionGUID: rltQj9RWSieZBDm9RlCi6w==
X-CSE-MsgGUID: iemh3MQ0TOqj84jpUIA+Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="37881331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 03:17:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sFABf-0000000E8Fy-2JP4;
	Thu, 06 Jun 2024 13:17:39 +0300
Date: Thu, 6 Jun 2024 13:17:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno Sa <nuno.sa@analog.com>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Chris Down <chris@chrisdown.name>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
Message-ID: <ZmGMwwglUlS6_NI_@smile.fi.intel.com>
References: <20240606-dev-add_dev_errp_probe-v3-0-51bb229edd79@analog.com>
 <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-dev-add_dev_errp_probe-v3-2-51bb229edd79@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jun 06, 2024 at 09:22:38AM +0200, Nuno Sa wrote:
> Use dev_err_probe() (and variants) in the probe() path. While at it, made
> some simple improvements:
>  * Explicitly included the err.h and errno.h headers;
>  * Removed some unnecessary line breaks;
>  * Removed a redundant 'else';
>  * Added some missing \n to prink.

...

> -		if (ret) {
> +		if (ret)
>  			/*
>  			 * This would be catched later but we can just return
>  			 * the error right away.
>  			 */
> -			dev_err(&st->spi->dev, "Property reg must be given\n");
> -			return ERR_PTR(ret);
> -		}
> +			return dev_err_ptr_probe(&st->spi->dev, ret,
> +						 "Property reg must be given\n");

Even if it becomes a one line of code, it's still a multiline branch, due to
comment. I think {} is better to be there. What does checkpatch say about this?


...

> +			return dev_err_ptr_probe(&st->spi->dev, -EINVAL,

You can make all these lines shorter by using

	struct device *dev = &st->spi->dev; // or analogue

at the top of the function.

> +						 "Invalid chann:%d for RTD\n",
> +						 sensor->chan);

-- 
With Best Regards,
Andy Shevchenko



