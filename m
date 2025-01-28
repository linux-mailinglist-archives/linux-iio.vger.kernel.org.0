Return-Path: <linux-iio+bounces-14675-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606DEA20B46
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 14:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7017A18CC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194201A4F12;
	Tue, 28 Jan 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HI3ZxLCN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8801A08A6;
	Tue, 28 Jan 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070731; cv=none; b=bspV6BFRP4y6NSbqpuSuMaoWgs4GhKGtUBGaznvqpKiLwRa46+1pXqrMUlgfNysosP+tSjCIhN8wMi55DhaDauTu4Io370RrhborFatgVpZIbdx+pAfseiMYLKsIRi6k/HF+lYe68lizFEWw87XQ/jAlILT5qg3jrUhGrEMqXnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070731; c=relaxed/simple;
	bh=DwngvkDtmiidgGC6O0oRy2qZpig8ZfH1v309bHtBkZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a0yeFVYryz4iZKi+6xp+lzpeYunjQlQ1foLSiqs5TuSY8w82ojtNB7Kx2v3Fsw3reTTse/tMPQpDdAuj2Kwq3raYg+iL2gL+sfcktHYnJvsMuWFUt1MiB2J/zYXaQHpC1j/+cG0It8tNd69VUMe/wGjBia47PVQodkRzhRifykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HI3ZxLCN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43675b1155bso64292945e9.2;
        Tue, 28 Jan 2025 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738070728; x=1738675528; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ldqGqgrHhfrhx8jVIdejzGqWxglEXRFIs93LlUOq6wA=;
        b=HI3ZxLCNrZyse5BugSgJlMPgg8LtbQ9r5pUd06VGGHDZb2NAviozweKAm/GyrcAbLe
         czQ9LWvnFp8UIhEXuH+6HaLa2+8lrbwLhStjGKcH7lxmolIMJeSeLNKYvx9mzBVqJdy8
         QKBcytL5o++mTFFKzCDYMd8iplsDZh3Avyv73ikesrVZoP4EJkGZtiWxVA5kXpojvi/b
         a1lZe5pRBXDLyx7KTJ+GcTxAdj43IZEa6CUlIASNjtn/DN0SrNsCZ2GVtqCEEBMySlGc
         3F/c4cNcliKOzkfOafmFCjw0mvVf0mt9QvOLlp546TUsodOP264ZHFTZWfrbMnPqL4iV
         V/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738070728; x=1738675528;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldqGqgrHhfrhx8jVIdejzGqWxglEXRFIs93LlUOq6wA=;
        b=Bo26NbkFCoLA/47htmcY8RlYps53oMVa/TZscGLA1TgWs3B8fvVPTjTcViJd9qq9Cj
         BCODPIFGphhGC4qVek/gEaxSSQVlPbx/jsOJLFYBPJyD1N1Ra8yDBVI7hcVm/ayR2x1N
         vghGcQuwiAmtQrsyADNH/hdOU4y5ubVGIZ6xS2ckXlnveSiYl3TeZ8LCwsxDphl9MSl3
         QWeXmcXT4XrI+AEbEZO3DdfM4mhqiUZ9uxJnMFGLFAJcuhzt9rsqZ/lPQzHS2/UqwzM0
         Y8n9z3S7gss8H/HVK+GHtYcKvk/sM66rqbQPyNhtxb/X/YuiZnkqfxDgR/dqwcIisQ4C
         S/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3MYPyQDqCrDq2KTJq0S5sIirrIWVFljKLj+UZ3ZeqkOZ3OngZUoxV3I+wp3Oe2JxXHqfwTzSo8MONtKvF@vger.kernel.org, AJvYcCVjSlXyBoIy2jSTO+TvzGUcYyn7Cnl9AZZ+1/sxOnITahzNnc7EtQKhumLwND/OYHawnRKFBNIxYNvY@vger.kernel.org, AJvYcCVusN20Gw6qpD9P6r6SXgT4nmYtWjlyCDGjuuDz5PWhMXepCzDj/1+R2sikmrL7LYfbd3nH5A5gmu99@vger.kernel.org
X-Gm-Message-State: AOJu0YypIIDalXh2SIZdQ9B9le75EjGgrGoXpLrJ391RO/mUdQ7TCDcd
	3HKkr6Z4JwvKD2+Ups5e2Q6QenyPSleIDhq8I7UNN3my6C91Q/Wy
X-Gm-Gg: ASbGnctXX4TQAx9x16pXzKKTSHJ76KCVFBO9lcSsNc/HS/Gms/nJCy1oh148NOPbwj5
	o3PZjpvGKCJH02qW+AHZHHRwfM9UbSrw7p/fdX/EVX2NKevHt3VF63lUqOVVH1bY+7dqK4sYHfX
	RAiS7ReEX/8IRy5G9imqn/+ira0zNvYQo3npzNERi+uOyzn3LUJ4iyQHCaJUX69RALkVrxWXqG6
	M1qB4tJNjUTsUEU8eyuIbOvBKNoEPKa+X7eyy1S3ewRFuCuFGRq6NuyyJV8/lbb71VKxuMK3lMo
	rJxx55r20WX31V0H2+Ze12tf9HEkF5CEC0LlfVyPjGv7LP30bIi15QkPkKodggS3mXKX4S1kBA=
	=
X-Google-Smtp-Source: AGHT+IFI+c0ORik6d5imU0AytTzyDrDagErZJ/lv0ccE4AKYww3mTtHBcfw9HpZ2Wf1EYuh6TBItNA==
X-Received: by 2002:a05:600c:a07:b0:434:f9c4:a850 with SMTP id 5b1f17b1804b1-438913cb16emr436806825e9.10.1738070727803;
        Tue, 28 Jan 2025 05:25:27 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd501721sm166996955e9.9.2025.01.28.05.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 05:25:27 -0800 (PST)
Message-ID: <648eedbee0e7702eda10034531de4611597cd9f2.camel@gmail.com>
Subject: Re: [PATCH v2 07/16] iio: adc: ad7768-1: convert driver to use
 regmap
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Santos
	 <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, 	jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, 	jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
Date: Tue, 28 Jan 2025 13:25:28 +0000
In-Reply-To: <9b8204f2-107a-477e-a822-c1649af12d02@baylibre.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
	 <0968f9cfc55c5ac80492a88bbe95fc8ff7208fa5.1737985435.git.Jonathan.Santos@analog.com>
	 <9b8204f2-107a-477e-a822-c1649af12d02@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-27 at 19:29 -0600, David Lechner wrote:
> On 1/27/25 9:12 AM, Jonathan Santos wrote:
> > Convert the AD7768-1 driver to use the regmap API for register
> > access. This change simplifies and standardizes register interactions,
> > reducing code duplication and improving maintainability.
> >=20
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v2 Changes:
> > * New patch in v2.
> > ---
> > =C2=A0drivers/iio/adc/ad7768-1.c | 82 +++++++++++++++++++++++++++------=
-----
> > =C2=A01 file changed, 58 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 95ba89435652..fb8d6fae5f8a 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -12,6 +12,7 @@
> > =C2=A0#include <linux/gpio/consumer.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/module.h>
> > +#include <linux/regmap.h>
> > =C2=A0#include <linux/regulator/consumer.h>
> > =C2=A0#include <linux/sysfs.h>
> > =C2=A0#include <linux/spi/spi.h>
> > @@ -153,6 +154,7 @@ static const struct iio_chan_spec ad7768_channels[]=
 =3D {
> > =C2=A0
> > =C2=A0struct ad7768_state {
> > =C2=A0	struct spi_device *spi;
> > +	struct regmap *regmap;
> > =C2=A0	struct regulator *vref;
> > =C2=A0	struct mutex lock;
> > =C2=A0	struct clk *mclk;
> > @@ -176,12 +178,17 @@ struct ad7768_state {
> > =C2=A0	} data __aligned(IIO_DMA_MINALIGN);
> > =C2=A0};
> > =C2=A0
> > -static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int a=
ddr,
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int len)
> > +static int ad7768_spi_reg_read(void *context, unsigned int addr,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *val)
> > =C2=A0{
> > -	unsigned int shift;
> > +	struct iio_dev *dev =3D context;
> > +	struct ad7768_state *st;
> > +	unsigned int shift, len;
> > =C2=A0	int ret;
> > =C2=A0
> > +	st =3D iio_priv(dev);
>=20
> This can be combined with the variable declaration.
>=20
> > +	/* Regular value size is 1 Byte, but 3 Bytes for ADC data */
>=20
> Probably not currently needed but COEFF_DATA register is also 3 bytes.
>=20
> > +	len =3D (addr =3D=3D AD7768_REG_ADC_DATA) ? 3 : 1;
> > =C2=A0	shift =3D 32 - (8 * len);
> > =C2=A0	st->data.d8[0] =3D AD7768_RD_FLAG_MSK(addr);
> > =C2=A0
> > @@ -190,13 +197,19 @@ static int ad7768_spi_reg_read(struct ad7768_stat=
e
> > *st, unsigned int addr,
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > =C2=A0
> > -	return (be32_to_cpu(st->data.d32) >> shift);
> > +	*val =3D be32_to_cpu(st->data.d32) >> shift;
> > +
> > +	return 0;
> > =C2=A0}
> > =C2=A0
> > -static int ad7768_spi_reg_write(struct ad7768_state *st,
> > +static int ad7768_spi_reg_write(void *context,
> > =C2=A0				unsigned int addr,
> > =C2=A0				unsigned int val)
> > =C2=A0{
> > +	struct iio_dev *dev =3D context;
> > +	struct ad7768_state *st;
> > +
> > +	st =3D iio_priv(dev);
> > =C2=A0	st->data.d8[0] =3D AD7768_WR_FLAG_MSK(addr);
> > =C2=A0	st->data.d8[1] =3D val & 0xFF;
> > =C2=A0
> > @@ -206,16 +219,16 @@ static int ad7768_spi_reg_write(struct ad7768_sta=
te
> > *st,
> > =C2=A0static int ad7768_set_mode(struct ad7768_state *st,
> > =C2=A0			=C2=A0=C2=A0 enum ad7768_conv_mode mode)
> > =C2=A0{
> > -	int regval;
> > +	int regval, ret;
> > =C2=A0
> > -	regval =3D ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
> > -	if (regval < 0)
> > -		return regval;
> > +	ret =3D regmap_read(st->regmap, AD7768_REG_CONVERSION, &regval);
> > +	if (ret)
> > +		return ret;
> > =C2=A0
> > =C2=A0	regval &=3D ~AD7768_CONV_MODE_MSK;
> > =C2=A0	regval |=3D AD7768_CONV_MODE(mode);
> > =C2=A0
> > -	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
> > +	return regmap_write(st->regmap, AD7768_REG_CONVERSION, regval);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int ad7768_scan_direct(struct iio_dev *indio_dev)
> > @@ -234,9 +247,10 @@ static int ad7768_scan_direct(struct iio_dev
> > *indio_dev)
> > =C2=A0	if (!ret)
> > =C2=A0		return -ETIMEDOUT;
> > =C2=A0
> > -	readval =3D ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > -	if (readval < 0)
> > -		return readval;
> > +	ret =3D regmap_read(st->regmap, AD7768_REG_ADC_DATA, &readval);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	/*
> > =C2=A0	 * Any SPI configuration of the AD7768-1 can only be
> > =C2=A0	 * performed in continuous conversion mode.
> > @@ -258,13 +272,11 @@ static int ad7768_reg_access(struct iio_dev
> > *indio_dev,
> > =C2=A0
> > =C2=A0	mutex_lock(&st->lock);
> > =C2=A0	if (readval) {
> > -		ret =3D ad7768_spi_reg_read(st, reg, 1);
> > -		if (ret < 0)
> > +		ret =3D regmap_read(st->regmap, reg, readval);
> > +		if (ret)
> > =C2=A0			goto err_unlock;
>=20
> Can drop the if and goto.
>=20
> > -		*readval =3D ret;
> > -		ret =3D 0;
> > =C2=A0	} else {
> > -		ret =3D ad7768_spi_reg_write(st, reg, writeval);
> > +		ret =3D regmap_write(st->regmap, reg, writeval);
> > =C2=A0	}
> > =C2=A0err_unlock:
> > =C2=A0	mutex_unlock(&st->lock);
> > @@ -283,7 +295,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *=
st,
> > =C2=A0	else
> > =C2=A0		mode =3D AD7768_DIG_FIL_DEC_RATE(dec_rate);
> > =C2=A0
> > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
> > +	ret =3D regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -320,7 +332,7 @@ static int ad7768_set_freq(struct ad7768_state *st,
> > =C2=A0	 */
> > =C2=A0	pwr_mode =3D AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div=
) |
> > =C2=A0		=C2=A0=C2=A0 AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode)=
;
> > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
> > +	ret =3D regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
> > =C2=A0	if (ret < 0)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -447,11 +459,11 @@ static int ad7768_setup(struct ad7768_state *st)
> > =C2=A0	 * to 10. When the sequence is detected, the reset occurs.
> > =C2=A0	 * See the datasheet, page 70.
> > =C2=A0	 */
> > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
> > +	ret =3D regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	ret =3D ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
> > +	ret =3D regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -509,18 +521,19 @@ static int ad7768_buffer_postenable(struct iio_de=
v
> > *indio_dev)
> > =C2=A0	 * continuous read mode. Subsequent data reads do not require an
> > =C2=A0	 * initial 8-bit write to query the ADC_DATA register.
> > =C2=A0	 */
> > -	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
> > +	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
> > =C2=A0{
> > =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> > +	unsigned int regval;
>=20
> Intention could be more clear by calling this "unused". Otherwise, it can=
 look
> like a bug if you don't fully understand what the comment below means.
>=20
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * To exit continuous read mode, perform a single read of the
> > ADC_DATA
> > =C2=A0	 * reg (0x2C), which allows further configuration of the device.
> > =C2=A0	 */
> > -	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> > +	return regmap_read(st->regmap, AD7768_REG_ADC_DATA, &regval);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static const struct iio_buffer_setup_ops ad7768_buffer_ops =3D {
> > @@ -563,6 +576,20 @@ static int ad7768_set_channel_label(struct iio_dev
> > *indio_dev,
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static const struct regmap_bus ad7768_regmap_bus =3D {
> > +	.reg_write =3D ad7768_spi_reg_write,
> > +	.reg_read =3D ad7768_spi_reg_read,
> > +	.reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
> > +	.val_format_endian_default =3D REGMAP_ENDIAN_BIG,
>=20
> The bus read function is calling be32_to_cpu(), so we probably want to re=
move
> that or change the default here.
>=20
> > +};
> > +
> > +static const struct regmap_config ad7768_regmap_config =3D {
> > +	.name =3D "ad7768-1",
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
>=20
> Should this be 24 since the largest registers are 24-bit?
>=20
> Another option could be to just use a regular spi_*() API for that regist=
er
> instead of regmap_*() and avoid trying to do something that regmap doesn'=
t
> really handle.
>=20
> Or we could possibly use regmap_bulk_read(), but that feels a bit hacky t=
oo
> since it isn't actually how that function was intended to be used.
>=20

Hmm I might be missing something but looking at the register map, It seems =
we do
have 8bit registers? We do have values that span multiple registers (3 for =
the
24bit values) and regmap_bulk_read() should actually fit right? I mean, loo=
king
at the docs:

"regmap_bulk_read() - Read multiple sequential registers from the device"

But I do agree that what we have right now does not make much sense. If we =
need
to do

len =3D (addr =3D=3D AD7768_REG_ADC_DATA) ? 3 : 1;

for supporting regmap, then I have to question using it. Also note that we =
have
things like gain and offset that are also 3 bytes which means that our cust=
om
read would need to become more questionable if we add support for it.

Jonathan, did you tried to use plain regmap (without the custom bus)? Assum=
ing
bulk reads work, I'm not seeing an apparent reason for the custom bus... I =
would
also suspect that if bulk reads don't work out of the box, providing a regm=
ap
cache would make it work but relying on implementation details is not a ver=
y
good practice.

Anyways, I would try would normal regmap and if bulk reads don't work I wou=
ld
either:

1) Just do three regmap_reads() for 3byte values;
2) Or do what David suggests and use normal spi_*() and forget about regmap=
.

Either way is fine to me.=20

- Nuno S=C3=A1
>=20


