Return-Path: <linux-iio+bounces-27758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B297D1DE4A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 11:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D3CA3016343
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770873815DB;
	Wed, 14 Jan 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeJFjVOP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D431E11F;
	Wed, 14 Jan 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385621; cv=none; b=kf4OqGYZyrBwBfLPyXOIxdLLpDJuzOhyv1XpuZvzW4y+2V3PyiJ/3LqGUdEFdFhbbabzt6oxL8kZbbmK2MlLPR0TTvaS0luRoAwZgTmHALwYsvEX7/r4EC1ZosrB/7Yhdc+0rHzv9TQ4LUNb+nZjEnztqDzsSPelyXg1/BcOxOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385621; c=relaxed/simple;
	bh=lN+XCgneLKX60oM5qLdQP/1Qox5jTDXSQU+lrBvCYe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRvwyvrAPN+2QgmVUHZhPIPyG8N/xWiMJ3r/UWK6l8g5y++MJ4YMb6RBEDfbiwXj8K2xZnPj6ZUzxS5lwhTwvelRgjaNSHuKA+O7UsWvFcgTCEKdXhdHfigpARPHwKuPAyBFLRXMrIER/wPIR7OAdnkCUVEyJjWafv6Y1ltXo6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeJFjVOP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768385619; x=1799921619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lN+XCgneLKX60oM5qLdQP/1Qox5jTDXSQU+lrBvCYe8=;
  b=IeJFjVOPca4EqZwCfhfvCb8C/uJYM1+EL07O9RIO7YG8PhMopPSmshQH
   wvzgkaLY+KcFJlmGz94yyeGCjlJFpavG42nVN3C3alwTgEK7EN+ZzTNvG
   +qBzqLLXQm+8xYcUyMIxebxVGQHsEVJ6/8yxx/+SpISFWPNVe9g1F47aJ
   tGH/ukLkx1qNy1XA9ctDHOJLjI07aYgUJB0Nd5J2OPRY8VGSh5dg17yo5
   Xyg/KcGia5BOiP49wJFdonJvh7SESDKpAMlUTszGtivNMqKNh52Af+53k
   lZKNXYpwe52i34r7TIl0mfoAYIxzxaH1w0y1Xwp71n+8S3KFM7q4x7GHd
   w==;
X-CSE-ConnectionGUID: n/G4lgw+Sz+Uj76svS2Fpw==
X-CSE-MsgGUID: JKXL/c5eTyybPTlv1l0FPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="68688042"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68688042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:13:38 -0800
X-CSE-ConnectionGUID: RTsKeBZ/TlSioJZemVS5pQ==
X-CSE-MsgGUID: o8zCBOzWQHiBUAORpJH7IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209146353"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 02:13:36 -0800
Date: Wed, 14 Jan 2026 12:13:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/13] iio: pressure: mprls0025pa: fix interrupt flag
Message-ID: <aWdsTf5l5hyw1qr0@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
 <20260114-mprls_cleanup-v2-3-5868b0045316@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-mprls_cleanup-v2-3-5868b0045316@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 12:05:37PM +0200, Petre Rodan wrote:
> Interrupt falling/rising flags should only be defined in the device tree.

...

>  	if (data->irq > 0) {
>  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> -				       IRQF_TRIGGER_RISING,
> -				       dev_name(dev),
> -				       data);
> +				       IRQF_TRIGGER_NONE, dev_name(dev), data);

No, this is still incorrect, should be plain 0 here.

>  		if (ret)
>  			return dev_err_probe(dev, ret,
>  					  "request irq %d failed\n", data->irq);

-- 
With Best Regards,
Andy Shevchenko



