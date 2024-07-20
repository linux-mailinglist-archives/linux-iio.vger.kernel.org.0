Return-Path: <linux-iio+bounces-7739-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD7E93817D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A29B1C20FA0
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B3012DD88;
	Sat, 20 Jul 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTWgxygu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF53209;
	Sat, 20 Jul 2024 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721482588; cv=none; b=W7+UUri8Hc3etgerTOOGAgCXXEsxEYtGmh/BZoQ4ISWV5dO5lGpPcRL03oMbyZ+yqk73bUOcI8JdUk1LtfX5lMaJmfu8/N5WFeJa9VmMLzwFTeex1GASMby85HviXKAw5sceuKvZ8wTpGgIE9Z0Vl0XWmoRf0L/2a9WZ9/3BnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721482588; c=relaxed/simple;
	bh=whTgYov6R0mAL+CB7A04ZKa4p6RRkvC/wvAPBg7DzT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXNt81rtKlsuqVdgcaE1z+kmyrwkSeE9t5kz6hmlhEHUotHpK27pYkVGtPN5xirvJID/ztVQvlB4dVxk1qYR9P4xbPpin50Kc6Iuwc7be41T3+/axZhNOU//HkkH/47nlQVdGQ35vhRdbSIH++oYvpmXlNVaJagA18wkEWxVmIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTWgxygu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4D4C2BD10;
	Sat, 20 Jul 2024 13:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721482588;
	bh=whTgYov6R0mAL+CB7A04ZKa4p6RRkvC/wvAPBg7DzT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZTWgxyguzBrhQX5n3cXK3/eqV9EiaIORuxLRQKNSZkfSSJ6BuzFxBMyjh+XRpp5u9
	 YWDcMUZ0AUQ7b7wk9R4klr7G5xbDPpdRijGIHufe7z0pdGqIr54hA8YOO6ChCxKXnF
	 tH6NvC1ePRwn9N/rlMIlG7WgjYgZ62EDNQfrhgffdcvvmGW2TZwsDHinhz5lZACY/7
	 KjfbFuY0nc1/u0hDb1HaLMACGKucV9zSqDboQMRsoA29Wqnrn5fGLKuLbit1YZH4jq
	 WoJWWuMJIAicgLq3jvv7O8cAYE2BIY4NUktLceM+/svr/clE+4Ei4e7a62qfAr3up0
	 DZODiwhaShHLw==
Date: Sat, 20 Jul 2024 14:36:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: frequency: adf4377: add adf4378 support
Message-ID: <20240720143619.3d6a976f@jic23-huawei>
In-Reply-To: <c26f39fc-94bd-40f2-9c3a-7075eb3e6dba@kernel.org>
References: <20240717093034.9221-1-antoniu.miclaus@analog.com>
	<20240717093034.9221-2-antoniu.miclaus@analog.com>
	<c26f39fc-94bd-40f2-9c3a-7075eb3e6dba@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 11:38:30 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 17/07/2024 11:30, Antoniu Miclaus wrote:
> > Add separate handling for adf4378 within the driver.
> > 
> > The main difference between adf4377 and adf4378 is that adf4378 has only
> > one output which is handled by only one gpio.
> > 
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Replying on top of Krzysztof's review as he is raising very similar
points to those I was going to make.

> > ---
> >  drivers/iio/frequency/adf4377.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
> > index 9284c13f1abb..e02298a8b47f 100644
> > --- a/drivers/iio/frequency/adf4377.c
> > +++ b/drivers/iio/frequency/adf4377.c
> > @@ -387,6 +387,11 @@
> >  #define ADF4377_FREQ_PFD_250MHZ			(250 * HZ_PER_MHZ)
> >  #define ADF4377_FREQ_PFD_320MHZ			(320 * HZ_PER_MHZ)
> >  
> > +enum adf4377_dev_type {
> > +	ADF4377,
> > +	ADF4378,
> > +};
See below - but using an enum for device type is normally a bad sign.
It means you are adding a bunch of code paths that will need continual
extension as new chips are added.

Much better to add a description of chip features in a const structure.
> > +
> >  enum {
> >  	ADF4377_FREQ,
> >  };
> > @@ -402,6 +407,7 @@ enum muxout_select_mode {
> >  
> >  struct adf4377_state {
> >  	struct spi_device	*spi;
> > +	enum adf4377_dev_type	type;
> >  	struct regmap		*regmap;
> >  	struct clk		*clkin;
> >  	/* Protect against concurrent accesses to the device and data content */
> > @@ -687,7 +693,7 @@ static void adf4377_gpio_init(struct adf4377_state *st)
> >  	if (st->gpio_enclk1)
> >  		gpiod_set_value(st->gpio_enclk1, 1);
> >  
> > -	if (st->gpio_enclk2)
> > +	if (st->gpio_enclk2 && st->type == ADF4377)  
> 
> Why? Isn't everything correct for NULL?
> 
> >  		gpiod_set_value(st->gpio_enclk2, 1);
> >  }
> >  
> > @@ -889,11 +895,13 @@ static int adf4377_properties_parse(struct adf4377_state *st)
> >  		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
> >  				     "failed to get the CE GPIO\n");
> >  
> > -	st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
> > -						  GPIOD_OUT_LOW);
> > -	if (IS_ERR(st->gpio_enclk2))
> > -		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> > -				     "failed to get the CE GPIO\n");
> > +	if (st->type == ADF4377) {  
> 
> So the device does not have this pin? Then you should express it in the
> bindings.
Agreed: That binding needs to ensure that there isn't a second pin expressed
for a chip where it makes no sense.

> 
> > +		st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
> > +							  GPIOD_OUT_LOW);
> > +		if (IS_ERR(st->gpio_enclk2))
> > +			return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
> > +					"failed to get the CE GPIO\n");
> > +	}
> >  
> >  	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
> >  						    adf4377_muxout_modes,
> > @@ -945,6 +953,7 @@ static int adf4377_probe(struct spi_device *spi)
> >  
> >  	st->regmap = regmap;
> >  	st->spi = spi;
> > +	st->type = spi_get_device_id(spi)->driver_data;  
> 
> 
> spi_get_device_match_data()
> 
> >  	mutex_init(&st->lock);
> >  
> >  	ret = adf4377_properties_parse(st);
> > @@ -964,13 +973,15 @@ static int adf4377_probe(struct spi_device *spi)
> >  }
> >  
> >  static const struct spi_device_id adf4377_id[] = {
> > -	{ "adf4377", 0 },
> > +	{ "adf4377", ADF4377 },
> > +	{ "adf4378", ADF4378 },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(spi, adf4377_id);
> >  
> >  static const struct of_device_id adf4377_of_match[] = {
> >  	{ .compatible = "adi,adf4377" },
> > +	{ .compatible = "adi,adf4378" },  
> 
> Your device ID tables have incoherent match data. Considering that one
> type is 0, this is error-prone and discouraged.
Agreed.  Much better to use a pointer to a chip specific structure for these
thus avoiding the accidental NULL value and turning chip differences into
data, not code.

> 
> Best regards,
> Krzysztof
> 


