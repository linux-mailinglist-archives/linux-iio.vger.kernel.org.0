Return-Path: <linux-iio+bounces-12104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B729C3451
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 20:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1402819A8
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2024 19:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424013DDD3;
	Sun, 10 Nov 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="ZdmkzEBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FFF224FD;
	Sun, 10 Nov 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731266071; cv=none; b=M0zSsrotL+3W+tszHPgZ0Rb43nL4sJtbMi9qbAXfJG087pSBCoUjsEqwGckUZ02NF1oPrhIklLfz/dNWM8zIiSBDP75LLUlL2mpTZM5dYhzo/euxMpZn2bZ/+Il05VHEqgyhQeAIEWlkn40I3+h6KPTvFfPaC8QC9EuoXuIwl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731266071; c=relaxed/simple;
	bh=ExGfcDlpx/6JW714B1W1DnhfapeOAbZJqYzPep8j/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edfrnx92+UAvamS7qUvejy6XF0q4Hxl04WpB4fJu6NjfTji7gDfcmzI4iYwhz9LkWndCs8FViwmLB0O1fv8pkPdDBAj8Dc0TvTvjw3lv4pnv5bvZhkG6wzeodQkZpLYIMFhjM3bGAAeiaiE6WCUsGx9N+5eQO4yzPCws0pEQW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=ZdmkzEBe; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D1C6F4C8F6;
	Sun, 10 Nov 2024 19:14:26 +0000 (UTC)
Date: Sun, 10 Nov 2024 14:14:24 -0500
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] iio: light: stk3310: use dev_err_probe where
 possible
Message-ID: <m7x526sv5krgt4t2whn5ykyktoz5u7ihsxv3qa5yue3ucbk6lb@37spwsmlcylm>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-11-aren@peacevolution.org>
 <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyiIcDaANjxwtCz-@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1731266068;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=51rqIAyIcgVeblNDeIP0tTw9wHbZ9mHgSey++a7S7Rs=;
	b=ZdmkzEBetq5p08NJ3nLHjD9gFK6PpH/wA0tEND6xZ6NolUi11FiaYC0d1G4nFmrVYifsGi
	4vc8pLErZjr1TFqPJH0x0TjG1/0xThg/2L8TNHf1VXUPhUkchzwS+BWWbXOd23hSHTynaR
	/yqRwQQzRjl2SBGhmZi8H+0SJCFjA5Y=

On Mon, Nov 04, 2024 at 10:40:16AM +0200, Andy Shevchenko wrote:
> On Sat, Nov 02, 2024 at 03:50:41PM -0400, Aren Moynihan wrote:
> > Using dev_err_probe instead of dev_err and return makes the errors
> > easier to understand by including the error name, and saves a little
> > code.
> 
> ...
> 
> >  #define STK3310_REGFIELD(name)						    \
> >  	do {								    \
> >  		data->reg_##name =					    \
> > -			devm_regmap_field_alloc(&client->dev, regmap,	    \
> > +			devm_regmap_field_alloc(dev, regmap,		    \
> >  				stk3310_reg_field_##name);		    \
> > -		if (IS_ERR(data->reg_##name)) {				    \
> > -			dev_err(&client->dev, "reg field alloc failed.\n"); \
> > -			return PTR_ERR(data->reg_##name);		    \
> > -		}							    \
> > +		if (IS_ERR(data->reg_##name))				    \
> 
> > +			return dev_err_probe(dev,			    \
> > +				PTR_ERR(data->reg_##name),		    \
> 
> AFAICS these two can be put on one.

This doesn't leave room for whitespace between the end of line and "\",
replacing "do { } while (0)" with "({ })" and deindenting could make
enough room to clean this up the formatting of this macro though.

> > +				"reg field alloc failed.\n");		    \
> >  	} while (0)
> 
> 
> ...
> 
> > @@ -654,12 +652,11 @@ static int stk3310_probe(struct i2c_client *client)
> >  	int ret;
> >  	struct iio_dev *indio_dev;
> >  	struct stk3310_data *data;
> > +	struct device *dev = &client->dev;
> 
> This should has been done a few patches earlier...

Moving it there now

 - Aren

