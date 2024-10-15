Return-Path: <linux-iio+bounces-10620-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7336E99E53F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F0AB26E99
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1079E1E9096;
	Tue, 15 Oct 2024 11:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1LinsJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B31E490B;
	Tue, 15 Oct 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990640; cv=none; b=JkqzrGc7fxcFoK+EG/A3c4ZLwhcmclwsJmI7hRePF9IigxZnODt5NzzTvvtlOvyrFgXHUIVMLPmbfuiLdc9sHv6zy72lbaqSFs/U7Vda1nlq13iSvpH1RYzTuXEV9G+X8ioFL/NXhHPJLqaf7+Yj99/6nzeqW9xC7glgda6RUx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990640; c=relaxed/simple;
	bh=JJRH80+q+OqXu1W6WpxGcA/XKLC9ji5QZ6eNy7xacEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E/80iNW0/ENNyy4zVKqNI7PqUKTtHCYMoGrnMqSc1dsTl5pSGWr/xPJ5/r37NBwvFA/7Dq0PJqo14k7DDQM6XIKOFklOPlUedwU3Wsiju2kO4oJtgJlc6Pu/m0pkVoN+j1poEr4lzU1sw07lPsVkHYw6IknAofWS22IVhJdZRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1LinsJk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4305724c12eso39812745e9.1;
        Tue, 15 Oct 2024 04:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990637; x=1729595437; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mmKHvviqiPWvp/u02bqbhQ1tUOIBIqz9Q/+BLNIaik=;
        b=Q1LinsJkSatc3y96jfzicLTWAjAE8R4bUFH5tmb7BZTaKhz7lS7vRyhnlVntz6pLqQ
         u7ObtU4gZzRBf+NxL404devhIcQcoqHQvtIfqiR3X6KGC0742BoPN/dXMT+hwQoMqVR2
         +N+e8mx/WGtvf8Z1tqnoxIWjFFG7Sa2x8Oy0IOYITbz7giclu2LTEkg9qPnmzRoQ0iMs
         H2iba7wbf29jV89JK/H1BLjQoVIKdupMXI2BYyk4fBjZWuW7L+Q5zheRRim2dC3U2TYe
         DjEtNgVQ4tHU+0/t4lRoM70bomGpTA4QgGiFuv4FmeDxzVYK+IGIcA9t5sDXG6bkkd8A
         g2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990637; x=1729595437;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mmKHvviqiPWvp/u02bqbhQ1tUOIBIqz9Q/+BLNIaik=;
        b=N+cKi70md5gNPvsviB0M5q353obONsq1Q75Svw6lCJbhaFXLlkxgrsZnat42Fo2Ydw
         lRGrtgLm2KKIBQcQGq7ZONqT8T6lro7dvYdpC7IpOix5GbJWxn0qG2fhAkVl87LbeF36
         s2nghgw0h9omOgrFWLHnj5x10guiIr6fNz/VjLUL273Y5K1MUj5YsbbqLu9F84VlNF6X
         rOjUEVHW/5nlgQ2og/dyZiHvhtNA3hMt2oo4W7ubxGVuV9F+GWZpIci1G0OGrPmN26GZ
         lnzo9RHO6GYrPrMlxAtOoMbOPJHYEtLoLj8z0XAPJaZPVxdIyNc2MM9z9yKS0XkYkum8
         69Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUkY8LNZkrY6lAvgjDlYnkizPbrody8jx1/2GV2BAf1otHStMC8AfYVGiO4Vg64f2PbxlN9hpKhpJ1K@vger.kernel.org, AJvYcCWNCF+HLpFMwOmKkkUUnrvqgeIyAtomMPU/V+Jrh/SGLfA4hcn+DRawrUyUX4L/xkoc/FQ1evLGf0ck@vger.kernel.org, AJvYcCX2RrHfkEJO1HbjsCssenJg+djWV6Ea0azDayL61lui/o9vXdmXtXqLep1DW58MxyedX8efGzeGWfNr65DJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxrybsgnwJc72R4uXxbbRZ7zg6F/HYvUofu/S0y7uOTULckyFDB
	h3zWgNeBcEIsNcRyM8plShpkO8I4N8wUT94PEw+Og+IHDJ8zPiHt
X-Google-Smtp-Source: AGHT+IFoM3pGpr44Zw+kDtXQOYC1kTlDJCocNDJvjDd7KjCgFIzsfEQ51e4FU+m8a+v6np2dK5H71w==
X-Received: by 2002:adf:f703:0:b0:37d:38a1:6470 with SMTP id ffacd0b85a97d-37d5ffc0320mr7916488f8f.46.1728990637066;
        Tue, 15 Oct 2024 04:10:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc3d6afsm1284648f8f.99.2024.10.15.04.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:10:36 -0700 (PDT)
Message-ID: <ca3bb7c87a15ebb8e1284aa2da312cd00de49159.camel@gmail.com>
Subject: Re: [PATCH v6 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown
	 <broonie@kernel.org>
Date: Tue, 15 Oct 2024 13:10:35 +0200
In-Reply-To: <bw2ldm54tg6klzfod5t5y6eb34dr4mcttojz4uulxqm5stk2hw@rmgpibnx6xsd>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
	 <ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>
	 <bw2ldm54tg6klzfod5t5y6eb34dr4mcttojz4uulxqm5stk2hw@rmgpibnx6xsd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 10:57 +0200, Angelo Dureghello wrote:
> On 14.10.2024 16:14, David Lechner wrote:
> > On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Extend AXI-DAC backend with new features required to interface
> > > to the ad3552r DAC. Mainly, a new compatible string is added to
> > > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > > IP but with some customizations to work with the ad3552r.
> > >=20
> > > Then, a serie of generic functions has been added to match with
> >=20
> > spelling: series
> >=20
> > > ad3552r needs. Function names has been kept generic as much as
> > > possible, to allow re-utilization from other frontend drivers.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> >=20
> > ...
> >=20
> > > +static int axi_dac_read_raw(struct iio_backend *back,
> > > +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > > +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +	int err, reg;
> > > +
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_FREQUENCY:
> > > +
> > > +		if (!st->info->has_dac_clk)
> > > +			return -EOPNOTSUPP;
> > > +
> > > +		/*
> > > +		 * As from ad3552r AXI IP documentation,
> > > +		 * returning the SCLK depending on the stream mode.
> > > +		 */
> > > +		err =3D regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> > > +			*val =3D st->dac_clk_rate / 2;
> > > +		else
> > > +			*val =3D st->dac_clk_rate / 8;
> >=20
> > To get the DAC sample rate, we only care about the streaming mode
> > rate, so this should just always be / 2 and not / 8. Otherwise
> > the sampling_frequency attribute in the DAC driver will return
> > the wrong value when the buffer is not enabled. We never do buffered
> > writes without enabling streaming mode.
> >=20
> > > +
> > > +		return IIO_VAL_INT;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, =
u32 val,
> > > +				 size_t data_size)
> > > +{
> > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > +	int ret;
> > > +	u32 ival;
> > > +
> > > +	if (data_size =3D=3D sizeof(u16))
> > > +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> > > +	else
> > > +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> > > +
> > > +	ret =3D regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
> >=20
> > I'm guessing these got renamed. REG_CNTRL_2 =3D AXI_DAC_CNTRL_2_REG
> > and AXI_DAC_CNTRL_DATA_WR =3D AXI_DAC_CUSTOM_WR_REG?
> >=20
> > > +	 * the data size. So keeping data size control here only,
> > > +	 * since data size is mandatory for the current transfer.
> > > +	 * DDR state handled separately by specific backend calls,
> > > +	 * generally all raw register writes are SDR.
> > > +	 */
> > > +	if (data_size =3D=3D sizeof(u8))
> > > +		ret =3D regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B);
> > > +	else
> > > +		ret =3D regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > > +					AXI_DAC_CNTRL_2_SYMB_8B);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > > reg));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D regmap_read_poll_timeout(st->regmap,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_REG, iv=
al,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ival &
> > > AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100 * KILO);
> > > +	if (ret)
> > > +		return ret;
> >=20
> > Should we also clear AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA on timeout
> > so that we don't leave things in a bad state?
> >=20
>=20
> just realized this poll is wrong and unuseful.
> It's a check on a bit we just set.
> Check must be done in AXI_MSK_BUSY of AXI_REG_UI_STATUS.
>=20
> If it fails after 100msecs, looks like things are seriously blocked,
> not sure clearing any bit would help.
>=20
>=20
> > > +
> > > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > > +}
> > > +
> >=20
> > ...
> >=20
> > > =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> > > =C2=A0{
> > > -	const unsigned int *expected_ver;
> > > =C2=A0	struct axi_dac_state *st;
> > > =C2=A0	void __iomem *base;
> > > =C2=A0	unsigned int ver;
> > > @@ -566,15 +793,26 @@ static int axi_dac_probe(struct platform_device=
 *pdev)
> > > =C2=A0	if (!st)
> > > =C2=A0		return -ENOMEM;
> > > =C2=A0
> > > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > > -	if (!expected_ver)
> > > +	st->info =3D device_get_match_data(&pdev->dev);
> > > +	if (!st->info)
> > > =C2=A0		return -ENODEV;
> > > =C2=A0
> > > -	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> >=20
> > This will break existing users that don't have clock-names
> > in the DT. It should be fine to leave it as NULL in which
> > case it will get the clock at index 0 in the clocks array
> > even if there is more than one clock.
> >=20
>=20
> mm, are there existing users except this hs driver right now ?
>=20
> Clock names are actually described in the example, and if missing,
> also retrieving "dac_clk" would fail.
>=20

There's already a frontend DAC using the generic DAC implementation. So, in=
 theory,
yes... We can already have users not setting clock-names in DT that would n=
ow fail to
probe with this patch. David is only suggesting leaving this call to NULL. =
For
dac_clk we do need the *id in devm_clk_get_enabled().

Maybe it would also be worth mentioning in the bindings that s_axi_aclk nee=
ds to be
the first entry in clocks and clock-names for backward compatibility.

- Nuno S=C3=A1
> >=20


