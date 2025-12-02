Return-Path: <linux-iio+bounces-26623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A177BC9BA99
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CF63A825D
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55B3203B6;
	Tue,  2 Dec 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYSWuf2x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810892BE632
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683219; cv=none; b=a9pbS1pk6aNoU4SMcWreaIGbfB9n8xGd811c6E0JGBu1gsaV/DWQTlDatyHq+8tU6bh/OHQK5Ae/OGj7YRkPdeEen+vhySZ71X/JlDhnBcWZluic9or4JfBUVrF+ToWXM4Wtm9n/RTWsR9lv0Cjaq+OIxyOA8zofYCKO7ypojwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683219; c=relaxed/simple;
	bh=Ar8AemtrD+ULZNSWdzjLU9Qx5WlzNp3CdU/hDfLhZX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oznNCLDSgIN4/82KoDtUgiyKnBb6FDU21zFZg/PKjTv7kXggkmTfmp4M6WSPWzsl1Tfp3EBTgqxFc1kcrB72fmOi/WSOA74z07XOFwMQhvcR+cei1DEGgFk0lc+uUfkm56jZlZJu+v3OSVcS+o7R/GeYL1hpsMQMBMbcVg6Yqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYSWuf2x; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42e2e50c233so1272311f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 05:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764683214; x=1765288014; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMUu4bYlRumQfTx0Vp9g1/ddN8WmtuPuYyu0b0KpVXc=;
        b=PYSWuf2xlv2ISpQp41bDeRe/FEquau9fNDn4oZyKb3zGGwoY7FonghIaf5iCiPn3Ci
         UOSY6ZcbxOUJ8TCHu8BEITMoAR6QtwZXTuPAxPZ0dhfgcKJFxxTljuuoIjUuJvnf2WwK
         ybVx9hewVd0ZwX1s2Tfx9bTeAP/XmUoMOg1NJhogLetwyabkwORVBtx7E0q9w8aSSe5Y
         9HkqqQd379mkNk1PVILH6zMsFpg3EsoKQBqu/MRtt/i0q5wPvjdmSthJ61LmuGo1TRsg
         ElHvlS/PPL6J3/eV51GDjUZdH4kYzGp7QXLNpKX/GpV5Ri7yF8RkTd3YPgCfR5Lo7hIr
         fLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764683214; x=1765288014;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMUu4bYlRumQfTx0Vp9g1/ddN8WmtuPuYyu0b0KpVXc=;
        b=GEKHqbDCQ0gt7uryUvalV1+tx/JbdYv8Vi/BuawKQyEKdOPqeCRbR/7E7qPnNAxCGX
         g/cCJnfHBdNWExsKhNYm6I4OwarCVux77POn1AIa0ylU+GB8oUgWTMpFKc9aXO9HGcVX
         O8e4sLvfjsqjlkdOi1Smoh81QAdMMLh9hw742r45lFpSBJCGD/sNMmSABeDU9xbOwyDS
         zHV/zBAZn72N8RSd1OwG4cvFLqLNN+sofHekkby7toaBwqEC0BIU1OPOZlM4n1AtodcM
         izXwECs5jPVhviEZalGajPyJnF/79jA1ouv1C0c8ezkvaAVEoqGjEcN7Wa0RSqPP1Zts
         TdWw==
X-Forwarded-Encrypted: i=1; AJvYcCWP4xT1+v16pneo7bBr+PSime4eAkWHePUWU5/YwI2HtGA0uaMHtQEXCrjFulaDzfkFX33lvFZYEGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBrYzbMJ7uHcx1nvRXQ78xg0bHgSJgYrjxPZ1oG5q7anynqQa
	sk1dINEgc6tHRH7J3X/8NI+aVuMFHhVZbH0mDkSkXiI0U1D1cJ827Gz3
X-Gm-Gg: ASbGncvTawSFujOgiEfIYBh46CRRVeJZSr2PoRWBheDvleFjvy+fIBi2tsA6jUGWIbu
	qt8pn/GGDUOVjcbZ2QfEZvLI7gfsQJTcvuXzdZ++TSDTLLurxHqgQoC6Pj79n6o4BAsqlJbgHpS
	pBUS+ui0/qieNRVrgytbugLjpFMoXFZ7zPl/ekCbW9D49lc0Ie8TAhkUjDQmgyZ+yuH3hc5FaR4
	RjtgzlW/iFKO8zdz+vT+JlBDsyxJ1HztmdNKH2w3bOOA353xn/+JMzCq7zlMqrvVo56ozsCvhGw
	XwTUaeSMg3ANXwnKjCkU9rUh9EOD23P1k0BVPnI9dkd5z/iBPnwlC2l67iCbIuh8aM+SyMDlHZx
	yZ5K+XtCZR+cNFAYhFP1Vqs3EpKvZUgOMW//sWSd1zD7TaczZlvRZAd0ZGLxTI81ZNZ+b5obY28
	HrUzG9pYaSfCE5VWGd+Oo=
X-Google-Smtp-Source: AGHT+IFgFZbB9vrelpDOhaxjd/YQx/3FjpJBwUNPcJgYR+lDOaHRzG6nA4JYIOtZdCY0YDko00dYbg==
X-Received: by 2002:a05:6000:1885:b0:42b:394a:9de with SMTP id ffacd0b85a97d-42cc1d1a10cmr44241554f8f.49.1764683213794;
        Tue, 02 Dec 2025 05:46:53 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a303sm34754386f8f.27.2025.12.02.05.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 05:46:53 -0800 (PST)
Message-ID: <5d343af235c499382bd2eac987357e857865b457.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad9467: support write/read offset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,  David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean	 <alexandru.ardelean@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2025 13:47:33 +0000
In-Reply-To: <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
References: <20251202-ad9434-fixes-v2-0-fa73d4eabbea@vaisala.com>
	 <20251202-ad9434-fixes-v2-2-fa73d4eabbea@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-02 at 12:53 +0000, Tomas Melin wrote:
> Support configuring output calibration value. Among the devices
> currently supported by this driver, this setting is specific to
> ad9434. The offset can be used to calibrate the output against
> a known input. The register is called offset, but the procedure
> is best mapped internally with calibbias operation.
>=20
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> =C2=A0drivers/iio/adc/ad9467.c | 60 +++++++++++++++++++++++++++++++++++++=
++++++++++-
> =C2=A01 file changed, 59 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 2d8f8da3671dac61994a1864a82cdbef7f54c1af..c3cf7ae977d4279ce5e80a7c9=
56c3844483eb8bd 100644
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
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.info_mask_shared_by_type_available =3D
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),

Odd style for info_mask_shared_by_type_available and info_mask_shared_by_ty=
pe. Seems we have
more line breaks than needed.


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
> +	/* Sync registers */

I think this is not what David meant by adding a comment. IMHO, the comment=
 as-is does not
bring any added value.

- Nuno S=C3=A1


