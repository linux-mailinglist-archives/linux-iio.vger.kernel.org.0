Return-Path: <linux-iio+bounces-10597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5999DE5F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 08:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8B4282A5E
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 06:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09525189F2D;
	Tue, 15 Oct 2024 06:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAK0vwJE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA9189916;
	Tue, 15 Oct 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973817; cv=none; b=OOkBkojMsP9Zyio29bAixtt7SACJ3UywhvwoRbHHIt1DQ0zW3Js4Rplr+je5zOBlC3pHNWad8kP0Iief2NvXy+u6Gs20s0+qsSsEt0U11FC9ioEOuw/2tMlvSv328MKfNTnxfxxmjsbMa8W/wxXa4/KZ6098XwUu8u+wVV9lX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973817; c=relaxed/simple;
	bh=41Txd5YoLMl6wAv7Qsle+XXPiZ4/UQIHqTjLCoOyMYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RD3UPy+TBVRFK3m8MvYRQpVlTLePmqpcwhoAgxctzSwpEARTcxSyPYe20+eC/fvzSx/nc/ujrjqC0dSf6tCG7YwmGt3/yMvH05xdzGeGUOFtGMGV+CCfsVrR36akVTgnM9nCzasUqIov+UOcWrqa37oQqY2wcZvnqGIdI57Ijpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAK0vwJE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d447de11dso3615234f8f.1;
        Mon, 14 Oct 2024 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728973814; x=1729578614; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0/51GjD74rmzWSp7jmO+qgKLOzZqeiFNpacQrj2PkHc=;
        b=hAK0vwJE1TnvRAkeFUJFV+B7pDF3PdsoNadn6H7lS4oTB1lB4CbjuODHookD29phOZ
         GY1AgJ06dupGXRyVkIoKaQHJbqA+H1G+bmkeE43UIEMJZqsBq4rQS7aIfw21n5FEzzCE
         C/GZXhEuTSg03N679fou2OcmtRevKy/2P2kBZ4rtxe1xlOaee0tI690ghY2RNdr1sG2F
         Xn3KpRc96LapQeYfqRvBwc97V2tiUuGsAa2fUztzaRkQkntRmCNPMLXLriBNwfBa6/PN
         in7t7TLFo5W1bJcxVKqPe4m5bzUHxN0BxiBWG7JcwylEKySwceX/+shxbSrYzH9qBMXK
         aGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728973814; x=1729578614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/51GjD74rmzWSp7jmO+qgKLOzZqeiFNpacQrj2PkHc=;
        b=PXiGFKQGewwOsR7wbSvKlsn9WHy6/LTrIjAHW/tAu0o+ynUPwX0i/XwAH6DdXe/sAT
         n7VudxONoUwr9HdUkmk41Q+KOef96B794c3cnAN6wufVsHCiXxPvh/SS6nfYghkgH9t0
         Bi/wSq2PkgQXRdxIoWr7Aud/kIEf8Om9SwP7K7oKNuLRF6XsNQA+3PEaU+lmQj7WsXMi
         nn9sbc2IDtCf8pYxNVg6jh7nj7ThB65LaEO2edSwqvIDP8gtLCCVPY75o7GfGlQ2ziid
         sd7JY0uWGPgGijDqZzr1M2ztK+WEgUj1Mb0ZdDXcfuUZURx41ygTowucTOUoDkt75/r6
         UmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7eTzkcDAAu71v9hd5THy+u6ZKYvqC9Wws11R0a+zFD4sgj3UUXDnTNLniLH2+xNiAYrQWZXfdJpf204+H@vger.kernel.org, AJvYcCWDOOC1nFBXlg9MRb3WVkfNRPsULj0RRDFYpgwwG5aVPE+U3TK9wHo4Eo7dpy9Y7vibFtcYi3D6Rys8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu47JROUvS0VY/ESBCK/cDam884tpK/dfjtaPJh1iMQ97Sdz/w
	EzWo7hDdf1FYPusF6qnqzzrrSud2BizdYeF+fnXydMpbPkZXhNSo
X-Google-Smtp-Source: AGHT+IGztSWoQNZUn18NP0qjrUlztyHZzM+Qnb1J/xY9GzqeImDRsQ4KreubkMNqsIUw5R4KTyaejg==
X-Received: by 2002:adf:a395:0:b0:37d:4fe9:b6a7 with SMTP id ffacd0b85a97d-37d5529effamr9818072f8f.36.1728973814126;
        Mon, 14 Oct 2024 23:30:14 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc40a14sm698756f8f.103.2024.10.14.23.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:30:13 -0700 (PDT)
Message-ID: <c4a961752398b7ecc6ed2eb59633b662ccfaaf50.camel@gmail.com>
Subject: Re: [PATCH v6 4/8] iio: dac: adi-axi-dac: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Tue, 15 Oct 2024 08:30:13 +0200
In-Reply-To: <ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>
References: 
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-4-eeef0c1e0e56@baylibre.com>
	 <ab559026-7e95-4adc-9978-6db30982b2a6@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 16:14 -0500, David Lechner wrote:
> On 10/14/24 5:08 AM, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Extend AXI-DAC backend with new features required to interface
> > to the ad3552r DAC. Mainly, a new compatible string is added to
> > support the ad3552r-axi DAC IP, very similar to the generic DAC
> > IP but with some customizations to work with the ad3552r.
> >=20
> > Then, a serie of generic functions has been added to match with
>=20
> spelling: series
>=20
> > ad3552r needs. Function names has been kept generic as much as
> > possible, to allow re-utilization from other frontend drivers.
> >=20
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
>=20
> ...
>=20
> > +static int axi_dac_read_raw(struct iio_backend *back,
> > +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> > +{
> > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > +	int err, reg;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +
> > +		if (!st->info->has_dac_clk)
> > +			return -EOPNOTSUPP;
> > +
> > +		/*
> > +		 * As from ad3552r AXI IP documentation,
> > +		 * returning the SCLK depending on the stream mode.
> > +		 */
> > +		err =3D regmap_read(st->regmap, AXI_DAC_CUSTOM_CTRL_REG, &reg);
> > +		if (err)
> > +			return err;
> > +
> > +		if (reg & AXI_DAC_CUSTOM_CTRL_STREAM)
> > +			*val =3D st->dac_clk_rate / 2;
> > +		else
> > +			*val =3D st->dac_clk_rate / 8;
>=20
> To get the DAC sample rate, we only care about the streaming mode
> rate, so this should just always be / 2 and not / 8. Otherwise
> the sampling_frequency attribute in the DAC driver will return
> the wrong value when the buffer is not enabled. We never do buffered
> writes without enabling streaming mode.

But the question then is, what do we return when streaming mode is off? Div=
iding by 2
in that case won't report the actual SCLK. But you do have a point and I th=
ink a very
common pattern from userspace is to first get the sampling frequency and on=
ly then
starting buffering. In this case, yes, we get the wrong sampling frequency.=
 Bottom
line I agree with David and we should just care about returning the max sam=
pling
frequency which is the one that apps ultimately care about.

So, I would say to divide it by 2 during probe and just return that value i=
n here.

- Nuno S=C3=A1
>=20
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int axi_dac_bus_reg_write(struct iio_backend *back, u32 reg, u3=
2 val,
> > +				 size_t data_size)
> > +{
> > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > +	int ret;
> > +	u32 ival;
> > +
> > +	if (data_size =3D=3D sizeof(u16))
> > +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_16, val);
> > +	else
> > +		ival =3D FIELD_PREP(AXI_DAC_CUSTOM_WR_DATA_8, val);
> > +
> > +	ret =3D regmap_write(st->regmap, AXI_DAC_CUSTOM_WR_REG, ival);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to know
>=20
> I'm guessing these got renamed. REG_CNTRL_2 =3D AXI_DAC_CNTRL_2_REG
> and AXI_DAC_CNTRL_DATA_WR =3D AXI_DAC_CUSTOM_WR_REG?
>=20
> > +	 * the data size. So keeping data size control here only,
> > +	 * since data size is mandatory for the current transfer.
> > +	 * DDR state handled separately by specific backend calls,
> > +	 * generally all raw register writes are SDR.
> > +	 */
> > +	if (data_size =3D=3D sizeof(u8))
> > +		ret =3D regmap_set_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CNTRL_2_SYMB_8B);
> > +	else
> > +		ret =3D regmap_clear_bits(st->regmap, AXI_DAC_CNTRL_2_REG,
> > +					AXI_DAC_CNTRL_2_SYMB_8B);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_ADDRESS,
> > +				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_ADDRESS, reg));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_read_poll_timeout(st->regmap,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_CUSTOM_CTRL_REG, ival=
,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ival & AXI_DAC_CUSTOM_CTRL_TR=
ANSFER_DATA,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100 * KILO);
> > +	if (ret)
> > +		return ret;
>=20
> Should we also clear AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA on timeout
> so that we don't leave things in a bad state?
>=20
> > +
> > +	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
> > +				 AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA);
> > +}
> > +
>=20
> ...
>=20
> > =C2=A0static int axi_dac_probe(struct platform_device *pdev)
> > =C2=A0{
> > -	const unsigned int *expected_ver;
> > =C2=A0	struct axi_dac_state *st;
> > =C2=A0	void __iomem *base;
> > =C2=A0	unsigned int ver;
> > @@ -566,15 +793,26 @@ static int axi_dac_probe(struct platform_device *=
pdev)
> > =C2=A0	if (!st)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > -	expected_ver =3D device_get_match_data(&pdev->dev);
> > -	if (!expected_ver)
> > +	st->info =3D device_get_match_data(&pdev->dev);
> > +	if (!st->info)
> > =C2=A0		return -ENODEV;
> > =C2=A0
> > -	clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +	clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
>=20
> This will break existing users that don't have clock-names
> in the DT. It should be fine to leave it as NULL in which
> case it will get the clock at index 0 in the clocks array
> even if there is more than one clock.

Good catch...

- Nuno S=C3=A1


