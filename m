Return-Path: <linux-iio+bounces-11883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305E89BAE4D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC34B1F231BA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D1195811;
	Mon,  4 Nov 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GN63/JWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7C718BB93;
	Mon,  4 Nov 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709663; cv=none; b=MsUQplIHRTldUnSbv6HWkVPK1NNGr2NIxl8PxDMcE8QT7roQzs3gub/5D7OSDzdGwForX3vGc8kwGNopuWFf5F6QeZFmX+IsO8CFtdkCgJi6FY3r2mYoKNfxGHob4uOKYJssqjMgfq37HpToyhkXGYcUa3E9t1hq4Rc6HUZUHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709663; c=relaxed/simple;
	bh=dQ2Nrwr8qCKLCZXi+hDpCYjvtmhoN1vcdUbtbhzg0e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYEqwi5CEcLwCsTxcEXvemTkYra28IpR5+4f6yqslUH2LxqmsWoTUjhWCupKOdPjkza0VIkJcCPF0xPD/TLI+K/4WqndEnhf4phhABHdrg77zIPXa+/MaKpQl2ZsmVf4+dHsFYuoenKZF/g6XIew8rTXCEi57+WhCvz6Sc1WukU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GN63/JWn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709662; x=1762245662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQ2Nrwr8qCKLCZXi+hDpCYjvtmhoN1vcdUbtbhzg0e4=;
  b=GN63/JWnGoC/22jVMSM+Gz+X1FLcbZMfmE1wTXGSSp/I7qUPIuhxbA+k
   E6LZUIkcMA2SNlOIxnivH4Dj+WcXGWuxvSRp/BiSJYrQeWQMk7knEWUrS
   wpHnTg4CphCttq+ELrL2Ix6hKRDHqAhGrSuooffyAoZFRqwUIDTcyfkOx
   hLRmy0dmjE6gqZ9hiuLAAGxugu2AnOvevE7tjj6Dq79UgWADsUnWfHLna
   1qLXO4+h/tdGg4lGHQtnuyLc7/a3co0S7bmu6ZtEkU24SHN6D89Amp8FJ
   ZDim/I8A66sKX2ouQXXb/zeXiN9OinPd1/rN8MKKZ9OklUz4IKstx8Lfc
   A==;
X-CSE-ConnectionGUID: FmS3aKCJS/+tGlZMnj218Q==
X-CSE-MsgGUID: f4vaQSfmTC+K+9hgtWRung==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30498316"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="30498316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:40:24 -0800
X-CSE-ConnectionGUID: dxjsGfaERoSkVhACXThpVw==
X-CSE-MsgGUID: 3wo+BoLAQjG0Cnx6nxvy6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="87520297"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:40:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7sdE-0000000Az6Y-1XIN;
	Mon, 04 Nov 2024 10:40:16 +0200
Date: Mon, 4 Nov 2024 10:40:16 +0200
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
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102195037.3013934-11-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 02, 2024 at 03:50:41PM -0400, Aren Moynihan wrote:
> Using dev_err_probe instead of dev_err and return makes the errors
> easier to understand by including the error name, and saves a little
> code.

...

>  #define STK3310_REGFIELD(name)						    \
>  	do {								    \
>  		data->reg_##name =					    \
> -			devm_regmap_field_alloc(&client->dev, regmap,	    \
> +			devm_regmap_field_alloc(dev, regmap,		    \
>  				stk3310_reg_field_##name);		    \
> -		if (IS_ERR(data->reg_##name)) {				    \
> -			dev_err(&client->dev, "reg field alloc failed.\n"); \
> -			return PTR_ERR(data->reg_##name);		    \
> -		}							    \
> +		if (IS_ERR(data->reg_##name))				    \

> +			return dev_err_probe(dev,			    \
> +				PTR_ERR(data->reg_##name),		    \

AFAICS these two can be put on one.

> +				"reg field alloc failed.\n");		    \
>  	} while (0)


...

> @@ -654,12 +652,11 @@ static int stk3310_probe(struct i2c_client *client)
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct stk3310_data *data;
> +	struct device *dev = &client->dev;

This should has been done a few patches earlier...

-- 
With Best Regards,
Andy Shevchenko



