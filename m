Return-Path: <linux-iio+bounces-26263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9BC62E78
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 09:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085573B1206
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6F131BCB6;
	Mon, 17 Nov 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Untafpcb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1431A571
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368466; cv=none; b=BFuNjGkno2fSiq4Q0waBlpcp3+SPJcFaPdvbqAzzCmADwS6MASJAiBxj9wPmLLAvoMS/6poKQaXW/xiMApvwC/HdoBblJs4SDEttIOlUx+ck0mqu8FBQKWO7OpWsllBJ7/TOxhaEtnxghZOQ59vJ3tTIszGE+R84plgizoqXmO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368466; c=relaxed/simple;
	bh=/w8+cOPPoQCGSAG/Bsdo816ahLwOpNRu9TtyqYsIsBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iiS07+64pZnZ5uK/s7Dq50AsjLvpYfzsJs7PE7BlQx94w3E1Rzlm7anz7OqbFWw7+NwmCsWOW8XOuOMCcPgtX5mTr1sUv+3BuVaz7QxVJCPBY8twuD10Re4ZUlkrt7g7soiJs0d+NYYzfIJVdjkh6pzWLn3yMffaiVkFgvwdHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Untafpcb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c48e05aeso2358927f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763368463; x=1763973263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bPqgK8cy9cCPRdd19hJcNNNEYGuuQbqc8vWqHqOTZkk=;
        b=UntafpcbeRfDn6U/xt6rO/r+TgrcWw13BZoGD4ixhRtK09N/MOX9tlR/Eg1xmT0Jdq
         vdCG3qHV+Zbi8qGR118XLVnNRJsgCtU2thpapis/4QQM3Nq3E4p1hjX6dkxnuKd2lEEa
         jMQ+zyC0Z3PjaMf2L7TLj0HChI/aAPV5JGswYchoYZ16PVuVZQBO0hB1R8Pk2f53JLj0
         +Jp67Mj8ICmj3OtIJx+aLULwqqLQXoJ/CbYGUHxg8TcGs+/A8COIsyvXWM2DYMb3TMGq
         edxRB1UQ/1mRzLdHdZscaUShUhlC7pOuraH79bLE5kL82ex7u1p7LTmf/TuVuI5Ii5FW
         FHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763368463; x=1763973263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPqgK8cy9cCPRdd19hJcNNNEYGuuQbqc8vWqHqOTZkk=;
        b=HTLbT7CPeeTKM4Sa4GvLTmxcPthEdsUEaShfGFyeabe+R/LtcDR758tJhj9rLUj5zY
         Bhj+EeutzlCeq/laif/O0iNV9G9OThJYF8v4TsUgpIYb5KGhbvxKjGhxjHXkrBlhpCNF
         F7ZH/ZAwrgJkC8Wnl/ZF5lyvsCbNAJpdGUy799wF+9W2yoL8iwDt+baieTMg5hxlYAzB
         iAGUT9/VqVjzeTtiOernGEYbxn49bOduQmBCARLYCHPA9GGwFtABMHS30LVSmQ8gCnO6
         yUWmk/o5uleLi84kfkMQuBON/evqB/jmLELliJzizP5Sb9H2QXzkJKB/dhkQtEwRBduu
         l5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhxByA+vcPzQBOSXpxvIe2XO2SbRxCXcIU67roZOAEJP2zCUS/if54SsTVC50V94SgQuJU+iWU+hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4NxU/GSEEWx5cvzcvRZr3KrlSFKqtPDJ/ZOveju7n4Po9c5g
	xuHtp36GZGnVaQ9zvmkB2V1XJY1/v7X2iWbXkjMc0aETUUOYfGx5x6V6
X-Gm-Gg: ASbGncuBX39Ss23tDBLd56Z43KTgVYuHk7TSpU+y0p4BNlcsXbj3iXFRniu8FXWi597
	e2AoEnDoyi8Seel7YgrC72quTEA2xdE0XwTNR128f3xhcx9gSPiLhNsGlAatNdFOMWZ4F0eNmtS
	REgmbOwn+j30LrDKRMAt3P67hOP5kpqGaPMXue9cYCSuhoz8f1H85ZTMWfguRv+/wXgjp8YDu7d
	9vhrhhZ7M2i6wi4cOorsxBzcWH2gQ4sCixcKQnBhuegNGiKzNoWk31ClSNXv7guJq2ht5qkoZCg
	7wVtW6lwJhdjSKob5tm+/ys94DZrGiN4fT5J047CQhBG2xFF5Volxvc+4ZMV5JFU3S9feYqlp5V
	SS5fIzbHgjW5jpUtV6i6vKTp6lx0x7z0dyeujScw+p5JKN/o0nc9rxcuKmOhvMWoBkrgDTkQt0x
	/iZtWsngq/b/JYLvHLiMUxGnfYSZpzkfm+eRAgokFuooyAToEydMqkwwtchbM=
X-Google-Smtp-Source: AGHT+IHntRTwsme03+6WMxIwVdcfrJhadXkeJJU2b3wpprfCD5Jds7oFoJy6WDNSAMQdfKqDWAF/RQ==
X-Received: by 2002:a05:6000:200c:b0:426:fb27:974a with SMTP id ffacd0b85a97d-42b52844e62mr14456258f8f.27.1763368462599;
        Mon, 17 Nov 2025 00:34:22 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f19aa0sm24961371f8f.37.2025.11.17.00.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 00:34:22 -0800 (PST)
Message-ID: <691267ecaa66a0f6a07ec79000b80de502d9b367.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: frequency: adf4377: add clk provider support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Date: Mon, 17 Nov 2025 08:35:23 +0000
In-Reply-To: <20251115172407.2c00d58c@jic23-huawei>
References: <20251114120908.6502-1-antoniu.miclaus@analog.com>
		<20251114120908.6502-3-antoniu.miclaus@analog.com>
	 <20251115172407.2c00d58c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-15 at 17:24 +0000, Jonathan Cameron wrote:
> On Fri, 14 Nov 2025 12:09:08 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add clk provider feature for the adf4377.
> >=20
> > Even though the driver was sent as an IIO driver in most cases the
> > device is actually seen as a clock provider.
> >=20
> > This patch aims to cover actual usecases requested by users in order to
> > completely control the output frequencies from userspace.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>=20
> Given this new code is basically a clock driver, I'd expect to see some
> relevant folk +CC.
>=20
> Added Michael, Stephen and linux-clk.
>=20
> One question from me right at the end around whether it makes sense
> to register an IIO device with no channels.=C2=A0 I left the rest so it w=
as
> easy for the people added to the thread to see all the code.
>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
> > ---
> > =C2=A0drivers/iio/frequency/adf4377.c | 131 +++++++++++++++++++++++++++=
++++-
> > =C2=A01 file changed, 129 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/ad=
f4377.c
> > index 08833b7035e4..08dc2110cf8c 100644
> > --- a/drivers/iio/frequency/adf4377.c
> > +++ b/drivers/iio/frequency/adf4377.c
> > @@ -8,6 +8,7 @@
> > =C2=A0#include <linux/bitfield.h>
> > =C2=A0#include <linux/bits.h>
> > =C2=A0#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > =C2=A0#include <linux/clkdev.h>
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/device.h>
> > @@ -435,9 +436,14 @@ struct adf4377_state {
> > =C2=A0	struct gpio_desc	*gpio_ce;
> > =C2=A0	struct gpio_desc	*gpio_enclk1;
> > =C2=A0	struct gpio_desc	*gpio_enclk2;
> > +	struct clk		*clk;
> > +	struct clk		*clkout;
> > +	struct clk_hw		hw;
> > =C2=A0	u8			buf[2] __aligned(IIO_DMA_MINALIGN);
> > =C2=A0};
> > =C2=A0
> > +#define to_adf4377_state(h)	container_of(h, struct adf4377_state, hw)
> > +
> > =C2=A0static const char * const adf4377_muxout_modes[] =3D {
> > =C2=A0	[ADF4377_MUXOUT_HIGH_Z] =3D "high_z",
> > =C2=A0	[ADF4377_MUXOUT_LKDET] =3D "lock_detect",
> > @@ -929,6 +935,120 @@ static int adf4377_freq_change(struct notifier_bl=
ock *nb,
> > unsigned long action,
> > =C2=A0	return NOTIFY_OK;
> > =C2=A0}
> > =C2=A0
> > +static void adf4377_clk_del_provider(void *data)
> > +{
> > +	struct adf4377_state *st =3D data;
> > +
> > +	of_clk_del_provider(st->spi->dev.of_node);
> > +}
> > +
> > +static unsigned long adf4377_clk_recalc_rate(struct clk_hw *hw,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long parent_rate)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +	u64 freq;
> > +	int ret;
> > +
> > +	ret =3D adf4377_get_freq(st, &freq);
> > +	if (ret)
> > +		return 0;
> > +
> > +	return freq;
> > +}
> > +
> > +static int adf4377_clk_set_rate(struct clk_hw *hw,
> > +				unsigned long rate,
> > +				unsigned long parent_rate)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +
> > +	return adf4377_set_freq(st, rate);
> > +}
> > +
> > +static int adf4377_clk_prepare(struct clk_hw *hw)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +
> > +	return regmap_update_bits(st->regmap, 0x1a, ADF4377_001A_PD_CLKOUT1_M=
SK
> > |
> > +				=C2=A0 ADF4377_001A_PD_CLKOUT2_MSK,
> > +				=C2=A0 FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
> > +				=C2=A0 FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
> > +}
> > +
> > +static void adf4377_clk_unprepare(struct clk_hw *hw)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +
> > +	regmap_update_bits(st->regmap, 0x1a, ADF4377_001A_PD_CLKOUT1_MSK |
> > +			=C2=A0=C2=A0 ADF4377_001A_PD_CLKOUT2_MSK,
> > +			=C2=A0=C2=A0 FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 1) |
> > +			=C2=A0=C2=A0 FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 1));
> > +}
> > +
> > +static int adf4377_clk_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct adf4377_state *st =3D to_adf4377_state(hw);
> > +	unsigned int readval;
> > +	int ret;
> > +
> > +	ret =3D regmap_read(st->regmap, 0x1a, &readval);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return !(readval & (ADF4377_001A_PD_CLKOUT1_MSK |
> > ADF4377_001A_PD_CLKOUT2_MSK));
> > +}
> > +
> > +static const struct clk_ops adf4377_clk_ops =3D {
> > +	.recalc_rate =3D adf4377_clk_recalc_rate,
> > +	.set_rate =3D adf4377_clk_set_rate,
> > +	.prepare =3D adf4377_clk_prepare,
> > +	.unprepare =3D adf4377_clk_unprepare,
> > +	.is_enabled =3D adf4377_clk_is_enabled,
> > +};
> > +
> > +static int adf4377_clk_register(struct adf4377_state *st)
> > +{
> > +	struct spi_device *spi =3D st->spi;
> > +	struct clk_init_data init;
> > +	struct clk *clk;
> > +	const char *parent_name;
> > +	int ret;
> > +
> > +	if (!device_property_present(&spi->dev, "#clock-cells"))
> > +		return 0;
> > +
> > +	if (device_property_read_string(&spi->dev, "clock-output-names",
> > &init.name)) {
> > +		init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> > +					=C2=A0=C2=A0 fwnode_get_name(dev_fwnode(&spi-
> > >dev)));
> > +		if (!init.name)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> > +	if (!parent_name)
> > +		return -EINVAL;
> > +
> > +	init.ops =3D &adf4377_clk_ops;
> > +	init.parent_names =3D &parent_name;
> > +	init.num_parents =3D 1;
> > +	init.flags =3D CLK_SET_RATE_PARENT;
> > +
> > +	st->hw.init =3D &init;
> > +	clk =3D devm_clk_register(&spi->dev, &st->hw);
> > +	if (IS_ERR(clk))
> > +		return PTR_ERR(clk);
> > +
> > +	st->clk =3D clk;
> > +
> > +	ret =3D of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get, =
clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->clkout =3D clk;
> > +
> > +	return devm_add_action_or_reset(&spi->dev, adf4377_clk_del_provider,
> > st);
> > +}
> > +
> > =C2=A0static const struct adf4377_chip_info adf4377_chip_info =3D {
> > =C2=A0	.name =3D "adf4377",
> > =C2=A0	.has_gpio_enclk2 =3D true,
> > @@ -958,8 +1078,6 @@ static int adf4377_probe(struct spi_device *spi)
> > =C2=A0
> > =C2=A0	indio_dev->info =3D &adf4377_info;
> > =C2=A0	indio_dev->name =3D "adf4377";
> > -	indio_dev->channels =3D adf4377_channels;
> > -	indio_dev->num_channels =3D ARRAY_SIZE(adf4377_channels);
> > =C2=A0
> > =C2=A0	st->regmap =3D regmap;
> > =C2=A0	st->spi =3D spi;
> > @@ -979,6 +1097,15 @@ static int adf4377_probe(struct spi_device *spi)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > +	ret =3D adf4377_clk_register(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!st->clkout) {
> > +		indio_dev->channels =3D adf4377_channels;
> > +		indio_dev->num_channels =3D ARRAY_SIZE(adf4377_channels);
>=20
> Why register a channel free iio device? Probably better to just not regis=
ter
> it at all in this path.

Maybe a sneaky way of making use of the IIO debug direct access :). But I a=
lready
asked myself the somehow related question if we should still allow IIO acce=
ss even if
the clock provider is registered. I mean, for sure we would need a more "fi=
ne"
grained access but we could only forbid IIO/userspace control in case an ac=
tual
consumer of the clock asks for it.

Or maybe not worth the trouble :)

- Nuno S=C3=A1

>=20
> > +	}
> > +
> > =C2=A0	return devm_iio_device_register(&spi->dev, indio_dev);
> > =C2=A0}
> > =C2=A0

