Return-Path: <linux-iio+bounces-5996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FB900195
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF77288851
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947F8187325;
	Fri,  7 Jun 2024 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ+pqRWn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94852186E38;
	Fri,  7 Jun 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758287; cv=none; b=dbxAo+YBEgNRV1ekjEe3gVawvZ2jjLMsG26iifco3Rpze3Blk2/hhsViKCskYsNXiSTFAMJw0pWis7KMhu2bFfq39z+jH9qx71Sc3M/eWrB9ccaaO0zGI+otPBGkv+PuGSjukSGPrTeDf3qdguGk7NG5XHI8r6d0s2NWxwM83qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758287; c=relaxed/simple;
	bh=3er2UeL8tEF40SAf9XsBp6jxeZiD80h1vL0uTLtytzc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bABltLiKOItCqZyNeySK8b7I69e2FpzapxS7SBPjCsbvRUOgECPduQv3aCAT7kTc/hlXTNYh/V4wP7cfJ6IW8RsZCYHoTtp+ScAS4yv0Dz00QlNaH9mhJJeLGl3uNXv6aQQYq0D/yGTrcU3Y/mRcZinR8UwxuGw+zslj3+DMlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ+pqRWn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so207202366b.1;
        Fri, 07 Jun 2024 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717758284; x=1718363084; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjekk4TvEWDeInc8ylyVqE1ont2pRDjuWBGD45pTYzI=;
        b=ZJ+pqRWnTz7LRiWnBHT2EMg/Nv9HyMF9kWrimEbvR44yWbAJ4vB4cP4K1ULpXkxRe9
         OKgr/LaeHq49n3VCZmLg0iocd8Ur7lW4sg2ayVKPcVdjAAZlbl6fyjjyGXhc4jsKVA8m
         YoKmc1oZK3YdGfSBnxf4dgAba523Yv3Kasf5cZ08keEzYoA+6AbEhYnlmnWjb0/7b1hL
         53pwUf//rudAz8yWTCOVqBOzk87QoU3eJcWVnyMkyfw6udCU1RiUq0nV18TU8VtTpNif
         9uFGqWPv6G3/Covhnz2LwQ9Wu3mSW+vs1byzK101Bx/gTLzLS2QK50AsvvAWkFiS/AJE
         8Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717758284; x=1718363084;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjekk4TvEWDeInc8ylyVqE1ont2pRDjuWBGD45pTYzI=;
        b=Eu88JB114EmOQ19ffES7RdVV7KUs4p2D8ybIz4tikAg3OrYB7RTt47+IEx0QRXOWB6
         A0Hui/iMfFY13LILLvfkZuZoe9nUpelFXCpRuNn9qwMjzrHktXQYVHjTC1tEnS9bWZMe
         JZ6kJYsZkWvWr1Du9RzA4vI6PjU6deHDv/MRusxXNGWaRNoQc1sVXXzHdgUJDhsSQsiR
         TPm4rV6JFVNFCjyO303v/MuLDa1pMbjcGX7b14/RWBEKw5HSEa8DcK426AnauhrzReQ1
         qlVMPhPiqo1SUffZRZjPLZW5BI+4WbNeZ6821YgqCg/r4RqAKXzMMmdQttQnheD3kpY9
         a9gw==
X-Forwarded-Encrypted: i=1; AJvYcCUsYOdrySu46DtYrWHbBLjFEwZe5u9tIEhiWJCt38NyNF01jvHehu8IdIHUqVajrFNf48NpVlN5x2Zupp2eWYTq2PLq/9wblAacM0shfGDPWNzuKcGkKY7lEXK38pXJGomNGQFuIAttH+EeRkmGrv2C5+3i+KWhNXq7nF5kJcv34YFcaA==
X-Gm-Message-State: AOJu0Yya9r9jiMOJI4Oc6MwwRtVrrz+5g5P5i0JGuP032vtL1pGUyygQ
	f//DGpKnXB88cEcq+3hcISTiFMM3FyKfAmQqbXJpQF9OLlvYyaKy
X-Google-Smtp-Source: AGHT+IELglwxS8UZfVGPN3EYGDazK4fEP5qmfTU0F9nfCyELDi09M+UbPTprQSsjyAXJddb+EyHx7g==
X-Received: by 2002:a17:906:48c7:b0:a6a:44d9:7d15 with SMTP id a640c23a62f3a-a6cdb203f7amr140038466b.58.1717758283780;
        Fri, 07 Jun 2024 04:04:43 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805cc280sm230758066b.72.2024.06.07.04.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:04:43 -0700 (PDT)
Message-ID: <751abd157213736e376ca43ef1082362a4ca1149.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: frequency: adf4350: add clk provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 07 Jun 2024 13:08:30 +0200
In-Reply-To: <20240607095806.3299-2-antoniu.miclaus@analog.com>
References: <20240607095806.3299-1-antoniu.miclaus@analog.com>
	 <20240607095806.3299-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 12:57 +0300, Antoniu Miclaus wrote:
> Add clk provider feature for the adf4350.
>=20
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
>=20
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
> =C2=A0- rework commit title
> =C2=A0drivers/iio/frequency/adf4350.c | 129 +++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 129 insertions(+)
>=20
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4=
350.c
> index 4abf80f75ef5..1eb8bce71fe1 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/gpio/consumer.h>
> =C2=A0#include <asm/div64.h>
> =C2=A0#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -31,11 +32,21 @@ enum {
> =C2=A0	ADF4350_PWRDOWN,
> =C2=A0};
> =C2=A0
> +struct adf4350_output {
> +	struct clk_hw hw;
> +	struct iio_dev *indio_dev;
> +};
> +
> +#define to_output(_hw) container_of(_hw, struct adf4350_output, hw)
> +
> =C2=A0struct adf4350_state {
> =C2=A0	struct spi_device		*spi;
> =C2=A0	struct gpio_desc		*lock_detect_gpiod;
> =C2=A0	struct adf4350_platform_data	*pdata;
> =C2=A0	struct clk			*clk;
> +	struct clk			*clkout;
> +	const char			*clk_out_name;
> +	struct adf4350_output		output;
> =C2=A0	unsigned long			clkin;
> =C2=A0	unsigned long			chspc; /* Channel Spacing */
> =C2=A0	unsigned long			fpfd; /* Phase Frequency Detector */
> @@ -264,6 +275,10 @@ static ssize_t adf4350_write(struct iio_dev *indio_d=
ev,
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0	switch ((u32)private) {
> =C2=A0	case ADF4350_FREQ:
> +		if (st->clkout) {
> +			ret =3D clk_set_rate(st->clkout, readin);
> +			break;
> +		}
> =C2=A0		ret =3D adf4350_set_freq(st, readin);
> =C2=A0		break;
> =C2=A0	case ADF4350_FREQ_REFIN:
> @@ -381,6 +396,115 @@ static const struct iio_info adf4350_info =3D {
> =C2=A0	.debugfs_reg_access =3D &adf4350_reg_access,
> =C2=A0};
> =C2=A0
> +static void adf4350_clk_del_provider(void *data)
> +{
> +	struct adf4350_state *st =3D data;
> +
> +	of_clk_del_provider(st->spi->dev.of_node);
> +}
> +
> +static unsigned long adf4350_clk_recalc_rate(struct clk_hw *hw,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long parent_rate)
> +{
> +	struct iio_dev *indio_dev =3D to_output(hw)->indio_dev;
> +	struct adf4350_state *st =3D iio_priv(indio_dev);
> +	unsigned long long tmp;
> +
> +	tmp =3D (u64)(st->r0_int * st->r1_mod + st->r0_fract) * st->fpfd;
> +	do_div(tmp, st->r1_mod * (1 << st->r4_rf_div_sel));
> +
> +	return tmp;
> +}
> +
> +static int adf4350_clk_set_rate(struct clk_hw *hw,
> +				unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	struct iio_dev *indio_dev =3D to_output(hw)->indio_dev;
> +	struct adf4350_state *st =3D iio_priv(indio_dev);
> +
> +	if (parent_rate =3D=3D 0 || parent_rate > ADF4350_MAX_FREQ_REFIN)
> +		return -EINVAL;
> +
> +	st->clkin =3D parent_rate;
> +
> +	return adf4350_set_freq(st, rate);
> +}
> +
> +static int adf4350_clk_prepare(struct clk_hw *hw)
> +{
> +	struct iio_dev *indio_dev =3D to_output(hw)->indio_dev;
> +	struct adf4350_state *st =3D iio_priv(indio_dev);
> +
> +	st->regs[ADF4350_REG2] &=3D ~ADF4350_REG2_POWER_DOWN_EN;
> +
> +	return adf4350_sync_config(st);
> +}
> +
> +static void adf4350_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct iio_dev *indio_dev =3D to_output(hw)->indio_dev;
> +	struct adf4350_state *st =3D iio_priv(indio_dev);
> +
> +	st->regs[ADF4350_REG2] |=3D ADF4350_REG2_POWER_DOWN_EN;
> +
> +	adf4350_sync_config(st);
> +}
> +
> +static int adf4350_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct iio_dev *indio_dev =3D to_output(hw)->indio_dev;
> +	struct adf4350_state *st =3D iio_priv(indio_dev);
> +
> +	return (st->regs[ADF4350_REG2] & ADF4350_REG2_POWER_DOWN_EN);
> +}
> +
> +static const struct clk_ops adf4350_clk_ops =3D {
> +	.recalc_rate =3D adf4350_clk_recalc_rate,
> +	.set_rate =3D adf4350_clk_set_rate,
> +	.prepare =3D adf4350_clk_prepare,
> +	.unprepare =3D adf4350_clk_unprepare,
> +	.is_enabled =3D adf4350_clk_is_enabled,
> +};
> +
> +static int adf4350_clk_register(struct adf4350_state *st)
> +{
> +	struct spi_device *spi =3D st->spi;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	const char *parent_name;
> +	int ret;
> +
> +	if (!device_property_present(&spi->dev, "#clock-cells"))
> +		return 0;
> +
> +	init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> +				=C2=A0=C2=A0 fwnode_get_name(dev_fwnode(&spi->dev)));
> +	device_property_read_string(&spi->dev, "clock-output-names",
> +				=C2=A0=C2=A0=C2=A0 &init.name);
> +
> +	parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> +	if (!parent_name)
> +		return -EINVAL;
> +
> +	init.ops =3D &adf4350_clk_ops;
> +	init.parent_names =3D &parent_name;
> +	init.num_parents =3D 1;
> +
> +	st->output.hw.init =3D &init;
> +	clk =3D devm_clk_register(&spi->dev, &st->output.hw);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret =3D of_clk_add_provider(spi->dev.of_node, of_clk_src_simple_get,
> clk);
> +	if (ret)
> +		return ret;
> +

I totally agree this chip should be a clock provider (maybe it should even =
in
drivers/clk from the beginning) but there's one thing that comes to my mind=
.
Should we still expose the IIO userspace interface in case we register it a=
s a
clock provider?

Sure, we do have clk notifiers in the kernel but I still think it's a sensi=
ble
question :)

I suspect we have another "outliers" in drivers/iio/frequency :)

- Nuno S=C3=A1=20



