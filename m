Return-Path: <linux-iio+bounces-23225-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E3B34239
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048C35E3293
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E6722576E;
	Mon, 25 Aug 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yn+fwLK5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795320C029;
	Mon, 25 Aug 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129536; cv=none; b=bLWD/QzLkCkNRVAY0SaTLYRzIDITieQCGCPdSpMZoerqek6J5M5Q1FW8XV3lYo54JqEr69Ukd1kIIViVH3dsde9a8VbSQFQF9hRPbIs3j6CYIEMBgz8zGZM3pULbcunCYF91SgxH1tOP+GFVehrnVI49EXv5Do7gI2PhkAzglig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129536; c=relaxed/simple;
	bh=n7ZHLlBmC4F1BWBZeTgA+4IUwpxd7p86l4X75gcH31Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVwk2yQVNXZLRpuaRH/3p9s9JZYY2K52EjptCgYh+SehODUjRvKQWSgCkyadKUvXOlsw2F/GHvWf5KTAlGrUZbvXiHbvxl6XJ2lfYWkb2xANMKdeAQNB5a5/naiJCqI/dZRiQPVFkCGL0hJWPj923jFdTq6NQbiV7RpJ9cmSY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yn+fwLK5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756129531; x=1787665531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n7ZHLlBmC4F1BWBZeTgA+4IUwpxd7p86l4X75gcH31Y=;
  b=Yn+fwLK5KS5vTfJLuAs1XNo2eumHHAfPSDEVseN6/bFRmUJSe39cHECF
   G52uHSDvUFTq/n8/ooKC6AQ4yTBQeqShkpSUbPKvd7YdrLRPIIpmmyc/O
   ochIwnH/SXQVimbVNnDTP6bSlDMSDOvbAlK4LbZH+Lr2UKvYDQCwOMMyv
   i2l1rhfX6ecqfRX7UzOfox8JRN5ZBiELEGCEMfsVOBXeXBEADQ87Xc9H9
   YIP0+SWc/w7UMGZkcyfIFwQ/cg9ZmexbC0/xM8pSBm33OcBgrMlMPWYJa
   7XRNMP7nGTW6dm6wx+c6eJZ51HKNS0xT0LTlTcDdWqrsEErQByTOpdMKQ
   Q==;
X-CSE-ConnectionGUID: Ms+J5/bFQBKu0fst8Dj4bQ==
X-CSE-MsgGUID: vsbbEL0PTDKk2rJ983wtkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11533"; a="45915400"
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="45915400"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:45:29 -0700
X-CSE-ConnectionGUID: o0MvBfN4QLmX+NrkZDza2g==
X-CSE-MsgGUID: CwROL3g6SrywqEUCX2CcVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="169689837"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2025 06:45:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uqXVj-00000008WRr-3bJT;
	Mon, 25 Aug 2025 16:45:23 +0300
Date: Mon, 25 Aug 2025 16:45:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Nechita <ramona.nechita@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: adc: extract setup function without backend
Message-ID: <aKxo87Pey5nzlP5G@smile.fi.intel.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
 <20250825105121.19848-4-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825105121.19848-4-Ioana.Risteiu@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 25, 2025 at 01:51:18PM +0300, Ioana Risteiu wrote:
> Refactor probe function by moving the initialization specific to
> communication without iio-backend into a separate setup function.
> 
> The purpose of this modification is better code organization. No
> functional changes intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
But there is a nit-pick.

...

>  	indio_dev->name = st->chip_info->name;
> -	indio_dev->info = &ad7779_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);

Hmm... Not sure about this split, as I would definitely keep logically coupled
things together, like channels and num_channels. Otherwise it will be harder
to maintain and more prone to subtle mistakes.

-- 
With Best Regards,
Andy Shevchenko



