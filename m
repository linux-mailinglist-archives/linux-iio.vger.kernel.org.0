Return-Path: <linux-iio+bounces-12115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6442C9C3B2C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB988B22456
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034715624D;
	Mon, 11 Nov 2024 09:45:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37CF143C72;
	Mon, 11 Nov 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318302; cv=none; b=vBlNh5QNopoEr36AZxoFWRijZsQx12ZI+d+ZQsCF1Rr7zZfNQBjbpSFHMlnFqkqSX1bBUnhj44+Q3diay6Smcf1aJxvzN7C5SaEej+S/F2xm001Fp6UvkB+Z6fgyEjoTMmczAh+FlzBw4+b5zyyWxw/hjt+0NBP26EU43lVpAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318302; c=relaxed/simple;
	bh=fZNzFehdsn1KYuBdyXoOclvk0TirGAtQUi7fLN6E00Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbb0RbQOohiJTWFxHs/aPYElqBXDxo0+YS0z2AYbEBlowKWbHFjcI/YJJzA7pLrsViU2bChQ4fe5MQKFkBwgqF1kpnXtjO3W7Dc+R+AE8mdoHcFe52RGba4W469a+hXf7kWw9fFYeZk3QPY+EtKF6M+oFyIdXZe/sEaIo8f5Tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: QdeBMHObTxqGGq77nM22kA==
X-CSE-MsgGUID: MsWjFg1cSiWCavtgXzfRRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30972332"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30972332"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 01:45:00 -0800
X-CSE-ConnectionGUID: /eX76d9LRjOk6/8VeX37PA==
X-CSE-MsgGUID: UvJCofyfTlmID8eXgH3kkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="91926457"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 01:44:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1tAQya-0000000DXxa-0N1Q;
	Mon, 11 Nov 2024 11:44:52 +0200
Date: Mon, 11 Nov 2024 11:44:51 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Aren <aren@peacevolution.org>
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
Message-ID: <ZzHSE9Nrf4YySJrq@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
 <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
 <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
 <ZzEPACoblmcQD9yu@surfacebook.localdomain>
 <xubjmxig4luag27ifnmqmv3x3bvzhwczwvw34kw6tssaa2d24t@ysnqh5e3g7sz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xubjmxig4luag27ifnmqmv3x3bvzhwczwvw34kw6tssaa2d24t@ysnqh5e3g7sz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Nov 10, 2024 at 04:34:30PM -0500, Aren wrote:
> On Sun, Nov 10, 2024 at 09:52:32PM +0200, Andy Shevchenko wrote:
> > Sun, Nov 10, 2024 at 02:14:24PM -0500, Aren kirjoitti:
> > > On Mon, Nov 04, 2024 at 10:40:16AM +0200, Andy Shevchenko wrote:
> > > > On Sat, Nov 02, 2024 at 03:50:41PM -0400, Aren Moynihan wrote:

...

> > > > >  #define STK3310_REGFIELD(name)						    \
> > > > >  	do {								    \
> > > > >  		data->reg_##name =					    \
> > > > > -			devm_regmap_field_alloc(&client->dev, regmap,	    \
> > > > > +			devm_regmap_field_alloc(dev, regmap,		    \
> > > > >  				stk3310_reg_field_##name);		    \
> > > > > -		if (IS_ERR(data->reg_##name)) {				    \
> > > > > -			dev_err(&client->dev, "reg field alloc failed.\n"); \
> > > > > -			return PTR_ERR(data->reg_##name);		    \
> > > > > -		}							    \
> > > > > +		if (IS_ERR(data->reg_##name))				    \
> > > > 
> > > > > +			return dev_err_probe(dev,			    \
> > > > > +				PTR_ERR(data->reg_##name),		    \
> > > > 
> > > > AFAICS these two can be put on one.
> > > 
> > > This doesn't leave room for whitespace between the end of line and "\",
> > 
> > Is it a problem?
> 
> It feels a bit camped and not as readable to me:
> 
> #define STK3310_REGFIELD(name)						    \
> 	do {								    \
> 		data->reg_##name =					    \
> 			devm_regmap_field_alloc(dev, regmap,		    \
> 				stk3310_reg_field_##name);		    \
> 		if (IS_ERR(data->reg_##name))				    \
> 			return dev_err_probe(dev, PTR_ERR(data->reg_##name),\
> 					     "reg field alloc failed.\n");  \
> 	} while (0)

Rather this way (besides the fact of having spaces instead of TABs for
the last formatting, in such case you even can simply add yet another
column with spaces):

#define STK3310_REGFIELD(name)								\
	do {										\
		data->reg_##name =							\
			devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_##name);	\
		if (IS_ERR(data->reg_##name))						\
			return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
					     "reg field alloc failed.\n");		\
	} while (0)

> Removing a level of indentation makes it much better

You can do it differently

#define STK3310_REGFIELD(name)							\
do {										\
	data->reg_##name =							\
		devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_##name);	\
	if (IS_ERR(data->reg_##name))						\
		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
				     "reg field alloc failed.\n");		\
} while (0)

> #define STK3310_REGFIELD(name) ({						\
> 	data->reg_##name = devm_regmap_field_alloc(dev, regmap,			\
> 						   stk3310_reg_field_##name);   \
> 	if (IS_ERR(data->reg_##name))						\
> 		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
> 				     "reg field alloc failed\n");		\
> })

I am against unneeded use of GNU extensions.

> > > replacing "do { } while (0)" with "({ })" and deindenting could make
> > > enough room to clean this up the formatting of this macro though.
> > 
> > do {} while (0) is C standard, ({}) is not.
> 
> ({ }) is used throughout the kernel, and is documented as such[1]. I
> don't see a reason to avoid it, if it helps readability.

I don't see how it makes things better here, and not everybody is familiar with
the concept even if it's used in the kernel here and there. Also if a tool is
being used in one case it doesn't mean it's suitable for another.

> 1: the "GNU Extensions" section of Documentation/kernel-hacking/hacking.rst

-- 
With Best Regards,
Andy Shevchenko



