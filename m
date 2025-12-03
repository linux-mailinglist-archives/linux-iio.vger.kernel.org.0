Return-Path: <linux-iio+bounces-26669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DCC9ECDB
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 12:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A14F34E12D6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ECC2F12DA;
	Wed,  3 Dec 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXG58sJ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F128B3E2
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759915; cv=none; b=pfdbW5vhNkO/oNYY2H8fvw31h8Ru00B7JV1J+wgDsKwsA6OLiuSN/45t1/fgHdMVYE/dcOXC4K5ke4cNXAsLTbcGvBQdhK0tRTGVpfJLp7Iy0PRzAh/BjxG4IBj+nCTU/EC31oC3jijq914HtOKC6Slt/XJ/2ofPjYL/bnNtQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759915; c=relaxed/simple;
	bh=3hYFKnwY/jXsew6ogw5GNr/BvCxjjBs8aEJJ49bJIoQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=je8lce/+zVE3wAygM9LV0KP1qF9nDo62ROzStOBR67Q0o0TkoKX/ofVJA4bF4YSSBS7YiG9l9s5273eN2roN1fACaG5pkZbvtigN1gInkzfiWTsU/hBgSJmXXdKoTfbcc8I6Bp8gc+0FKPB4A0XKGvXdYSuSGyu0Cf9C/OH/7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXG58sJ6; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79e7112398so4555566b.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 03:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764759911; x=1765364711; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AksAhhiwRCGTKs9EFnYVmYfT9CZfWA/Jx9dAGLK16fw=;
        b=JXG58sJ6udAk0aAJgbYOx5sn7O0ZYi2m8OZ0sYVg8XIFNO+EiPWpw/JrMDGIG29zhp
         WiNx0bsoJgah6zqfZD8sd/Vpiy4eKSb2VBvrK2zhj9PbrxFXBTUT/3QDL9C/VCL42ntk
         p2/Xx5zTYGEC7NKFk0Ae3NL+1qWFJVzqhzVEiY99u6Lf726ppznsmUlNABbByRHCgaR1
         IcTJI56RvKNaNrHya8LrTxck3h7xY4L7znMbFQUPKKmC5stLYtcxq4gz+K7+873r4iPO
         hP5uwXlc/hhLV8XTf8b84mJ74tKN1povyKIv33vPtlEJtJ0scfDKUOg9V2LpAgMKX1iI
         9yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764759911; x=1765364711;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AksAhhiwRCGTKs9EFnYVmYfT9CZfWA/Jx9dAGLK16fw=;
        b=KhldVUE/TdJ7J4bITYHuN5gw9LHR38wNJcJ2eG8JgC54RicdSx8i8butAwPXwwD8iH
         Nj/Vc9zEgm34UD9LQ8FTRtPEyqwTEBwLr/nc/wxHOYzDkpfSC7+6CDaRtvUwC0NyAG/M
         xKoY+kDlbEH+QrZRd7XJMGdeRCfOKkbAYzeCAk9frEwna5p4BWk0UAqgnG+fH/cIOGL1
         DCzLknm/YvnDBo2eh1rtg+o8Bzdafm+RW+hEg3Wy4w9JOGEwkh7BKGCHw1QHUrz7N12Y
         e+7M2eUBq/x4/xtGHVl4S4cRWnO2AXwfJumF9RwTHIlVXXuxlcmXC4LJ9Jgj2pYGlGE/
         AFhA==
X-Forwarded-Encrypted: i=1; AJvYcCU2/yvBh91+puxyEGqdeC+qJ4uMphLK3xp2B9kgmaFyXXLMu8mzU/eguTlfRhCC89HW3UgSixfB6oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLihWPiapL3+BCaPDWDm17vTr6NxmKdJK+Tn/r1J5d8FSJNCAs
	s/Mv0/tk3Y72Gf2Bhn1qDNKWrShZjm0McIFcMuMdWk/8tpnAuOHhxtW/
X-Gm-Gg: ASbGnctmoowuSeJXOFK2/spjQvcHC104DmztZ51BNWRrImroaW0zNbFcsF/CsyU5CWG
	hUdFzd6A+6CX01iXQkPaiKhe5LP8qulpc2pSdPl01BM6fo3rvORqfPjQvouH+R9I7OedIm4cEBV
	PzsM48WPKPCOZ93ylwMjF7vlSszjw6iuwKTLSQ838hIBv6zbt/QboXc5+tm4L5GGorU4Cxc50+x
	YiGdOSX0qvOwud8AvQzJ3TJU+viK5EtIGnWnC9y23y5VhwPzckqNIfYLJjw2uJJHslVvFNHMznp
	W+Eb3WI1nwOHDvyWPVPcNUsvFKDkLuGzHo9ML8lpbDSHA2p+clFGIF2DYvLgI3Pe3UfkH0DLsNd
	FJXElIKBBRr7oxi73a38SKtCVd67bZpjmQHjkFzukbgXNxkwmINv8fiNVlN+GPyMB9nSi6Inl5D
	GVo8HZ/zdLCp0=
X-Google-Smtp-Source: AGHT+IFiogLaMfIFSYeoKmJmWQPGe8YZ4J7kAIGQwOZQc/+JKv85DYmkE7ZxcZkVpaVrbWXlGN9Z3w==
X-Received: by 2002:a17:907:9813:b0:b72:70e7:5b62 with SMTP id a640c23a62f3a-b79dbe85759mr168928766b.23.1764759910643;
        Wed, 03 Dec 2025 03:05:10 -0800 (PST)
Received: from [10.5.0.2] ([185.128.9.168])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a25fcasm1758519066b.61.2025.12.03.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:05:10 -0800 (PST)
Message-ID: <fdf00f852543f9da3efd0c87c78165d9f22db367.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad9467: support write/read offset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,  David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean	 <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 03 Dec 2025 11:05:50 +0000
In-Reply-To: <20251203-ad9434-fixes-v3-2-38d14f28456f@vaisala.com>
References: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com>
	 <20251203-ad9434-fixes-v3-2-38d14f28456f@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-03 at 09:28 +0000, Tomas Melin wrote:
> Support configuring output calibration value. Among the devices
> currently supported by this driver, this setting is specific to
> ad9434. The offset can be used to calibrate the output against
> a known input. The register is called offset, but the procedure
> is best mapped internally with calibbias operation.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Still don't really like the style in .info_mask_shared_by_type and=20
.info_mask_shared_by_type_available. But ok, it seems I'm the only one. So:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad9467.c | 60 +++++++++++++++++++++++++++++++++++++=
++++++++++-
> =C2=A01 file changed, 59 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 2d8f8da3671dac61994a1864a82cdbef7f54c1af..48c10acb1566ba471be0804e7=
c39b0b553d76188 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -145,6 +145,7 @@ struct ad9467_chip_info {
> =C2=A0	unsigned int num_lanes;
> =C2=A0	unsigned int dco_en;
> =C2=A0	unsigned int test_points;
> +	const int *offset_range;
> =C2=A0	/* data clock output */
> =C2=A0	bool has_dco;
> =C2=A0	bool has_dco_invert;
> @@ -234,6 +235,10 @@ static int ad9467_reg_access(struct iio_dev *indio_d=
ev, unsigned int reg,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static const int ad9434_offset_range[] =3D {
> +	-128, 1, 127,
> +};
> +
> =C2=A0static const unsigned int ad9265_scale_table[][2] =3D {
> =C2=A0	{1250, 0x00}, {1500, 0x40}, {1750, 0x80}, {2000, 0xC0},
> =C2=A0};
> @@ -298,7 +303,24 @@ static void __ad9467_get_scale(struct ad9467_state *=
st, int index,
> =C2=A0}
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad9434_channels[] =3D {
> -	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 12, 's'),
> +	{
> +		.type =3D IIO_VOLTAGE,
> +		.indexed =3D 1,
> +		.channel =3D 0,
> +		.info_mask_shared_by_type =3D
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.info_mask_shared_by_type_available =3D
> +			BIT(IIO_CHAN_INFO_SCALE) |
> +			BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.scan_index =3D 0,
> +		.scan_type =3D {
> +			.sign =3D 's',
> +			.realbits =3D 12,
> +			.storagebits =3D 16,
> +		},
> +	},
> =C2=A0};
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad9467_channels[] =3D {
> @@ -367,6 +389,7 @@ static const struct ad9467_chip_info ad9434_chip_tbl =
=3D {
> =C2=A0	.default_output_mode =3D AD9434_DEF_OUTPUT_MODE,
> =C2=A0	.vref_mask =3D AD9434_REG_VREF_MASK,
> =C2=A0	.num_lanes =3D 6,
> +	.offset_range =3D ad9434_offset_range,
> =C2=A0};
> =C2=A0
> =C2=A0static const struct ad9467_chip_info ad9265_chip_tbl =3D {
> @@ -499,6 +522,33 @@ static int ad9467_set_scale(struct ad9467_state *st,=
 int val, int val2)
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> +static int ad9467_get_offset(struct ad9467_state *st, int *val)
> +{
> +	int ret;
> +
> +	ret =3D ad9467_spi_read(st, AN877_ADC_REG_OFFSET);
> +	if (ret < 0)
> +		return ret;
> +	*val =3D ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad9467_set_offset(struct ad9467_state *st, int val)
> +{
> +	int ret;
> +
> +	if (val < st->info->offset_range[0] || val > st->info->offset_range[2])
> +		return -EINVAL;
> +
> +	ret =3D ad9467_spi_write(st, AN877_ADC_REG_OFFSET, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad9467_spi_write(st, AN877_ADC_REG_TRANSFER,
> +				AN877_ADC_TRANSFER_SYNC);
> +}
> +
> =C2=A0static int ad9467_outputmode_set(struct ad9467_state *st, unsigned =
int mode)
> =C2=A0{
> =C2=A0	int ret;
> @@ -802,6 +852,8 @@ static int ad9467_read_raw(struct iio_dev *indio_dev,
> =C2=A0	struct ad9467_state *st =3D iio_priv(indio_dev);
> =C2=A0
> =C2=A0	switch (m) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad9467_get_offset(st, val);
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		return ad9467_get_scale(st, val, val2);
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -836,6 +888,8 @@ static int ad9467_write_raw(struct iio_dev *indio_dev=
,
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad9467_set_offset(st, val);
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		return ad9467_set_scale(st, val, val2);
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -874,6 +928,10 @@ static int ad9467_read_avail(struct iio_dev *indio_d=
ev,
> =C2=A0	const struct ad9467_chip_info *info =3D st->info;
> =C2=A0
> =C2=A0	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*type =3D IIO_VAL_INT;
> +		*vals =3D info->offset_range;
> +		return IIO_AVAIL_RANGE;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		*vals =3D (const int *)st->scales;
> =C2=A0		*type =3D IIO_VAL_INT_PLUS_MICRO;

