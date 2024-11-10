Return-Path: <linux-iio+bounces-12108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CA9C34CA
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125801C20DBF
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8D156F36;
	Sun, 10 Nov 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="f9tVVIwx"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC89418E1F;
	Sun, 10 Nov 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731274477; cv=none; b=L9eK90h+IuBdPcMXEytqQ5xodqMlR+oxWb4RMIzWdncoiSvWA3p2i9ce1CmPIdTUrHTiWGgtviHN6EDMjb1AC2zm84YNrkBiwOFoyaKso6dKsKx/QcZS2+aaGp6mLV9I9w3n4a90XHUZcR054U3eZOybii+6CnvpntTdIU+xqpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731274477; c=relaxed/simple;
	bh=OgL/qoT3LYnj9w1Et57aGyhc6u3/rI4DxO7jGiTe47I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abAtHU9d7n64VNQhEwnCymlieQ78ma3fNSD/rU59LvUAjqdRjOLRQR18jeRpUvrHamwcw+2HkZ5lAiaXB9eL2XSEZJ2yREBm4G/6NY7XD7KbBba+HvxdzJ0dTrT9IJVuL5gsKZIHGGvS1/pvYYybQ8R7OXR6seb+PNLS+Q/vwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=f9tVVIwx; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 2763C4C949;
	Sun, 10 Nov 2024 21:34:33 +0000 (UTC)
Date: Sun, 10 Nov 2024 16:34:30 -0500
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <xubjmxig4luag27ifnmqmv3x3bvzhwczwvw34kw6tssaa2d24t@ysnqh5e3g7sz>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
 <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
 <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
 <ZzEPACoblmcQD9yu@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzEPACoblmcQD9yu@surfacebook.localdomain>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731274474;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=oZcPhgVogTXytMRM2X3xlfPRj/xPsn3yw0hTKHL8ttU=;
	b=f9tVVIwxnKGQLg6bmCXySmWScp8LSpvZQfexKo1/aOdBOYhvxAdyTpFbVZUj3C2ce1hshi
	iixMbVEkA1qUwuAwFnlTEC1qAYNUMd6D5MeRodWpF/VCKgPS9VXM1nAPOtNjlKcSsYiodK
	L6nJMhaEPdkFvEp7pHwo/J+aFEuiEbQ=

On Sun, Nov 10, 2024 at 09:52:32PM +0200, Andy Shevchenko wrote:
> Sun, Nov 10, 2024 at 02:14:24PM -0500, Aren kirjoitti:
> > On Mon, Nov 04, 2024 at 10:40:16AM +0200, Andy Shevchenko wrote:
> > > On Sat, Nov 02, 2024 at 03:50:41PM -0400, Aren Moynihan wrote:
> 
> ...
> 
> > > >  #define STK3310_REGFIELD(name)						    \
> > > >  	do {								    \
> > > >  		data->reg_##name =					    \
> > > > -			devm_regmap_field_alloc(&client->dev, regmap,	    \
> > > > +			devm_regmap_field_alloc(dev, regmap,		    \
> > > >  				stk3310_reg_field_##name);		    \
> > > > -		if (IS_ERR(data->reg_##name)) {				    \
> > > > -			dev_err(&client->dev, "reg field alloc failed.\n"); \
> > > > -			return PTR_ERR(data->reg_##name);		    \
> > > > -		}							    \
> > > > +		if (IS_ERR(data->reg_##name))				    \
> > > 
> > > > +			return dev_err_probe(dev,			    \
> > > > +				PTR_ERR(data->reg_##name),		    \
> > > 
> > > AFAICS these two can be put on one.
> > 
> > This doesn't leave room for whitespace between the end of line and "\",
> 
> Is it a problem?

It feels a bit camped and not as readable to me:

#define STK3310_REGFIELD(name)						    \
	do {								    \
		data->reg_##name =					    \
			devm_regmap_field_alloc(dev, regmap,		    \
				stk3310_reg_field_##name);		    \
		if (IS_ERR(data->reg_##name))				    \
			return dev_err_probe(dev, PTR_ERR(data->reg_##name),\
					     "reg field alloc failed.\n");  \
	} while (0)

Removing a level of indentation makes it much better

#define STK3310_REGFIELD(name) ({						\
	data->reg_##name = devm_regmap_field_alloc(dev, regmap,			\
						   stk3310_reg_field_##name);   \
	if (IS_ERR(data->reg_##name))						\
		return dev_err_probe(dev, PTR_ERR(data->reg_##name),		\
				     "reg field alloc failed\n");		\
})

> > replacing "do { } while (0)" with "({ })" and deindenting could make
> > enough room to clean this up the formatting of this macro though.
> 
> do {} while (0) is C standard, ({}) is not.

({ }) is used throughout the kernel, and is documented as such[1]. I
don't see a reason to avoid it, if it helps readability.

1: the "GNU Extensions" section of Documentation/kernel-hacking/hacking.rst

 - Aren

