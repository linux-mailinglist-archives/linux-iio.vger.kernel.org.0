Return-Path: <linux-iio+bounces-5813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7748FC690
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 10:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3069C285866
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF74A11;
	Wed,  5 Jun 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtZzXHXj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079841946A1;
	Wed,  5 Jun 2024 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576487; cv=none; b=unkAc4iN0/3/BovnmR2D95O4xb2aryRd6yLvWxdZGzxYDRtZTuwoyjIJJTDRkZAE/eA3CGqV6HgdZjk5CvnLlQHfbJ9w8kdXfR08dtUR9FqEiQ7tePAUYBzNWqDX3yaGMK4dmDAiDXsglCFmqALkG4bl1uZAiqi56VtOr0+Jal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576487; c=relaxed/simple;
	bh=8tub/dq8Y5Q6ruH9V24XLrhs/lz6AhQ7gjdxdBmwEs0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoNgruTsupMkI8eaU0aYyhicThlmqeVToZVEV8PBytQ8RkPACTfClaQireFxp8hN//jKLY1zkfRsAFVObdRQYpLu5uTw18vcNjTfJsOATxa3fODK7ECNDv3b7Hm8apGeyTU76U8/9KtjNqQ9b0xj1xGZgFF6vLkTJ1hwWnCSRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtZzXHXj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68fc86acfaso105747066b.1;
        Wed, 05 Jun 2024 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717576484; x=1718181284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXTVAvomi+GcMNTA33Njw+J/KuHjIHiARYW73adHZhA=;
        b=PtZzXHXjKZzb3OLnSK82ZXf+4vSA+KierM//Ao9mSAgDm+TVNztTKomF5MHSjnmUcQ
         GTUT/a9C70R15wJOoy0qX/G4sB3LirrnZAjBzC0dXzPTEw1ZsJoPeysG+dkCgo6no4lN
         moehbpxQvaNhQgEcmGWBw/R8CSrXbKf2gl4s5YdC/KNlsqKOaOPxQKmfO8aCUma+JXMJ
         yZUawM4ePpSvJR4UFuPwG3aYEQokWTqUQH8Oa5YQCrblRquTk3oTB6BFfZgQfdQgNVd6
         5+pSWUJ1A3FMQhxR8ajWeVbji7HrcxgacHjOZ/PlXkw2QznH/6OAP3PJMKh9OO264RSq
         acPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576484; x=1718181284;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXTVAvomi+GcMNTA33Njw+J/KuHjIHiARYW73adHZhA=;
        b=cHk3bxdiG0LZwmEYyk6NI/D8rbAvnGxoXTWWWuGNf0ZjOyyrBiEacX+xYa75Vz+//i
         uRXN6m/fSh8qFJyqOztekObVhQDub6vNGq3FdbCFHioAfy94shC8MrE+Y3rLCFcdUk3o
         Nu53sI7NvJeQgZXiDZuWJS3LTAYC8catyS5Y3DhCDunuD6ti/slhVNE5wBIF0GdbT2XL
         pHEYpCCiCO5Knttpl1NcQyz8ZDo93W6Rz3BpQRmQc8WlANgTJEePCosewETXzaJxha7f
         DzVNyBb/dKJpDKyzFeugPptUssJy7POBvUQE8VdT5Tav19sD0yscMFQduecn6vQI39WZ
         kL9A==
X-Forwarded-Encrypted: i=1; AJvYcCX0YhJehfvYaw7WKCH8KZdsHB6VJEDuBhlujP2Re05SPVgDz5rCQIaDovGYvKkKKgn/nsm9vcXglVdPeVyftBKuZWAyV7Jw549CVDezazqMHSEOdn1Ps4+fFvaxbn4yONODj1NjSCHKEYQPnYshkeD8zZH0Wz6qYxPfsWwKaSE7TPoqxw==
X-Gm-Message-State: AOJu0YxLe1dYnvWlw1pK6bga86MNRvfY9tE3OlwFVUhcZbdcmSBUtWu1
	1xMbHc8WFzcfvcAfs1oEqFdry29ZEagKXJhSeZw5dD4a3pEkgvdl
X-Google-Smtp-Source: AGHT+IHgtYNraahDjvpDbChpLJT7frY7o8BT6Cu/M37rZy3FCtqIpojRwaHZxveOXVDIB2EiyWYrpQ==
X-Received: by 2002:a17:907:77c5:b0:a69:e07:c81 with SMTP id a640c23a62f3a-a69543cea4cmr398095966b.19.1717576484227;
        Wed, 05 Jun 2024 01:34:44 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a69097bf6bbsm412239666b.110.2024.06.05.01.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:34:43 -0700 (PDT)
Message-ID: <f4adedf90d8d14671335071a305335ed7ffcde8b.camel@gmail.com>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7192: Fix clock config
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Alexandru Tachici
 <alexandru.tachici@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Date: Wed, 05 Jun 2024 10:38:30 +0200
In-Reply-To: <20240605075154.625123-3-alisa.roman@analog.com>
References: <20240605075154.625123-1-alisa.roman@analog.com>
	 <20240605075154.625123-3-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-05 at 10:51 +0300, Alisa-Dariana Roman wrote:
> There are actually 4 configuration modes of clock source for AD719X
> devices. Either a crystal can be attached externally between MCLK1 and
> MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
> pin. The other 2 modes make use of the 4.92MHz internal clock, which can
> be made available on the MCLK2 pin.
>=20
> Rename mclk to ext_clk for clarity.
>=20
> Note that the fix tag is for the commit that moved the driver out of
> staging.
>=20
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7192.c | 153 ++++++++++++++++++++++++++++++------=
---
> =C2=A01 file changed, 119 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index f06cb7ac4b42..75b0724142b1 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/slab.h>
> @@ -202,7 +203,8 @@ struct ad7192_state {
> =C2=A0	const struct ad7192_chip_info	*chip_info;
> =C2=A0	struct regulator		*avdd;
> =C2=A0	struct regulator		*vref;
> -	struct clk			*mclk;
> +	struct clk			*ext_clk;
> +	struct clk_hw			int_clk_hw;
> =C2=A0	u16				int_vref_mv;
> =C2=A0	u32				aincom_mv;
> =C2=A0	u32				fclk;
> @@ -398,27 +400,6 @@ static inline bool ad7192_valid_external_frequency(u=
32
> freq)
> =C2=A0		freq <=3D AD7192_EXT_FREQ_MHZ_MAX);
> =C2=A0}
> =C2=A0
> -static int ad7192_clock_select(struct ad7192_state *st)
> -{
> -	struct device *dev =3D &st->sd.spi->dev;
> -	unsigned int clock_sel;
> -
> -	clock_sel =3D AD7192_CLK_INT;
> -
> -	/* use internal clock */
> -	if (!st->mclk) {
> -		if (device_property_read_bool(dev, "adi,int-clock-output-
> enable"))
> -			clock_sel =3D AD7192_CLK_INT_CO;
> -	} else {
> -		if (device_property_read_bool(dev, "adi,clock-xtal"))
> -			clock_sel =3D AD7192_CLK_EXT_MCLK1_2;
> -		else
> -			clock_sel =3D AD7192_CLK_EXT_MCLK2;
> -	}
> -
> -	return clock_sel;
> -}
> -
> =C2=A0static int ad7192_setup(struct iio_dev *indio_dev, struct device *d=
ev)
> =C2=A0{
> =C2=A0	struct ad7192_state *st =3D iio_priv(indio_dev);
> @@ -1194,6 +1175,96 @@ static void ad7192_reg_disable(void *reg)
> =C2=A0	regulator_disable(reg);
> =C2=A0}
> =C2=A0
> +static const char *const ad7192_clock_names[] =3D {
> +	"xtal",
> +	"clk"
> +};

This could be moved closer where it will be used...

> +
> +static struct ad7192_state *clk_hw_to_ad7192(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ad7192_state, int_clk_hw);
> +}
> +
> +static void ad7192_clk_disable_unprepare(void *clk)
> +{
> +	clk_disable_unprepare(clk);
> +}
> +
> +static unsigned long ad7192_clk_recalc_rate(struct clk_hw *hw,
> +					=C2=A0=C2=A0=C2=A0 unsigned long parent_rate)
> +{
> +	return AD7192_INT_FREQ_MHZ;
> +}
> +
> +static int ad7192_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +
> +	return st->clock_sel =3D=3D AD7192_CLK_INT_CO;
> +}
> +
> +static int ad7192_clk_prepare(struct clk_hw *hw)
> +{
> +	struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +	int ret;
> +
> +	st->mode &=3D ~AD7192_MODE_CLKSRC_MASK;
> +	st->mode |=3D AD7192_CLK_INT_CO;
> +
> +	ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +	if (ret)
> +		return ret;
> +
> +	st->clock_sel =3D AD7192_CLK_INT_CO;
> +
> +	return 0;
> +}
> +
> +static void ad7192_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +	int ret;
> +
> +	st->mode &=3D ~AD7192_MODE_CLKSRC_MASK;
> +	st->mode |=3D AD7192_CLK_INT;
> +
> +	ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +	if (ret)
> +		return;
> +
> +	st->clock_sel =3D AD7192_CLK_INT;
> +}
> +
> +static const struct clk_ops ad7192_int_clk_ops =3D {
> +	.recalc_rate =3D ad7192_clk_recalc_rate,
> +	.is_enabled =3D ad7192_clk_output_is_enabled,
> +	.prepare =3D ad7192_clk_prepare,
> +	.unprepare =3D ad7192_clk_unprepare,
> +};
> +
> +static int ad7192_register_clk_provider(struct iio_dev *indio_dev)
> +{
> +	struct ad7192_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +	struct fwnode_handle *fwnode =3D dev_fwnode(dev);
> +	struct clk_init_data init =3D {};
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
> +
> +	init.name =3D fwnode_get_name(fwnode);
> +	init.ops =3D &ad7192_int_clk_ops;
> +
> +	st->int_clk_hw.init =3D &init;
> +	ret =3D devm_clk_hw_register(dev, &st->int_clk_hw);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					=C2=A0=C2=A0 &st->int_clk_hw);
> +}

The above code is unrelated... Should be in another patch (also needs chang=
es in
the bindings). It's also a new feature which does not match much with the s=
eries
subject :)

> +
> =C2=A0static int ad7192_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct device *dev =3D &spi->dev;
> @@ -1312,20 +1383,34 @@ static int ad7192_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	st->fclk =3D AD7192_INT_FREQ_MHZ;
> =C2=A0
> -	st->mclk =3D devm_clk_get_optional_enabled(dev, "mclk");
> -	if (IS_ERR(st->mclk))
> -		return PTR_ERR(st->mclk);
> +	ret =3D device_property_match_property_string(dev, "clock-names",
> +						=C2=A0=C2=A0=C2=A0 ad7192_clock_names,
> +						=C2=A0=C2=A0=C2=A0
> ARRAY_SIZE(ad7192_clock_names));
> +	if (ret < 0) {
> +		st->clock_sel =3D AD7192_CLK_INT;
> +		st->fclk =3D AD7192_INT_FREQ_MHZ;
> =C2=A0
> -	st->clock_sel =3D ad7192_clock_select(st);
> +		ret =3D ad7192_register_clk_provider(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Registration of clock provider
> failed\n");
> +	} else {
> +		st->clock_sel =3D AD7192_CLK_EXT_MCLK1_2 + ret;
> =C2=A0
> -	if (st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK1_2 ||
> -	=C2=A0=C2=A0=C2=A0 st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK2) {
> -		st->fclk =3D clk_get_rate(st->mclk);
> -		if (!ad7192_valid_external_frequency(st->fclk)) {
> -			dev_err(dev,
> -				"External clock frequency out of bounds\n");
> -			return -EINVAL;
> -		}
> +		st->ext_clk =3D devm_clk_get_enabled(dev,
> ad7192_clock_names[ret]);
> +		if (IS_ERR(st->ext_clk))
> +			return PTR_ERR(st->ext_clk);
> +
> +		ret =3D devm_add_action_or_reset(dev,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7192_clk_disable_unprepare,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->ext_clk);

No need for this... Check what devm_clk_get_enabled() is doing :)

> +		if (ret)
> +			return ret;
> +
> +		st->fclk =3D clk_get_rate(st->ext_clk);
> +		if (!ad7192_valid_external_frequency(st->fclk))
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "External clock frequency out of
> bounds\n");

Maybe the above could be placed in a proper setup function... Like renaming
ad7192_clock_select() -> ad7192_clock_setup()?


One other thing is, if this is a fix, then it should come first in the seri=
es.
The reasoning is that we may want to backport the fix but there's no reason=
 to
backport unneeded patches like your first patch that's only about cosmetics=
.

- Nuno S=C3=A1

