Return-Path: <linux-iio+bounces-25196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE99BE9826
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 17:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FB474148C
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 15:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB81332905;
	Fri, 17 Oct 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VWZ2lb80"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89932C946;
	Fri, 17 Oct 2025 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713274; cv=none; b=LY/UmGcVf9UG3ngXEbXF/J1V3U7HQw+Jf7U/B/PndjBO0dUbOb56ehVHkeO2/UEeou6K2jU1f4vyRHrFtUqZe8L5TwqnxpmTq4qVQnAx6LkbldWJ9xcvUOSMJ6RuRz3XZf35Y7vTlqALIqCg1pqOB+2q/xjutvEwYLRhXkHNZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713274; c=relaxed/simple;
	bh=fu1rgFg6zFERmWrukTHtScTFU9VI+YSEm3Jqr3a3rqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J07JHeDck/7Uov7sbn9jM7+3ziAro6YmO2DSLBk3HPesz21L/5kmfcbyeNI460nllP46/XVk7DTCH15sIZPQga9JlkjWZkZI3pyAM8/zxbhlUr3+IeZGUZuflmaNhOYFcNN9RGIh8Gt4n/QA9s9Mt1NUFG8MpjzFYWnABdNwT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VWZ2lb80; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E464EC041F6;
	Fri, 17 Oct 2025 15:00:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28795606DB;
	Fri, 17 Oct 2025 15:01:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53F01102F2363;
	Fri, 17 Oct 2025 17:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760713265; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b9g9x9l+TGh+Jz6FtSUgUJKPZ2bmCq5GDO9amdTb+jU=;
	b=VWZ2lb805RvAcMpu2w7GsmG4qPzHEvrmTXEmSf8bLkdyqv8tELrbP1N9GAyxwhuevB6DOy
	ZqLha3EVHs7C3aY05GsxzDYApneZKZroDf1OnCtTXktlSpyHTuHIzyiT2dBcYisbYJ/f7T
	JjroPIiENIUsrrrjgkPAU1zfgNM5V990gaiQRXv265R9Ht/4SIcK6lfOUNPhmIEqJHYDG0
	mVJLKaoYho9vY3N3HdSWjsf+FUAkElIPSoSpFZ7JcYofHz0UTYpB6tzfJP75sHyGiOhmcq
	UMkhtwb88dZwI94C0APecwjz124C0yM9cmIq7lZILPj1skAr+Jf7/L5H4YtUBA==
Date: Fri, 17 Oct 2025 17:00:54 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251017170054.7a7a6d5f@bootlin.com>
In-Reply-To: <aPIIVUlHnvi0BXtN@shikoro>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<aPIIVUlHnvi0BXtN@shikoro>
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

Hi Wolfram,

On Fri, 17 Oct 2025 11:11:49 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> > +static int rzn1_adc_read_raw_ch(struct rzn1_adc *rzn1_adc, unsigned int chan, int *val)
> > +{
> > +	u32 *adc1_data, *adc2_data;
> > +	int adc1_ch, adc2_ch;
> > +	u32 adc_data;
> > +	int ret;
> > +
> > +	if (chan < 8) {
> > +		/* chan 0..7 used to get ADC1 ch 0..7 */
> > +		adc1_ch = chan;
> > +		adc1_data = &adc_data;
> > +		adc2_ch = -1;
> > +		adc2_data = NULL;
> > +	} else if (chan < 16) {
> > +		/* chan 8..15 used to get ADC2 ch 0..7 */
> > +		adc1_ch = -1;
> > +		adc1_data = NULL;
> > +		adc2_ch = chan - 8;
> > +		adc2_data = &adc_data;
> > +	} else {
> > +		return -EINVAL;
> > +	}  
> 
> How about putting part of the logic into the setup function? So, here
> only:
> 
> 	if (chan >= 16)
> 		return -EINVAL
> 
> > +
> > +	ret = pm_runtime_resume_and_get(rzn1_adc->dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mutex_lock(&rzn1_adc->lock);
> > +
> > +	rzn1_adc_vc_setup_conversion(rzn1_adc, chan, adc1_ch, adc2_ch);  
> 
> 	rzn1_adc_vc_setup_conversion(rzn1_adc, chan);
> 
> And in that function:
> 
> > +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
> > +					 int adc1_ch, int adc2_ch)
> > +{
> > +	u32 vc = 0;
> > +
> > +	if (adc1_ch != -1)
> > +		vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch);
> > +
> > +	if (adc2_ch != -1)
> > +		vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(adc2_ch);
> > +
> > +	writel(vc, rzn1_adc->regs + RZN1_ADC_VC_REG(ch));
> > +}  
> 
> 	if (ch < 8)
> 		vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(ch);
> 	else
> 		vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(ch - 8);
> 
> And a similar simplification for rzn1_adc_vc_wait_conversion().
> 
> Should work and the code is even more readable, I'd say. And has less
> lines.
> 

That was what I did on my first driver draft before sending this first
iteration. I moved to adc1 and adc2 channel numbers in parameters to avoid
adding this logic here.

I think it was better to decouple the IIO chan number from the adc core
channel used.

I don't know if it will be relevant but we can image a future improvement
where new IIO chans use both the ADC core 1 and 2. It could make sense.

IMHO, I think the solution you proposed is similar in term of complexity
to the RZN1_ADC_NO_CHANNEL approach. On my side, I would prefer the
RZN1_ADC_NO_CHANNEL approach to keep the decoupling between IIO chan and
ADC core chans.

That's said, I am still open to move in your direction if you still think
it is more relevant than the RZN1_ADC_NO_CHANNEL approach. Just tell me.

Best regards,
Hervé

