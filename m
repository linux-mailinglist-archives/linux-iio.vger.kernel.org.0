Return-Path: <linux-iio+bounces-10990-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA599ACDD0
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 17:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2475DB2781A
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092E71CF5C4;
	Wed, 23 Oct 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIAPVZaB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17041C5792;
	Wed, 23 Oct 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695145; cv=none; b=OJOxNnw74qgSFD4WjvHBFaj5LkW+Mnxlhm0SGLELWPmbmqKIQeOolgJ77z981JgQ3wkiRQC3wZ94aHSvJO7D87Sj0HP5CghQtCniwGWvNgEENvDr7ooHEH7vjJlLKoXXO/aTjdyHXYMczYSFwqLIsufIVHVtetpfGM1T+pR7ya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695145; c=relaxed/simple;
	bh=LUa/WnRwLe0ezlLUw6bOjDBGNmC3QbLtYUV/mVRUxTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KoSAlpVcwjVJFfDhlZP7QjXZQ/K/6mNjZgYFtjCgvOKZF5jesEYw25no2vfMsimipnn8WwrZz1OY03RDroCQ1/HjN3cWsw/uqDKbna/UY7lXClJG+5XzecboAGobYENlCKUQAi6TAJVPmbGHueJWmYJZ3K5kEEn4pM9e/4heYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIAPVZaB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso61184875e9.1;
        Wed, 23 Oct 2024 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729695142; x=1730299942; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fGAGjdzZ/U198pz7p43PfUzhBwFlaYTWYMQjDyByFEQ=;
        b=CIAPVZaB4MBghj0NOhWFrEtHuu6gMe/K+9aOCwRvK/hiaCIIYvEhOwkWTeLvDOPMnT
         2h90JgiOU0ZK+Id0pf+yoMoWyHw6U7KqcwAXbfUbPBf9Wow9kVFT9uHWABlqSQjPHG4r
         UujhjpXDMEKIe8v8bhF2kyFpyDFj+vTm13JvORGqeoBGs+D2/V9uhludDQeNMCJagJas
         y5kPSVK0d2vbTGWNd85+hIArnP24nzdoxpF8MhQ7hg7+I/fQpOO0zjvMned0B8pE3QK0
         PA3d+nKtfJGey5ooYgwsKHUs76hwf8OfMDsKYVkfnjV5Vvr2XvjUp3hAXGG5/AmGM3hy
         kMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729695142; x=1730299942;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGAGjdzZ/U198pz7p43PfUzhBwFlaYTWYMQjDyByFEQ=;
        b=AR6A3MoRHGoNXJyyiSUdy36qUzArFrDsL5FLPkyYxBbz92BSE8wrgz59D/Wm7CcUQe
         uXuGBrgaWunwyeK0KHOaJ7bFKuKn6UVbjbTdzmcdsuqttsCm/P5cpd6L+BPhHDTpq46J
         Jp09ZcGPrl2JKL6yIKNVJ85Z9cf2wWcaFByIYVwkFm7Wy7zGOZ9XvE0eQ3SdYtnXt2+p
         quz42q7MAQSgOTQQNNCWhKdEbnWtVOWr1/gMSSOcXn815NZ7WTGoGZzWKx8U4cMWDRzq
         BDoZTgb0AQyhelwFbR5Q6mbMK+NJjAswLFt9ZrNy+hhqgjoJSvGP6R6w/aj+fv9nRHYK
         oKuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIjCgdEcjTS1HMirExy+RSBws5Z3p2uvOonR6Q3nw4gNsM81B71yaiSndTkdWUC4sScJkTdFez1KGD7zaB@vger.kernel.org, AJvYcCXQqrvM8fBeAcfPEPpQ6JPJD+Odfl9fp+JM1va1EFghUHQSfY/q4fJb10OzVcEdOp7PhS50Pd6wd1Gt@vger.kernel.org, AJvYcCXfeJtVfVvc+w8zFtlrINp7w++L6blDk6SWM1sKbGN9DzFf7JZbkmuhFgFf7wJZwRdh1IyJxG9cjyhH@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmcnMjqeG0vD9kWR3yiMm8Y9DCJHZUGPNufwATvDDahtsoKGi
	VmYNs4Jlq3bPBnEZRB8cCM2B8EbV95PhCC3GiV9kQlBSv1h4pOEK
X-Google-Smtp-Source: AGHT+IF10CszRtIgcGNvdMQcPgv3q4B9GxJoMvj0JW3NenFCOAFbXNLRguOJAe8omCZXeBYFl+hzGw==
X-Received: by 2002:a05:600c:1d9b:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-4318419d392mr26014755e9.29.1729695141813;
        Wed, 23 Oct 2024 07:52:21 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a614d0sm9097434f8f.63.2024.10.23.07.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 07:52:21 -0700 (PDT)
Message-ID: <7a4f8c718029c8c57596d950495fcf28562c6e78.camel@gmail.com>
Subject: Re: [PATCH v7 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich	 <Michael.Hennerich@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown	 <broonie@kernel.org>
Date: Wed, 23 Oct 2024 16:56:39 +0200
In-Reply-To: <20241022-napped-labored-6956ce18d986@spud>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-4-969694f53c5d@baylibre.com>
	 <b1ac7d51280caf729d192ca871c26260fdf3697c.camel@gmail.com>
	 <20241022-napped-labored-6956ce18d986@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-22 at 18:21 +0100, Conor Dooley wrote:
> On Tue, Oct 22, 2024 at 02:36:44PM +0200, Nuno S=C3=A1 wrote:
> > On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Extend AXI-DAC backend with new features required to interface
> > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > IP but with some customizations to work with the ad3552r.
> > >=20
> > > Then, a series of generic functions has been added to match with
> > > ad3552r needs. Function names has been kept generic as much as
> > > possible, to allow re-utilization from other frontend drivers.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> >=20
> > Looks mostly good,
> >=20
> > one minor thing that (I think) could be improved
> > > =C2=A0drivers/iio/dac/adi-axi-dac.c | 269
> > > +++++++++++++++++++++++++++++++++++++++--
> > > -
> > > =C2=A01 file changed, 255 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-=
dac.c
> > > index 04193a98616e..9d6809fe7a67 100644
> > > --- a/drivers/iio/dac/adi-axi-dac.c
> > > +++ b/drivers/iio/dac/adi-axi-dac.c
> > > @@ -46,9 +46,28 @@
> > > =C2=A0#define AXI_DAC_CNTRL_1_REG			0x0044
> > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_CNTRL_1_SYNC			BIT(0)
> > > =C2=A0#define AXI_DAC_CNTRL_2_REG			0x0048
> > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SDR_DDR_N		BIT(16)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B		BIT(14)
> > > =C2=A0#define=C2=A0=C2=A0 ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CNTRL_2_UNSIGNED_DATA		BIT(4)
> > > +#define AXI_DAC_STATUS_1_REG			0x0054
> > > +#define AXI_DAC_STATUS_2_REG			0x0058
> > > =C2=A0#define AXI_DAC_DRP_STATUS_REG			0x0074
> > > =C2=A0#define=C2=A0=C2=A0 AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
> > > +#define AXI_DAC_CUSTOM_RD_REG			0x0080
> > > +#define AXI_DAC_CUSTOM_WR_REG			0x0084
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_8		GENMASK(23, 16)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_WR_DATA_16		GENMASK(23, 8)
> > > +#define AXI_DAC_UI_STATUS_REG			0x0088
> > > +#define=C2=A0=C2=A0 AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
> > > +#define AXI_DAC_CUSTOM_CTRL_REG			0x008C
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
> > > +#define=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
> >=20
> > ...
> > =C2=A0
> > > =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> > > =C2=A0{
> > > -	const unsigned int *expected_ver;
> > > =C2=A0	struct axi_dac_state *st;
> > > =C2=A0	void __iomem *base;
> > > =C2=A0	unsigned int ver;
> > > @@ -566,14 +780,29 @@ static int axi_dac_probe(struct platform_device
> > > *pdev)
> > > =C2=A0	if (!st)
> > > =C2=A0		return -ENOMEM;
> > > =C2=A0
> > > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > > -	if (!expected_ver)
> > > +	st->info =3D device_get_match_data(&pdev->dev);
> > > +	if (!st->info)
> > > =C2=A0		return -ENODEV;
> > > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> > > +	if (IS_ERR(clk)) {
> >=20
> > If clock-names is not given, then we'll get -EINVAL. Hence we could ass=
ume
> > that:
> >=20
> > 		if (PTR_ERR(clk) !=3D -EINVAL)
> > 			return dev_err_probe();
>=20
> clock-names isn't a required property, but the driver code effectively
> makes it one. Doesn't this lookup need to be by index, unless
> clock-names is made required for this variant?

Likely I'm missing something but the driver is not making clock-names manda=
tory,
is it?

At least for the s_axi_aclk, we first try to get it using clock-names and i=
f
that fails we backup to what we're doing which is passing NULL (which
effectively get's the first clock in the array).

The reasoning is that on the generic variant we only need the AXI clk and w=
e
can't now enforce clock-names on it. But to keep things flexible, this was
purposed.

Another alternative that might have more lines of code (but simpler to
understand the intent) is to have (for example) a callback get_clocks funct=
ion
that we set depending on the variant. And this also makes me realize that w=
e
could improve the bindings. I mean, for the generic dac variant we do not n=
eed
clock-names but for this new variant, clock-names is mandatory and I'm fair=
ly
sure we can express that in the bindings.

- Nuno S=C3=A1

