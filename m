Return-Path: <linux-iio+bounces-4831-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7D8BC96B
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3D284062
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CF1411C8;
	Mon,  6 May 2024 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtKJu5uP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B841D53C;
	Mon,  6 May 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714983620; cv=none; b=V22piPqpIWYACkyE1PMYsDBFWVJmjpUSUa1oahJ8405Ve+Z2D0IxtP5EsRPeHYSREqPUrYB82rzvs93dq8XMBBS7t/MNOpD7fTdncEVSShW+zUYEJ77xuF54fzZdljeFA+0Nf97bT/pnXpqo05xHuSY6lbO3/T4ZAWYyA1oikwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714983620; c=relaxed/simple;
	bh=oI6KZL8xMEnOI0JUSajfcOjR5/0VaRJGSrYiP8gyYr4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrE1MQBvbJRcZhzAIk/b8Gc96ImjI58z/6TLl2pVXr2c33g7WKbfHj0Cpb5fJKrCuEZJwSu7e+ReRxoDn+2zmfKx7ce7pRNj41+wre4+Gp6Us5rfuRxJOp46igs9LD1PYxPgxl5/E+TBG/lQRNE8+tzgDTlGH+H2BoZMRiZ1RMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtKJu5uP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a599c55055dso366999866b.0;
        Mon, 06 May 2024 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714983617; x=1715588417; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bNHd0an/gaXMy+olLRoP7YkYSvwCWy00m2F9nn+euPM=;
        b=VtKJu5uPtaGcgYdMXmu6iRSlOe+CT8Vp+p5bAuk9iqr8OQXX0zHzJnoG+dqYW4pT9i
         6F4PgV4yG9Y61NOcax11WFtqM8RMetkqn88wsUXOJZEqdDyhBXghwl/1AKnvKb1ONxPs
         LLGr7dvvBQ2RePzVlsalO9mmpTyYKnBJF5/j225P4L0FvwdZglzGvzhpoEdzZDzyJIzu
         H9HkPJKoJ9L1/4jODtAWeuLrWWKwPSCLsn6Jlzo0ThAxnOR1/pgGVbNbAntu0CWRsUTR
         VWlrJh2dEaNNpDfJZlOVtQvC7US9BH0OMRCyiqmVFlZkL1FhIJmeqjR++EgkLShI0Xva
         4zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714983617; x=1715588417;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bNHd0an/gaXMy+olLRoP7YkYSvwCWy00m2F9nn+euPM=;
        b=BSnbYn9G8YATd82B+yrXp6gsk073IVu/nSkNyQWiE+G6Gko1DxFoIZEFkJ6kdFjnU5
         e4yZ152AIEr5IMzUR20w7jeAT/srzfyxKTHi1I1LN0+M4AZR6JzXTU7TB8KIObbTO818
         F9q8OpK+XDYsI5Qv8K+4gNTrnXulXLTE3J9fieAfP7f8yYtx07+pEDlgpmlktONZtWda
         tzyxMmZkFP4JU75GhwJs1Xk72xT7ktTYRhFncXQFiA6bYdvPW0lrDtUUxMgR+QrAzmrr
         k2pt9Aep3N1gGMoqsJq4u1RXyFMmNmtBWTRN26zuSoGmTRp9BvC4XDalYCBJ20vv5MJj
         cXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOYEUXBRIlFFYrqU8UGAeNLV1i52R+2MCkJOVAeCdph8RvEjvD+ZxYjR7s4zo4xmHMGHYht/jWfOxg3zXivlS8DFzdNKbXmfFz6TMd3JwvTf3ObBMvkEbWcBM4egxv/StJIGyeLGwSfZOlXtTC8NhVcgUjLIuBCTYSPoNlYJOX+FWJVg==
X-Gm-Message-State: AOJu0YwLexIYTIj8FbQJyhTYYtIkwNq61SSqr9hvf89HMKLYc6JdU650
	8akT3qybEoHHUPU6m5ISFr5zDEhQLQuYm8qcoDlKOULGSDHcrkfV
X-Google-Smtp-Source: AGHT+IFj0E/KOpeYb7bSNt/7kwgAaso8l+rPl642Z/i+jT0OGVg0kBhQNBho96YZRTBKAiPgTx5Axw==
X-Received: by 2002:a17:906:a159:b0:a52:3f01:e11d with SMTP id bu25-20020a170906a15900b00a523f01e11dmr5393048ejb.34.1714983616604;
        Mon, 06 May 2024 01:20:16 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090668d100b00a59bacd35ddsm1998352ejr.98.2024.05.06.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 01:20:16 -0700 (PDT)
Message-ID: <1be8a603c1db69278181089e3653b6312bcc99da.camel@gmail.com>
Subject: Re: [PATCH RFC v6 08/10] iio: adc: ad7380: add oversampling support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
  Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: kernel test robot <lkp@intel.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 10:20:15 +0200
In-Reply-To: <20240501-adding-new-ad738x-driver-v6-8-3c0741154728@baylibre.com>
References: 
	<20240501-adding-new-ad738x-driver-v6-0-3c0741154728@baylibre.com>
	 <20240501-adding-new-ad738x-driver-v6-8-3c0741154728@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Julien,

On Wed, 2024-05-01 at 16:55 +0200, Julien Stephan wrote:
> ad7380x(-4) parts are able to do oversampling to increase accuracy.
> They support 2 average modes: normal average and rolling overage.
> This commits focus on enabling normal average oversampling, which is the
> default one.
>=20
> Normal averaging involves taking a number of samples, adding them togethe=
r,
> and dividing the result by the number of samples taken.
> This result is then output from the device. The sample data is cleared wh=
en
> the process completes. Because we need more samples to output a value,
> the data output rate decrease with the oversampling ratio.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7380.c | 115 ++++++++++++++++++++++++++++++++++++=
++++++++++-
> =C2=A01 file changed, 114 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 020959759170..1e3869f5e48c 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -88,7 +88,10 @@ struct ad7380_chip_info {
> =C2=A0	.type =3D IIO_VOLTAGE,					\
> =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> =C2=A0		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),	\
> -	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_type_available =3D			\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> =C2=A0	.indexed =3D 1,						\
> =C2=A0	.differential =3D (diff),					\
> =C2=A0	.channel =3D (diff) ? (2 * (index)) : (index),		\
> @@ -156,6 +159,16 @@ static const struct ad7380_timing_specs ad7380_4_tim=
ing =3D {
> =C2=A0	.t_csh_ns =3D 20,
> =C2=A0};
> =C2=A0
> +/*
> + * Available oversampling ratios. The indices correspond
> + * with the bit value expected by the chip.
> + * The available ratios depend on the averaging mode,
> + * only normal averaging is supported for now
> + */
> +static const int ad7380_normal_average_oversampling_ratios[] =3D {
> +	1, 2, 4, 8, 16, 32,
> +};
> +
> =C2=A0static const struct ad7380_chip_info ad7380_chip_info =3D {
> =C2=A0	.name =3D "ad7380",
> =C2=A0	.channels =3D ad7380_channels,
> @@ -231,6 +244,7 @@ static const struct ad7380_chip_info ad7384_4_chip_in=
fo =3D {
> =C2=A0struct ad7380_state {
> =C2=A0	const struct ad7380_chip_info *chip_info;
> =C2=A0	struct spi_device *spi;
> +	unsigned int oversampling_ratio;

nit: move this to the other 'unsigned int' fields...

> =C2=A0	struct regmap *regmap;
> =C2=A0	unsigned int vref_mv;
> =C2=A0	unsigned int vcm_mv[MAX_NUM_CHANNELS];
> @@ -386,6 +400,12 @@ static int ad7380_read_direct(struct ad7380_state *s=
t,
> =C2=A0	};
> =C2=A0	int ret;
> =C2=A0
> +	/*
> +	 * In normal average oversampling we need to wait for multiple conversi=
ons
> to be done
> +	 */
> +	if (st->oversampling_ratio > 1)
> +		xfers[0].delay.value =3D T_CONVERT_NS + 500 * st-
> >oversampling_ratio;
> +
> =C2=A0	ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> @@ -428,6 +448,91 @@ static int ad7380_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0			/ st->vref_mv;
> =C2=A0
> =C2=A0		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D st->oversampling_ratio;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7380_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D ad7380_normal_average_oversampling_ratios;
> +		*length =3D ARRAY_SIZE(ad7380_normal_average_oversampling_ratios);
> +		*type =3D IIO_VAL_INT;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * check_osr - Check the oversampling ratio
> + * @available_ratio: available ratios's array
> + * @size: size of the available_ratio array
> + * ratio: ratio to check
> + *
> + * Check if ratio is present in @available_ratio. Check for exact match.
> + * @available_ratio is an array of the available ratios (depending on th=
e
> oversampling mode).
> + * The indices must correspond with the bit value expected by the chip.
> + */
> +static inline int check_osr(const int *available_ratio, int size, int ra=
tio)

Please name the function ad7380_check_osr(). Also, drop the inline... The c=
ompiler
should be smart enough to take of that for us.

> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if (ratio =3D=3D available_ratio[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad7380_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> +			=C2=A0=C2=A0=C2=A0 int val2, long mask)
> +{
> +	struct ad7380_state *st =3D iio_priv(indio_dev);
> +	int ret, osr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		osr =3D check_osr(ad7380_normal_average_oversampling_ratios,
> +				ARRAY_SIZE(ad7380_normal_average_oversampling_rati
> os),
> +				val);
> +
> +		if (osr < 0)
> +			return osr;
> +
> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> +			ret =3D regmap_update_bits(st->regmap,
> AD7380_REG_ADDR_CONFIG1,
> +						 AD7380_CONFIG1_OSR,
> +						 FIELD_PREP(AD7380_CONFIG1_OSR,
> osr));
> +
> +			if (ret)
> +				return ret;
> +
> +			st->oversampling_ratio =3D val;
> +
> +			/*
> +			 * Perform a soft reset.
> +			 * This will flush the oversampling block and FIFO but
> will
> +			 * maintain the content of the configurable registers.
> +			 */
> +			ret =3D regmap_update_bits(st->regmap,
> AD7380_REG_ADDR_CONFIG2,
> +						 AD7380_CONFIG2_RESET,
> +						 FIELD_PREP(AD7380_CONFIG2_RESET,
> +							=C2=A0=C2=A0=C2=A0
> AD7380_CONFIG2_RESET_SOFT));
> +		}
> +		return 0;

return ret;

Or you may be asked to directly return in regmap_update_bits() and use unre=
achable()
here.

> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}
> @@ -435,6 +540,8 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
> =C2=A0
> =C2=A0static const struct iio_info ad7380_info =3D {
> =C2=A0	.read_raw =3D &ad7380_read_raw,
> +	.read_avail =3D &ad7380_read_avail,
> +	.write_raw =3D &ad7380_write_raw,
> =C2=A0	.debugfs_reg_access =3D &ad7380_debugfs_reg_access,
> =C2=A0};
> =C2=A0
> @@ -458,6 +565,12 @@ static int ad7380_init(struct ad7380_state *st, stru=
ct
> regulator *vref)
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> +	/* Disable oversampling by default.
> +	 * This is the default value after reset,
> +	 * so just initialize internal data
> +	 */

Your comment block is not in accordance with coding style. checkpatch shoul=
d complain
about this.

> +	st->oversampling_ratio =3D 1;
> +
> =C2=A0	/* SPI 1-wire mode */
> =C2=A0	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> =C2=A0				=C2=A0 AD7380_CONFIG2_SDO,
>=20


