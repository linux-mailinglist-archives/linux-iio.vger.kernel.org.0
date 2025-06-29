Return-Path: <linux-iio+bounces-21106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF22AECEA7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BE61722A3
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2352327A3;
	Sun, 29 Jun 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZv9RRP5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F482185AA;
	Sun, 29 Jun 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751214424; cv=none; b=H+QDZoMfi/RESJu/KUnye3lrrpmHNKBYMUPgPJXra5lXfB1RJTsv9HOTd++Z3jhpPL/agLrNTBx9cjaehUkmbtIYJrQ8eFQPXKEwGjcVckvLwP7ckHmc2d9U8B5oewFBmX/qKUkpIFBxDT8Q6Ulos+r9XB3w3yzC1L/r9YC1mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751214424; c=relaxed/simple;
	bh=pNONqr+ynlSLv5Sw/Zqqmn1DfkLBbN7gWTRlWjnaQqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTSHErFGYzP66yrw39sCrVDEaz93q6/P/3CYkONXCANOM+u52f8VzaGM5Hi4InKaDnE15j48KrkpEYsBzCB7P7D6h+gJklcMyQdyI/qLyUwEwqvBuoruR1NxSBR/Rq52H777zUrXfVjTN3yGXbQ+hAEVlHM4EZGqHSImCcu7a4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZv9RRP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5431CC4CEEB;
	Sun, 29 Jun 2025 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751214424;
	bh=pNONqr+ynlSLv5Sw/Zqqmn1DfkLBbN7gWTRlWjnaQqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZv9RRP5w4oGi+ymZKzZVOLrti6mg0AbAg9KBTe+hk0o1BAPeHrNZHVeQYj49otAN
	 jvoMqvB5eqQT0Xk0pzRTyin2LFaTZWITGv0hceGv0dYhF038jQQAZbDhjYoOgma9/j
	 bU1yNdpyl3H0eDhgR0ONwr4+gYUwETxNXpUNZt3XpuBNtTgrkTlriEJT6ytzQnqYbD
	 cxQNyHa1ePy3KVfXCUM+8KX/HmZeX974XyMX0umSXqiu/tNENBAtpb+A73MGPWHd9T
	 4B8D046Cpt9YmKHaduT/uoGhOJ1omDfueZJgXBpezb9tC9oDQlz8YWQlhAc9XwQMgZ
	 JqUiFkgasuXEQ==
Date: Sun, 29 Jun 2025 17:26:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>, Nishanth Menon
 <nm@ti.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: adc: ti-adc128s052: Use shift and realbits
Message-ID: <20250629172655.209e2bd2@jic23-huawei>
In-Reply-To: <aGBKMcZGYOcXmKdB@dev-linux>
References: <20250614091504.575685-1-sbellary@baylibre.com>
	<20250614091504.575685-3-sbellary@baylibre.com>
	<20250614142743.23ee2203@jic23-huawei>
	<aGBKMcZGYOcXmKdB@dev-linux>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 13:01:53 -0700

> > > +		.type = IIO_VOLTAGE,					\
> > > +		.indexed = 1,						\
> > > +		.channel = (num),					\
> > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > > +		.scan_index = (num),					\
> > > +		.scan_type = {						\
> > > +			.sign = 'u',					\
> > > +			.realbits = (real_bits),			\
> > > +			.storagebits = 16,				\
> > > +			.shift = (12 - real_bits),			\
> > > +		},							\
> > >  	}
> > >  
> > > +#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12)  
> > 
> > I wonder if it would be clearer to just have the 12 explicit in each entry
> > and skip this two levels of macro thing?
> >  
> Do you mean to pass realbits to
> ADC128_VOLTAGE_CHANNEL/_ADC128_VOLTAGE_CHANNEL as e.g.,
> 
> static const struct iio_chan_spec adc122s021_channels[] = {
>         ADC128_VOLTAGE_CHANNEL(0, 12),
>         ADC128_VOLTAGE_CHANNEL(1, 12),
> };
> 
> I think we added 2nd level macros as ADC082_VOLTAGE_CHANNEL,
> ADC102_VOLTAGE_CHANNEL, etc., to have a visual distinction for a different
> part nos.

I think as we can have lots of parts with each resolution that will
end up confusing.

> But I am ok if you prefer ADC128_VOLTAGE_CHANNEL with a second parameter
> as real_bits.

I think that's going to be easier to follow.

Jonathan


