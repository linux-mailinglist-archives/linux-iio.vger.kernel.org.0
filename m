Return-Path: <linux-iio+bounces-25201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2236BEA296
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B66E19C470B
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 15:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FE22F12C2;
	Fri, 17 Oct 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PVWvx2vm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7822E716A;
	Fri, 17 Oct 2025 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715822; cv=none; b=mB1beZ297caZnxucVeDWLMf7ewLC2keTatZ4767/H+Qk3gmffApqMtV6lh3E5TlSGAsatPws0cV3fEgHooBtJXJGV+3IP+ka9duII/jSPeHmRXui1KHaL1ZHNZtNrba6ZSU/QGkTCGFd9i/oljL1LFgenFRF1UzwYtsJ8O+q35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715822; c=relaxed/simple;
	bh=IBzm0BkIQZZsdt4xJw7y+O0Sm5/LFDw6hjYa1sV6J7M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdpJxT/othZHSIKaVtr/dNKaIrdOMwEqLXAFfb39gxlVzBwEQNWzakrH+b/lyVxqycKMHuCd1ML7Ok7kaTul2LsSdr8ZWzuHCL8e8hjluGUlUrwvz5rN1rrITBkX8Iv8/1EuwQNDtQDWohK4FyES0OJjYkbu7R9U2cwWqcM2FLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PVWvx2vm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D0ACCC041F7;
	Fri, 17 Oct 2025 15:43:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1E02F606DB;
	Fri, 17 Oct 2025 15:43:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34268102F2326;
	Fri, 17 Oct 2025 17:43:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760715816; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=T3sgtYckKNpZfrVMfRULcu2lLGe70YFSspAezpijEXk=;
	b=PVWvx2vmTlWIvYh5BJEJwIeglCvikRUVYwmfYiDqyDUGT0g22W9Dz9279iBM9hEHSqEx/X
	LwhMRobtn4HcGtIcNlimhAkTTqiARlgQ1jyJ+vEaBQFPkSNXBzsXW6axUuOWNMSbKcBv3g
	Pbl3bQJ0KyNTNRN8Gz92zA7lC4fK47UUIuN3iTbbLGxSfSygnHOrx/ULz/RxfU1iDhWBVH
	JydHsoDBSks4pvHd9Vwt3Nv/lmUZ74yAkfTudbQtRPhKKcenvHlVXLyUwsWUio8EBONSqC
	QTJC4Lv0gR63T/NgZyWZwemAAIrRo4eE3LZVJkSB9owqhtMmpfQwqZsdrPiCrw==
Date: Fri, 17 Oct 2025 17:43:22 +0200
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
Message-ID: <20251017174322.07997789@bootlin.com>
In-Reply-To: <10e119ee5a76f1c47d7eb6a15989c8ffc00ffc5f.camel@gmail.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<1e8d7c96cdfaa93bcc0f581103dc0e13dfee17b7.camel@gmail.com>
	<20251015211420.031c61fa@bootlin.com>
	<de57f5274b2fe0aac3621dc10cb6d4d0d98d3063.camel@gmail.com>
	<20251016160202.3d4d0a5e@bootlin.com>
	<d7576a0bb9a8d5326d77ae434131540b4359bd2a.camel@gmail.com>
	<20251017085904.07e40e37@bootlin.com>
	<10e119ee5a76f1c47d7eb6a15989c8ffc00ffc5f.camel@gmail.com>
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

I Nuno,

On Fri, 17 Oct 2025 09:26:26 +0100
Nuno Sá <noname.nuno@gmail.com> wrote:

> On Fri, 2025-10-17 at 08:59 +0200, Herve Codina wrote:
> > Hi Nuno,
> > 
> > On Thu, 16 Oct 2025 16:26:28 +0100
> > Nuno Sá <noname.nuno@gmail.com> wrote:
> > 
> > ...
> > 
> > ...  
> > > > > > > > +
> > > > > > > > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-
> > > > > > > >       
> > > > > > > > > adc_core[0],      
> > > > > > > > +					   "adc1-avdd", "adc1-
> > > > > > > > vref");
> > > > > > > > +	if (ret)
> > > > > > > > +		return ret;
> > > > > > > > +
> > > > > > > > +	ret = rzn1_adc_core_get_regulators(rzn1_adc, &rzn1_adc-
> > > > > > > >       
> > > > > > > > > adc_core[1],      
> > > > > > > > +					   "adc2-avdd", "adc2-
> > > > > > > > vref");
> > > > > > > > +	if (ret)
> > > > > > > > +		return ret;        
> > > > > > > 
> > > > > > > Hmm, is avdd really an optional regulator? I mean can the ADC power
> > > > > > > up
> > > > > > > at
> > > > > > > all
> > > > > > > without a supply in AVDD? Even vref seems to be mandatory as we
> > > > > > > can't
> > > > > > > properly
> > > > > > > scale the sample without it.      
> > > > > > 
> > > > > > Where do you see that avdd is an optional regulator?      
> > > > > 
> > > > > You are using devm_regulator_get_optional(). That's for optional
> > > > > regulators.
> > > > >     
> > > > 
> > > > Indeed I use devm_regulator_get_optional().
> > > > 
> > > > We have two similar function to get regulators:
> > > > - devm_regulator_get() and
> > > > - devm_regulator_get_optional().
> > > > 
> > > > devm_regulator_get() returns a dummy regulator if the regulator is not
> > > > described in the device-tree. The calling code has no way to known if
> > > > the regulator was present or not.    
> > > 
> > > Yeah because it's mandatory and the part cannot work without power :). So we
> > > should not be allowed to operate without a regulator.
> > >   
> > > > 
> > > > On the other hand, devm_regulator_get_optional() returns -ENODEV when the
> > > > regulator is not described.
> > > > 
> > > > That's pretty confusing but it is the reality.
> > > > 
> > > > I use devm_regulator_get_optional() but check for -ENODEV to see if the
> > > > regulator is provided or not.
> > > > 
> > > > In order to use the ADC core (is_used flag), I need both the AVDD and the
> > > > VREF regulator available.    
> > > 
> > > And that is why I don't get why are we allowed to proceed if there's no
> > > regulators? That seems wrong to me. 
> > > 
> > > So I think the regulators should be mandatory in the bindings and a dummy
> > > regulator should also not be allowed in this case because that should get
> > > you 
> > > -EINVAL when calling regulator_get_voltage().
> > >   
> > 
> > I have 4 regulators: avdd1, vref1, avvd2, vref2.
> > 
> > The ADC controller can work with 2 internal ADC core (adc_core[0] and
> > adc_core[1])
> > in the driver. Those internal core are not directly accessed by the driver.
> > Only
> > the ADC controller is accesses.
> > 
> > Those cores have an AVDD and a VREF power supply.
> > 
> > We can use either adc_core[0] only, adc_core[1] only or both adc cores.
> > 
> > Depending on regulator described, the driver uses one or two adc cores.
> > 
> > This choice is done by:
> > --- 8< ---
> > static int rzn1_adc_set_iio_dev_channels(struct rzn1_adc *rzn1_adc,
> > 					 struct iio_dev *indio_dev)
> > {
> > 	int adc_used;
> > 
> > 	adc_used = rzn1_adc->adc_core[0].is_used ? 0x01 : 0x00;
> > 	adc_used |= rzn1_adc->adc_core[1].is_used ? 0x02 : 0x00;
> > 
> > 	switch (adc_used) {
> > 	case 0x01:
> > 		indio_dev->channels = rzn1_adc1_channels;
> > 		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc1_channels);
> > 		return 0;
> > 	case 0x02:
> > 		indio_dev->channels = rzn1_adc2_channels;
> > 		indio_dev->num_channels = ARRAY_SIZE(rzn1_adc2_channels);
> > 		return 0;
> > 	case 0x03:
> > 		indio_dev->channels = rzn1_adc1_adc2_channels;
> > 		indio_dev->num_channels =
> > ARRAY_SIZE(rzn1_adc1_adc2_channels);
> > 		return 0;
> > 	default:
> > 		break;
> > 	}
> > --- 8< ---
> > 
> > In rzn1_adc_core_get_regulators(), looking at one core I do the
> > following:
> >  - Try to get AVDD (using get_optional)
> >  - Try to get VREF (using get_optional)
> >  - Core is used only if both regulators are present.
> > 
> > For one core to be used, both regulators have to be present.
> > 
> > Regulators are mandatory but adc core usage is optional.
> > 
> > This optional usage depends on related regulator presence.
> >   
> 
> Ok, then we could flip the logic and have boolean properties for the adc core
> usage and depending on that, requesting the regulators. To me, the intent would
> be more clear (at the expense of more FW properties).

This introduces a new property and duplicates the information:
- flag to tell if adc core is used
- regulators described only if used

And so, the possible flag set to "adc core used" but regulators not
described. This is error prone.


I have chosen to rely only on regulators description to avoid the
information redundancy.
  - regulators described -> adc core used
  - regulators not described -> adc core not used

> 
> Having said that, the above helps a lot in understanding what's going on and
> explains the get_optional() usage. I'm not still 100% convinced but bah, fine :)
> 
> I would still argue that you should have a comment (likely in get_regulators())
> explaining the logic and the optional usage.
> 
> Given the above I think you could also remove:
> 
> if (!adc_core->vref)
> 	return -ENODEV;
> 
> from rzn1_adc_core_get_vref_mv() since the channels are only exposed in case the
> regulators are present.

Yes indeed, I will remove the adc_core->vref check.

Best regards,
Hervé

