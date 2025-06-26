Return-Path: <linux-iio+bounces-20973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D53AEA538
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108EB7A6341
	for <lists+linux-iio@lfdr.de>; Thu, 26 Jun 2025 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198C223DF1;
	Thu, 26 Jun 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1TSmmKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7591A316C;
	Thu, 26 Jun 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962022; cv=none; b=ASBT+wm+ot827MARCtV/k8St6wz96+3LnOwHs1tGDRTwz4NTJe6LJbiuAxKp5EleRahLbrCqF14cvSeuIKFJhK0lKANnBurzHf0Vje22nSN3nn2IwVqGzcoAzsxYnLBlnSC75sVm9zj91dcu/ZDeB5Nr99m0i6kup88QGN0aBVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962022; c=relaxed/simple;
	bh=ojxtrCSlAxBab3aqEdaoBxwo2pv44yPWbPAbxh2oCzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbuTJ8MuVY5Zczb1ZEEBCZ9Y98lSP9Hl2ZbYJOiNWh0rTBtwcZQ6FWXRoENiyZAbhaRRb5e60SO1InGGagKoUe/wVe++ZONT0wULeGR47eFI3CwofpNDtxNCB6TU4HcQoDEDgJxmGrJ6uZLCAtJQK/KmdAdFLrXiPsYiGjo7Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1TSmmKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FEEC4CEEB;
	Thu, 26 Jun 2025 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750962022;
	bh=ojxtrCSlAxBab3aqEdaoBxwo2pv44yPWbPAbxh2oCzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j1TSmmKawOFir+mO9EHc15u/sZGKkncgNtQ8/BsyXg7aASmkemxG/soApRH+/F3TB
	 Vi+b2MKNLlOKBVjirUwCIIQ7QvP3+RGS0nd9qVZjCCIa1+/rM5fR9C1u1aKG5MSEsC
	 5m3TEWvQaabaq6PPJ78q9V/IACAkhY7lNIwnk9j6kqZw4ODJEdk0AjP6PaR/3gCGwI
	 8i7iopo5xBVjKxj22Xp/6BQvEqDcO9qbO0F7WXE+wgPpPSVklI5m72zvnZbL/YNCdG
	 zqyEeHCqx+cyKweWXFt8eXYpXEOVGquszGNn9s7TqcFSD4IJDdOi/xjGS8/hYcy/1v
	 S3daq7Em6oQfA==
Date: Thu, 26 Jun 2025 19:20:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: ti-adc128s052: replace literal by unit
 expression
Message-ID: <20250626192014.4dd4a270@jic23-huawei>
In-Reply-To: <c97e840e-fe8e-40e9-baef-0a18103848fd@gmail.com>
References: <20250625170218.545654-1-l.rubusch@gmail.com>
	<20250625170218.545654-3-l.rubusch@gmail.com>
	<c97e840e-fe8e-40e9-baef-0a18103848fd@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 08:07:19 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 25/06/2025 20:02, Lothar Rubusch wrote:
> > Replace the literal number 1000 by MILLI from linux/units.h
> > 
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >   drivers/iio/adc/ti-adc128s052.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> > index cf271c39e663..67bc7fbd52bc 100644
> > --- a/drivers/iio/adc/ti-adc128s052.c
> > +++ b/drivers/iio/adc/ti-adc128s052.c
> > @@ -18,6 +18,7 @@
> >   #include <linux/property.h>
> >   #include <linux/regulator/consumer.h>
> >   #include <linux/spi/spi.h>
> > +#include <linux/units.h>
> >   
> >   struct adc128_configuration {
> >   	const struct iio_chan_spec	*channels;
> > @@ -189,7 +190,7 @@ static int adc128_probe(struct spi_device *spi)
> >   				     "failed to read '%s' voltage",
> >   				     config->refname);
> >   
> > -	adc->vref_mv = ret / 1000;
> > +	adc->vref_mv = ret / MILLI;  
> 
> This makes no sense to me. What does it mean we divide the micro volts 
> by 'milli'? It is clear when we divide micro volts by 1000 that we get 
> milli volts. Also, the mv suffix in variable makes units clear already, 
> division by MILLI just obfuscates things. I'd keep it as 1000.
> 

ret / (MICRO / MILLI) would be more descriptive as indicates
we are converting form microvolts to milivolts.
 
> I would just drop this unless Jonathan disagrees.
> 
> Yours,
> 	-- Matti


