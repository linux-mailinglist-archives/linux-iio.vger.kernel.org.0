Return-Path: <linux-iio+bounces-25113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E17BE0553
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C599E342E33
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BDF30498F;
	Wed, 15 Oct 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OjEyLUA2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035E303A0B;
	Wed, 15 Oct 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555676; cv=none; b=Po8hJN4snPIP07FV/bwvV6CRd2jAItmOGX+6ZzqlnXOtGgRHiGjgK8JZekakj/SIs884H8Aacs+aI85GGPuhoV0Zl0Kfj2o8Qhjm57IvnFyfQ2rjOiVMf0V4fmYqsycDvzKonG+FS/TSodiCLzcN67RDlPlHTIEj5ZFk9weQ4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555676; c=relaxed/simple;
	bh=capcANLMQMa9VkmAVmPCDiytYriFywVv/8fYWytb4k8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBehvqo/SK1U6Tb9jXoNTb0BAhz1bSJE/EVigBgQ2sAw9eMVYH8SF2+Rog3ho90B9JlENW7D0yngC+E3gsT44gVou1mAR75awo+8DcCVNm21fnuunZ3Q46NpP+ledCD9vOnCLc9AKCMELBLG0u5LxdtuzkUmejayrWDRK8IwC3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OjEyLUA2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B87344E410DF;
	Wed, 15 Oct 2025 19:14:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F87060673;
	Wed, 15 Oct 2025 19:14:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43314102F22E5;
	Wed, 15 Oct 2025 21:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760555670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wa4NcWEC700br0R9Bk2bE/WAk5/Eh5OEwJob4/PGm1o=;
	b=OjEyLUA2eEVF/4rtwvfCwqxDH6VCnflNpoqnKkzmE3Iufd84CwwLOlkHfx4o1/1w9o2oUk
	Go622a8+U9BsTm+HuLWgpP60wC+QAoL44jUP9Pwf+u3pzqptLj1WLr3p8p4T9sf6q7jMYI
	d9TttwFVuIdMv6SkQhCSdbzboH4TGjJGJ2kWdzDIVSEzBt/SEW0y+B385C5Sl+3hoT0+dj
	jmUd8nd00kLFCbhH9QYhrL2d3EdLuScbfrq0tg1JeXQ7F8XSHkn3CvjFEbsEdZiPyHpVbZ
	sgHsKssJe6RRkGqstNZt8KBjPtSTNOznR7m2n/XlpXDqrsa0ReCetbnv/sAVdQ==
Date: Wed, 15 Oct 2025 21:14:20 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner	 <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven	
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Liam
 Girdwood	 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal Eberhard	
 <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251015211420.031c61fa@bootlin.com>
In-Reply-To: <1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
 <20251015142816.1274605-3-herve.codina@bootlin.com>
 <1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
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

On Wed, 15 Oct 2025 16:21:09 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

...
> 
> > +static int rzn1_adc_enable(struct rzn1_adc *rzn1_adc)
> > +{
> > +	int ret;
> > +
> > +	ret = rzn1_adc_core_power_on(&rzn1_adc->adc_core[0]);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = rzn1_adc_core_power_on(&rzn1_adc->adc_core[1]);
> > +	if (ret)
> > +		goto poweroff_adc_core0;
> > +
> > +	ret = clk_prepare_enable(rzn1_adc->pclk);
> > +	if (ret)
> > +		goto poweroff_adc_core1;
> > +
> > +	ret = clk_prepare_enable(rzn1_adc->adc_clk);
> > +	if (ret)
> > +		goto disable_pclk;
> > +
> > +	ret = rzn1_adc_power(rzn1_adc, true);
> > +	if (ret)
> > +		goto disable_adc_clk;  
> 
> Can we use devm_actions() on the above to avoid the complex error path plus the
> .remove() callback?

rzn1_adc_enable() is used by the driver pm_runtime_resume() function.

I don't think that devm_add_actions_or_reset() will help here.

In my understanding, devm_* functions are use to perform some operations
automatically on device removal.

The purpose of the error path here is to restore a correct state if
rzn1_adc_enable() failed when it is called from pm_runtime_resume().

In that case no device removal is involved to trig any action set by
devm_add_actions_or_reset().

Maybe I am wrong. Did I miss something?

> 
> > +
> > +	return 0;
> > +
> > +disable_adc_clk:
> > +	clk_disable_unprepare(rzn1_adc->adc_clk);
> > +disable_pclk:
> > +	clk_disable_unprepare(rzn1_adc->pclk);
> > +poweroff_adc_core1:
> > +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[1]);
> > +poweroff_adc_core0:
> > +	rzn1_adc_core_power_off(&rzn1_adc->adc_core[0]);
> > +	return ret;
> > +}
> > +

...

> > +static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> > +					 struct iio_dev *indio_dev)
> > +{
> > +	int adc_used;
> > +
> > +	adc_used = rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> > +	adc_used |= rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> > +
> > +	switch (adc_used) {
> > +	case 0x01:
> > +		indio_dev->channels = rzn1_adc1_channels;
> > +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
> > +		return 0;
> > +	case 0x02:
> > +		indio_dev->channels = rzn1_adc2_channels;
> > +		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
> > +		return 0;
> > +	case 0x03:
> > +		indio_dev->channels = rzn1_adc1_adc2_channels;
> > +		indio_dev->num_channels =
> > ARRAY_SIZE(rzn1_adc1_adc2_channels);
> > +		return 0;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	dev_err(rzn1_adc->dev, "Failed to set IIO channels, no ADC core
> > used\n");
> > +	return -ENODEV;  
> 
> dev_err_probe()?

Why? the error returned is a well known value: -ENODEV.

dev_err_probe() should be involved when -EPROBE_DEFER is a potential error
code.

IMHO, dev_err() here is correct.

> 
> > +}
> > +
> > +static int rzn1_adc_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct rzn1_adc *rzn1_adc;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*rzn1_adc));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	rzn1_adc = iio_priv(indio_dev);
> > +	rzn1_adc->dev = dev;
> > +	mutex_init(&rzn1_adc->lock);  
> 
> devm_mutex_init()

Yes, I will update in the next iteration.

> 
> > +
> > +	rzn1_adc->regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(rzn1_adc->regs))
> > +		return PTR_ERR(rzn1_adc->regs);
> > +
> > +	rzn1_adc->pclk = devm_clk_get(dev, "pclk");
> > +	if (IS_ERR(rzn1_adc->pclk))
> > +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to
> > get pclk\n");
> > +
> > +	rzn1_adc->adc_clk = devm_clk_get(dev, "adc-clk");
> > +	if (IS_ERR(rzn1_adc->pclk))
> > +		return dev_err_probe(dev, PTR_ERR(rzn1_adc->pclk), "Failed to
> > get adc-clk\n");
> > +
> > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[0],
> > +					   "adc1-avdd", "adc1-vref");
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc->adc_core[1],
> > +					   "adc2-avdd", "adc2-vref");
> > +	if (ret)
> > +		return ret;  
> 
> Hmm, is avdd really an optional regulator? I mean can the ADC power up at all
> without a supply in AVDD? Even vref seems to be mandatory as we can't properly
> scale the sample without it.

Where do you see that avdd is an optional regulator?

> 
> Also, can't we have getting and enabling the regulator together? Then, we could
> use some of the modern helpers to simplify the code (ok I see you use them in
> the PM callbacks).

Yes, I rely on PM callbacks to handle those regulators.

> 
> > +
> > +	platform_set_drvdata(pdev, indio_dev);
> > +
> > +	indio_dev->name = dev_name(dev);  
> 
> dev_name() should not be used for the above. It's typically the part name so I
> guess in here "rzn1-adc" would be the appropriate one.

I thought it was more related to the instance and so having a different name
for each instance was better.

Some other IIO drivers use dev_name() here.

But well, if you confirm that a fixed string should be used and so all
instances have the same string, no problem, I will update my indio_dev->name.

> 
> > +	indio_dev->info = &rzn1_adc_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	ret = rzn1_adc_set_iio_dev_channels(rzn1_adc, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = rzn1_adc_enable(rzn1_adc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_set_autosuspend_delay(dev, 500);
> > +	pm_runtime_use_autosuspend(dev);
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_enable(dev);  
> 
> There's a devm_pm_runtime_enable() API now.

Will look to use it in the next iteration.

> 
> > +
> > +	ret = devm_iio_device_register(dev, indio_dev);
> > +	if (ret)
> > +		goto disable;
> > +
> > +	pm_runtime_mark_last_busy(dev);
> > +	pm_runtime_put_autosuspend(dev);
> > +
> > +	return 0;
> > +
> > +disable:
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_put_noidle(dev);
> > +	pm_runtime_set_suspended(dev);
> > +	pm_runtime_dont_use_autosuspend(dev);
> > +
> > +	rzn1_adc_disable(rzn1_adc);
> > +	return ret;
> > +}
> > +
> > +static void rzn1_adc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
> > +
> > +	pm_runtime_disable(rzn1_adc->dev);
> > +	pm_runtime_set_suspended(rzn1_adc->dev);
> > +	pm_runtime_dont_use_autosuspend(rzn1_adc->dev);
> > +
> > +	rzn1_adc_disable(rzn1_adc);
> > +}  
> 
> I'm fairly confident we can sanely go without .remove().

Will see what I can be do for the next iteration.

Maybe I will ask some questions if I need some clarification around
pm_runtime but let me first try to go further in that direction.

>  
> > +
> > +static int rzn1_adc_pm_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
> > +
> > +	rzn1_adc_disable(rzn1_adc);
> > +
> > +	return 0;
> > +}
> > +
> > +static int rzn1_adc_pm_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct rzn1_adc *rzn1_adc = iio_priv(indio_dev);
> > +
> > +	return rzn1_adc_enable(rzn1_adc);
> > +}
> > +
> > +static const struct dev_pm_ops rzn1_adc_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> > pm_runtime_force_resume)
> > +	SET_RUNTIME_PM_OPS(rzn1_adc_pm_runtime_suspend,
> > rzn1_adc_pm_runtime_resume, NULL)
> > +};
> > +
> > +static const struct of_device_id rzn1_adc_of_match[] = {
> > +	{ .compatible = "renesas,rzn1-adc" },
> > +	{ /* sentinel */ },
> > +};  
> 
> We typically don't add the sentinel comment in IIO.

Ok, will be removed.

> 
> > +
> > +MODULE_DEVICE_TABLE(of, rzn1_adc_of_match);
> > +
> > +static struct platform_driver rzn1_adc_driver = {
> > +	.probe = rzn1_adc_probe,
> > +	.remove = rzn1_adc_remove,
> > +	.driver = {
> > +		.name = "rzn1-adc",
> > +		.of_match_table = of_match_ptr(rzn1_adc_of_match),  
> 
> Drop of_match_ptr().

Ok, will be removed.


Thanks for your review.

Best regards,
Hervé

