Return-Path: <linux-iio+bounces-14298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52970A0BCF5
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 17:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B36E18857EF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18961FBBE8;
	Mon, 13 Jan 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhNq0EnG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542E240252;
	Mon, 13 Jan 2025 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784625; cv=none; b=X9p7Mt78O+aeeZiDPKAuy+kdwhmleO8OAUVAaxYaEvxMAUhPlgSDiy3EFgExvRkIt2r8qsVaNdcA9vSQewyhd3MOGOupNMW4HjnIJvraiZlzJKPW+hs+0WRCsPC5rHpUCzkpU56ELgURnN4NHAvTA06a6akXh+yBkidTNsRpyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784625; c=relaxed/simple;
	bh=WeoO1uWcxGs2NGkhtoKXVIW+vfNeBZ7ctHcKjymF3es=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccKOD2CNLEYWlzJgamXC+NpHcpm2WXpzRti5IBKwEhGKhnJ7UFM7F+xvHui4bu07IkVzsSYDEOkVuaaeyb3RSE7Ce/EahCavz455uw3XRO6K+eHc1L4yJs3vfSfvG2uFNZUI6wSJkZII9IXpO9iYR5X8HNrpq1c3uD8tn6C1PRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhNq0EnG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43675b1155bso51604285e9.2;
        Mon, 13 Jan 2025 08:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736784622; x=1737389422; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=knOcXyW3eCKPxmNNhW/U+roFNe3fpOdXuVvLHqIbOi4=;
        b=hhNq0EnG47vPPsYQmFKum9Yvzpnpokl8uExQx4bCyUYHt8acG0uYn2ND6Pwb04oAka
         7PJvwywDwdY/F3Qw6v6kmVeGjqsbzFLChl2kLZRVuuBkl0hRYakM+06TURjm3CDP2QGp
         e5WFXTjuF43QZnC3pIj050q1FbrtzkPP/tJXi0rOcypOKXNTWEwq/Xlm5jI+D3XdiyIE
         L8A+3pfLFiWRY7arHD5TpDNq0E579CqBtr857m6Uu6Jk/m2uIadwNbpE9gIzzFL+R7Nk
         0nAiA4/MXrWwL6wNld5Tdo8SRKgB8I4GqruxNXl79WPhMPCTzTnA6u74MzMnbUKquUhi
         UD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736784622; x=1737389422;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knOcXyW3eCKPxmNNhW/U+roFNe3fpOdXuVvLHqIbOi4=;
        b=sZwuJVBx3GgETcxzzl1XXBcpK1TKnzNDCd6aXr1oxga0xYXQ86Q0VtDsFQ7Vvx23pT
         mTcwah1mCONiUs39CkVdXqi3XRTRR1oTkqjoeNL2NQ4XroeY33hzfAHRB0DYdHoGbeSK
         up12Ej28XoEa3QvavhlcGUaWF0P/nZNY+IgwwhPA+SzrkOcxAt5AUeoMov75+jityLZD
         vISEjp9C+BaMJw0kgm8H5liian2eRJkVm/U9k2F6kjuCoytvKJLo2Pdr6mfLKPDCjrqk
         XGtaHP/BGr+msoJzsOXTKivKf2OEtK4MzSf2TKBidBh2Liog7YxxZP+nFb9atanPTOyW
         1Ixw==
X-Forwarded-Encrypted: i=1; AJvYcCUIhjQ59FUMMa3rpL1rFdVbQcY388eL1lg+jHTurlNFXvq0Yjz1NXwhdAZ4H2HLzYasYyzs6keBazc=@vger.kernel.org, AJvYcCXilcFNuXGyhZit8IvPzbfAYyrP0sJ3fARYtuJDCQq5GC1trViLwe6By4W26z23e8KOGN7BV+Z31eW23MCg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CQqFv8iDJ1e4qj5qpPRX2gjqiOWhRWXlxBzcfUH/tBCIb/fs
	vNMn0DKKOyM3hf5jvuYbn4E+0jaGLMmBZNZmTNARvifR71hwFGHc
X-Gm-Gg: ASbGncvCi3NPGTQEE6B5SvFOa6nQPrPNBWttA61MRLhLwKIfFwsK3qv4RKj9DCe919Y
	6V8liDOQJYr+NzlL/cEOjCG+RmId37GvMC/JdAuPOTipAbkwS3o+iuvYjqYkqF4FGGrTr5jAncg
	bP6FSawoGdZ77Ajt1TRoo8IyeEU133GIs9ieWRBrRQfGgz1bkj7HL3H3Oi3lwjT2Gl62aYf8dLl
	kKSuYUIVZ9neFQPnmqE4JawqPDHNn2QIf8bJOXuighF1WtHc1u/3zuDZs8qGK3A7WCqg1jURLna
	TE4A2l2kzdPoDfpJ7qAyX+CDPSik
X-Google-Smtp-Source: AGHT+IFRQXCivvwkHkKVtLvvl/TmOe83OLwhPsmTLg2VsAgzUk3rOlJoS/IVH7KQ/g2Nx8MzBi4/Ew==
X-Received: by 2002:a05:600c:4f03:b0:434:f396:525e with SMTP id 5b1f17b1804b1-436e269c2e6mr193327325e9.9.1736784621839;
        Mon, 13 Jan 2025 08:10:21 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1f2esm12590370f8f.98.2025.01.13.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:10:21 -0800 (PST)
Message-ID: <e4f47b8cb02d9b1d67ce58aad8b1b3da600fb02d.camel@gmail.com>
Subject: Re: [PATCH v3 7/9] iio: dac: ad3552r: share model data structures
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno Sa
	 <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 16:10:21 +0000
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-7-ab42aef0d840@baylibre.com>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
	 <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-7-ab42aef0d840@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-10 at 11:24 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Preparing for new parts to be added also in the hs driver,
> set model data structures in ad3552r-common.c, to be accessible
> from both -hs and non hs driver.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r-common.c | 46 +++++++++++++++++++++++++++++=
+++++++---
> -
> =C2=A0drivers/iio/dac/ad3552r-hs.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ----=
---
> =C2=A0drivers/iio/dac/ad3552r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 36 -------------------------------
> =C2=A0drivers/iio/dac/ad3552r.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 6 ++++--
> =C2=A04 files changed, 46 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-
> common.c
> index 03e0864f5084..ded90bf57baf 100644
> --- a/drivers/iio/dac/ad3552r-common.c
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -11,23 +11,21 @@
> =C2=A0
> =C2=A0#include "ad3552r.h"
> =C2=A0
> -const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] =3D {
> +static const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] =3D {
> =C2=A0	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	=3D { 0, 2500 },
> =C2=A0	[AD3552R_CH_OUTPUT_RANGE_0__5V]		=3D { 0, 5000 },
> =C2=A0	[AD3552R_CH_OUTPUT_RANGE_0__10V]	=3D { 0, 10000 },
> =C2=A0	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	=3D { -5000, 5000 },
> =C2=A0	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	=3D { -10000, 10000 }
> =C2=A0};
> -EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R");
> =C2=A0
> -const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] =3D {
> +static const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] =3D {
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	=3D { 0, 2500 },
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_0__5V]		=3D { 0, 5000 },
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_0__10V]	=3D { 0, 10000 },
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	=3D { -5000, 5000 },
> =C2=A0	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	=3D { -2500, 7500 }
> =C2=A0};
> -EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
> =C2=A0
> =C2=A0/* Gain * AD3552R_GAIN_SCALE */
> =C2=A0static const s32 gains_scaling_table[] =3D {
> @@ -37,6 +35,46 @@ static const s32 gains_scaling_table[] =3D {
> =C2=A0	[AD3552R_CH_GAIN_SCALING_0_125]		=3D 125
> =C2=A0};
> =C2=A0
> +const struct ad3552r_model_data ad3541r_model_data =3D {
> +	.model_name =3D "ad3541r",
> +	.chip_id =3D AD3541R_ID,
> +	.num_hw_channels =3D 1,
> +	.ranges_table =3D ad3542r_ch_ranges,
> +	.num_ranges =3D ARRAY_SIZE(ad3542r_ch_ranges),
> +	.requires_output_range =3D true,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
> +
> +const struct ad3552r_model_data ad3542r_model_data =3D {
> +	.model_name =3D "ad3542r",
> +	.chip_id =3D AD3542R_ID,
> +	.num_hw_channels =3D 2,
> +	.ranges_table =3D ad3542r_ch_ranges,
> +	.num_ranges =3D ARRAY_SIZE(ad3542r_ch_ranges),
> +	.requires_output_range =3D true,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
> +
> +const struct ad3552r_model_data ad3551r_model_data =3D {
> +	.model_name =3D "ad3551r",
> +	.chip_id =3D AD3551R_ID,
> +	.num_hw_channels =3D 1,
> +	.ranges_table =3D ad3552r_ch_ranges,
> +	.num_ranges =3D ARRAY_SIZE(ad3552r_ch_ranges),
> +	.requires_output_range =3D false,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
> +
> +const struct ad3552r_model_data ad3552r_model_data =3D {
> +	.model_name =3D "ad3552r",
> +	.chip_id =3D AD3552R_ID,
> +	.num_hw_channels =3D 2,
> +	.ranges_table =3D ad3552r_ch_ranges,
> +	.num_ranges =3D ARRAY_SIZE(ad3552r_ch_ranges),
> +	.requires_output_range =3D false,
> +};
> +EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
> +
> =C2=A0u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
> =C2=A0{
> =C2=A0	return FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1) |
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index 991b11702273..bfb6228c9b9b 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -527,14 +527,6 @@ static int ad3552r_hs_probe(struct platform_device *=
pdev)
> =C2=A0	return devm_iio_device_register(&pdev->dev, indio_dev);
> =C2=A0}
> =C2=A0
> -static const struct ad3552r_model_data ad3552r_model_data =3D {
> -	.model_name =3D "ad3552r",
> -	.chip_id =3D AD3552R_ID,
> -	.num_hw_channels =3D 2,
> -	.ranges_table =3D ad3552r_ch_ranges,
> -	.num_ranges =3D ARRAY_SIZE(ad3552r_ch_ranges),
> -};
> -
> =C2=A0static const struct of_device_id ad3552r_hs_of_id[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad3552r", .data =3D &ad3552r_model_data },
> =C2=A0	{ }
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index e7206af53af6..9d28e06b80c0 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -649,42 +649,6 @@ static int ad3552r_probe(struct spi_device *spi)
> =C2=A0	return devm_iio_device_register(&spi->dev, indio_dev);
> =C2=A0}
> =C2=A0
> -static const struct ad3552r_model_data ad3541r_model_data =3D {
> -	.model_name =3D "ad3541r",
> -	.chip_id =3D AD3541R_ID,
> -	.num_hw_channels =3D 1,
> -	.ranges_table =3D ad3542r_ch_ranges,
> -	.num_ranges =3D ARRAY_SIZE(ad3542r_ch_ranges),
> -	.requires_output_range =3D true,
> -};
> -
> -static const struct ad3552r_model_data ad3542r_model_data =3D {
> -	.model_name =3D "ad3542r",
> -	.chip_id =3D AD3542R_ID,
> -	.num_hw_channels =3D 2,
> -	.ranges_table =3D ad3542r_ch_ranges,
> -	.num_ranges =3D ARRAY_SIZE(ad3542r_ch_ranges),
> -	.requires_output_range =3D true,
> -};
> -
> -static const struct ad3552r_model_data ad3551r_model_data =3D {
> -	.model_name =3D "ad3551r",
> -	.chip_id =3D AD3551R_ID,
> -	.num_hw_channels =3D 1,
> -	.ranges_table =3D ad3552r_ch_ranges,
> -	.num_ranges =3D ARRAY_SIZE(ad3552r_ch_ranges),
> -	.requires_output_range =3D false,
> -};
> -
> -static const struct ad3552r_model_data ad3552r_model_data =3D {
> -	.model_name =3D "ad3552r",
> -	.chip_id =3D AD3552R_ID,
> -	.num_hw_channels =3D 2,
> -	.ranges_table =3D ad3552r_ch_ranges,
> -	.num_ranges =3D ARRAY_SIZE(ad3552r_ch_ranges),
> -	.requires_output_range =3D false,
> -};
> -
> =C2=A0static const struct spi_device_id ad3552r_id[] =3D {
> =C2=A0	{
> =C2=A0		.name =3D "ad3541r",
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index 4b5581039ae9..3dc8d1d9c0f9 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -134,8 +134,10 @@
> =C2=A0#define AD3542R_MAX_RANGES	5
> =C2=A0#define AD3552R_QUAD_SPI	2
> =C2=A0
> -extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
> -extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];
> +extern const struct ad3552r_model_data ad3541r_model_data;
> +extern const struct ad3552r_model_data ad3542r_model_data;
> +extern const struct ad3552r_model_data ad3551r_model_data;
> +extern const struct ad3552r_model_data ad3552r_model_data;
> =C2=A0
> =C2=A0enum ad3552r_id {
> =C2=A0	AD3541R_ID =3D 0x400b,
>=20


