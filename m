Return-Path: <linux-iio+bounces-25172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF0BE6E4F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F059E50242A
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 07:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D333112DE;
	Fri, 17 Oct 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1tFictYX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756B3112B6;
	Fri, 17 Oct 2025 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684873; cv=none; b=fTJW9dzHBAJi7elhUBfMsG25o9pBSwyIObhTOvR1i1nSAuHN8NBv3UpEYWkCLNSXbyBQMIdvM9ssH+/Db47e0/tzYv7zOnvH36Q7faGl6ZtXHMav4oI7UFpS4hA1kquRullsZetaqBTWzAuSK3ePUcWFjH49AjnetgjzcjLFsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684873; c=relaxed/simple;
	bh=nGj8GFjt5qte1lomT2t2u3rGDiz7RAwncQys5pP/YSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBYid9L2Ii7L7ico6M5nuhoEp2fKjHxPKqE5HeKa9CJA+Y9l0Nrwrm0h2KMMTdnQRgTbQI5brX5EoJzxzc2xtUokbBOF2w4Wrgh7CbrnKph6/jTa6mQ2ae7GaOLrw0DU5jvomPRaPw50m2xURHTQ8Vv3zB/t6v8at9G5LfBeqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1tFictYX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A0237C041DC;
	Fri, 17 Oct 2025 07:07:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BFFAD606DB;
	Fri, 17 Oct 2025 07:07:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 027FB102F22FF;
	Fri, 17 Oct 2025 09:07:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760684868; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YKd2eae/Odja+KvQxWhp56FdbF5sP3xpzCWQkm4UAAA=;
	b=1tFictYXo+2tYvfpeF0hMYmhrAM0mGooNkpruRH2LKJJdQRoK+ZUIquw65ezYGcrAATwak
	VZp48QwzJHKjgmpdYeDcBmGTDddlATOqXzt06rXHhlGT/arZbEgYECjWYRuyNdF+UM4MMJ
	desYOO/ta+2Jep5CJUfnCInAC1jFOiygk1EWmlzTa9ausm3Ts1p2vB3OqG5TpNJ3rk1pbI
	VDx0+18xbgvDst9FPq90961cqcNiSn8wr2rBTPnIAyfesKyyDn3IDQVvCA4YsiaHxa2cSQ
	qL70eBnhwx0D8ZRE4hW6zHsiUNOoV41N+/awXOU8NsQJwRWyd6i0MONQGMLB+A==
Date: Fri, 17 Oct 2025 09:07:42 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: Add the Renesas RZ/N1 ADC
Message-ID: <20251017090742.49f2d628@bootlin.com>
In-Reply-To: <aPEoqkdatl4G82co@shikoro>
References: <20251015142816.1274605-1-herve.codina@bootlin.com>
	<20251015142816.1274605-2-herve.codina@bootlin.com>
	<aPEoqkdatl4G82co@shikoro>
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

On Thu, 16 Oct 2025 19:17:30 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> > +description:
> > +  The Renesas RZ/N1 ADC controller available in the Renesas RZ/N1 SoCs family
> > +  can use up to two internal ACD cores (ADC1 and ADC2) those internal cores are  
> 
> ADC cores?

Sure, will be fixed.

> 
> > +  handled through ADC controller virtual channels.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a06g032-adc   # RZ/N1D
> > +      - const: renesas,rzn1-adc  
> 
> Do you know of other SoCs with this IP core? If it is only RZ/N for now,
> we could go with const for N1D. All other N1 variants cannot run Linux
> because of no SDRAM controller.
> 

I know only about RZ/N1 family.

I will keep only "renesas,r9a06g032-adc" in the next iteration.

Best regards,
Hervé

