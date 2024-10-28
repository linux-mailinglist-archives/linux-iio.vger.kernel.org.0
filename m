Return-Path: <linux-iio+bounces-11478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1169B33C6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7891C21781
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DC1DDC3C;
	Mon, 28 Oct 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ox2ej3l3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F181DDA14;
	Mon, 28 Oct 2024 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126329; cv=none; b=C0+Y9TWTYqaubZ/2pBuUwLMFPk+7i7t5AmokrFUuKpO6OWmRHAR4Q0QbjMtUCsYqSSFCTxOJeI3/Q13LUuYAnSTi92UoyxqY/LWBnKvXpNCd1iHL4ESeXrg9aZXndbO5pQMsvOH15Ynkct8OXN1kH42fcSO7vDMt/Zf9dVYD5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126329; c=relaxed/simple;
	bh=VnKHNq/LVYhXDEEst8PtAj0P/TxTkAgJaUiIvrCxnO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXn9dJ4ZJwkO9oMRnQTdC5xxOJVuLU3sAiqwr7UTTKvDVEl881AgIzfA3RFZPBdh9mTii/nQZxwXdxy9YMEupYFo+4ch1eTJ8jqXYMNMd4W5HIcYsZtbpmdfe9V9ipo8TE3xqFp/rAyZzcpmpiEmeWLMlCho3HRPR4wEGC9/1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ox2ej3l3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730126327; x=1761662327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VnKHNq/LVYhXDEEst8PtAj0P/TxTkAgJaUiIvrCxnO8=;
  b=Ox2ej3l3gYiuNqwFYqfrGzWQ754v3TkHvi/fFc/0oHYUEg6V43KscZ5s
   +3Mv84PvgpzX8hDYfTPE61gzplhb2calRp6s2Bh/tbU7V8S7kLymTCd3u
   kbseSDgFubkaIoDMehkFdPB9NGUKgezEinKOS4dL1j4/pxB6mHdU/btc1
   z/Y107ho/+b1JfEgh2bmqC7O8n297UH7CoEBRBmZceuQRjPOBuekw7Y8c
   vjPRcslqhHjz76ZBkrfoBaor6Z0ceF3TZ7X/mO4ADjP4uo2P+4RBP7MNc
   xZk0Dee6d+dLstwLQ8qMYNgFQQn6JUz6RpLDczJ4GcUTP64WV4O2LDfxO
   g==;
X-CSE-ConnectionGUID: BI/hltz7TLOAFTd31KLATg==
X-CSE-MsgGUID: DHP7+XRCRHqo2o0vOwN0eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52277500"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52277500"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:38:46 -0700
X-CSE-ConnectionGUID: Zv0JGberReG955Uff7Y88g==
X-CSE-MsgGUID: X4oBG17qSt+qqfke9r9MQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="86424632"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 07:38:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5QtB-000000085dP-42c5;
	Mon, 28 Oct 2024 16:38:37 +0200
Date: Mon, 28 Oct 2024 16:38:37 +0200
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
Subject: Re: [PATCH v3 3/6] iio: light: stk3310: Implement vdd and leda
 supplies
Message-ID: <Zx-h7QUnCKwtu8iC@smile.fi.intel.com>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-4-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028142000.1058149-4-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 28, 2024 at 10:19:57AM -0400, Aren Moynihan wrote:
> The vdd and leda supplies must be powered on for the chip to function
> and can be powered off during system suspend.
> 
> Co-developed-by: Ondrej Jirman <megi@xff.cz>

Missing SoB. Please, read Submitting Patches documentation for understanding
what has to be done here.

> Signed-off-by: Aren Moynihan <aren@peacevolution.org>

...

> Notes:
>     I'm not sure what the proper way to handle attribution for this patch
>     is. It was origionally based on a patch by Ondrej Jirman[1], but I have
>     rewritten a large portion if it. I have included a Co-developed-by tag
>     to indicate this, but haven't sent him this patch, so I'm not sure what
>     to do about a Signed-off-by.

Ah, seems you already aware of this issue. So, either drop Co-developed-by
(and if you wish you may give a credit in a free form inside commit message)
or make sure you get his SoB tag.

...

>  	mutex_init(&data->lock);

Somewhere (in the previous patch?) you want to switch to devm_mutex_init().

...

> +	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
> +				      data->supplies);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "get regulators failed\n");

> +		return dev_err_probe(&client->dev, ret,
> +				     "regulator enable failed\n");

> +	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "failed to register regulator cleanup\n");

With

	struct devuce *dev = &client->dev;

at the top of the function makes these and more lines neater.

...

>  static int stk3310_resume(struct device *dev)
>  {
> -	u8 state = 0;
>  	struct stk3310_data *data;
> +	u8 state = 0;
> +	int ret;

While changing to RCT order here, it seems you have inconsistent approach
elsewhere (in your own patches!). Please, be consistent with chosen style.

>  	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));

-- 
With Best Regards,
Andy Shevchenko



