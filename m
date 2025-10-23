Return-Path: <linux-iio+bounces-25366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 380BAC00087
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 10:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306454F2394
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503B3016FD;
	Thu, 23 Oct 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dh+noOqF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5182FB632;
	Thu, 23 Oct 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209713; cv=none; b=jQpCXn5BC4m3v41MRO7TWqyj7IIxkW/OuI5bJUAerZDZNRzqTPcApbKL4P3pVdoIJpSEQbtblVWEgP7grFRIaEh1Wdr4kE2DY1X2dS76oV2lB/w8zvoOYqz6iND6rWTs/ixZR6hsrmrgpdeO16yIP+wdq2XTEZX6h/wSl2q35tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209713; c=relaxed/simple;
	bh=vnI0o5WV/8375Q9X3ezTYN6ydp49H3sIrzgEDjPS0M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSlPzAybM0+t6qeSOeiSQ3e7A/xgqhGYRDEf7hHM/DKWtx34NlC7TbNZ7afw5Z4PiwAmOyBDTOrI3aDyw7/d5OWVU7ljeeX0aOmOe3yAxoGLZZtvjxvrha8rpUeaLxXOfXsRZBgWsD01akQmyDquiIoAbS5cbPXEMPiwzONOabs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dh+noOqF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2014E4E4129D;
	Thu, 23 Oct 2025 08:55:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D88146062C;
	Thu, 23 Oct 2025 08:55:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4431B102F2459;
	Thu, 23 Oct 2025 10:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761209707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JJYzWRervYd6xbaGyN0P+R856qBpgbVlxMHKNl9v3HA=;
	b=Dh+noOqF8/+jpFrrF36/6zTmuFM+BcOLEgl7rR5koN0gDqES3Y9Vc4aTxVof+1szs0h4+Z
	j8yzHp/1NOYNXyXi18QELWmyZvXr/sjZJeDoJHLlqkFh4CyWMx96xXiiBQJIX6iPQN0utc
	y77gPkWk7nIjkfwB7ernZXMvUHH9W1o6cScnw3NcwUPb4QolxQF9DXE5ZFl4sWrwUOJ3k7
	gRVAK6PVW8nl8XEh8mWdv4OXamJzB/DVAPzr1N5o0808HrN80pDz+KM9ZredUFsUvL3dgF
	8j4X0axfYUa2MmZ/IS1QWxI8V1B3kZyIyXSfxgK3E00sLHJeIFnF3vJKQRGYfA==
Date: Thu, 23 Oct 2025 10:55:03 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus
 Damm <magnus.damm@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
Message-ID: <20251023105445.1adb2e86@bootlin.com>
In-Reply-To: <20251017090742.49f2d628@bootlin.com>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-2-herve.codina@bootlin.com>
	<aPEoqkdatl4G82co@shikoro>
	<20251017090742.49f2d628@bootlin.com>
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

Hi Wolfram, Geert,

On Fri, 17 Oct 2025 09:07:42 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - renesas,r9a06g032-adc   # RZ/N1D
> > > +      - const: renesas,rzn1-adc    
> > 
> > Do you know of other SoCs with this IP core? If it is only RZ/N for now,
> > we could go with const for N1D. All other N1 variants cannot run Linux
> > because of no SDRAM controller.
> >   
> 
> I know only about RZ/N1 family.
> 
> I will keep only "renesas,r9a06g032-adc" in the next iteration.
> 

May be I misunderstood.

Most of other bindings related to rzn1d have the both r9a06g032 and
rzn1 compatible string.


Would you expect:

  - a) renesas,r9a06g032-adc and renesas,rzn1-adc

    compatible:
      items:
        - const: renesas,r9a06g032-adc   # RZ/N1D
        - const: renesas,rzn1-adc

or

 - b) renesas,r9a06g032-adc only

    compatible:
      const: renesas,r9a06g032-adc

Can you confirm your expectation?

Best regards,
Hervé

