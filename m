Return-Path: <linux-iio+bounces-23380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0BDB3BF0D
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE44A01ECB
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925C322A3D;
	Fri, 29 Aug 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="ubHKogH3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03948314B82;
	Fri, 29 Aug 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480837; cv=none; b=NvDm6OOu6jKzrStuy1WzVEZRZ7cZsYqGbbUhU3KrwCNM9GA9LjrZzN1FSdDSUb5hp8ZjiP7ABKVLLPBt4v2mLMjyqLa9GAKEESZPV904UbfHGASS09gDKDxilfskZFFRdCOeEZryPn97NaML8NT1ZM6YDwqyDsl0vh2GK0JvlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480837; c=relaxed/simple;
	bh=T8VUd2JD/kzWzvbmfVYvtWKcNtsmaPwe0r8nEevSY7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWnkVYbRt+wz/5Ydt3sv/un01FZIGi9yXvewCG4Vt55QR1BL0pyuCNGWexZKIBJ+3SY8GzRLYn/KjbRYV4n8UDxbJBZ/q7luoM0buAhqdS4NPGNsua3EzxGF/1qq+o5j+aVUYpjtXHjSl5j0n6hTTweKG/8CGx86O6SssoYGqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=ubHKogH3; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=3QQYotBOPK5tBpX1HJ+fA7Ibti4EjTziQULJn+9wQ7U=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756480818; v=1; x=1756912818;
 b=ubHKogH3XFmdIwW+4CYDv5zm6Wb2oh3E0UxOVTJOLksZWi6RjnTuK4pLiULN01kU9CgK+aKv
 vLjc+o5dr2AyEeecwWfFm/Wu2LUWAyuPI/65m36+BykzucvygmGXO8ojGlEA8d5VcvNmRqf0xk/
 qpciPB4AkkssIfQueAql7RybLWcLe44TNQ1DxcMO+3sciAGwaSfE4mKsgtlGJjji17CFGSkX7QH
 0gW8pzBcc7Z6gXSg6uLTOg3wE5qR+UZqmnx5z4jCvK/lJq7rnKbMC5I1OO+v9xsqr7/W1T4da42
 1jGXtmk6ZzMme4QtBA3aViRYn6ydWDD8uBHCIHOu/W+aw==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id e6b3fbc8; Fri, 29 Aug 2025 17:20:18 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
 Lee Jones <lee@kernel.org>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Date: Fri, 29 Aug 2025 17:20:17 +0200
Message-ID: <2250556.Mh6RI2rZIc@radijator>
In-Reply-To: <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
References:
 <20250829-88pm886-gpadc-v1-0-f60262266fea@dujemihanovic.xyz>
 <20250829-88pm886-gpadc-v1-1-f60262266fea@dujemihanovic.xyz>
 <4f93d53a-3dfa-4b9f-8c09-73703888d263@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 29 August 2025 01:40:56 Central European Summer Time David Lechner wrote:
> > +#define ADC_CHANNEL(index, lsb, _type, name) {	\
> > +	.type = _type, \
> > +	.indexed = 1, \
> > +	.channel = index, \
> > +	.address = lsb, \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > +			      BIT(IIO_CHAN_INFO_PROCESSED), \
> > +	.datasheet_name = name, \
> 
> Do you have a link for the datasheet?

No, unfortunately. The only reference I have for the ADC itself is this
vendor driver:
https://github.com/acorn-marvell/brillo_pxa_kernel/blob/master/drivers/iio/adc/88pm88x-gpadc.c

> > +	ADC_CHANNEL(VSC_CHAN, 1367, IIO_VOLTAGE, "vsc"),
> > +	ADC_CHANNEL(VCHG_PWR_CHAN, 1709, IIO_VOLTAGE, "vchg_pwr"),
> > +	ADC_CHANNEL(VCF_OUT_CHAN, 1367, IIO_VOLTAGE, "vcf_out"),
> > +	ADC_CHANNEL(TINT_CHAN, 104, IIO_TEMP, "tint"),
> > +
> > +	ADC_CHANNEL(GPADC0_CHAN, 342, IIO_VOLTAGE, "gpadc0"),
> > +	ADC_CHANNEL(GPADC1_CHAN, 342, IIO_VOLTAGE, "gpadc1"),
> > +	ADC_CHANNEL(GPADC2_CHAN, 342, IIO_VOLTAGE, "gpadc2"),
> > +
> > +	ADC_CHANNEL(VBAT_CHAN, 1367, IIO_VOLTAGE, "vbat"),
> > +	ADC_CHANNEL(GNDDET1_CHAN, 342, IIO_VOLTAGE, "gnddet1"),
> > +	ADC_CHANNEL(GNDDET2_CHAN, 342, IIO_VOLTAGE, "gnddet2"),
> > +	ADC_CHANNEL(VBUS_CHAN, 1709, IIO_VOLTAGE, "vbus"),
> > +	ADC_CHANNEL(GPADC3_CHAN, 342, IIO_VOLTAGE, "gpadc3"),
> > +	ADC_CHANNEL(MIC_DET_CHAN, 1367, IIO_VOLTAGE, "mic_det"),
> > +	ADC_CHANNEL(VBAT_SLP_CHAN, 1367, IIO_VOLTAGE, "vbat_slp"),
> > +
> > +	ADC_CHANNEL(GPADC0_RES_CHAN, 342, IIO_RESISTANCE, "gpadc0_res"),
> > +	ADC_CHANNEL(GPADC1_RES_CHAN, 342, IIO_RESISTANCE, "gpadc1_res"),
> > +	ADC_CHANNEL(GPADC2_RES_CHAN, 342, IIO_RESISTANCE, "gpadc2_res"),
> > +	ADC_CHANNEL(GPADC3_RES_CHAN, 342, IIO_RESISTANCE, "gpadc3_res"),
> 
> Is it safe (or sensible) to have both voltage and resistance channels
> for the same input at the same time? It seems like if a voltage
> channel was connected to an active circuit, we would not want to be
> supplying current to it to take a resistance reading (this doesn't
> sound safe). Likewise, if a voltage input has a passive load on it,
> wouldn't the voltage channel always return 0 because no current was
> supplied to induce a voltate (doesn't seem sensible to have a channel
> that does notthing useful).
> 
> It might make sense to have some firmware (e.g. devicetree) to describe
> if the input is active or passive on the voltage inputs and set up the
> channels accordingly.
> 
> I'm also wondering if the other channels like vbat and vbus are always
> wired up to these things internally or if this channel usage is only for
> a specific system.

Looking at the vendor kernel, I am fairly confident that the channels
labeled gpadc are indeed general-purpose and connected to arbitrary
resistances (thermistors and battery detection depending on the board),
while the rest are fixed-function as their names imply.

The above most likely is safe as my board is still functional, but it
probably doesn't make sense to keep the voltage channels so I suppose
I'll drop these in v2.

> > +	int val, ret;
> > +	u8 buf[2];
> > +
> > +	if (chan >= GPADC0_RES_CHAN)
> > +		/* Resistor voltage drops are read from the corresponding voltage channel
> > */ +		chan -= GPADC0_RES_CHAN - GPADC0_CHAN;
> 
> Does this actually work for GPADC3_RES_CHAN?
> 
> GPADC3_RES_CHAN == GPADC0_RES_CHAN + 3 but GPADC3_CHAN != GPADC0_CHAN + 3

Good catch. Upon closer inspection, the order of the channel enum
doesn't matter much and I'll fix this by simply ordering the enum more
wisely.

> > +		     long mask)
> > +{
> > +	struct device *dev = iio->dev.parent;
> > +	int raw, ret;
> > +
> > +	ret = pm_runtime_resume_and_get(dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (chan->type == IIO_RESISTANCE) {
> > +		raw = gpadc_get_resistor(iio, chan);
> > +		if (raw < 0) {
> > +			ret = raw;
> > +			goto out;
> > +		}
> > +
> > +		*val = raw;
> > +		dev_dbg(&iio->dev, "chan: %d, %d Ohm\n", chan->channel, *val);
> > +		ret = IIO_VAL_INT;
> > +		goto out;
> > +	}
> > +
> > +	raw = gpadc_get_raw(iio, chan->channel);
> > +	if (raw < 0) {
> > +		ret = raw;
> > +		goto out;
> > +	}
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> 
> If there is IIO_CHAN_INFO_RAW, then we also should have IIO_CHAN_INFO_SCALE.
> 
> > +		*val = raw;
> > +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_PROCESSED: {
> 
> Unusual to have both raw and processed. What is the motivation?

I was following what ab8500-gpadc does, no particular motivation.
Considering the above, to me it makes the most sense to limit it to
processed.

> > @@ -67,6 +68,35 @@
> > 
> >  #define PM886_REG_BUCK4_VOUT		0xcf
> >  #define PM886_REG_BUCK5_VOUT		0xdd
> > 
> > +/* GPADC enable/disable registers */
> > +#define PM886_REG_GPADC_CONFIG1		0x1
> > +#define PM886_REG_GPADC_CONFIG2		0x2
> > +#define PM886_REG_GPADC_CONFIG3		0x3
> > +#define PM886_REG_GPADC_CONFIG6		0x6
> 
> Could just write this as:
> 
> #define PM886_REG_GPADC_CONFIG(n)		(n)
> 
> > +
> > +/* GPADC bias current configuration registers */
> > +#define PM886_REG_GPADC_CONFIG11	0xb
> > +#define PM886_REG_GPADC_CONFIG12	0xc
> > +#define PM886_REG_GPADC_CONFIG13	0xd
> > +#define PM886_REG_GPADC_CONFIG14	0xe
> > +#define PM886_REG_GPADC_CONFIG20	0x14
> 
> which covers these too.
> 
> Most of these aren't used anyway.
> 
> Also suspicious that there are 5 registers listed here
> but only 4 channels for resistance.

The last one is used to enable the bias generators, the rest only set
the bias current for their respective channel.

Regards,
--
Duje




