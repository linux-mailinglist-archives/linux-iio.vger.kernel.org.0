Return-Path: <linux-iio+bounces-25174-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09875BE6F47
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F0625093
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 07:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD9D239573;
	Fri, 17 Oct 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q7+xXmnG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DB22ACEF;
	Fri, 17 Oct 2025 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686632; cv=none; b=N6vHNcNP/jdWQIXhR1t9i5SPhKC7E90eyeMP/gQ3hMUGlufwm2TKngDyhqIepDvHVwbgV8rWIE5PBgTJ6yam0NyQJ5NC5ogS4NhFqEb2a6I2XgEXnV4qPdDIoxM0Nijn+Cmh7KVwvMwDUMfz90qHVzSKYkWriOmVGCw3SID5Gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686632; c=relaxed/simple;
	bh=XpEL9oM2Q6hwqTx+Q2i/5Z/FDYFR+6KRpvMuvhq7Ovc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmwkL2h84DR01O8MK/tMlwNWYISLzXQrByl04L+xznMYWDSKzGd8ISD3ziGJDm/LtI0Bag08dwyV0vNo4tPOyupoW0eqz5x5sHQOh47P2lS3yMS4DWgyKkcy9cY6CXqZRvR/f7X3QqToWdx0qQtEcO86dRm0nFTsV0jX3H2fo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q7+xXmnG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 08F134E40B36;
	Fri, 17 Oct 2025 07:37:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1541606DB;
	Fri, 17 Oct 2025 07:37:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2422D102F2292;
	Fri, 17 Oct 2025 09:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760686626; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JOW8UJxO9T39NNPi0vwW+ahsGyVdO2TbKfHgdJqSrmc=;
	b=Q7+xXmnGjsfONNO7RdknAoYKUvJSWKc4No9/CaTnR+6x1/wcnOkyN3tXGBBPl2hyRnJGUx
	qVVIYdVa+r1AZfhKTo9/ua63VWU9FhiDbTIi0X7aNxn263z93ss1F9Ppz3gyDWCGcLjMst
	zBUzMbxH7bhYx9AUVOCbVbCzoPW4JXAe6jVFAiau8X84me/SSVCTt/iapCLUkYT/1N2SLG
	xR1V/y3hoVmns6bWCnln/0QJGnM2f6G+zhz8WyFVX30Pj/BKHa+5gqzwTuG5JX9j4IGnq8
	KNwSs0bKdlyF+7srNcovElUXd8GFvxDsBqQQhBNhBnhB7jofpx5jngCXx4d8pg==
Date: Fri, 17 Oct 2025 09:36:49 +0200
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
Message-ID: <20251017093649.2d5549e4@bootlin.com>
In-Reply-To: <aPHiAObA61OVf8mY@ninjato>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-3-herve.codina@bootlin.com>
	<aPHiAObA61OVf8mY@ninjato>
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

On Fri, 17 Oct 2025 08:28:16 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> Hi Herve,
> 
> On Wed, Oct 15, 2025 at 04:28:14PM +0200, Herve Codina (Schneider Electric) wrote:
> > The Renesas RZ/N1 ADC controller is the ADC controller available in the
> > Renesas RZ/N1 SoCs family. It can use up to two internal ACD cores (ADC1  
> 
> ADC cores

Yes, indeed.

> 
> > and ADC2) those internal cores are not directly accessed but are handled
> > through ADC controller virtual channels.
> > 
> > Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>  
> 
> Very high level review.
> 
> > +/*                  ADC1 ADC2
> > + * RZ/N1D, BGA 400   y    y
> > + * RZ/N1D, BGA 324   y    n
> > + * RZ/N1S, BGA 324   y    n
> > + * RZ/N1S, BGA 196   y    n
> > + * RZ/N1L, BGA 196   y    n
> > + */  
> 
> I think this table can go. N1D is the only variant supported by Linux
> because others have no SDRAM controller. Maybe a comment after the
> copyright is helpful stating that the second ADC core is utilized when
> the adc2-* bindings are supplied?

Yes, with only RZ/N1D supported, this table doesn't bring any additional
information.

As you suggested, I will add information about ADC cores in the header
part of this .c file.

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
> 
> Are you open to either use an errno (maybe EACCES) or define something
> custom (maybe RZN1_ADC_NO_CHANNEL) instead of hardcoded -1? I think I
> like the latter a tad more.

I prefer RZN1_ADC_NO_CHANNEL too instead of an error code and I will use
that instead of -1 in the next iteration.

Best regards,
Hervé

