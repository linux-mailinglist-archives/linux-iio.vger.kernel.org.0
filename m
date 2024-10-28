Return-Path: <linux-iio+bounces-11479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81849B33EB
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC9B211D1
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2871DE2A7;
	Mon, 28 Oct 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft2yK+UT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AA91DDA1B;
	Mon, 28 Oct 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126683; cv=none; b=dpwamw7Mrp97nJfwiNYZ8j3ScmO2IxlRYj7fXDI4CeEGgFJg1oJVW3wiHNa6Gy5z8FoaRjDs+pDMe8GC1i9eE7DOP6lWRh2hkkuO48Lq1M29NZUVlVGuMHKB0F2nNFRN8O9X0bjuELJm2BKLRpA41Ytu4+OI/3D4ewfQrO6UefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126683; c=relaxed/simple;
	bh=Bfgx/pN4+ZpmTPUi9k1nDEyQyXcONpELcSCUR7eiAy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4vacbgGiE9ofsmMS9pfCTq1hkDanZhxTx9EH8tiJFiU+RapYDxIazI+3uPLkYGCR1wMLn6nZfA6eooEKjb5RODrot0/i6iLnM6AtW7wujFW1vFvE+L2/q+nAdTad/RZIdtINEEb2K2MFvdH14YgmPLAL+Ojes1+9Wj67cdbV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ft2yK+UT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730126683; x=1761662683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bfgx/pN4+ZpmTPUi9k1nDEyQyXcONpELcSCUR7eiAy0=;
  b=Ft2yK+UTjN3GfsAJp4TFFqHfuAv8DMeeN3inolOlUKCbQgbaRF1CE4+T
   9CJ/iS1Nk47YSIosSN+Y5FbiMDMnmcNv6UV9KzXffW8He+xO4snGQsRqk
   +E5Dv6rayRjYOy4llqhHIiKom3TP2hsoERTKVwrDFBS0XiPPSH/IdpSvw
   YJ3u9TV2YTwH7PEv1g0NyTUA1t4uaiqxNVGIyST9HhTTAeaW+OhRBcKmC
   nIYQTHsxw+7fnfSvGmemyVuPomQaowa+qDsal9Bp9Sbi4KMVCU2hqDcqe
   759Bqzm5WoArY8+rTDhmSj6P323HvRHwo0mQULJiqFyrsulZuF1Sc9uST
   g==;
X-CSE-ConnectionGUID: eesB9AvyRXC2Oua1Alcsfw==
X-CSE-MsgGUID: zQ7lGl2sR6q7AgbIiOuTmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40824954"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40824954"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:44:42 -0700
X-CSE-ConnectionGUID: Ys/a85DwTkujR009Uj6D1A==
X-CSE-MsgGUID: HVRckoVjRQaYZ+L5JfieUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81216495"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:44:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5Qyv-000000085jT-3zhr;
	Mon, 28 Oct 2024 16:44:33 +0200
Date: Mon, 28 Oct 2024 16:44:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <Zx-jUeQ9UbZt48ss@smile.fi.intel.com>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-5-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028142000.1058149-5-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 28, 2024 at 10:19:58AM -0400, Aren Moynihan wrote:
> Using dev_err_probe instead of dev_err and return makes the errors
> easier to understand by including the error name, and saves a little
> code.

...

>  		data->reg_##name =					    \
>  			devm_regmap_field_alloc(&client->dev, regmap,	    \
>  				stk3310_reg_field_##name);		    \
> -		if (IS_ERR(data->reg_##name)) {				    \
> -			dev_err(&client->dev, "reg field alloc failed.\n"); \
> -			return PTR_ERR(data->reg_##name);		    \
> -		}							    \
> +		if (IS_ERR(data->reg_##name))				    \
> +			return dev_err_probe(&client->dev,		    \
> +				PTR_ERR(data->reg_##name),		    \
> +				"reg field alloc failed.\n");		    \
>  	} while (0)

Same remark, if client is not used here, supply struct device pointer directly
and make these all lines better to read.

-- 
With Best Regards,
Andy Shevchenko



