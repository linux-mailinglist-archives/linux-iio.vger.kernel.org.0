Return-Path: <linux-iio+bounces-24929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F54BCE6B0
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 21:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DD4A3558B3
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969323019CD;
	Fri, 10 Oct 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuYvCcSf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B741D30171B
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125511; cv=none; b=u12LN1L44H71C+7+tbleHl3mHwb/3GgKq6ORTeOF2U1rVMCpdi6oBZK0bZrtFwyNQyedsUDP8FCDQBiuBaK/lq5QzCSBk4eyt1hFtsM3Rf2cIShmjepWFUeFx8X2EeU0qDJ/wR6/xzKbBfnskBdfqzZ6b/BcTkaoAs31fNjsUBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125511; c=relaxed/simple;
	bh=j7eRCO8WXdU/zad3n+NWlTSndVmgNqtq1p4vqwLQNX8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SgzWCz8DrKvAMsqX3HxJUdb2eIk9HlUs/9/Xx+edliKfbYeCiSH/7EIZBSgYr7wk7w9cKOl8bVCEh+1ULID0+7VJtY/PlZrPYoe+FN8Pc3QzBEzyQiVLcjm3b7J7TMFgCsaYq71bfIXFU3EMAqkzVdQ/ZkNp35axy2JTQwS/228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuYvCcSf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e504975dbso14533275e9.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 12:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760125506; x=1760730306; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQu0rr6UjxQklgSlwaowAdD1/Ytw7JaYBhmk2aJvOXk=;
        b=RuYvCcSfJyIRhZ2o6Z9aV4YLxxndlUqEqvOjjxTQErygeiptPow5tlZRLSd0WzpIrA
         xpezIgxuexsk0wMXBurwDM+KPzJPrWaY+05h3DITGERd2QjYQ/w57k7Mg/8aPo2hS8X6
         g0cfNLDMzAv6m3UxQF1Vr48Yjt0qiRJ8lLr/p3PsFkVMLpgLAIiPjFicXz7v2zwkkw2O
         nIEntAakKjQNS/Wg9RmrrTd7UYMfNvXxwn82LRW/REyFCfW6oSz034jlLI/nDqyFBNOF
         Q5+0SxeMQCNW+9APIdfWhbFlFLzoT/+BsLHDxvdkF4GGOh2msKYl/9f/HPJWQLARHhk7
         3H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125506; x=1760730306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQu0rr6UjxQklgSlwaowAdD1/Ytw7JaYBhmk2aJvOXk=;
        b=ljIOYcCpFK7cs5Rm6bKwUSo2xtSmb8m7I3HY1zOiCDeQbc6MarME6xilAxoN3n2Fb3
         xX2nHC7b28jH1fR3uud4HPIsldhziAdhLLQI3dTsTMKw6Ghe3z8v9Rtm9t4PnIqSlmNA
         SDDr4ufgcnE5PXyZpfQSmPn66GWmBjWcl4E1dQSQTlJXwSGjwdd89mGBUwVIfq1v8cK1
         E26q/F1CGCNffbTN+/k4aWCArZRFWO3rxX1HyU5wHZTqPHne89KlG2QVq+cOhmNSXKgu
         mi/IKKs8zYgG/uKjyrTQI56OHt5rIhPFip1Iem/c5TxlGdoohuTekBOKRHHGSrqRyvq3
         HPGA==
X-Forwarded-Encrypted: i=1; AJvYcCWsKqIzP7MgdFvYQFkkG4eWhMufvPNH6Z0Jmg8QShRWzfbUKpqPC7hGsnNNQWS7vodeIjHP/jbtgB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1dJ/XCXZWyJctzG34RMCvZJF1g1xjW26uMwcMU5FXv1YboTd
	ejiTnIhKE3lafbAkrLWINyAEktxG8F9mcesofdGscfS2jrHm+w3tXF/I
X-Gm-Gg: ASbGnctaCb62WRSc04nJlUkR4CUZCUKEAMvGy37V5r0bbstvXPP3wWKOBTa9Gz3csQI
	vqmRoj7dxaL99Zw6XD3LRzLscKkQfv/29emQv6e5GuWHkPxhZN3dg6a3IY/bkLespwVDldR9twZ
	fpji7vym7ilTt3HEynqqMckuxtABF+zeK50uxo0MukSV4TyXaMFA+KwWxIfxbJibOPyFdp5X8ym
	MwahPxsTT1+2CHRo9iif0hVXd+Ad6uwsvi7akB9pKH7ooL0ILaC0MbkbMaOtCa8AYaLvu4+Dk77
	ch10VMwG72Pr6v95SDpeHpXNlaDQLAmRviPy9UCzmKH3evGtw8R1Hf3l5H2TZnJ6FVLVqTuMUSJ
	8f+p1V0alsQhQvv537eGxm9UX4nfzhj0m6tM3iWknXfCfmuyAdmU2SkVF8ubBwLWGiPcWKTI3oL
	d/PPf+KTO67dCFfuDLrELz/SQ0
X-Google-Smtp-Source: AGHT+IHHHrb9if1pSYItixsAXjV8Fo41Ye9u4kM+Ypfmjxxvzg1eG3Pwur7ZSPXeiqGWANKsBZ20ow==
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46fa9a8638dmr92447005e9.2.1760125505754;
        Fri, 10 Oct 2025 12:45:05 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb32a84edsm39166195e9.4.2025.10.10.12.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 12:45:05 -0700 (PDT)
Message-ID: <755d4fcea043d62ba6ac44c483f70c0a08b5e41e.camel@gmail.com>
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt	
 <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
	marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>, Axel
 Haslam	 <ahaslam@baylibre.com>
Date: Fri, 10 Oct 2025 19:46:01 +0100
In-Reply-To: <576b582e-7388-4ee4-9a4c-4f7e04fc3fda@baylibre.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
	 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
	 <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
	 <576b582e-7388-4ee4-9a4c-4f7e04fc3fda@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 11:18 -0500, David Lechner wrote:
> On 10/10/25 6:19 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-10-08 at 10:51 -0300, Marcelo Schmitt wrote:
> > > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > > samples per second (MSPS). Not all SPI controllers are able to achiev=
e such
> > > high throughputs and even when the controller is fast enough to run
> > > transfers at the required speed, it may be costly to the CPU to handl=
e
> > > transfer data at such high sample rates. Add SPI offload support for =
AD4030
> > > and similar ADCs to enable data capture at maximum sample rates.
> > >=20
> > > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v3 -> v4
> > > - Applied code adjustments suggested to SPI offload patch.
> > > - Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).
> > >=20
> > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 3 +
> > > =C2=A0drivers/iio/adc/ad4030.c | 504 ++++++++++++++++++++++++++++++++=
+++----
> > > =C2=A02 files changed, 465 insertions(+), 42 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 58a14e6833f6..1ed091b6731a 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -62,7 +62,10 @@ config AD4030
> > > =C2=A0	depends on GPIOLIB
> > > =C2=A0	select REGMAP
> > > =C2=A0	select IIO_BUFFER
> > > +	select IIO_BUFFER_DMA
> > > +	select IIO_BUFFER_DMAENGINE
> > > =C2=A0	select IIO_TRIGGERED_BUFFER
> > > +	select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> >=20
> > Two things as I mentioned in [1]:
> >=20
> > 1) Wouldn't 'imply SPI_OFFLOAD_TRIGGER_PWM' accomplish the same?
> > 2) Don't we also need stubs for spi/offload/consumer.h?
>=20
> It doesn't hurt to enable SPI offload support even if no controller
> supports it, so I would prefer that drivers that use it just select
> SPI_OFFLOAD.

It does not hurt for sure. I just don't love enabling code when the feature=
 is
optional. For things like GPIO it not does not matter much because it's mos=
t likely
always enabled anyways.

But, fair enough! I don't feel strong about this at all and if we wanted to=
 be picky
then we would also have to take into account that IIO_BUFFER_DMA and
IIO_BUFFER_DMAENGINE also depend on SPI_OFFLOAD being present and we just s=
elect
those.

- Nuno S=C3=A1

>=20
> >=20
> > [1]:
> > https://lore.kernel.org/linux-pwm/2e82eaf275b5c8df768c8b842167c3562991e=
50c.camel@gmail.com/T/#t
> > - Nuno S=C3=A1
> > =C2=A0

