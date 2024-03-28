Return-Path: <linux-iio+bounces-3898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBCD8905EB
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 17:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CB62999A9
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FD813B5B7;
	Thu, 28 Mar 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGiA1+tQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7EB13B599;
	Thu, 28 Mar 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643888; cv=none; b=oosFvjJ0XH++7m+e3I8BWkxCfeO+YN7lctAhbh5iqrWLn2mk1j4v3DuNtaJR/qNQKMt9Xx743xTdWMIlKNWVT++1bBOzBJKmIgL9m4sNQsWZgC0Q/ALmFuGHBFKz++Mg4lNdRlZpdily/UToSHcUimXYZlyNTKCNNf2LBeeR5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643888; c=relaxed/simple;
	bh=sHN6INMoKf/R2f2GfJ3/WJ/QEFTT6/H1uQn3/g4+oAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e+3SlNB20/LnUtsiL6K1tR4UXU7sYatZAB+RBzpdZG1v06Bjt3FW9lyhLcd64CnlIRrjcFlq2uFCnwC6AkoQXN0ZwDW6vtJFDEgNthqLgCiE+gAP0b7N9hy+QYVw4hBcGzGlZoElojKdJDviaVxkLOEOkauV/Uqxf2FNP8y3oK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGiA1+tQ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68651e253so17059431fa.0;
        Thu, 28 Mar 2024 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711643883; x=1712248683; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y9bsrpAMcF33MLx5oZA5n4HO53rnT269o/xkdvf8Hjs=;
        b=QGiA1+tQW4pqd4yC7xEN7N2Py/4tx7HXPjC1t7jikQMtgerbFb1N0TBoWRknmA6FVH
         9TqW0FVBzMvR6NJKQKIlZKmBFy/sXDzmBw2nmJacxgewaHKfz+L22pZacWMtfi66zr+h
         NIGPArZS6lQo5AWQ9K1T48uSavtIBItmPTO3Zq51hrwfQoCsETpbVoTyucasi0jZ87fG
         KfSB1nNAwR5RhQSQwpDEvvHtWsupZUSAIZ2cNllQ6vLndKgU4D7Puuu8+r9gEWJMAZOj
         HO5ySGN1Lv0fZJ7p1WZM3KwxMw2MEZbG8cAn1fUk31WtwLnYV9jXCepCVqcvNF4xT2zM
         vYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711643883; x=1712248683;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9bsrpAMcF33MLx5oZA5n4HO53rnT269o/xkdvf8Hjs=;
        b=Fu14TwvrRQs39gc/OAP4XJ4ngu/6aEWNGjRzqJmiTq5eToSGDdiej6/D12kqFPvW+U
         wLitqxDboGLYW3gJjJWUh//EdDsAiwvdWPtxj5RosqCdVF194xacnip3/jgSWtsgR61g
         IHn8a8St5WECPvirTQLYoyeeteOytLAjkLSGVaumzcCONzngm9KdNLerx1UiiqO6ykOI
         lkhyJ35glYJmnrEopXUCtugyD+Zjqmtw2iJlBmALbFOzfPmAfoxvC/ycJbbmllSnNcnB
         SogAqbQchef8HPMoSx+U9ahr3jAlHLp+yRo6zY2gytDRGXSWn1YxafkhiCjzPfucbWW2
         DDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PXofepqoYT36+u9qZv7LMtfEbbRea+CxVWOGH7qhb7hqtNSpLqiTucmWukDO9S4mQrY2/wZUac8ZQlLcMLQ8F68Vu/eQ804113a05joTiz7YUlqCbHiHzU57O5oNKqVZOHkWqg==
X-Gm-Message-State: AOJu0YyWGSIewBkrbeejF01GEoJDD81D4EGrMr/YI/GMeXPzgrJv6HQf
	BBpEgo5J/TonMisM3XNAWwMvFeqOwD/kXml66pWPaPPUpPEsd8pM
X-Google-Smtp-Source: AGHT+IFECVPXHDHBM2qIznh4jMmP2j0yOB7FJaB/fpIWZttKEOjBWSwKeCaCR594aeRLMqErc3edEw==
X-Received: by 2002:ac2:5045:0:b0:513:da61:9b46 with SMTP id a5-20020ac25045000000b00513da619b46mr2092842lfm.53.1711643882662;
        Thu, 28 Mar 2024 09:38:02 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7c70f000000b0056c4f3af305sm1012286edq.30.2024.03.28.09.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 09:38:02 -0700 (PDT)
Message-ID: <62e07212e1eebf8bbc6a7f9ee27f670a6d79c57e.camel@gmail.com>
Subject: Re: [PATCH 10/10] iio: dac: support the ad9739a RF DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Dragos Bogdan <dragos.bogdan@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 28 Mar 2024 17:37:56 +0100
In-Reply-To: <20240328155126.2575d754@jic23-huawei>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-10-afc808b3fde3@analog.com>
	 <20240328155126.2575d754@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-28 at 15:51 +0000, Jonathan Cameron wrote:
> On Thu, 28 Mar 2024 14:22:34 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are cap=
able
> > of synthesizing wideband signals from dc up to 3 GHz.
> DC perhaps
>=20
> >=20
> > A dual-port, source synchronous, LVDS interface simplifies the digital
> > interface with existing FGPA/ASIC technology. On-chip controllers are u=
sed
> > to manage external and internal clock domain variations over temperatur=
e to
> > ensure reliable data transfer from the host to the DAC core.
> >=20
> > Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Hi Nuno,
>=20
> A few questions / comments inline but on the whole looking good to me.
>=20
> Jonathan
>=20
> > ---
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio-ad9739a |=C2=A0 17 +
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
> > =C2=A0drivers/iio/dac/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/dac/ad9739a.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 445 ++++++++++++++++++++++++
> > =C2=A05 files changed, 480 insertions(+)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
> > b/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
> > new file mode 100644
> > index 000000000000..8a8a5cd10386
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad9739a
> > @@ -0,0 +1,17 @@
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_operating_mode
> > +KernelVersion:	6.9
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Dac operating mode. One of the following modes can be selected:
>=20
> DAC operating mode. ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * normal: This is DAC=
 normal mode.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * mixed-mode: In this=
 mode the output is effectively chopped at the
>=20
> Spaces and tabs mixed...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DAC sample =
rate. This has the effect of reducing the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power of th=
e fundamental signal while increasing the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power of th=
e images centered around the DAC sample rate,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thus improv=
ing the output power of these images.
>=20
> Any idea why it is called mixed mode?=C2=A0 Name doesn't suggest to me wh=
at the Docs say
> this does.

Nope, just respecting the datasheet names for the modes. But I may give it =
another
read. Likely there was a reason for that naming :)

>=20
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_operating_mode_av=
a
> > ilable
> > +KernelVersion:	6.9
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Available operating modes.
>=20
> > =C2=A0M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> > index 7c0a8caa9a34..ee0d9798d8b4 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -131,6 +131,22 @@ config AD5624R_SPI
> > =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD5624R,=
 AD5644R and
> > =C2=A0	=C2=A0 AD5664R converters (DAC). This driver uses the common SPI=
 interface.
> > =C2=A0
> > +config AD9739A
> > +	tristate "Analog Devices AD9739A RF DAC spi driver"
> > +	depends on SPI
> > +	select REGMAP_SPI
> > +	select IIO_BACKEND
> > +	help
> > +	=C2=A0 Say yes here to build support for Analog Devices AD9739A Digit=
al-to
> > +	=C2=A0 Analog Converter.
> > +
> > +	=C2=A0 The driver requires the assistance of the AXI DAC IP core to o=
perate,
>=20
> Maybe a depends on || COMPILE_TEST to increase build coverage (compared t=
o
> a hard depends on)
>=20

Can do that...

> > +	=C2=A0 since SPI is used for configuration only, while data has to be
> > +	=C2=A0 streamed into memory via DMA.
> > +
> > +	=C2=A0 To compile this driver as a module, choose M here: the module =
will be
> > +	=C2=A0 called ad9739a.
> > +
>=20
>=20
> > diff --git a/drivers/iio/dac/ad9739a.c b/drivers/iio/dac/ad9739a.c
> > new file mode 100644
> > index 000000000000..46431fa345a5
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad9739a.c
>=20
> > +
> > +enum {
> > +	AD9739A_NORMAL_MODE,
> > +	AD9739A_MIXED_MODE =3D 2,
>=20
> Push these next to the relevant registers and more conventional defines.
> Not seeing why the enum helps much here.

Alright..

>=20
> > +};
> > +
> > +static int ad9739a_oper_mode_get(struct iio_dev *indio_dev,
> > +				 const struct iio_chan_spec *chan)
> > +{
> > +	struct ad9739a_state *st =3D iio_priv(indio_dev);
> > +	u32 mode;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(st->regmap, AD9739A_REG_DEC_CNT, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mode =3D FIELD_GET(AD9739A_DAC_DEC, mode);
> > +	/* sanity check we get valid values from the HW */
> > +	if (mode !=3D AD9739A_NORMAL_MODE && mode !=3D AD9739A_MIXED_MODE)
> > +		return -EIO;
> > +	if (!mode)
> > +		return AD9739A_NORMAL_MODE;
> > +
> > +	return AD9739A_MIXED_MODE - 1;
>=20
> As below. I'd like to see a mapping function, or lookup table or similar
> rather than handling this conversion in code.
>=20
> > +}
> > +
> > +static int ad9739a_oper_mode_set(struct iio_dev *indio_dev,
> > +				 const struct iio_chan_spec *chan, u32 mode)
> > +{
> > +	struct ad9739a_state *st =3D iio_priv(indio_dev);
> > +
> > +	if (mode =3D=3D AD9739A_MIXED_MODE - 1)
> > +		mode =3D AD9739A_MIXED_MODE;
>=20
> Why?=C2=A0 Feels like a comment is needed. Or a more obvious conversion f=
unction.
>=20

To match what we want to write in the register... With just two values it's=
 too
simple that opt not to have any helper function or table. Would you be fine=
 with a
comment?

> > +
> > +	return regmap_update_bits(st->regmap, AD9739A_REG_DEC_CNT,
> > +				=C2=A0 AD9739A_DAC_DEC, mode);
> > +}
> > +
> > +static int ad9739a_read_raw(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> > +{
> > +	struct ad9739a_state *st =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val =3D st->sample_rate;
> > +		*val2 =3D 0;
> > +		return IIO_VAL_INT_64;
>=20
> Big numbers :)

My setup is using 2.5Ghz which is big enough to overflow INT but would work=
 on UINT.
>=20

> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
>=20
>=20
> > +
> > +/*
> > + * Recommended values (as per datasheet) for the dac clk common mode v=
oltage
> > + * and Mu controller. Look at table 29.
> > + */
> > +static const struct reg_sequence ad9739a_clk_mu_ctrl[] =3D {
> > +	/* DAC clk common mode voltage */
> > +	{AD9739A_REG_CROSS_CNT1, 0x0f},
> 	{ AD9739A_REG_CROSS_CNT1, 0x0f },
> etc is more readable in my opinion so is always my preference in IIO.
>=20
> > +	{AD9739A_REG_CROSS_CNT2, 0x0f},
> > +	/* Mu controller configuration */
> > +	{AD9739A_REG_PHS_DET, 0x30},
> > +	{AD9739A_REG_MU_DUTY, 0x80},
> > +	{AD9739A_REG_MU_CNT2, 0x44},
> > +	{AD9739A_REG_MU_CNT3, 0x6c},
> > +};
> > +
> > +static int ad9739a_init(struct device *dev, const struct ad9739a_state=
 *st)
> > +{
> > +	unsigned int i =3D 0, lock, fsc;
> > +	u32 fsc_raw;
> > +	int ret;
> > +
> > +	ret =3D regmap_multi_reg_write(st->regmap, ad9739a_clk_mu_ctrl,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(ad9739a_clk_mu_ctrl));
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Try to get the MU lock. Repeat the below steps AD9739A_LOCK_N_TRIE=
S
> > +	 * (as specified by the datasheet) until we get the lock.
> > +	 */
> > +	do {
> > +		ret =3D regmap_write(st->regmap, AD9739A_REG_MU_CNT4,
> > +				=C2=A0=C2=A0 AD9739A_MU_CNT4_DEFAULT);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Enable the Mu controller search and track mode. */
>=20
> MU for consistency

ack

>=20
> > +		ret =3D regmap_set_bits(st->regmap, AD9739A_REG_MU_CNT1,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD9739A_MU_EN_MASK);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Ensure the DLL loop is locked */
> > +		ret =3D regmap_read_poll_timeout(st->regmap, AD9739A_REG_MU_STAT1,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock, lock &
> > AD9739A_MU_LOCK_MASK,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1000);
> 		if (ret < 0 && ret !=3D -ETIMEOUT)
> 			return ret;
>=20
> i.e. deal with error codes that don't meant it timed out.
>=20

Oh yes, that makes sense.

> > +	} while (ret && ++i < AD9739A_LOCK_N_TRIES);
> > +
> > +	if (i =3D=3D AD9739A_LOCK_N_TRIES)
> > +		return dev_err_probe(dev, ret, "Mu lock timeout\n");
> > +
> > +	/* Receiver tracking and lock. Same deal as the Mu controller */
>=20
> MU or Mu.=C2=A0 Either fine but be consistent in comments. I have no idea=
 what this is
> so can't say which is better.
>=20
> > +	i =3D 0;
> > +	do {
> > +		ret =3D regmap_update_bits(st->regmap, AD9739A_REG_LVDS_REC_CNT4,
> > +					 AD9739A_FINE_DEL_SKW_MASK,
> > +					 FIELD_PREP(AD9739A_FINE_DEL_SKW_MASK,
> > 2));
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Disable the receiver and the loop. */
> > +		ret =3D regmap_write(st->regmap, AD9739A_REG_LVDS_REC_CNT1, 0);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/*
> > +		 * Re-enable the loop so it falls out of lock and begins the
> > +		 * search/track routine again.
> > +		 */
> > +		ret =3D regmap_set_bits(st->regmap, AD9739A_REG_LVDS_REC_CNT1,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD9739A_RCVR_LOOP_EN_MASK);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Ensure the DLL loop is locked */
> > +		ret =3D regmap_read_poll_timeout(st->regmap,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD9739A_REG_LVDS_REC_STAT9, =
lock,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock =3D=3D
> > AD9739A_RCVR_TRACK_AND_LOCK,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1000);
>=20
> As above, consider other error codes than -ETIMEOUT;
>=20
> > +	} while (ret && ++i < AD9739A_LOCK_N_TRIES);
> > +
> > +	if (i =3D=3D AD9739A_LOCK_N_TRIES)
> > +		return dev_err_probe(dev, ret, "Receiver lock timeout\n");
> > +
> > +	ret =3D device_property_read_u32(dev, "adi,full-scale-microamp", &fsc=
);
> > +	if (ret && ret =3D=3D -EINVAL)
> > +		return 0;
> > +	if (ret)
> > +		return ret;
> > +	if (!in_range(fsc, AD9739A_FSC_MIN, AD9739A_FSC_RANGE))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid full scale current(%u) [%u %u]\n=
",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 fsc, AD9739A_FSC_MIN, AD9739A_FSC_MAX);
> > +	/*
> > +	 * IOUTFS is given by
> > +	 *	Ioutfs =3D 0.0226 * FSC + 8.58
> > +	 * and is given in mA. Hence we'll have to multiply by 10 * MILLI in
> > +	 * order to get rid of the fractional.
> > +	 */
> > +	fsc_raw =3D DIV_ROUND_CLOSEST(fsc * 10 - 85800, 226);
> > +
> > +	ret =3D regmap_write(st->regmap, AD9739A_REG_FSC_1, fsc_raw & 0xff);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return regmap_update_bits(st->regmap, AD9739A_REG_FSC_1,
> > +				=C2=A0 AD9739A_FSC_MSB, fsc_raw >> 8);
> > +}
>=20
>=20
>=20
> > +
> > +static int ad9739a_probe(struct spi_device *spi)
> > +{
> > +	struct device *dev =3D &spi->dev;
> > +	struct iio_dev *indio_dev;
> > +	struct ad9739a_state *st;
> > +	unsigned int id;
> > +	struct clk *clk;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +
> > +	clk =3D devm_clk_get_enabled(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return dev_err_probe(dev, PTR_ERR(clk), "Could not get
> > clkin\n");
> > +
> > +	st->sample_rate =3D clk_get_rate(clk);
> > +	if (!in_range(st->sample_rate, AD9739A_MIN_DAC_CLK,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD9739A_DAC_CLK_RANGE))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid dac clk range(%lu) [%lu %lu]\n",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 st->sample_rate, AD9739A_MIN_DAC_CLK,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 AD9739A_MAX_DAC_CLK);
> > +
> > +	st->regmap =3D devm_regmap_init_spi(spi, &ad9739a_regmap_config);
> > +	if (IS_ERR(st->regmap))
> > +		return PTR_ERR(st->regmap);
> > +
> > +	ret =3D regmap_read(st->regmap, AD9739A_REG_ID, &id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (id !=3D AD9739A_ID)
> > +		return dev_err_probe(dev, -ENODEV, "Unrecognized CHIP_ID 0x%X",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 id);
> Do we have to give up here?=C2=A0 Could it be a compatible future part?
> If so we should fallback on what firmware told us it was + perhaps a
> dev_info() to say we don't recognise the ID register value.
>=20

I typically prefer to really give up in these cases but no strong opinion..=
. Can turn
this into a dev_warn()...

- Nuno S=C3=A1


