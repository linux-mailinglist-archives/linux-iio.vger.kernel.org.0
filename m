Return-Path: <linux-iio+bounces-22715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F87AB25E28
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9BD1887288
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 07:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA596279346;
	Thu, 14 Aug 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThmEnxOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A122D78F;
	Thu, 14 Aug 2025 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158112; cv=none; b=XKHzc32Jnr9+TDK3clW4TMoSKMxdmJSb65V4zWCE2ZZodmb80NPxgkCNk58zFYs/+A+E3Z769m3K9VVV8Ta4UyDDamxazE/TPEh1msOI6ofuLlyzdPdQZLIBEE6Kd6Cl3xSrwtmyTk4Fo64JS6jalFtghtXffGx99tLaLG8gzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158112; c=relaxed/simple;
	bh=Xf6A7tGHBppWxT/EFiw84E3ZJeOlEaCzfvbcx7Dc8Ac=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ue4MxnLmWWot+j4hGv2E+r6Khpe4Mei1xE/xwKRcMU5slWin/V/86yHvo8QFAPqAymQ1mFZJ7CQ2wkaIzblgIhwMwyNbk44MZvkPYcTEDQbt0nup0/7VUWGJKVq5Bep8rSNHzP6f9rMFIXh6IhPJTnck0mI3HBrrfWf75Hz71zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThmEnxOf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9d41c1149so384569f8f.0;
        Thu, 14 Aug 2025 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755158108; x=1755762908; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5d7vpLQTerIqgdSAl9wrlVhC6rbuibMerzNO3mXWhfw=;
        b=ThmEnxOfCqTGoAL9xS1GVpv74VYMKnRymvO0NQK/3VBOppVdRJGwKZ0v6EkbZHpaK6
         8pYCPaaKnXVz5Qdl9wUuGSB334sPqZFUFupDmec4LQXnEDfqkRlLJM0f8Dg8aOUVMeQG
         sFVt4/MHyC7/HP5EI79GNJsOS1EgyC944w7+tySIwI2Q08wKOGAu8VCpDrg2l678+qyv
         SoAY/UYuwpHxKXw5N9FaG5HEoVHqpMTkfX2fhP/O/d9RCRD5pV11nGt6uMNXV6tUNyVd
         L1BBGmffd6KyKqMKsHdKbbCzwgP9hRdqxa0FDvhBixYPbLRrxszVhbUTTfG0cEIvxaQ/
         qNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755158108; x=1755762908;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d7vpLQTerIqgdSAl9wrlVhC6rbuibMerzNO3mXWhfw=;
        b=h208yxyAXUG+mebvPltCp4BhsR78F8k2PnL3U4F0HysnOltFcWr1EpzxS35NCapAwa
         zWQIIf2UkoTjbtaQiyidhYRwWz39T7BiE25Cl3ivT9NmTLN3Xn7LDMHN9awHz7Elqx1q
         Gg/bWAFNatHvr9U4TS/mX0OHz0EXcMh3xMElMZcK5quHUGpcwVUcVCpVnzpF+QSKJcjN
         TM+aCW94NSzG2yWUQU1TnBhcXNsR/9cL9CCOUC9/lE40q7Ym0tNWMYBxAKF4d73WTk7U
         adyHzOvz+UyyfilKurBi0Q2WI5KeythLStp+vLTwcfeMLss10Y2lJ5+cqyulxjfTpQ+Y
         QtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Z2ZPXd3GamCKdVhZeBKTTsi1EH2yEt06VuhZtHcFUH2BP4Bd50zgoJMOSRNEUY/waZUAOYDdlYA2VrMj@vger.kernel.org, AJvYcCUX1+eqnLY7FII+PE+/fTvy0ITdY2Ir+sbXE6cQamv40xxk5IK8MqRmJWEeNDMlbJerj2hBtcoyKmJP@vger.kernel.org, AJvYcCV8gDeZ3VQOinttd3z/jS43HwN10R7ESZQN6P1MUpK6oE4a12qrjutVPJ8y/ToynF/QbEg9nmFz1467@vger.kernel.org
X-Gm-Message-State: AOJu0YzFfwxAgbpCz7DO+o1SzUEUskXpb0I6rCJ4o3ZNK1oSOQHcZuvz
	kEJzcXnR7+DGhGb23Xjcje1UIvKWic/GJb/tOu3f7X2asdgt0+Z4E4z5
X-Gm-Gg: ASbGncvrzsLXCnmjlE/NUx/kPyAACl8yrbA6Dk4pN8jvRH2Y+OfOm6uzx21Epx06BYn
	8ZrY70SFaR1iUfKzniKqJPx9McCeZOQa8yzx9SFynk0ewADeEUXvYedz6haRagVUMq+HGh24njs
	mtKBs3HPWwqgV1rFLDWLFY+NXBvBSSihtqiV0+GthuT5K92n10snWF4IUIDgdb6QjniykC4D4Pd
	6wz0T1P0v8rGedPKsC9tRok89xlzVUdZgXIsXkDaXsI9YGLNT8RBhSc+M+6gsKf3uYit+0hH79F
	IXR9zUVuOCxNgGfk1IoLu7GS0FmWxKqhNDEbNfeFqi41NNfY0DrvHVxdre9RHLe6elIR1fpTiN+
	/CjtXVq9mGgRmjB70jW2ZgM6STxVpKe07H5Lq7zxsN1E5jLMqRcjiRmZRkHHzN/sAxu2y+zXB
X-Google-Smtp-Source: AGHT+IE9sPssjzlgNaveco7sQ0C/rcOqNx7RIOrPIuY/rDCkmE+Gim9FN6X1uXAAh4PeH8VxDX9cYg==
X-Received: by 2002:a05:6000:3111:b0:3b7:b3f2:f8b3 with SMTP id ffacd0b85a97d-3b9fc34c406mr1468699f8f.38.1755158108214;
        Thu, 14 Aug 2025 00:55:08 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1e136360sm5017495e9.18.2025.08.14.00.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:55:07 -0700 (PDT)
Message-ID: <f7aeff222bf0f09dc32784640c81a870c9145320.camel@gmail.com>
Subject: Re: [PATCH 4/4] iio: adc: ad7768-1: add support for ADAQ776x-1 ADC
 Family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jonath4nns@gmail.com
Date: Thu, 14 Aug 2025 07:55:51 +0100
In-Reply-To: <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
	 <f0c1cbc9c2994a90113788cad57df1f32f9db45e.1754617360.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-12 at 23:49 -0300, Jonathan Santos wrote:
> Add support for ADAQ7767/68/69-1 series, which includes PGIA and
> Anti-aliasing filter (AAF) gains.
>=20
> The PGA gain is configured in run-time through the scale attribute,
> if supported by the device. The scale options are updated according
> to the output data width.
>=20
> The AAF gain is configured in the devicetree and it should correspond to
> the AAF channel selected in hardware.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

Hi Jonathan,

Some comments from me...

> =C2=A0drivers/iio/adc/ad7768-1.c | 286 ++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 279 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index d0b9764a8f92..4397d044f5de 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -16,6 +16,7 @@
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/minmax.h>
> =C2=A0#include <linux/module.h>
> +#include <linux/rational.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> =C2=A0#include <linux/regulator/driver.h>
> @@ -98,16 +99,22 @@
> =C2=A0/* AD7768_REG_GPIO_CONTROL */
> =C2=A0#define AD7768_GPIO_UNIVERSAL_EN	BIT(7)
> =C2=A0#define AD7768_GPIO_CONTROL_MSK		GENMASK(3, 0)
> +#define AD7768_GPIO_PGIA_EN		(AD7768_GPIO_UNIVERSAL_EN | GENMASK(2, 0))
> =C2=A0
> =C2=A0/* AD7768_REG_GPIO_WRITE */
> =C2=A0#define AD7768_GPIO_WRITE_MSK		GENMASK(3, 0)
> +#define AD7768_GPIO_WRITE(x)		FIELD_PREP(AD7768_GPIO_WRITE_MSK, x)
> =C2=A0
> =C2=A0/* AD7768_REG_GPIO_READ */
> =C2=A0#define AD7768_GPIO_READ_MSK		GENMASK(3, 0)
> +#define AD7768_GPIO_READ(x)		FIELD_PREP(AD7768_GPIO_READ_MSK, x)
> =C2=A0
> =C2=A0#define AD7768_VCM_OFF			0x07
> =C2=A0#define AD7768_CHAN_INFO_NONE		0
> =C2=A0
> +#define ADAQ776X_GAIN_MAX_NANO		(128 * NANO)
> +#define ADAQ776X_MAX_GAIN_MODES		8
> +
> =C2=A0#define AD7768_TRIGGER_SOURCE_SYNC_IDX 0
> =C2=A0
> =C2=A0#define AD7768_MAX_CHANNELS 1
> @@ -154,6 +161,52 @@ enum ad7768_scan_type {
> =C2=A0	AD7768_SCAN_TYPE_HIGH_SPEED,
> =C2=A0};
> =C2=A0
> +enum {
> +	AD7768_PGA_GAIN_0,
> +	AD7768_PGA_GAIN_1,
> +	AD7768_PGA_GAIN_2,
> +	AD7768_PGA_GAIN_3,
> +	AD7768_PGA_GAIN_4,
> +	AD7768_PGA_GAIN_5,
> +	AD7768_PGA_GAIN_6,
> +	AD7768_PGA_GAIN_7,
> +	AD7768_MAX_PGA_GAIN,
> +};
> +
> +enum {
> +	AD7768_AAF_IN1,
> +	AD7768_AAF_IN2,
> +	AD7768_AAF_IN3,
> +};
> +
> +/* PGA and AAF gains in V/V */
> +static const int adaq7768_gains[7] =3D {
> +	[AD7768_PGA_GAIN_0] =3D 325,	/* 0.325 */
> +	[AD7768_PGA_GAIN_1] =3D 650,	/* 0.650 */
> +	[AD7768_PGA_GAIN_2] =3D 1300,	/* 1.300 */
> +	[AD7768_PGA_GAIN_3] =3D 2600,	/* 2.600 */
> +	[AD7768_PGA_GAIN_4] =3D 5200,	/* 5.200 */
> +	[AD7768_PGA_GAIN_5] =3D 10400,	/* 10.400 */
> +	[AD7768_PGA_GAIN_6] =3D 20800	/* 20.800 */
> +};
> +
> +static const int adaq7769_gains[8] =3D {
> +	[AD7768_PGA_GAIN_0] =3D 1000,	/* 1.000 */
> +	[AD7768_PGA_GAIN_1] =3D 2000,	/* 2.000 */
> +	[AD7768_PGA_GAIN_2] =3D 4000,	/* 4.000 */
> +	[AD7768_PGA_GAIN_3] =3D 8000,	/* 8.000 */
> +	[AD7768_PGA_GAIN_4] =3D 16000,	/* 16.000 */
> +	[AD7768_PGA_GAIN_5] =3D 32000,	/* 32.000 */
> +	[AD7768_PGA_GAIN_6] =3D 64000,	/* 64.000 */
> +	[AD7768_PGA_GAIN_7] =3D 128000	/* 128.000 */
> +};
> +
> +static const int ad7768_aaf_gains[3] =3D {
> +	[AD7768_AAF_IN1] =3D 1000,	/* 1.000 */
> +	[AD7768_AAF_IN2] =3D 364,		/* 0.364 */
> +	[AD7768_AAF_IN3] =3D 143		/* 0.143 */
> +};
> +
> =C2=A0/* -3dB cutoff frequency multipliers (relative to ODR) for each fil=
ter type. */
> =C2=A0static const int ad7768_filter_3db_odr_multiplier[] =3D {
> =C2=A0	[AD7768_FILTER_SINC5] =3D 204,		/* 0.204 */
> @@ -216,6 +269,12 @@ static const struct iio_scan_type ad7768_scan_type[]=
 =3D {
> =C2=A0
> =C2=A0struct ad7768_chip_info {
> =C2=A0	const char *name;
> +	bool has_variable_aaf;
> +	bool has_pga;
> +	int num_pga_modes;
> +	int default_pga_mode;
> +	int pgia_mode2pin_offset;
> +	const int *pga_gains;
> =C2=A0	const struct iio_chan_spec *channel_spec;
> =C2=A0	const unsigned long *available_masks;
> =C2=A0	int num_channels;
> @@ -236,6 +295,9 @@ struct ad7768_state {
> =C2=A0	unsigned int samp_freq;
> =C2=A0	unsigned int samp_freq_avail[ARRAY_SIZE(ad7768_mclk_div_rates)];
> =C2=A0	unsigned int samp_freq_avail_len;
> +	int pga_gain_mode;
> +	int aaf_gain;
> +	int scale_tbl[ADAQ776X_MAX_GAIN_MODES][2];
> =C2=A0	struct completion completion;
> =C2=A0	struct iio_trigger *trig;
> =C2=A0	struct gpio_desc *gpio_sync_in;
> @@ -466,6 +528,43 @@ static int ad7768_reg_access(struct iio_dev *indio_d=
ev,
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +static void ad7768_fill_scale_tbl(struct iio_dev *dev)
> +{
> +	struct ad7768_state *st =3D iio_priv(dev);
> +	const struct iio_scan_type *scan_type;
> +	int val, val2, tmp0, tmp1, i;
> +	unsigned long denominator, numerator;
> +	u64 tmp2;
> +
> +	scan_type =3D iio_get_current_scan_type(dev, &dev->channels[0]);
> +	if (scan_type->sign =3D=3D 's')
> +		val2 =3D scan_type->realbits - 1;
> +	else
> +		val2 =3D scan_type->realbits;
> +
> +	for (i =3D 0; i < st->chip->num_pga_modes; i++) {
> +		/* Convert gain to a fraction format */
> +		numerator =3D st->chip->pga_gains[i];
> +		denominator =3D MILLI;
> +		if (st->chip->has_variable_aaf) {
> +			numerator *=3D ad7768_aaf_gains[st->aaf_gain];
> +			denominator *=3D MILLI;
> +		}
> +
> +		rational_best_approximation(numerator, denominator, __INT_MAX__,
> __INT_MAX__,
> +					=C2=A0=C2=A0=C2=A0 &numerator, &denominator);
> +

Hmm, I would user kernel limits.h (INT_MAX)
=20
> +		val =3D st->vref_uv / 1000;
> +		/* Multiply by MILLI here to avoid losing precision */
> +		val =3D mult_frac(val, denominator * MILLI, numerator);
> +		/* Would multiply by NANO here but we already multiplied by MILLI
> */
> +		tmp2 =3D shift_right((u64)val * MICRO, val2);
> +		tmp0 =3D (int)div_s64_rem(tmp2, NANO, &tmp1);
> +		st->scale_tbl[i][0] =3D tmp0; /* Integer part */
> +		st->scale_tbl[i][1] =3D abs(tmp1); /* Fractional part */
> +	}
> +}
> +
> =C2=A0static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int dec_rate)
> =C2=A0{
> @@ -567,12 +666,68 @@ static int ad7768_configure_dig_fil(struct iio_dev =
*dev,
> =C2=A0		st->oversampling_ratio =3D ad7768_dec_rate_values[dec_rate_idx];
> =C2=A0	}
> =C2=A0
> +	/* Update scale table: scale values vary according to the precision */
> +	ad7768_fill_scale_tbl(dev);
> +
> =C2=A0	ad7768_fill_samp_freq_tbl(st);
> =C2=A0
> =C2=A0	/* A sync-in pulse is required after every configuration change */
> =C2=A0	return ad7768_send_sync_pulse(st);
> =C2=A0}
> =C2=A0
> +static int ad7768_calc_pga_gain(struct ad7768_state *st, int gain_int,
> +				int gain_fract, int precision)
> +{
> +	u64 gain_nano, tmp;
> +	int gain_idx;
> +
> +	precision--;
> +	gain_nano =3D gain_int * NANO + gain_fract;
> +	if (gain_nano < 0 || gain_nano > ADAQ776X_GAIN_MAX_NANO)
> +		return -EINVAL;
> +
> +	tmp =3D DIV_ROUND_CLOSEST_ULL(gain_nano << precision, NANO);
> +	gain_nano =3D DIV_ROUND_CLOSEST_ULL(st->vref_uv, tmp);

Does not look like we need u64 divison above...

> +	if (st->chip->has_variable_aaf)
> +		/* remove the AAF gain from the overall gain */
> +		gain_nano =3D DIV_ROUND_CLOSEST_ULL(gain_nano *=C2=A0 MILLI,
> +						=C2=A0 ad7768_aaf_gains[st->aaf_gain]);
> +	tmp =3D st->chip->num_pga_modes;
> +	gain_idx =3D find_closest(gain_nano, st->chip->pga_gains, tmp);
> +
> +	return gain_idx;
> +}
> +
> +static int ad7768_set_pga_gain(struct ad7768_state *st,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int gain_mode)
> +{
> +	int pgia_pins_value =3D abs(gain_mode - st->chip->pgia_mode2pin_offset)=
;
> +	int check_val;
> +	int ret;
> +
> +	/* Check GPIO control register */
> +	ret =3D regmap_read(st->regmap, AD7768_REG_GPIO_CONTROL, &check_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((check_val & AD7768_GPIO_PGIA_EN) !=3D AD7768_GPIO_PGIA_EN) {
> +		/* Enable PGIA GPIOs and set them as output */
> +		ret =3D regmap_write(st->regmap, AD7768_REG_GPIO_CONTROL,
> AD7768_GPIO_PGIA_EN);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Write the respective gain values to GPIOs 0, 1, 2 */
> +	ret =3D regmap_write(st->regmap, AD7768_REG_GPIO_WRITE,
> +			=C2=A0=C2=A0 AD7768_GPIO_WRITE(pgia_pins_value));
> +	if (ret < 0)
> +		return ret;
> +
> +	st->pga_gain_mode =3D gain_mode;
> +

It looks the above function could use some locking.

> +	return 0;
> +}
> +
> =C2=A0static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsi=
gned int
> offset)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev =3D gpiochip_get_data(chip);
> @@ -782,13 +937,17 @@ static const struct iio_chan_spec ad7768_channels[]=
 =3D {
> =C2=A0	AD7768_CHAN(0, AD7768_CHAN_INFO_NONE),
> =C2=A0};
> =C2=A0
> +static const struct iio_chan_spec adaq776x_channels[] =3D {
> +	AD7768_CHAN(0, BIT(IIO_CHAN_INFO_SCALE)),
> +};
> +
> =C2=A0static int ad7768_read_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0 int *val, int *val2, long info)
> =C2=A0{
> =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> =C2=A0	const struct iio_scan_type *scan_type;
> -	int scale_uv, ret, temp;
> +	int ret, temp;
> =C2=A0
> =C2=A0	scan_type =3D iio_get_current_scan_type(indio_dev, chan);
> =C2=A0	if (IS_ERR(scan_type))
> @@ -809,12 +968,19 @@ static int ad7768_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0		return IIO_VAL_INT;
> =C2=A0
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> -		scale_uv =3D st->vref_uv;
> -		if (scale_uv < 0)
> -			return scale_uv;
> -
> -		*val =3D (scale_uv * 2) / 1000;
> -		*val2 =3D scan_type->realbits;
> +		if (st->chip->has_pga) {
> +			*val =3D st->scale_tbl[st->pga_gain_mode][0];
> +			*val2 =3D st->scale_tbl[st->pga_gain_mode][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
> +		*val =3D st->vref_uv / 1000;
> +		if (st->chip->has_variable_aaf)
> +			*val =3D (*val * MILLI) / ad7768_aaf_gains[st->aaf_gain];
> +		/*
> +		 * ADC output code is two's complement so only (realbits - 1)
> +		 * bits express voltage magnitude.
> +		 */
> +		*val2 =3D scan_type->realbits - 1;
> =C2=A0

I'm a bit confused. Is there something wrong with the original code that ne=
eds to be
fixed? The above change seems to effectively change behavior of the code wi=
th had
before.

- Nuno S=C3=A1
> =C2=A0		return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0
> @@ -869,18 +1035,42 @@ static int ad7768_read_avail(struct iio_dev *indio=
_dev,
> =C2=A0		*length =3D st->samp_freq_avail_len;
> =C2=A0		*type =3D IIO_VAL_INT;
> =C2=A0		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals =3D (int *)st->scale_tbl;
> +		*length =3D st->chip->num_pga_modes * 2;
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> =C2=A0static int __ad7768_write_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long info)
> =C2=A0{
> =C2=A0	struct ad7768_state *st =3D iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	int gain_mode;
> =C2=A0	int ret;
> =C2=A0
> +	scan_type =3D iio_get_current_scan_type(indio_dev, chan);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> =C2=A0	switch (info) {
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> =C2=A0		return ad7768_set_freq(st, val);
> @@ -892,6 +1082,13 @@ static int __ad7768_write_raw(struct iio_dev *indio=
_dev,
> =C2=A0
> =C2=A0		/* Update sampling frequency */
> =C2=A0		return ad7768_set_freq(st, st->samp_freq);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!st->chip->has_pga)
> +			return -EOPNOTSUPP;
> +
> +		gain_mode =3D ad7768_calc_pga_gain(st, val, val2,
> +						 scan_type->realbits);
> +		return ad7768_set_pga_gain(st, gain_mode);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -933,6 +1130,7 @@ static const struct iio_info ad7768_info =3D {
> =C2=A0	.read_raw =3D &ad7768_read_raw,
> =C2=A0	.read_avail =3D &ad7768_read_avail,
> =C2=A0	.write_raw =3D &ad7768_write_raw,
> +	.write_raw_get_fmt =3D &ad7768_write_raw_get_fmt,
> =C2=A0	.read_label =3D ad7768_read_label,
> =C2=A0	.get_current_scan_type =3D &ad7768_get_current_scan_type,
> =C2=A0	.debugfs_reg_access =3D &ad7768_reg_access,
> @@ -1351,10 +1549,46 @@ static const struct ad7768_chip_info ad7768_chip_=
info =3D {
> =C2=A0	.available_masks =3D ad7768_channel_masks,
> =C2=A0};
> =C2=A0
> +static const struct ad7768_chip_info adaq7767_chip_info =3D {
> +	.name =3D "adaq7767-1",
> +	.channel_spec =3D ad7768_channels,
> +	.num_channels =3D ARRAY_SIZE(ad7768_channels),
> +	.available_masks =3D ad7768_channel_masks,
> +	.has_pga =3D false,
> +	.has_variable_aaf =3D true
> +};
> +
> +static const struct ad7768_chip_info adaq7768_chip_info =3D {
> +	.name =3D "adaq7768-1",
> +	.channel_spec =3D adaq776x_channels,
> +	.num_channels =3D ARRAY_SIZE(adaq776x_channels),
> +	.available_masks =3D ad7768_channel_masks,
> +	.pga_gains =3D adaq7768_gains,
> +	.default_pga_mode =3D AD7768_PGA_GAIN_2,
> +	.num_pga_modes =3D ARRAY_SIZE(adaq7768_gains),
> +	.pgia_mode2pin_offset =3D 6,
> +	.has_pga =3D true,
> +	.has_variable_aaf =3D false
> +};
> +
> +static const struct ad7768_chip_info adaq7769_chip_info =3D {
> +	.name =3D "adaq7769-1",
> +	.channel_spec =3D adaq776x_channels,
> +	.num_channels =3D ARRAY_SIZE(adaq776x_channels),
> +	.available_masks =3D ad7768_channel_masks,
> +	.pga_gains =3D adaq7769_gains,
> +	.default_pga_mode =3D AD7768_PGA_GAIN_0,
> +	.num_pga_modes =3D ARRAY_SIZE(adaq7769_gains),
> +	.pgia_mode2pin_offset =3D 0,
> +	.has_pga =3D true,
> +	.has_variable_aaf =3D true
> +};
> +
> =C2=A0static int ad7768_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct ad7768_state *st;
> =C2=A0	struct iio_dev *indio_dev;
> +	u32 val;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -1418,6 +1652,35 @@ static int ad7768_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	st->aaf_gain =3D AD7768_AAF_IN1;
> +	ret =3D device_property_read_u32(&spi->dev, "adi,aaf-gain", &val);
> +	if (ret) {
> +		/* AAF gain required, but not specified */
> +		if (st->chip->has_variable_aaf)
> +			return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not
> specified\n");
> +
> +	} else if (!st->chip->has_variable_aaf) {
> +		/* AAF gain provided, but not supported */
> +		return dev_err_probe(&spi->dev, -EINVAL, "AAF gain not supported
> for %s\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 st->chip->name);
> +	} else {
> +		/* Device supports variable AAF gain, validate and set the gain */
> +		switch (val) {
> +		case 1000:
> +			st->aaf_gain =3D AD7768_AAF_IN1;
> +			break;
> +		case 364:
> +			st->aaf_gain =3D AD7768_AAF_IN2;
> +			break;
> +		case 143:
> +			st->aaf_gain =3D AD7768_AAF_IN3;
> +			break;
> +		default:
> +			return dev_err_probe(&spi->dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid firmware provided gain\n");
> +		}
> +	}
> +
> =C2=A0	ret =3D ad7768_setup(indio_dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		dev_err(&spi->dev, "AD7768 setup failed\n");
> @@ -1426,6 +1689,9 @@ static int ad7768_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	init_completion(&st->completion);
> =C2=A0
> +	if (st->chip->has_pga)
> +		ad7768_set_pga_gain(st, st->chip->default_pga_mode);
> +
> =C2=A0	ret =3D ad7768_set_channel_label(indio_dev, st->chip->num_channels=
);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> @@ -1446,12 +1712,18 @@ static int ad7768_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0static const struct spi_device_id ad7768_id_table[] =3D {
> =C2=A0	{ "ad7768-1", (kernel_ulong_t)&ad7768_chip_info },
> +	{ "adaq7767-1", (kernel_ulong_t)&adaq7767_chip_info },
> +	{ "adaq7768-1", (kernel_ulong_t)&adaq7768_chip_info },
> +	{ "adaq7769-1", (kernel_ulong_t)&adaq7769_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(spi, ad7768_id_table);
> =C2=A0
> =C2=A0static const struct of_device_id ad7768_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad7768-1", .data =3D &ad7768_chip_info },
> +	{ .compatible =3D "adi,adaq7767-1", .data =3D &adaq7767_chip_info },
> +	{ .compatible =3D "adi,adaq7768-1", .data =3D &adaq7768_chip_info },
> +	{ .compatible =3D "adi,adaq7769-1", .data =3D &adaq7769_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ad7768_of_match);


