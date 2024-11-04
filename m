Return-Path: <linux-iio+bounces-11881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E845E9BAE34
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AA2B20E51
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACC618B49B;
	Mon,  4 Nov 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WEwscpW2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0B3214;
	Mon,  4 Nov 2024 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709352; cv=none; b=JwZas6TyljbOEzu+t/hCKRIfmnWwMktVvKsKfmBNTKY/urwhd0BK3Kc9ekFxwywMBYSiqg4MdSUr/63I6/NxOCaFkOhcU/fPyg/xcCrlPDUH0TUohDytqM+tb79XJrK6MoPmEPldU50pS3mVn+31EctwGGQFL286nwbH9vQ2Zuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709352; c=relaxed/simple;
	bh=wbnG3byYpMqq7suN0oey1RV3b6DeAMAFl852jccRA8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErcfV6We/jGCVuMdJfQQHHCTCCLushe32wj0P0ivheSM595IXQm9xfyG3ACH+LHhAA6roFvolYZEQx8hpJxke9l3rdjVdILZQPRyBMehsg51RQHbSQTCVTKvnrrN1IuFVJeTzRJmlDaNpkIbXo9iMBwVYaaFulSF01eJ/eMg0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WEwscpW2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709351; x=1762245351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wbnG3byYpMqq7suN0oey1RV3b6DeAMAFl852jccRA8M=;
  b=WEwscpW2ObfQqM5tdKT6yTqMVNld8/kzXXaPquHXH4qwa6mR3IB4TJ6j
   IOqatU+8jcRwNhG/9+n3aKGVKVD/sWJpx0U+v1+VG2OnUX4zTonwkoYWX
   Az6RJIsKvgAdDRvYB39U5f76bhKrY8IRxMgylFqk1MtKPUaOkXw/I8fD7
   7SgARxO9ZGjAcfzMEFcGbjz8Mq9aXFgb440Z78Nzg/Z8DBXp/h+yNoiwL
   GjUN1PkO5oItlnxHLl0+6zYuCkb+oPyGYBiEc6o0nNQL+mzDeYOfDW/yY
   HIHaRIvOyYzaztGhg9KgvKE7Tl9zPdFjbq9Rgoi/IUlgV0MOFxIcArP2I
   w==;
X-CSE-ConnectionGUID: iCq12IiHQ5qFXpNvk13t5g==
X-CSE-MsgGUID: s/yRKkWjQkWuC6oy87j3kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41501572"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41501572"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:35:51 -0800
X-CSE-ConnectionGUID: vsYC28+jRu676hKNhfTnag==
X-CSE-MsgGUID: E9Ezl5rPTHGFjB7sqcjLtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88165220"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:35:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7sYo-0000000Az2S-3O3j;
	Mon, 04 Nov 2024 10:35:42 +0200
Date: Mon, 4 Nov 2024 10:35:42 +0200
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
Subject: Re: [PATCH v4 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <ZyiHXl0mRIvM4Qa0@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-9-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102195037.3013934-9-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 02, 2024 at 03:50:39PM -0400, Aren Moynihan wrote:
> The vdd and leda supplies must be powered on for the chip to function
> and can be powered off during system suspend.
> 
> This was originally based on a patch by Ondrej Jirman[1], but has been
> rewritten since.
> 
> 1: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82

Make it a Link tag...

> 

...here

Link: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82 [1]
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

...

> +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
> +				      data->supplies);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "get regulators failed\n");

With previously introduced temporary 'dev' variable these become:

	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies), data->supplies);
	if (ret)
		return dev_err_probe(dev, ret, "get regulators failed\n");

...

> +	ret = stk3310_regulators_enable(data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "regulator enable failed\n");
> +
> +	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to register regulator cleanup\n");

So do these...

...

> +	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);

Is array_size.h included?

> +	if (ret) {
> +		dev_err(dev, "failed to disable regulators: %d\n", ret);
> +		return ret;
> +	}

...

> -	u8 state = 0;
> +	int ret;
>  	struct stk3310_data *data;
> +	u8 state = 0;

Can we try to make it RCT ordered?

-- 
With Best Regards,
Andy Shevchenko



