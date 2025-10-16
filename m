Return-Path: <linux-iio+bounces-25147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DBBE3D70
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7DB18861DB
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C32A1C84BC;
	Thu, 16 Oct 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fx9/b6XS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6CF32E686;
	Thu, 16 Oct 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760623338; cv=none; b=i3rlST+xZhZC7tApN5Z6G3TJ9cdkVm7lYtjqHsIx0BJNPZq9Zpn5z5FRjenWqRxqtLMHZFAuemqeJF7fNSjU/8ASanxAsnEur9wpL3dwcvu5VHYo1wF2ew6b0Gr4MswGdIPDfv9orzLsXGR9EwIsQZg8LlEVerErgm+hi/QrtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760623338; c=relaxed/simple;
	bh=si2FzUDU748XftQ5EDd5liBfLdLMuh7tapZfv/ImxNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEjlVs02wcOHj8hVElFa5f5cMXiu5DytigqBl11c49xTIS4iAWr+QdrchRCAGa8D87Sbp44hfWF5idD9zw96WuREAMPJWu9TQAaZ8dVDJWT935gBtp6a9PuHg0azCIgFacp8Pr2bVE8PSCET54C1TDh4NUPI4FVHaVUbD8mXPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fx9/b6XS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B4FB64E410EA;
	Thu, 16 Oct 2025 14:02:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 806D36062C;
	Thu, 16 Oct 2025 14:02:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B96A102F230E;
	Thu, 16 Oct 2025 16:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760623331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2bFoA8MyaDvl/5Ycj1d2n5W5Ke/JKZq4XyHicBpLuzA=;
	b=Fx9/b6XSSYXEOlKl4J76sNSG9A+rZkfvsEKvKNHZw359FJFe4EA10bl0/mDXFNeveUk4Xc
	ywQXeynu+1l1EyXZ4TCA1BJat/h7mP6JY86ksoSjHaUnP3t4YtiuostLtuEdlcWUrzZkwG
	14bquoeeYKcjPZNW83RX2M+YQRaI0PPebjjfo8BxpIa0Xr9JsIFD9Z5q9ibRt4TgdvDBBY
	DvGHBWTLCz5rtAA1woB010WlYYp5vFpM8LJpfkLBV/vvEKsyrDIsBfYCX0H8/WsxJSzdEO
	MgYnX1vcwgx2/ceZ0qDiRDqV8je09jG1UErXiJRPGZ1P3Dk6XoQH1ysaGZPHnA==
Date: Thu, 16 Oct 2025 16:02:02 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley	 <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown	 <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal Eberhard
 <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251016160202.3d4d0a5e@bootlin.com>
In-Reply-To: <de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
	<20251015211420.031c61fa@bootlin.com>
	<de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Nuno,

On Thu, 16 Oct 2025 10:24:36 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Wed, 2025-10-15 at 21:14 +0200, Herve Codina wrote:
> > Hi Nuno,
> > 
> > On Wed, 15 Oct 2025 16:21:09 +0100
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > 
> > ...  
> > >   
> > > > +static int rzn1_adc_enable(struct rzn1_adc *rzn1_adc)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = rzn1_adc_core_power_on(&rzn1_adc->adc_core[0]);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = rzn1_adc_core_power_on(&rzn1_adc->adc_core[1]);
> > > > +	if (ret)
> > > > +		goto poweroff_adc_core0;
> > > > +
> > > > +	ret = clk_prepare_enable(rzn1_adc->pclk);
> > > > +	if (ret)
> > > > +		goto poweroff_adc_core1;
> > > > +
> > > > +	ret = clk_prepare_enable(rzn1_adc->adc_clk);
> > > > +	if (ret)
> > > > +		goto disable_pclk;
> > > > +
> > > > +	ret = rzn1_adc_power(rzn1_adc, true);
> > > > +	if (ret)
> > > > +		goto disable_adc_clk;    
> > > 
> > > Can we use devm_actions() on the above to avoid the complex error path plus
> > > the
> > > .remove() callback?  
> > 
> > rzn1_adc_enable() is used by the driver pm_runtime_resume() function.
> > 
> > I don't think that devm_add_actions_or_reset() will help here.
> > 
> > In my understanding, devm_* functions are use to perform some operations
> > automatically on device removal.
> > 
> > The purpose of the error path here is to restore a correct state if
> > rzn1_adc_enable() failed when it is called from pm_runtime_resume().
> > 
> > In that case no device removal is involved to trig any action set by
> > devm_add_actions_or_reset().
> > 
> > Maybe I am wrong. Did I miss something?  
> 
> Nope, I see now what's your intent.

Ok, no change planned for the next iteration related to this error path.

> 
> >   
> > >   
> > > > +
> > > > +	return 0;
> > > > +
> > > > +disable_adc_clk:
> > > > +	clk_disable_unprepare(rzn1_adc->adc_clk);
> > > > +disable_pclk:
> > > > +	clk_disable_unprepare(rzn1_adc->pclk);
> > > > +poweroff_adc_core1:
> > > > +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
> > > > +poweroff_adc_core0:
> > > > +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
> > > > +	return ret;
> > > > +}
> > > > +  
> > 
> > ...
> >   
> > > > +static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> > > > +					 struct iio_dev *indio_dev)
> > > > +{
> > > > +	int adc_used;
> > > > +
> > > > +	adc_used = rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> > > > +	adc_used |= rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> > > > +
> > > > +	switch (adc_used) {
> > > > +	case 0x01:
> > > > +		indio_dev->channels = rzn1_adc1_channels;
> > > > +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
> > > > +		return 0;
> > > > +	case 0x02:
> > > > +		indio_dev->channels = rzn1_adc2_channels;
> > > > +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
> > > > +		return 0;
> > > > +	case 0x03:
> > > > +		indio_dev->channels = rzn1_adc1_adc2_channels;
> > > > +		indio_dev->num_channels =
> > > > ARRAY_SIZE(rzn1_adc1_adc2_channels);
> > > > +		return 0;
> > > > +	default:
> > > > +		break;
> > > > +	}
> > > > +
> > > > +	dev_err(rzn1_adc->dev, "Failed to set IIO channels, no ADC core
> > > > used\n");
> > > > +	return -ENODEV;    
> > > 
> > > dev_err_probe()?  
> > 
> > Why? the error returned is a well known value: -ENODEV.
> > 
> > dev_err_probe() should be involved when -EPROBE_DEFER is a potential error
> > code.
> > 
> > IMHO, dev_err() here is correct.  
> 
> If I'm not missing nothing this function is called during probe so I do think
> dev_err_probe() should be used. Not only unifies logging style during probe it
> also has the small benefit of doing:
> 
> return dev_err_probe(...) saving a line of code.
> 
> You can see that, at least in IIO, we even have some patches just converting
> drivers probe() to use dev_err_probe().

Right, I will use dev_err_probe() in the next iteration.

> 
> >   
> > >   
> > > > +}
> > > > +
> > > > +static int rzn1_adc_probe(struct platform_device *pdev)
> > > > +{
> > > > +	struct device *dev = &pdev->dev;
> > > > +	struct iio_dev *indio_dev;
> > > > +	struct rzn1_adc *rzn1_adc;
> > > > +	int ret;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	rzn1_adc = iio_priv(indio_dev);
> > > > +	rzn1_adc->dev = dev;
> > > > +	mutex_init(&rzn1_adc->lock);    
> > > 
> > > devm_mutex_init()  
> > 
> > Yes, I will update in the next iteration.
> >   
> > >   
> > > > +
> > > > +	rzn1_adc->regs = devm_platform_ioremap_resource(pdev, 0);
> > > > +	if (IS_ERR(rzn1_adc->regs))
> > > > +		return PTR_ERR(rzn1_adc->regs);
> > > > +
> > > > +	rzn1_adc->pclk = devm_clk_get(dev, "pclk");
> > > > +	if (IS_ERR(rzn1_adc->pclk))
> > > > +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk),
> > > > "Failed to
> > > > get pclk\n");
> > > > +
> > > > +	rzn1_adc->adc_clk = devm_clk_get(dev, "adc-clk");
> > > > +	if (IS_ERR(rzn1_adc->pclk))
> > > > +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk),
> > > > "Failed to
> > > > get adc-clk\n");
> > > > +
> > > > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-  
> > > > >adc_core[0],  
> > > > +					   "adc1-avdd", "adc1-vref");
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-  
> > > > >adc_core[1],  
> > > > +					   "adc2-avdd", "adc2-vref");
> > > > +	if (ret)
> > > > +		return ret;    
> > > 
> > > Hmm, is avdd really an optional regulator? I mean can the ADC power up at
> > > all
> > > without a supply in AVDD? Even vref seems to be mandatory as we can't
> > > properly
> > > scale the sample without it.  
> > 
> > Where do you see that avdd is an optional regulator?  
> 
> You are using devm_regulator_get_optional(). That's for optional regulators.
> 

Indeed I use devm_regulator_get_optional().

We have two similar function to get regulators:
- devm_regulator_get() and
- devm_regulator_get_optional().

devm_regulator_get() returns a dummy regulator if the regulator is not
described in the device-tree. The calling code has no way to known if
the regulator was present or not.

On the other hand, devm_regulator_get_optional() returns -ENODEV when the
regulator is not described.

That's pretty confusing but it is the reality.

I use devm_regulator_get_optional() but check for -ENODEV to see if the
regulator is provided or not.

In order to use the ADC core (is_used flag), I need both the AVDD and the
VREF regulator available.

> >   
> > > 
> > > Also, can't we have getting and enabling the regulator together? Then, we
> > > could
> > > use some of the modern helpers to simplify the code (ok I see you use them
> > > in
> > > the PM callbacks).  
> > 
> > Yes, I rely on PM callbacks to handle those regulators.
> >   
> > >   
> > > > +
> > > > +	platform_set_drvdata(pdev, indio_dev);
> > > > +
> > > > +	indio_dev->name = dev_name(dev);    
> > > 
> > > dev_name() should not be used for the above. It's typically the part name so
> > > I
> > > guess in here "rzn1-adc" would be the appropriate one.  
> > 
> > I thought it was more related to the instance and so having a different name
> > for each instance was better.
> > 
> > Some other IIO drivers use dev_name() here.
> > 
> > But well, if you confirm that a fixed string should be used and so all
> > instances have the same string, no problem, I will update my indio_dev->name.  
> 
> It is a fixed string, typically the part name. David Lechner not that long ago
> actually sent some patch or documented somewhere why not to use dev_name(). To
> identify different instances we have a 'label' property.

Right, I will set indio_dev->name to the "rzn1-adc" fixed string.

> 
> >   
> > >   
> > > > +	indio_dev->info = &rzn1_adc_info;
> > > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > > +	ret = rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = rzn1_adc_enable(rzn1_adc);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > > > +	pm_runtime_use_autosuspend(dev);
> > > > +	pm_runtime_get_noresume(dev);
> > > > +	pm_runtime_set_active(dev);
> > > > +	pm_runtime_enable(dev);    
> > > 
> > > There's a devm_pm_runtime_enable() API now.  
> > 
> > Will look to use it in the next iteration.
> >   
> > >   
> > > > +
> > > > +	ret = devm_iio_device_register(dev, indio_dev);
> > > > +	if (ret)
> > > > +		goto disable;
> > > > +
> > > > +	pm_runtime_mark_last_busy(dev);
> > > > +	pm_runtime_put_autosuspend(dev);
> > > > +
> > > > +	return 0;
> > > > +
> > > > +disable:
> > > > +	pm_runtime_disable(dev);
> > > > +	pm_runtime_put_noidle(dev);
> > > > +	pm_runtime_set_suspended(dev);
> > > > +	pm_runtime_dont_use_autosuspend(dev);
> > > > +
> > > > +	rzn1_adc_disable(rzn1_adc);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static void rzn1_adc_remove(struct platform_device *pdev)
> > > > +{
> > > > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > > +	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
> > > > +
> > > > +	pm_runtime_disable(rzn1_adc->dev);
> > > > +	pm_runtime_set_suspended(rzn1_adc->dev);
> > > > +	pm_runtime_dont_use_autosuspend(rzn1_adc->dev);
> > > > +
> > > > +	rzn1_adc_disable(rzn1_adc);
> > > > +}    
> > > 
> > > I'm fairly confident we can sanely go without .remove().  
> > 
> > Will see what I can be do for the next iteration.
> > 
> > Maybe I will ask some questions if I need some clarification around
> > pm_runtime but let me first try to go further in that direction.  
> 
> Yeah, maybe you can come up with something but given how you use pm to
> enable/disable stuff I'm also not sure the above is easily doable.
> 

Hum, do you think it's worth a try?

Best regards,
Hervé

