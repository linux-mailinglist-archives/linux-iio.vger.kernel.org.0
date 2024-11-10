Return-Path: <linux-iio+bounces-12107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EF9C3478
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 20:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A21F21518
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47E213BC0D;
	Sun, 10 Nov 2024 19:52:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBC149C4A
	for <linux-iio@vger.kernel.org>; Sun, 10 Nov 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731268359; cv=none; b=Y+4dD6u9buluSwEeLPnmvtgQsHBgBLE0zFBD2uJyaED0jExQnoY+ytdXcg1Qa9RZeo/r6dmO7bbruIf8rgC9zbNfWW1O8kxyePnF2P1VfzVJjlQAtYcRsFvFAcN0XwmCUwApyT9xkD2u+Nrl0CnfMKlUdgqThdB3DUJTiV/Abbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731268359; c=relaxed/simple;
	bh=9Z/pDoqd+qplmP5YdyAJMIIHWDi+W2hpCCQf7xbBy0c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtwfRh+UODAvNEYghLkQG9DsZHiMUPIRz1CGlnCR3AnQUQ5tR0B6O97z5/1Vuk8jAB5Xo8XfMka6OF13DC+nUX5T5K1z7bGNNy/6TYm4qVg9a/1Ja+JCkQc0RIimbpvJr5JaGmis+GOlF4TLw/zhETSpX7q1ktezgu+4fd3p8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-24-75.elisa-laajakaista.fi [88.113.24.75])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 5376b6f1-9f9d-11ef-8874-005056bdd08f;
	Sun, 10 Nov 2024 21:52:33 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 10 Nov 2024 21:52:32 +0200
To: Aren <aren@peacevolution.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
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
Message-ID: <ZzEPACoblmcQD9yu@surfacebook.localdomain>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
 <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
 <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>

Sun, Nov 10, 2024 at 02:14:24PM -0500, Aren kirjoitti:
> On Mon, Nov 04, 2024 at 10:40:16AM +0200, Andy Shevchenko wrote:
> > On Sat, Nov 02, 2024 at 03:50:41PM -0400, Aren Moynihan wrote:

...

> > >  #define STK3310_REGFIELD(name)						    \
> > >  	do {								    \
> > >  		data->reg_##name =					    \
> > > -			devm_regmap_field_alloc(&client->dev, regmap,	    \
> > > +			devm_regmap_field_alloc(dev, regmap,		    \
> > >  				stk3310_reg_field_##name);		    \
> > > -		if (IS_ERR(data->reg_##name)) {				    \
> > > -			dev_err(&client->dev, "reg field alloc failed.\n"); \
> > > -			return PTR_ERR(data->reg_##name);		    \
> > > -		}							    \
> > > +		if (IS_ERR(data->reg_##name))				    \
> > 
> > > +			return dev_err_probe(dev,			    \
> > > +				PTR_ERR(data->reg_##name),		    \
> > 
> > AFAICS these two can be put on one.
> 
> This doesn't leave room for whitespace between the end of line and "\",

Is it a problem?

> replacing "do { } while (0)" with "({ })" and deindenting could make
> enough room to clean this up the formatting of this macro though.

do {} while (0) is C standard, ({}) is not.

> > > +				"reg field alloc failed.\n");		    \
> > >  	} while (0)

-- 
With Best Regards,
Andy Shevchenko



