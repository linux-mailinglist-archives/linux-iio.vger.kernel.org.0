Return-Path: <linux-iio+bounces-3899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA167890633
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 17:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A529E99D
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE777E767;
	Thu, 28 Mar 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtR04z6/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B903BBC7;
	Thu, 28 Mar 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644230; cv=none; b=DE0eHnbHHVNjzCMZDDGhv2c8pwvN0mcPlAMdXgshye/U1ZJEWUrdCgu9t9YFEIvLfxdMEMjiUDv8ArBN94zC6zGxEsiWxh6u/qZWp8wkcPlKCeXZ5yuql8Rx+ellc95V/pptupMJKlyFKaqIyDrxo5WcpvQJfnHgX9Ur3CJFtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644230; c=relaxed/simple;
	bh=4E0MUs1BwbIDg+DH/YiBcSfr9+4OJ24FDqzrlLewnL0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPWRE4VLdCFwTsutHPCn/BxR2tJfMlTxr+BmyUv8mclMqadOjJFSzzQ22LCWZKNNn49j7ObeAi49NATFY0pqTy14jo/Lp3Tb0IWVjqCK5F7qNAaZ8RSVXmUvOE22ogYNNNo2YMdHbdHQ/bghOOIJjVxJfNIlclBk688fMOL6eQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtR04z6/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso10615171fa.1;
        Thu, 28 Mar 2024 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711644226; x=1712249026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bmmqruep+ijJiklvlFPDX8S90IG+pF0MAJz3BPeb2Qk=;
        b=JtR04z6/jr6LaxeWLnK12TMqkyktLs45Q5Tv3QzXnjc94Z8mGWW2fGG6h8Eeqgymcr
         i154nIJYHoXWClaUBAcTrwx886Bo8F6xQTXeHeInPA9VKtmWi0BFmMn/liD2Mu/TvBP7
         7tAnnIlb6x47cHNp/KmUl4VjI/5HzNigxjFzX61HmNpFjyr9q97R2u1b2a6PxtpGk6MG
         8etbQONeKPYir7tabYSfbw1z95k5VurJ04J/T7BbEeszjlrr0zhgX2nfx1yyotgaiNEM
         sP/oz81JofOqP5c4neA0IRZlnHuUyWNUEGz0ptGe0FquL/vBzSUsw1zYlmf++uhyVSaX
         XEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711644226; x=1712249026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmmqruep+ijJiklvlFPDX8S90IG+pF0MAJz3BPeb2Qk=;
        b=wLJXzoZWDiSLfADENYDfYQNRVU3mU1/0d4DuKXWGvuIKfXaiZXjZ9UJdRk9vhHGJgl
         lfXXEwhgjksNa/sqfp6wsskRm6Ulm1O+phTkHdDHzH7J4ErLeBfjoP8y197dojZpZZNk
         4yZ4fMJRJce5HaXD7xjk3w3FfYTsn++Pvd4/KUsoWtdt/YbSCZshBmdrDohw+gsJgGrR
         949AOW/a/9sm0oR0pnHAUkmZfOq7ZX0IsTaRl63EPwJhEn1pTQSIbf6xnxe81k7QPRGf
         9C+2sYnv7Ho6vlcV8Vrb3E8lA3ETa1aglUA76kKHVKj4msEFgBZQeA4K5JWlzO0S/jNf
         DBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNmwoQ/g0d3lahqAnTESAcBRx85xnMsvYVB65iaCwNLUz4d1m/5+D3Roo9j0n+/U8gLHOniAH8Z1uI9jkncM1Hsv5c6QchF5sWeQnG00LBi/9ubUpD8JVx4O551u9GloH1uO4DJA==
X-Gm-Message-State: AOJu0YyvFwGeje75lt5GtZfJO4wK1XTPWerc6uhmKxzeUxx7dX/4QYCP
	mljACBHwm0d6dj8QQ5PRdRVYrxJDsxT0rSzUvkgXZ83QqbtCHHB5
X-Google-Smtp-Source: AGHT+IFk+xpAbnblslTCmr4Dy5hx7iNQPWjLPjtTfMumTFo6Ew7Yx1xUmw3mh7TduHzNFtl15Fe2Dw==
X-Received: by 2002:a2e:b6cc:0:b0:2d6:f17f:f975 with SMTP id m12-20020a2eb6cc000000b002d6f17ff975mr1195493ljo.2.1711644225629;
        Thu, 28 Mar 2024 09:43:45 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e3817000000b002d6d464ac2fsm291786lja.122.2024.03.28.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:43:45 -0700 (PDT)
Message-ID: <d86dbdd7c1f234ebedc08c3433735f43abff7f7e.camel@gmail.com>
Subject: Re: [PATCH 09/10] iio: dac: add support for AXI DAC IP core
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 28 Mar 2024 17:43:43 +0100
In-Reply-To: <20240328153542.7ddb897c@jic23-huawei>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-9-afc808b3fde3@analog.com>
	 <20240328153542.7ddb897c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 15:35 +0000, Jonathan Cameron wrote:
> On Thu, 28 Mar 2024 14:22:33 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Support the Analog Devices Generic AXI DAC IP core. The IP core is used
> > for interfacing with digital-to-analog (DAC) converters that require ei=
ther
> > a high-speed serial interface (JESD204B/C) or a source synchronous para=
llel
> > interface (LVDS/CMOS). Typically (for such devices) SPI will be used fo=
r
> > configuration only, while this IP core handles the streaming of data in=
to
> > memory via DMA.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
>=20
> A few minor things inline, but mostly seems fine to me.
>=20
> Jonathan
>=20
>=20
> ...
>=20
> > diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-da=
c.c
> > new file mode 100644
> > index 000000000000..0022ecb4e4bb
> > --- /dev/null
> > +++ b/drivers/iio/dac/adi-axi-dac.c
>=20
>=20
> > +
> > +enum {
> > +	AXI_DAC_FREQ_TONE_1,
> > +	AXI_DAC_FREQ_TONE_2,
> > +	AXI_DAC_SCALE_TONE_1,
> > +	AXI_DAC_SCALE_TONE_2,
> > +	AXI_DAC_PHASE_TONE_1,
> > +	AXI_DAC_PHASE_TONE_2,
> > +};
> > +
> > +static int __axi_dac_frequency_get(struct axi_dac_state *st, unsigned =
int chan,
> > +				=C2=A0=C2=A0 unsigned int tone, unsigned int *freq)
> > +{
> > +	u32 reg, raw;
> > +	int ret;
> > +
> > +	if (!st->dac_clk) {
> > +		dev_err(st->dev, "Sampling rate is 0...\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (tone =3D=3D AXI_DAC_FREQ_TONE_1)
>=20
> Given this is matching 2 out of enum with other values, it would be more
> locally readable as a switch statement with an error returning default.
> Then we wouldn't need to look at the caller.
>=20
> Or at the caller convert from the enum to 0,1 for all these functions.
>=20

Ok, will see what of the alternatives looks better.

>=20
>=20
> > +		reg =3D AXI_DAC_REG_CHAN_CNTRL_2(chan);
> > +	else
> > +		reg =3D AXI_DAC_REG_CHAN_CNTRL_4(chan);
> > +
> > +	ret =3D regmap_read(st->regmap, reg, &raw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	raw =3D FIELD_GET(AXI_DAC_FREQUENCY, raw);
> > +	*freq =3D DIV_ROUND_CLOSEST_ULL(raw * st->dac_clk, BIT(16));
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static int axi_dac_scale_set(struct axi_dac_state *st,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len, unsigned int =
tone)
> > +{
> > +	int integer, frac, scale;
> > +	u32 raw =3D 0, reg;
> > +	int ret;
> > +
> > +	ret =3D iio_str_to_fixpoint(buf, 100000, &integer, &frac);
> > +	if (ret)
> > +		return ret;
> > +
> > +	scale =3D integer * MEGA + frac;
> > +	if (scale <=3D -2 * (int)MEGA || scale >=3D 2 * (int)MEGA)
> > +		return -EINVAL;
> > +
> > +	/*=C2=A0 format is 1.1.14 (sign, integer and fractional bits) */
> > +	if (scale < 0) {
> > +		raw =3D FIELD_PREP(AXI_DAC_SCALE_SIGN, 1);
> > +		scale *=3D -1;
> > +	}
> > +
> > +	raw |=3D div_u64((u64)scale * AXI_DAC_SCALE_INT, MEGA);
> > +
> > +	if (tone =3D=3D AXI_DAC_SCALE_TONE_1)
> > +		reg =3D AXI_DAC_REG_CHAN_CNTRL_1(chan->channel);
> > +	else
> > +		reg =3D AXI_DAC_REG_CHAN_CNTRL_3(chan->channel);
> > +
> > +	guard(mutex)(&st->lock);
> > +	ret =3D regmap_write(st->regmap, reg, raw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* synchronize channels */
> > +	ret =3D regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC=
);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > +
> > +static int axi_dac_phase_set(struct axi_dac_state *st,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len, unsigned int =
tone)
> > +{
> > +	int integer, frac, phase;
> > +	u32 raw, reg;
> > +	int ret;
> > +
> > +	ret =3D iio_str_to_fixpoint(buf, 100000, &integer, &frac);
>=20
> > +	if (ret)
> > +		return ret;
> > +
> > +	phase =3D integer * MEGA + frac;
> > +	if (phase < 0 || phase > AXI_DAC_2_PI_MEGA)
> > +		return -EINVAL;
> > +
> > +	raw =3D DIV_ROUND_CLOSEST_ULL((u64)phase * U16_MAX, AXI_DAC_2_PI_MEGA=
);
> > +
> > +	if (tone =3D=3D AXI_DAC_PHASE_TONE_1)
> Preference for a switch so it's clear there are only 2 choices.
> > +		reg =3D AXI_DAC_REG_CHAN_CNTRL_2(chan->channel);
> > +	else
> > +		reg =3D AXI_DAC_REG_CHAN_CNTRL_4(chan->channel);
> > +
> > +	guard(mutex)(&st->lock);
> > +	ret =3D regmap_update_bits(st->regmap, reg, AXI_DAC_PHASE,
> > +				 FIELD_PREP(AXI_DAC_PHASE, raw));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* synchronize channels */
> > +	ret =3D regmap_set_bits(st->regmap, AXI_DAC_REG_CNTRL_1, AXI_DAC_SYNC=
);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return len;
> > +}
> > +
> > +static int axi_dac_ext_info_set(struct iio_backend *back, uintptr_t pr=
ivate,
> > +				const struct iio_chan_spec *chan,
> > +				const char *buf, size_t len)
> > +{
> > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > +
> > +	switch (private) {
> > +	case AXI_DAC_FREQ_TONE_1:
> > +	case AXI_DAC_FREQ_TONE_2:
>=20
> Same as the get path - convert to which tone here so that the enum become=
s
> a tone index for the functions called and the mapping to that single enum
> is kept clear of the lower level code.
>=20
> > +		return axi_dac_frequency_set(st, chan, buf, len, private);
> > +	case AXI_DAC_SCALE_TONE_1:
> > +	case AXI_DAC_SCALE_TONE_2:
> > +		return axi_dac_scale_set(st, chan, buf, len, private);
> > +	case AXI_DAC_PHASE_TONE_1:
> > +	case AXI_DAC_PHASE_TONE_2:
> > +		return axi_dac_phase_set(st, chan, buf, len, private);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int axi_dac_ext_info_get(struct iio_backend *back, uintptr_t pr=
ivate,
> > +				const struct iio_chan_spec *chan, char *buf)
> > +{
> > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > +
> > +	switch (private) {
> > +	case AXI_DAC_FREQ_TONE_1:
> > +	case AXI_DAC_FREQ_TONE_2:
> > +		return axi_dac_frequency_get(st, chan, buf, private);
> I'd break out private as an unsigned int here and then - AXI_DAC_FREQ_TON=
E_1
> so that it is just which tone for all the calls made from here.
> Similar for the following ones.
>=20

ack..

> > +	case AXI_DAC_SCALE_TONE_1:
> > +	case AXI_DAC_SCALE_TONE_2:
> > +		return axi_dac_scale_get(st, chan, buf, private);
> > +	case AXI_DAC_PHASE_TONE_1:
> > +	case AXI_DAC_PHASE_TONE_2:
> > +		return axi_dac_phase_get(st, chan, buf, private);
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info axi_dac_ext_info[] =3D {
> > +	IIO_BACKEND_EX_INFO("frequency0", IIO_SEPARATE, AXI_DAC_FREQ_TONE_1),
> > +	IIO_BACKEND_EX_INFO("frequency1", IIO_SEPARATE, AXI_DAC_FREQ_TONE_2),
> > +	IIO_BACKEND_EX_INFO("scale0", IIO_SEPARATE, AXI_DAC_SCALE_TONE_1),
> > +	IIO_BACKEND_EX_INFO("scale1", IIO_SEPARATE, AXI_DAC_SCALE_TONE_2),
> > +	IIO_BACKEND_EX_INFO("phase0", IIO_SEPARATE, AXI_DAC_PHASE_TONE_1),
> > +	IIO_BACKEND_EX_INFO("phase1", IIO_SEPARATE, AXI_DAC_PHASE_TONE_2),
> > +	{}
> > +};
> > +
> > +static int axi_dac_extend_chan(struct iio_backend *back,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec *chan)
> > +{
> > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > +
> > +	if (chan->type !=3D IIO_ALTVOLTAGE)
> > +		return -EINVAL;
> > +	if (st->reg_config & AXI_DDS_DISABLE)
> > +		/* nothing to extend */
> > +		return 0;
> > +
> > +	chan->ext_info =3D axi_dac_ext_info;
> > +
> > +	return 0;
> > +}
>=20
> > +static int axi_dac_set_sample_rate(struct iio_backend *back, unsigned =
int chan,
> > +				=C2=A0=C2=A0 u64 sample_rate)
> > +{
> > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > +	unsigned int freq;
> > +	int ret, tone;
> > +
> > +	if (!sample_rate)
> > +		return -EINVAL;
> > +	if (st->reg_config & AXI_DDS_DISABLE)
> > +		/* nothing to care if DDS is disabled */
> Rephrase this.=C2=A0 Is the point that the sample rate has no meaning wit=
hout DDS or
> that it has meaning but nothing to do here?

Has no meaning as it's not used with DDS enabled...

- Nuno S=C3=A1
>=20

