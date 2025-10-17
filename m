Return-Path: <linux-iio+bounces-25176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5854BE7074
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 10:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15486251F6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7D266EF1;
	Fri, 17 Oct 2025 08:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EePkFiAz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D122620D5;
	Fri, 17 Oct 2025 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688009; cv=none; b=BttcvZE3BIZx2VYjVchX/34R2TepgoW5FrVcp0uNSlF0Mk3Huz8cIgmo1ALOhjAWhJ+Aw3Dx9VYYs/olCg9PUK1Xjx9w3STYoHEoJlNH2a77V4tXaukKg7Xrsj+3t+smAvb/PkGRqkgRJYjx1N0rrmQ2gxnt5eNoxCBv4gsPk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688009; c=relaxed/simple;
	bh=Tc3/ELtbtt0sJENB0B7Or+iGswnWW4vMvbAo+PxCyHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laACUbdzsGCFRfwRdxyTVMTAjy3WclRMQTeRvwVR6eD6ZESlb/Zg02y8OFRMBJqsvRcupByWBDHdW2xZCkNJ4H3zqxNUC+yT5G4iII4m+7zlA2/KY+nuPi2pUx4oXUsGrnKaV11iHrxLjoSj5dCF6OOxXh0VNyxsrw6mm2FkATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EePkFiAz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AF1DCC041DD;
	Fri, 17 Oct 2025 07:59:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA567606DB;
	Fri, 17 Oct 2025 08:00:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AAFD102F22F0;
	Fri, 17 Oct 2025 09:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760688001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qdb3zBaLrjZWsHURH6g1nqx2Ac1GQ6bBBQODdXaFSNI=;
	b=EePkFiAz+vAhFGrOoRPyHPtjzVhwvdEKp+PMnxHYe3qDGcRf3gJiYsjePY4CMJPpyfVfJ2
	2cWO3cw7v+xhxRrPJx9ZuCnm9OMFJEiNkz5soqmi4IKQq7UFnQk9Bv8zLFc3n5cGwNH2Dw
	mdDyHgiXEY5+mWQto3TvNoBvEvgYLQjB+eszduPGsefGe9sCVBvTMkd6cK2DfUZTs3v5Rh
	mNkcDqPZV+3HIgSpydNxaC1h1vSu1BEhHqTfsJ5chzn5inpRYrmM7O1ldan1f/n+oAdcYL
	JgHt7NUHdI68zz9LP11u4J7hxqN3lO14wCyFamJ65IcXF8l2912Z7JyMH8EqHA==
Date: Fri, 17 Oct 2025 09:59:36 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pascal Eberhard
 <pascal.eberhard@se.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/4] iio: adc: Add support for the Renesas RZ/N1 ADC
Message-ID: <20251017095936.71cb318b@bootlin.com>
In-Reply-To: <CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<aPHiAObA61OVf8mY@ninjato>
	<20251017093649.2d5549e4@bootlin.com>
	<CAMuHMdV0As4XKG0P0y+pJpTT82Bq8qpq2rHufeX4_q0j-eOPPA@mail.gmail.com>
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

Hi Geert,

On Fri, 17 Oct 2025 09:40:42 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Hervé,
> 
> On Fri, 17 Oct 2025 at 09:37, Herve Codina <herve.codina@bootlin.com> wrote:
> > Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:  
> > > On Wed, Oct 15, 2025 at 04:28:14PM +0200, Herve Codina (Schneider Electric) wrote:  
> > > > +static void rzn1_adc_vc_setup_conversion(struct rzn1_adc *rzn1_adc, u32 ch,
> > > > +                                    int adc1_ch, int adc2_ch)
> > > > +{
> > > > +   u32 vc = 0;
> > > > +
> > > > +   if (adc1_ch != -1)
> > > > +           vc |= RZN1_ADC_VC_ADC1_ENABLE | RZN1_ADC_VC_ADC1_CHANNEL_SEL(adc1_ch);
> > > > +
> > > > +   if (adc2_ch != -1)
> > > > +           vc |= RZN1_ADC_VC_ADC2_ENABLE | RZN1_ADC_VC_ADC2_CHANNEL_SEL(adc2_ch);  
> > >
> > > Are you open to either use an errno (maybe EACCES) or define something
> > > custom (maybe RZN1_ADC_NO_CHANNEL) instead of hardcoded -1? I think I
> > > like the latter a tad more.  
> >
> > I prefer RZN1_ADC_NO_CHANNEL too instead of an error code and I will use
> > that instead of -1 in the next iteration.  
> 
> Or just -ENODEV or -ENOENT, and change the checks above to
> "if (adc1_ch >= 0)"?

I prefer to avoid mixing channel numbers with error code.

The specific RZN1_ADC_NO_CHANNEL value looks good to me meaning "No channel
to use".

Best regards,
Hervé

