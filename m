Return-Path: <linux-iio+bounces-25170-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47959BE6E0A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023F93A1BB5
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3EB31065C;
	Fri, 17 Oct 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fAk5Ef0D"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176FB33F9
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684784; cv=none; b=CGh4xitfDTI1c7/0eyH2NbmSRvxJSPNngv+SBz4xqRSQtAVeDdX6RdZoKCLIsQ6fhgDP7Rg1w9g+u09N/z7f62TxYQPcOKuV0cZGWRZ+gkEAN5f9NwilsazsnP8C/lamNNi3RWvZm28lWupR4a4jQ0AURbvxoL0tKXQnx6/Iytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684784; c=relaxed/simple;
	bh=8OQY8QOLNWepduPiOkPoOwkFH3ACC14yEP8MXSuDiMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+Ljcs+3AL9qVye77EAZBdNVDCiklH73bZ5a9MpxfZfOLCBN3f3UnNgRP4n2fH3HmuGp5uWmV4wsnizXzYZ27tTVxFx5fZTebg2D73A67pBEithg7jLNaW2LL9/qINkkXFRVDRFmKpohBhz8gWrThbogyPGKvQQ7tGE6ifyYIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fAk5Ef0D; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E87A7C041DC;
	Fri, 17 Oct 2025 06:58:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C911606DB;
	Fri, 17 Oct 2025 06:59:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AE80102F22FF;
	Fri, 17 Oct 2025 08:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760684357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6VjiAwlnAaPSfGdrf60Hyg6jUXaFHDvITlfpGvqxAm0=;
	b=fAk5Ef0DF+6h6xHBiRHRQk91kJx2IEl7f6IDerNI+IHsad5AiDg2/9F66BmxmpFLluvDJF
	L5WmRKBzzQLcK8GIYKXJp67GUWY/FOI10a63IvKvGudc4Knyb4esZevhL/ary20yTJpV4B
	nzZxc7Z4qAcxApCXYK1zOqNIh6Qf8t+TKtGGlnR8H9GKIeSKkkDM8RUP4Chotl78DGvsOI
	hwFo/M1vobrnYHn0nuciBtZ9l0URBA+qLimc+Ak/2rxPp5UQ6AZkvGwfOMQ0bBr5jz7vms
	eXxvbrlT+GSObjJ5m6rAHQrchLGUTw1DuS5rajwzQe4udfTNgFYkCKwAu+V/6g==
Date: Fri, 17 Oct 2025 08:59:04 +0200
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
Message-ID: <20251017085904.07e40e37@bootlin.com>
In-Reply-To: <d7576a0bb9a8d5326d77ae434131540b4359bd2a.camel@gmail.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
	<20251015211420.031c61fa@bootlin.com>
	<de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
	<20251016160202.3d4d0a5e@bootlin.com>
	<d7576a0bb9a8d5326d77ae434131540b4359bd2a.camel@gmail.com>
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

On Thu, 16 Oct 2025 16:26:28 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

...

...
> > > > > > +
> > > > > > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-    
> > > > > > > adc_core[0],    
> > > > > > +					   "adc1-avdd", "adc1-vref");
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-    
> > > > > > > adc_core[1],    
> > > > > > +					   "adc2-avdd", "adc2-vref");
> > > > > > +	if (ret)
> > > > > > +		return ret;      
> > > > > 
> > > > > Hmm, is avdd really an optional regulator? I mean can the ADC power up
> > > > > at
> > > > > all
> > > > > without a supply in AVDD? Even vref seems to be mandatory as we can't
> > > > > properly
> > > > > scale the sample without it.    
> > > > 
> > > > Where do you see that avdd is an optional regulator?    
> > > 
> > > You are using devm_regulator_get_optional(). That's for optional regulators.
> > >   
> > 
> > Indeed I use devm_regulator_get_optional().
> > 
> > We have two similar function to get regulators:
> > - devm_regulator_get() and
> > - devm_regulator_get_optional().
> > 
> > devm_regulator_get() returns a dummy regulator if the regulator is not
> > described in the device-tree. The calling code has no way to known if
> > the regulator was present or not.  
> 
> Yeah because it's mandatory and the part cannot work without power :). So we
> should not be allowed to operate without a regulator.
> 
> > 
> > On the other hand, devm_regulator_get_optional() returns -ENODEV when the
> > regulator is not described.
> > 
> > That's pretty confusing but it is the reality.
> > 
> > I use devm_regulator_get_optional() but check for -ENODEV to see if the
> > regulator is provided or not.
> > 
> > In order to use the ADC core (is_used flag), I need both the AVDD and the
> > VREF regulator available.  
> 
> And that is why I don't get why are we allowed to proceed if there's no
> regulators? That seems wrong to me. 
> 
> So I think the regulators should be mandatory in the bindings and a dummy
> regulator should also not be allowed in this case because that should get you 
> -EINVAL when calling regulator_get_voltage().
> 

I have 4 regulators: avdd1, vref1, avvd2, vref2.

The ADC controller can work with 2 internal ADC core (adc_core[0] and adc_core[1])
in the driver. Those internal core are not directly accessed by the driver. Only
the ADC controller is accesses.

Those cores have an AVDD and a VREF power supply.

We can use either adc_core[0] only, adc_core[1] only or both adc cores.

Depending on regulator described, the driver uses one or two adc cores.

This choice is done by:
--- 8< ---
static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
					 struct iio_dev *indio_dev)
{
	int adc_used;

	adc_used = rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
	adc_used |= rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;

	switch (adc_used) {
	case 0x01:
		indio_dev->channels = rzn1_adc1_channels;
		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
		return 0;
	case 0x02:
		indio_dev->channels = rzn1_adc2_channels;
		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
		return 0;
	case 0x03:
		indio_dev->channels = rzn1_adc1_adc2_channels;
		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_adc2_channels);
		return 0;
	default:
		break;
	}
--- 8< ---

In rzn1_adc_core_get_regulators(), looking at one core I do the
following:
 - Try to get AVDD (using get_optional)
 - Try to get VREF (using get_optional)
 - Core is used only if both regulators are present.

For one core to be used, both regulators have to be present.

Regulators are mandatory but adc core usage is optional.

This optional usage depends on related regulator presence.


> > 
> > Hum, do you think it's worth a try?  
> 
> Not sure. But it got me thinking about all this handling in the pm runtime
> routines. So if in the resume() call you fail at some point and then disable
> stuff in your return path and then we get an unbind won't things (clocks and
> regulators) be unbalanced leading to splats? In fact by just looking at the
> unbind path [1] I can see:
> 
> 1. We call pm_runtime_get_sync(dev) which can fail;
> 2. Later on we call pm_runtime_put_sync(dev).
> 
> Not really sure if there's special handling in the pm core to be aware that
> resuming failed (the refcount seems to be incremented [2] before resuming so...)
> 
> Maybe I would keep it simple and get and enable clocks/regulators during probe
> and only care of rzn1_adc_power() in the runtime routines. My 2 cents.
> 
> [1]: https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/dd.c#L1249
> [2]: https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/power/runtime.c#L1189
> 

I see, thanks for those clarifications.
I will simplify and, as you proposed, I will only take care of rzn1_adc_power().

Best regards,
Hervé

