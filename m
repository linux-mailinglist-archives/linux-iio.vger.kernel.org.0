Return-Path: <linux-iio+bounces-20888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F179AE3658
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 08:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF99188FD3F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F31EEA5D;
	Mon, 23 Jun 2025 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grwBN8c2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D3B1E519;
	Mon, 23 Jun 2025 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661670; cv=none; b=Ni/tWPWx6LBBWhyUguP6Um5Esx2HiOL/L4wAMBq1LkHXJS6F/JFFUSozM9qAEQdBw76aXll6l01XJ9EV/jmnwh6yERrlyO5ZhkN58uyKwg45ZcGigZ1i1qOQqN0aVUfXDMzYPSLS5aKbrE6IX/gIXSwg7MdE3QFPPsoaEcxFXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661670; c=relaxed/simple;
	bh=qBJRC5UhjRWwqThbeuRLLpmyFgT1YaRzLDVFuh+gVSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXIQlrTIwFJ8AM47WANE655J0b4ZjkWgDzdd2dCgf0vulRT09NvRCmKLCUGNzFQiM2IT/fi6U4kEsLqQVQKmgz7sZgDNcr4Y8TtLrQhaQ/kSBM1S7mYqEoMmYyu5tn7aS2YDV79GLWumzK1Rcy4mMnuLaHaAqkE3HZ4mW0PMlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grwBN8c2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750661669; x=1782197669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qBJRC5UhjRWwqThbeuRLLpmyFgT1YaRzLDVFuh+gVSU=;
  b=grwBN8c2DF0Wtdiv970NQNpAoFDqCTc7e0/GJdzS0pNZNDRu8tAjaHvG
   ctmkxYmEAKPeUVbgG08N3QduFdC/WBah/p/ANL4yj/McxYErks0kCcvgt
   r8TIrsRKVNJ5PGrZ+ZAqLjszOs2B/4TGZ1OcKXplQA/hmdKjudE2HYZek
   h6/KXBYSw2FlxzQgw1IjI7R9+t8Ixakxon5nJdQ9nJ7egA+8CBKO/PRMC
   g/5UT9SlbkW8qv7NHqiSBWFPZBcoNav7Dxz3ruSRsbda+wkM0pV55p282
   I7azQHJUuSHO8OR+68/YdPpDVtV0SzD1VJZHjda8onwyEwlQDxZX5ygkA
   w==;
X-CSE-ConnectionGUID: m7aVnkL9S8eejT4xOydzBA==
X-CSE-MsgGUID: Bi+Vpcv1RzyupmER4o0kkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63461109"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="63461109"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:54:13 -0700
X-CSE-ConnectionGUID: 40XZyqUmSxS2q+lYiKYLjw==
X-CSE-MsgGUID: iHSj7DzbR3eWzhdd+VGBZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155524540"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:54:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTb4A-000000095Va-3oBG;
	Mon, 23 Jun 2025 09:54:06 +0300
Date: Mon, 23 Jun 2025 09:54:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/9] iio: adc: ad_sigma_delta: use BITS_TO_BYTES() macro
Message-ID: <aFj6Dv1kKFe9ijvr@smile.fi.intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-3-0766f6297430@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 20, 2025 at 05:20:09PM -0500, David Lechner wrote:
> Use the BITS_TO_BYTES() macro instead of dividing by 8 to convert bits
> to bytes.
> 
> This makes it more obvious what unit conversion is taking place.
> 
> In once instance, we also avoid the temporary assignment to a variable
> as it was confusing that reg_size was being used with two different
> units (bits and bytes).

...

> -	size = DIV_ROUND_UP(reset_length, 8);
> +	size = BITS_TO_BYTES(reset_length);
>  	buf = kcalloc(size, sizeof(*buf), GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;

Hmm... On the rough glance this sounds like some kind of bitmap
and hence bitmap_zalloc() (and other bitmap APIs), but I am not
sure.

-- 
With Best Regards,
Andy Shevchenko



