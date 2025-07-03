Return-Path: <linux-iio+bounces-21296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88EAF75EF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25BA5189BB7A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C262E3AFF;
	Thu,  3 Jul 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnVq0hfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D9622F384;
	Thu,  3 Jul 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550011; cv=none; b=HC4oXj+HnkuZ8EyxX4cUB9FmibPbHyxHfRi2PkJAlsxpEVzx5FqrJyfHfGOw/6QA2pQfIws1e9k5c6qvw6mRK56nXi5GkiRCeNYDTnpEj5WMtcJ5pgKlmVhx3ZNNLotJ7yI90IPj63njMYTWFAgDaFNuOXqAEXPvm3n0mIPDq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550011; c=relaxed/simple;
	bh=7tjoXBgVlhft02eD+orqPpaW/4xw5wOeTcdUF5x4nz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrFCBjuQ0ko903/sLfSy1+Q66QyvftzNY2n/jlgb1gZq4ZooRCYxztO5Fx1n7NQBa18z9I/5HrCh5mFzzK4iCXS4KfwDyQYxedqdMH6dVqnu4oZRFTlvtruVZn41bgDMpY6e1u4pUhpd0SW6PR+gEqEgJwsp+oKbKLA+FDflPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnVq0hfS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751550009; x=1783086009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7tjoXBgVlhft02eD+orqPpaW/4xw5wOeTcdUF5x4nz8=;
  b=HnVq0hfSoTjfPrKKe5k0tISD1hj3wgyrvmohg4cn2b3XPTZi7ygrkVpy
   9YxrTNB6sGm16vpRYqTDvH7qqfCvQSGD3FP2SA0qS5vqnvqaszlXTMjPI
   3MHOVggxd6B+pFDaB7Abtjq+xXTLq1VUBR8qLAwzCsUcvVdbT6xc5g/0a
   QUCipQY11XLRrJgCISmOu/Wxc/SUMLCR5vTXiqLBt5S2eKtKfivWdkT+x
   Ru3l6oRZF9mZIni1CC8g9h2bmId/3kMa+jsMcP88z6cUuvI+HTm/7AjCm
   p7ptwhiBYsRJ321/NVvBeH9r4tkDD4AHwqJXFWDnWUSferA1iGqci/oWC
   g==;
X-CSE-ConnectionGUID: Flu4cnZJQmK9ALTQfqbkQA==
X-CSE-MsgGUID: 8Zonhtk0R+iVI2IB69sm8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53971323"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53971323"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 06:40:08 -0700
X-CSE-ConnectionGUID: gDTPfZpVQUS2W0Y+nOqTBg==
X-CSE-MsgGUID: qrOytyl9S62aZ1oQrJ7V+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="191554579"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 06:40:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXKAU-0000000CDXy-3qwF;
	Thu, 03 Jul 2025 16:40:02 +0300
Date: Thu, 3 Jul 2025 16:40:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akshay Bansod <akbansd@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <aGaIMjkYBmfMmCBn@smile.fi.intel.com>
References: <20250703053900.36530-1-akbansd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703053900.36530-1-akbansd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 03, 2025 at 11:08:59AM +0530, Akshay Bansod wrote:
> Update the sysfs interface for sampling frequency and scale attributes.
> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> and recommended for use in sysfs.

'must' is stronger than 'recommendation'.
Of has the documentation been changed lately?

...

> st_lsm6dsx_sysfs_sampling_frequency_avail(struct device *dev,

>  	odr_table = &sensor->hw->settings->odr_table[sensor->id];
>  	for (i = 0; i < odr_table->odr_len; i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%03d ",
> -				 odr_table->odr_avl[i].milli_hz / 1000,
> -				 odr_table->odr_avl[i].milli_hz % 1000);
> +		len += sysfs_emit_at(buf, len, "%d.%03d ",
> +				     odr_table->odr_avl[i].milli_hz / 1000,
> +				     odr_table->odr_avl[i].milli_hz % 1000);
>  	buf[len - 1] = '\n';

My gosh, this is error prone. I'm wondering when some CIs will start to
complain on this line. But this was already before your change...

>  	return len;

...

>  	fs_table = &hw->settings->fs_table[sensor->id];
>  	for (i = 0; i < fs_table->fs_len; i++)
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
> -				 fs_table->fs_avl[i].gain);
> +		len += sysfs_emit_at(buf, len, "0.%09u ",
> +				     fs_table->fs_avl[i].gain);
>  	buf[len - 1] = '\n';

Ditto.

-- 
With Best Regards,
Andy Shevchenko



