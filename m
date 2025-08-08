Return-Path: <linux-iio+bounces-22436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CEFB1E515
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EAB16405F
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A6B26AAB2;
	Fri,  8 Aug 2025 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2sJ0XvF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5B266565;
	Fri,  8 Aug 2025 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754643240; cv=none; b=Mn4TlNbECU76ssH85pQ6c9mnhxxDFMf81t835BO7hc2HUxlUrhPvlBxB6WU7KCi7YCeuZ9H0L03IkGMvJ8ZvOst2vH1L4FhIuW0cpvARuHbAmeoppriFM/LjHdA7eqNV3PiddWkf/L1p8bn0/99r6SSW0m1mxUlvJU7ClTFMZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754643240; c=relaxed/simple;
	bh=+27YLCTX9hs95WcJyDn+H3oGT/rtvSb/bx40WCzCwVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRQ2THp5uBq+9P1T8JTRD679IbqpCE+MBff9pocuPu9R0+d8FvmQxUUFqvlHYMy2IXFhUGhSnSuPso2oxJ4rZux76Wj/Oe3VC8NQnZQUysNidDRWfU+QMuU5lOXDhXN9PKJjJbxBcarOOd8nL7I2LkfkAD5hoKFywEiMI4TYLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2sJ0XvF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af9180a11bcso391444566b.0;
        Fri, 08 Aug 2025 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754643236; x=1755248036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r2C7ASj9t4ybFimtFtuG34MO5U16LP5ZLfqxX97dOSA=;
        b=I2sJ0XvFr6s6l/gk7aLl8VkZQycCPpDsY6zEcfPIOnjggfqv9ksY7cx8Wzf34vY3Td
         Uo3OrQKopoNDrfOiyybe6PMMIW6toQUO0Q7M6Movw0eKDYYhQBW95MhHHjarAl6dqUPI
         UdGqB2ap2JpIyAHvk/qlRDjg2HS6ba3TzoMa5kvbjn3sEnD2ptm90Uv0Au+dWIkf8scG
         nTCpzq1OdHszkQQ+NkFxweF/nLF5f/lX3Pa7ltnvB/vtvFtOjxpIvgH3jdSW32VGUj/f
         ZY2fJeQISLANBFDNIm+M3UhwEc0FVwr+FmsZZlEiXvsje1TcIAW6mZaIcFsb59xFmxxU
         l4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754643236; x=1755248036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2C7ASj9t4ybFimtFtuG34MO5U16LP5ZLfqxX97dOSA=;
        b=hs1GOQhb19x6mZngb+KtMklAAiY8qSz2sMnk15/KGzcgdX+5rIjGrDC2twwvIjEokE
         p+siaSxZX5a509AzSywcqI2ELHcp4sdK2/WUY2fGjD7WjEL1bjKH+PFV5AB5LXSjUZ6E
         SkEcbOrLLn/Zk9L2kSQDDMtPAu5jVkgXOkrXLT3rOR8HFuOsdfcg5zW6ro9ki8/+igVS
         OnHidaItJnl0++qkkPmdUf+/rTM0JB6Bx8avaVNvjhRp+f89uDl/Oe1JcDXfyZMQhalU
         OB8vBzVKdbT/HajV+zY4D7sXPg5sTxvd1l7LA2n3wG8QDOAsvaxZBPKmhT1Z+t7FFbd6
         h0fw==
X-Forwarded-Encrypted: i=1; AJvYcCW4laMiTCyQrEB54kPSOHPtTL0eacy8+7i4kzZDQ6oXDg4zIvo95N2qBRn7zk7bkxZ5iuhj+FKqeN9g+quS@vger.kernel.org, AJvYcCX7DmeXon1Ujmk2NcOpcIo4FNX93zZOWvt5373R4tvhbw/vtwMwHLTXgoqxmqOWt6jLI+0p/fuX96bD@vger.kernel.org, AJvYcCXpFg3AKeZ7A1zy8+cRrHCDa2gtVpR4HWPRntW8IE5fn1OKP5w3G9KgLpNJYOLovJU5JRsrNoWlUAlp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7+7OFC+s1bT/L77GUXwMzk/R88ThknZ7nGI/W43ezTIpO9Hp
	nLPquWx0uaHkhze5G0/pA43Y5FGFw27gazJtWM7XzNgNo+TOs+qAa106
X-Gm-Gg: ASbGnctawtNBvseSVh4llRk7VO1J19LoZIeHSb+vPN0t+jW1rxXR+cz3/zujK8CZF3B
	wfNVzho5+f3uZEwOPfhjjBII4YEXReickEaeHBuXkxzTt9i5HHEs2JGe0kpoRZQPQ8On0xq50Bd
	gaD+4+GcM6o4RcpIl9+C1u1gDb78EatsqmocZrbTq6jCrIm3ud3uuFVtZJeUPhegeqCvwofCbUl
	FrJH/s+KxLyByNsrNmXHRP98yfX0GkgKEKEdd+JRkxrFx0WiifKNHu8bCWszEg0LPp1gV/jNVkq
	5l5zAg1qhH3/QQ2Q6S0SBA9wWU2kE3Xxz+jRhV2yhYZIVd6oZgCjGaRLuMSDl5kg4ismPS0RmRX
	fPuXw3CN4Uw==
X-Google-Smtp-Source: AGHT+IFDWoUsNJast/OF4ozkKL1WhnAmv1549wIl4YPt6LkjDcvKiHm6MT7NUYdutRryK0+xxqArCQ==
X-Received: by 2002:a17:907:9344:b0:af9:479b:8c80 with SMTP id a640c23a62f3a-af9a3c5928fmr588777466b.4.1754643235393;
        Fri, 08 Aug 2025 01:53:55 -0700 (PDT)
Received: from nsa ([185.128.9.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763e4sm1464649766b.1.2025.08.08.01.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 01:53:55 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:54:11 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] iio: adc: ad7476: Support ROHM BD79105
Message-ID: <5w6ryx7dvu5fuxfyz3hwqbncwwh573a6nou3w3ebspbm4e4p7k@ne637fm22n5i>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <da7e6b31a0f25106d7e2f56fb089c8fe71224654.1754559149.git.mazziesaccount@gmail.com>
 <stmpyitqnjst2l26xdlkfqdedczpnxhoydges7xumtl5e46pof@cyidmsvdtdnj>
 <2a678156-8e0b-4fa9-a940-f368cfac8f7a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a678156-8e0b-4fa9-a940-f368cfac8f7a@gmail.com>

On Fri, Aug 08, 2025 at 09:11:03AM +0300, Matti Vaittinen wrote:
> On 07/08/2025 16:01, Nuno Sá wrote:
> > On Thu, Aug 07, 2025 at 12:35:25PM +0300, Matti Vaittinen wrote:
> > > The ROHM BD79105 is a simple 16-bit ADC accessible via SPI*.
> > > 
> > > The BD79105 has a CONVSTART pin, which must be set high to start the ADC
> > > conversion. Unlike with the ad7091 and ad7091r which also have a
> > > CONVSTART pin, the BD79105 requires that the pin must remain high also
> > > for the duration of the SPI access.
> > > 
> > > (*) Couple of words about the SPI. The BD79105 has pins named as
> > > CONVSTART, SCLK, DIN and DOUT. For the curious reader, DIN is not SPI
> > > ISO.
> > > 
> > > DIN is a signal which can be used as a chip-select. When DIN is pulled
> > > low, the ADC will output the completed measurement via DOUT as SCLK is
> > > clocked. According to the data-sheet, the DIN can also be used for
> > > daisy-chaining multiple ADCs. Furthermore, DOUT can be used also for a
> > > 'data-ready' -IRQ. These modes aren't supported by this driver.
> > > 
> > > Support reading ADC scale and data from the BD79105 using SPI, when DIN
> > > is used as a chip-select.
> > > 
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > ---
> > > Revision history:
> > >   v1 => v2:
> > >   - Fix the conversion delay for the BD79105
> > >   - Drop unnecessary GPIO check from the convstart disable
> > >   - Drop unintended whitespace change
> > >   - Fix spelling
> > > ---
> > 
> > IIUC, for this chip the CONV GPIO is actually mandatory no?
> 
> Yes. You're right.
> 
> > If so, we
> > should likely fail probe in case there's no GPIO. And we could also change> the dt bindings accordingly.
> 
> I did change the dt-binding (patch 8/10):
> +  # Devices with a convstart GPIO where it is not optional
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rohm,bd79105
> +    then:
> +      required:
> +        - adi,conversion-start-gpios
> +
> 
> I didn't want to complicate the probe with extra checks for the GPIO based
> on the IC-type. But I am having second thoughts - maybe it is the right
> thing to do as you say :) Thanks!
> 
> > Some more comments inline...
> > >   drivers/iio/adc/ad7476.c | 35 +++++++++++++++++++++++++++++++++++
> > >   1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> > > index 8914861802be..aa8a522633eb 100644
> > > --- a/drivers/iio/adc/ad7476.c
> > > +++ b/drivers/iio/adc/ad7476.c
> > > @@ -31,6 +31,7 @@ struct ad7476_chip_info {
> > >   	struct iio_chan_spec		channel[2];
> > >   	void (*reset)(struct ad7476_state *);
> > >   	void (*conversion_pre_op)(struct ad7476_state *st);
> > > +	void (*conversion_post_op)(struct ad7476_state *st);
> > >   	bool				has_vref;
> > >   	bool				has_vdrive;
> > >   };
> > > @@ -39,6 +40,7 @@ struct ad7476_state {
> > >   	struct spi_device		*spi;
> > >   	struct gpio_desc		*convst_gpio;
> > >   	void (*conversion_pre_op)(struct ad7476_state *st);
> > > +	void (*conversion_post_op)(struct ad7476_state *st);
> > 
> > Pointer duplication again :)
> > 
> > >   	struct spi_transfer		xfer;
> > >   	struct spi_message		msg;
> > >   	struct iio_chan_spec		channel[2];
> > > @@ -63,6 +65,21 @@ static void ad7091_convst(struct ad7476_state *st)
> > >   	udelay(1); /* Conversion time: 650 ns max */
> > >   }
> > > +static void bd79105_convst_disable(struct ad7476_state *st)
> > > +{
> > > +	gpiod_set_value(st->convst_gpio, 0);
> > > +}
> > > +
> > > +static void bd79105_convst_enable(struct ad7476_state *st)
> > > +{
> > > +	if (!st->convst_gpio)
> > > +		return;
> > 
> > I think the pattern for optional GPIOs is to just call
> > gpiod_set_value_*() and the lib handles NULL pointers. Also the above is
> > not coeherent with bd79105_convst_disable().
> 
> I definitely don't want to do *delay() if there is no reason. Haven't
> checked the code lately, but I suppose the ndelay() is a busy-wait, blocking
> _everything_ on the core it is executed.
> 
> I dropped the check from the _disable() variant since it doesn't call the
> delay().

It's a valid point but...

> 
> But now that you (and Andy) have commented on these checks...
> 
> (even though I don't really think these checks are THAT bad. It's almost as
> if there were some reviewer's "unconditionally comment this"-list where NULL
> check for the GPIO API's was written ;) These check's are quick and very
> clear, and they avoid a blocking busy-wait)
> 
> ...I see two other options. One is adding the check in probe as you suggest.

I do think this is the right approach. We should make sure no one tries
to probe this device without any gpio because it will be pretty much
useless so better to fail probe in the first place. I'm also not sure
it's that complicated. Maybe just a chip_info flag like
'convgpio_mandatory' (likelly a bad name) and act accordingly when
checking the return value.

- Nuno Sá

> This check will however be substantially more complicated code than this
> NULL check here, because it needs to be performed only for the ICs which
> _require_ the convstart. Good thing is that it will error-out early and
> clearly, whereas current solution will just lead bogus values to be read if
> convstart is not correctly populated.
> 
> Other option would be making the conversion_*_op to return an error. I would
> still keep the NULL check but the bd79105_convst_enable() could error out.
> Delay would be avoided, user would get the error notification and
> bd79105_convst_disable() wouldn't get called.
> 
> TLDR; I will see how the "check in probe" you suggested plays out. Then I
> can omit these checks here :)
> 
> > 
> > > +
> > > +	gpiod_set_value(st->convst_gpio, 1);
> > 
> > gpiod_set_value_cansleep()? I do see the driver is calling the same API
> > in other places but I do not see a reason for it... So, precursor patch?
> 
> Ah. Great catch. *kicking himself*. I should've noticed...
> 
> Thanks!
> 
> Yours,
> 	-- Matti

