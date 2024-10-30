Return-Path: <linux-iio+bounces-11619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576619B665A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029881F219AC
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396F1F131C;
	Wed, 30 Oct 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl6ppK73"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860026AD4;
	Wed, 30 Oct 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730299678; cv=none; b=F4kR9t/7N+9xCWz7AiHXH3H4i8wpHqr9unf8oqJsrCiL4bZ41Ta1PTykGxmtg+qNNK/ShNH+GaC5QUC2NTDTgAhTkUt1RhOuMO7sxCquJo+ZoGhR+3TeuoM7zWWd5gtb32OsjTvYble8Pvd3s/jWmyLUu9HRTLBzPKv+7fQIPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730299678; c=relaxed/simple;
	bh=0qNSMhz3HfQ8pdlxFtN+Wf71hTW7vNFz35H/uAF59sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iegqSckwzbowW2JOXRb1BUZxFVMBa3d3NLb4w1Rsea3LJNsWc3H02znT+/9QpPk+y7aGWUp5opYP5dcRFMwE938lENK5FRvLKttuzXq15wSHAeig2vVtbX6z29C5MMvVAGJXQhOcoOFFkIZ1spm7A5Bgzz/keIThLTPMxV0rNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl6ppK73; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730299676; x=1761835676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0qNSMhz3HfQ8pdlxFtN+Wf71hTW7vNFz35H/uAF59sE=;
  b=kl6ppK73J7olNGNpxAg5vim5/wE3hMOYNqIMfIDUrYim1XI/0q24dhq2
   /hCKbq5Wy03bea/L0xsI0uF9YT46reU73d+MQ+I1x+IiY+BpyGZlf87Tr
   om+/UCCSjhUO4Cf9MWvGUCbKZQptZDrrO4+zWfrmd5nzcUUs0VnNSHolq
   IUSgWGSW7U1HCkVNjRfQL4mL2SGMlccXvlY5sV2zHSQt4IR2RKnPdoXL3
   KDazDHlu52RCXd8jyp9tDtAUMhgfNuCMVcDk+UXrh8zCsQ/tbj6PtOyDN
   Vkk4kumIuqAosSBFrN+CXy7tve/27lXDd0jAl4cd5X4/ffuy+iH4wX/Xa
   w==;
X-CSE-ConnectionGUID: YUBURptFSb2/bmuvyfI9fQ==
X-CSE-MsgGUID: jefUExjlSpGu5F+LSedmCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30108723"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="30108723"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 07:47:55 -0700
X-CSE-ConnectionGUID: EdP2Z8J1Q7Ol8IOnqn7q3Q==
X-CSE-MsgGUID: CDc8J2m5RWyO1yL2qRqb/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="86889613"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 30 Oct 2024 07:47:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 838EC1FD; Wed, 30 Oct 2024 16:47:50 +0200 (EET)
Date: Wed, 30 Oct 2024 16:47:50 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>,
	Paul Cercueil <paul@crapouillou.net>,
	Sebastian Reichel <sre@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: consumers: copy/release available info from
 producer to fix race
Message-ID: <ZyJHFp6vbQ7deLFs@black.fi.intel.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
 <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-iio-read-avail-release-v5-2-b168713fab33@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 02:54:15PM +0200, Matteo Martelli wrote:
> Consumers need to call the producer's read_avail_release_resource()
> callback after reading producer's available info. To avoid a race
> condition with the producer unregistration, change inkern
> iio_channel_read_avail() so that it copies the available info from the
> producer and immediately calls its release callback with info_exists
> locked.
> 
> Also, modify the users of iio_read_avail_channel_raw() and
> iio_read_avail_channel_attribute() to free the copied available buffers
> after calling these functions. To let users free the copied buffer with
> a cleanup pattern, also add a iio_read_avail_channel_attr_retvals()
> consumer helper that is equivalent to iio_read_avail_channel_attribute()
> but stores the available values in the returned variable.

...

> +static void dpot_dac_read_avail_release_res(struct iio_dev *indio_dev,
> +					    struct iio_chan_spec const *chan,
> +					    const int *vals, long mask)
> +{
> +	kfree(vals);
> +}
> +
>  static int dpot_dac_write_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int val, int val2, long mask)
> @@ -125,6 +132,7 @@ static int dpot_dac_write_raw(struct iio_dev *indio_dev,
>  static const struct iio_info dpot_dac_info = {
>  	.read_raw = dpot_dac_read_raw,
>  	.read_avail = dpot_dac_read_avail,
> +	.read_avail_release_resource = dpot_dac_read_avail_release_res,
>  	.write_raw = dpot_dac_write_raw,
>  };

I have a problem with this approach. The issue is that we allocate
memory in one place and must clear it in another. This is not well
designed thingy in my opinion. I was thinking a bit of the solution and
at least these two comes to my mind:

1) having a special callback for .read_avail_with_copy (choose better
name) that will dump the data to the intermediate buffer and clean it
after all;

2) introduce a new type (or bit there), like IIO_AVAIL_LIST_ALLOC.

In any case it looks fragile and not scalable. I propose to drop this
and think again.

Yes, yes, I'm fully aware about the problem you are trying to solve and
agree on the report, I think this solution is not good enough.

-- 
With Best Regards,
Andy Shevchenko



