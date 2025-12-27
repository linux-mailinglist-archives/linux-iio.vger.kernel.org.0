Return-Path: <linux-iio+bounces-27377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E5CCDFFCC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BF04300E46F
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D31324B0C;
	Sat, 27 Dec 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRsV8Gfh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634612B2DA;
	Sat, 27 Dec 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766854585; cv=none; b=QbRSPawb9UMBHJH4XEOKha101K12fGinFUNQCZ2I/dloDQgr5xfia3TxuTH0LW02cCsG051aCkskISs7RZ/DafRM5ky62hkI1hRdNIhuQzWNyvgtUtTw1pEDvaRSOqdPUPYQIbHAG7nLW9LoMp8j+S6XAt6+mEQk0ONVOl6Wn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766854585; c=relaxed/simple;
	bh=1VgjqUJS75sYiz8u7aAl7Ta8yZZWWXRxXGNm1eC3oo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYyUGEnRib/bqNLgf/FgxkIWOMvzrc+sYIcbKJ2kJr53hThncrVhv/zL5URb4njr8NpychBDV9Ne3hBtD2UXSjS5FUnvtNe2ud0mgD5M3Xu3oJyOJ95TG+bxQYIUYl4aijBv4PZa0XqWT73af0cSjxRPltHwmZiJ76blJoEDV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRsV8Gfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344EEC4CEF1;
	Sat, 27 Dec 2025 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766854584;
	bh=1VgjqUJS75sYiz8u7aAl7Ta8yZZWWXRxXGNm1eC3oo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aRsV8GfhlObM3d2eO9fLfAsuWkST83IrszLfjuVZOcp6R8OwZSRaxT1ymdV+xNqLi
	 z9Fkp+F2wzav7tFBl5W+2GL5WztHoYbVxsuA1bxC+xLEv7zCIXnJLpBrKbgyuVF+Zb
	 qyivfFTE4Ayp3vJ2fny31fDNvcjix4VGLFrRYX6dMslYUfN2Lt1E69fI65vW+Na+95
	 meM82NrAFgHuaMzd+YGUcc3j1P2pnsh3sLr+UdB6FmrxmdPjDMKbA7S9lb/7k2qFSt
	 suy6GuW92BmDkFAe//Col/kCsF2BN08ufTg2SWXViWQ2IBcR3/WoPmbtdJFjuj/sR0
	 8k0ZcGvHBro3g==
Date: Sat, 27 Dec 2025 16:56:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 2/6] iio: frequency: adf41513: driver implementation
Message-ID: <20251227165613.264d6e11@jic23-huawei>
In-Reply-To: <3agb73fmwhcoho4uowhwh3tchux5wb5amgzrmr2fj66uiw4grg@oddcbaeqmneu>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
	<20251219-adf41513-iio-driver-v2-2-be29a83d5793@analog.com>
	<20251221174902.7ebb9e74@jic23-huawei>
	<3agb73fmwhcoho4uowhwh3tchux5wb5amgzrmr2fj66uiw4grg@oddcbaeqmneu>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


...

> > > +	cfg->ref_div2 = FIELD_GET(ADF41513_REG5_RDIV2_MSK,
> > > +				  st->regs_hw[ADF41513_REG5]);
> > > +	cfg->prescaler = FIELD_GET(ADF41513_REG5_PRESCALER_MSK,
> > > +				   st->regs_hw[ADF41513_REG5]);  
> > For cases like this I think keeping to 80 chars is hurting readability
> > and so it is fine to go a little higher. 
> > 	cfg->int_value = FIELD_GET(ADF41513_REG0_INT_MSK, st->regs_hw[ADF41513_REG0]);
> > 	cfg->frac1 = FIELD_GET(ADF41513_REG1_FRAC1_MSK, st->regs_hw[ADF41513_REG1]);
> > 	cfg->frac2 = FIELD_GET(ADF41513_REG3_FRAC2_MSK, st->regs_hw[ADF41513_REG3]);
> > 	cfg->mod2 = FIELD_GET(ADF41513_REG4_MOD2_MSK, st->regs_hw[ADF41513_REG4]);
> > 	cfg->r_counter = FIELD_GET(ADF41513_REG5_R_CNT_MSK, st->regs_hw[ADF41513_REG5]);
> > 	cfg->ref_doubler = FIELD_GET(ADF41513_REG5_REF_DOUBLER_MSK, st->regs_hw[ADF41513_REG5]);
> > 	cfg->ref_div2 = FIELD_GET(ADF41513_REG5_RDIV2_MSK, st->regs_hw[ADF41513_REG5]);
> > 	cfg->prescaler = FIELD_GET(ADF41513_REG5_PRESCALER_MSK,st->regs_hw[ADF41513_REG5]);
> > Is fine here. I'd also be fine with wrapping the ref_doubler line as it's rather
> > longer than the others.  
> 
> ack

Small kernel development process thing.  For efficiency general rule is
don't bother replying at all to suggestions you accept. It just adds noise.
Much better to just crop that chunk of the reply out so we can
rapidly see where more discussion is needed.

>  
> > > +
> > > +	/* calculate pfd frequency */

...

> > > +static int adf41513_parse_fw(struct adf41513_state *st)
> > > +{
> > > +	struct device *dev = &st->spi->dev;
> > > +	int ret;
> > > +	u32 tmp;
> > > +	u32 cp_resistance;
> > > +	u32 cp_current;  
> > Where you have set of variables of same type and grouping doesn't hurt
> > readability, declare them all on one line.
> > 
> > 	u32 tmp, cp_resistance, cp_current;  
> 
> ack
> 
> > I'll not repeat comments I made on the dt-binding in here but I'd expect
> > this code to change somewhat in response to those.  
> 
> understood. for now, will use -mhz for the power-up frequency, but I will
> see how the discussion follows.

That one is indeed non obvious and so (assuming I didn't miss anything) this
is the one block where there was a non trivial comment in your reply so
ideally would have been only bit there.

I get grumpy about this every now and then and this time you get to be
the target!

Jonathan

