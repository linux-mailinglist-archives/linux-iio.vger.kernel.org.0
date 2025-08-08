Return-Path: <linux-iio+bounces-22444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53DB1E54A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 11:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E74D189383C
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3884268C73;
	Fri,  8 Aug 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONRsrKkG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D8825CC4D;
	Fri,  8 Aug 2025 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643885; cv=none; b=FRCQk4o2LwBQNRze/CXithBr+KkI6dITulpaHV+eJr9BSkZtsYoPcu/FBU6hPI2cGhnuEDq31icW8eq99KlvzFbtd95nSBgN68rr2oeBKaLvakSofl2mNwCBnjOZfO3k/EZRfpD7o9CJidWOp//3qLJmz+WtD62qhWa6j99qe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643885; c=relaxed/simple;
	bh=QoqrP+WVihWRD1+qh/e/eWTY/l5LNxRxXsBcP+5K5y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDUjB3rOvhatS/wG3/r+fr/TcTmDaaW+U1J17PKElr0tiwThebelxDm6v7+/gFPEnDC98jJF0htDRydCOd45i4PJo+nYTwlHVSIlvbFY9iF80b3FyVpwyfbu/optnsEe5cFDk590CHvDYFhwtYyklP09M9zjZd3QGBvSdKM3RSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONRsrKkG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so4938603a12.1;
        Fri, 08 Aug 2025 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643882; x=1755248682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7W0Vd49dpngshz+Y+Kc7qgpDtsHofkExFIoBFZHJwcQ=;
        b=ONRsrKkG3433KAHmUxwuWotoihD3DkyrGZlKk0IQLyuJoRLQu1JXMLEho3ceSSIwbA
         2j0L2IsidO2sKOKwGUZap5suzUH++qj4JIHj1etmINEtO6F/fN8zJ3dLLRn4BjXz9zWk
         FpLSWuQCgrm3GL3wdfOXbrkQliQZ+FMtWBABSnRSRnpoPTUslOg3vCZyPeH4AbUL3K9M
         9KTxMPqrOaQfTX1ibdf9D6vKyMhcDcnbrkp5PgUOCcU8TRihwVNUt5M0iHjuNGE8NLnq
         Hf/rUYzSGz7uu2/AjiQbrrmjWa4vIkdOj0D1AFAJJdPFa+lVarg4Wt/d4DiR+B8ySePU
         Uo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643882; x=1755248682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W0Vd49dpngshz+Y+Kc7qgpDtsHofkExFIoBFZHJwcQ=;
        b=mZO8AvhkimTPUPIpFnoOGDZeWXG4RNLZ55zzvJGY4aPi90Sxdk89th9rpYscG7nOYa
         BjkGvDZJWMOITpTUsTqs94v7mcXR/Bma85BbtY4iDhNei93gy+ndq0CtDOL5nMhde/0h
         AmatSURB6FeINbXWpRhRNOeqoft//MMbcD3l4wpw7D/lCLAumEIZZypDRX3qw2ITQolj
         yvzKnVT3q8O5wmXyMFcvGCgQ/JH+t1Tt8/S9NpM8j/u/PJBZ0ky3LMG2rGjHLlHEw1Cg
         CRadJHK8NTBFQ7JiGybpJoLDpQYMCxq5PFGNqACUVUv8AAUJI2YWVA8TiNvdNUNdaeO3
         FZEw==
X-Forwarded-Encrypted: i=1; AJvYcCU9nD0V3TaapHgB6Z1u6U+I4oby8dHUOjDmZVNDqgMaNETPsLdVyJIvZMBjBrPbQpsPp4XS6alqs073wzOH@vger.kernel.org, AJvYcCV+Coscov7VX7rKWYHs0rmtsYBDPlp2NmrhWMKutHB/HLrdxsHXSVBx3R3KqYB4MtRyAo74O3GTCK/l@vger.kernel.org, AJvYcCXFdWaUSkFOjHXH8m6OKOS17LFLjyeDtN/e0IErx4WgdYmjplXIZZ56QgxjG4Y2ueKH6EBkPkCoCpmK@vger.kernel.org
X-Gm-Message-State: AOJu0YwYiUFQmB3seVluncgrxJ2bunP/aoLOKjx+zimsB6PUIyrRqB0d
	frKGbW+/zJG/WPpfeUNErTmVqw1gqAKQ7+pfxKNUhyTmJJxdTaEKCp19
X-Gm-Gg: ASbGncvvhZBruTUGsZcxS4UhW3K48gRc780tmXYmFaoXjYWD3w4Qt0J9LvNf6SY1LJA
	jhglhSIGwckQr+N6Bw4DoTz04SKeGWRT9LHUrvk+rl9ZC05dSmdDiP0+BUr96MrTZqfR6BhXEFr
	yRk4sOf/B8Y3H5KYk5O/m8wLoscLFSRZoiaVk/x9qo+fjM6CeUyPB/uzI1sLWwPLarWIVgwziUA
	liDcjXCKXxbRbkRgb4epevXL/9ensRdVfiSElxEmHeI2HuBpk8FGUHPf+peKqEYqd5aG5L1JMz0
	fbs/yPmTkLApSgDj+BujGzpayYbW1GgD4r0JqWiOykS0jvw77DSuWLVYqPuhJcnG0DRC40ZlICu
	+SVOHiMlAOA==
X-Google-Smtp-Source: AGHT+IH4iJdQwIiMewCgGZoPiBmVm/K2o0rzpFKXVJtAlkCNjnWxNgVQx3kMPrg7tw+GqXDxWZpR1A==
X-Received: by 2002:a17:907:3ccc:b0:af3:9a3e:7ea7 with SMTP id a640c23a62f3a-af9a3e7bf88mr587364566b.22.1754643881542;
        Fri, 08 Aug 2025 02:04:41 -0700 (PDT)
Received: from nsa ([185.128.9.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6178b074a38sm5198587a12.32.2025.08.08.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:04:41 -0700 (PDT)
Date: Fri, 8 Aug 2025 10:04:58 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] iio: adc: ad7476: Conditionally call convstart
Message-ID: <rgpt3lsbnr7hh4rfg4ye4vxlvecx5sikvb6vahwemirxcefc4r@kq4dtxy2redt>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <bb96107301b249d4be912fa4384ed4de7791410b.1754559149.git.mazziesaccount@gmail.com>
 <jqq73v23juc3wj3ykq5df3mevjatnq3zb2aq4w524xnl4xgban@qemnvtvs2twn>
 <f8c8cbd3-ce40-4b49-b8e4-cbb84e30dfe1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8c8cbd3-ce40-4b49-b8e4-cbb84e30dfe1@gmail.com>

On Fri, Aug 08, 2025 at 08:43:18AM +0300, Matti Vaittinen wrote:
> On 07/08/2025 15:47, Nuno Sá wrote:
> > On Thu, Aug 07, 2025 at 12:35:03PM +0300, Matti Vaittinen wrote:
> > > The ad7476 supports two IC variants which may have a 'convstart' -GPIO
> > > for starting the conversion. Currently the driver calls a function which
> > > tries to access the GPIO for all of the IC variants, whether they
> > > support 'convstart' or not. This is not an error because this function
> > > returns early if GPIO information is not populated.
> > > 
> > > We can do a tad better by calling this function only for the ICs which
> > > have the 'convstart' by providing a function pointer to the convstart
> > > function from the chip_info structure, and calling this function only
> > > for the ICs which have the function pointer set.
> > > 
> > > This does also allow to support ICs which require different convstart
> > > handling than the currently supported ICs.
> > > 
> > > Call convstart function only on the ICs which can support it and allow
> > > IC-specific convstart functions for the ICs which require different
> > > handling.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > > Revision history:
> > >   v1 => v2:
> > >   - Adapt to the change which removed the chip_info pointer from the
> > >    driver's state structure.
> > > 
> > > The follow-up patch adding support for the ROHM BD79105 will bring
> > > different 'convstart' functions in use. The IC specific pointer will
> > > also prepare the way for this.
> > > ---
> > >   drivers/iio/adc/ad7476.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > index a30eb016c11c..8914861802be 100644
> > > --- a/drivers/iio/adc/ad7476.c
> > > +++ b/drivers/iio/adc/ad7476.c
> > > @@ -30,6 +30,7 @@ struct ad7476_chip_info {
> > >   	unsigned int			int_vref_mv;
> > >   	struct iio_chan_spec		channel[2];
> > >   	void (*reset)(struct ad7476_state *);
> > > +	void (*conversion_pre_op)(struct ad7476_state *st);
> > >   	bool				has_vref;
> > >   	bool				has_vdrive;
> > >   };
> > > @@ -37,6 +38,7 @@ struct ad7476_chip_info {
> > >   struct ad7476_state {
> > >   	struct spi_device		*spi;
> > >   	struct gpio_desc		*convst_gpio;
> > > +	void (*conversion_pre_op)(struct ad7476_state *st);
> > 
> > Ok, I was going to reply to patch patch 5 saying I was not sure about
> > the change. And now this makes it clear. My point would be that it's
> > fairly easiy to end up needing chip info after probe. The above function
> > pointer only has to exist because of patch 5. So I would better drop
> > patch 5 and...
> 
> Andy had the same comment. I personally like to only carry around stuff that
> is used after probe in the driver's private data. In my eyes it makes things
> clearer (and cleaner) as you know what is used. But yes, (also) here it
> leads to some duplication.

And also remember that like this you're pretending that const stuff needs to
be set at runtime which is really not the case.

- Nuno Sá

> 
> Well, I'll drop the patch 5.
> 
> Thanks!
> 
> Yours,
> 	-- Matti

