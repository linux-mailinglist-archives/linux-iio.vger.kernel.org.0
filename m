Return-Path: <linux-iio+bounces-10850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EA9A6625
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 13:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96A89B218DC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62CF1E47C6;
	Mon, 21 Oct 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+XGsCE4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5A1E4113;
	Mon, 21 Oct 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729509067; cv=none; b=ucXQXLW1FO7xqU7/2fuK+RRmHWDQklUYuj5nCbnZZaaf5mBioHgIvyEn8QVGIFblBRtC/LyKCvANuM76+qG3hBbD8PTbQGc4zKm1n4ZDxzWNNOyCCbeBHpgoz1dy2YfD/3SxpOUKEhAAvP5HWes8MQ+frpGbNoiFAoZCzlHb6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729509067; c=relaxed/simple;
	bh=+bAzZdHJkLhYT2xViaFvj/FYA8M7o0i0u5aBFglRTtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wa+dhzzgnYXQn0XGb6Fo4XD/CIZW/yvZItQIZ+QJQQf1DnQ8Pr682FcSaBQyKOx1dRs3vanzOwe0YfqDMuXpBztM/alzlkKvez+1ETnHgD+5+k5NjCSpJkcaP33wj0poIpD+3zXpnLZ2LZIVIsvewwj+t8SiuKBdgQgbZdi7njo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+XGsCE4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a68480164so382449266b.3;
        Mon, 21 Oct 2024 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729509063; x=1730113863; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRPhe3PD01BFPF5Vj//QclQdPB2/iRm6LQpX4eTiwB4=;
        b=Z+XGsCE4x9RCRy04lziYQnQplcKTr7mUGYY44k9cd7Ad73Jg3J8HCI7YmY6NH1V6Px
         j4eEGZvkrH9vxAO+rtmRioThAUC7BzBcKlxBsSLZtBMLyIDiPOwNOny4md9YHbUN89MQ
         l/LM9ivuF+LAUFl0U5eU3Fe0bPgvOBXGStQ84r6qWYGS9YOeloVwESBlubPz74lG0oXA
         fB5+js+GzkZ8dH0jYe30AyyOD+J83A/bk8GIiV9I2owOcQpZMwWT6+Y/OiPySI2U1Tbi
         zMiQwaazgBy5Z0bpYP58Io0uPQKX2EWCuduDbHt/buqOa3iOLPq8zSkZDOG7DI6/0aWO
         A2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729509063; x=1730113863;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRPhe3PD01BFPF5Vj//QclQdPB2/iRm6LQpX4eTiwB4=;
        b=WIHm1ao+VRCUuN0J125NuwBHmMxY2wOupv1a7HLPpfOrsa8ZltHmx2mWPpSft6D5cq
         L9MZB4M2u0DlXw/uqyM1oXOgtE8RLeIEbdIxMjIGkqsbyA3vou0vZ/Tm1kFfxhmJ66SV
         qrqr7IFkb6qVeSwQdPfsRtO1DJyhtXvnhRjC4YxYim1e8xDK6483pL0Cfls/l1mymFM4
         rXa75Y490hg56L2mv5GrlWed9wpvnY1dwrFa82Soy7ayPNFJtNUOjcHLhjMSe0otWHeF
         gc70fPKfaXPu1GddfQfybzCfQ59zE+wF92z3pPH0RX18dwOnl9PQHggmJV1kG6J8FPt3
         Gw6g==
X-Forwarded-Encrypted: i=1; AJvYcCU4/+7qqF+2sV/R3loyeKUWh+09spZPYbtHwEKBZfQauqqUVVLArLML6hvCkska8GQw4QSD1/CdH32VX+XO@vger.kernel.org, AJvYcCWHYclWot8TSxwxYsmgikyl1SxvZSx/62s9Tv3Z1ZxEbuLlePsPtnhFRvV2YfWu8ZfSY1gVGGWgEZu3@vger.kernel.org, AJvYcCWyev77GnCZ/d4oGqO6GsNbxM78SuA+Dazvo/KKiS5kEeQnYqv8EVjrZUZrFu5WB/gk26ioAaW+uJxs@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCyJ0qzYtAMK5KPkJRG/UA7jsFR+rAXhGXi4yF/5WcETxOE47
	ondbFZ5Tscw3augV6h3Wl3Tb7A82sYocVKgyqJu+nskQtAOjP0f/
X-Google-Smtp-Source: AGHT+IFK3pr6f74QbQLaXjvX4/32aLS267OYD/Dpq4m+daaWjBcfyOz+uUb5G4u2sNzwSsqzBHj2VA==
X-Received: by 2002:a17:907:e89:b0:a99:ebcc:bfbe with SMTP id a640c23a62f3a-a9a69bad270mr1061976666b.27.1729509062344;
        Mon, 21 Oct 2024 04:11:02 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91573603sm192833666b.179.2024.10.21.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:11:02 -0700 (PDT)
Message-ID: <717d15c36fbd1a5c23526ac87bc9d66cd39c54d3.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: adc: ad7380: add missing supplies
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Julien Stephan <jstephan@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, David Lechner	
 <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown	
 <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Date: Mon, 21 Oct 2024 13:15:19 +0200
In-Reply-To: <20241021-ad7380-fix-supplies-v2-3-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
	 <20241021-ad7380-fix-supplies-v2-3-2ca551b3352a@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 12:00 +0200, Julien Stephan wrote:
> vcc and vlogic are required but are not retrieved and enabled in the
> probe. Add them.
>=20
> In order to prepare support for additional parts requiring different
> supplies, add vcc and vlogic to the platform specific structures
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

One small not below... With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 43 +++++++++++++++++++++++++++++++++++++=
++++++
> =C2=A01 file changed, 43 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> e033c734191143a25a490b09c730dbf95f796737..e257f78d63edd7910fcb936ec534492=
2f8e7
> 0b99 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -75,6 +75,7 @@
> =C2=A0#define T_CONVERT_NS 190		/* conversion time */
> =C2=A0#define T_CONVERT_0_NS 10		/* 1st conversion start time
> (oversampling) */
> =C2=A0#define T_CONVERT_X_NS 500		/* xth conversion start time
> (oversampling) */
> +#define T_POWERUP_MS 5			/* Power up */
> =C2=A0
> =C2=A0struct ad7380_timing_specs {
> =C2=A0	const unsigned int t_csh_ns;	/* CS minimum high time */
> @@ -86,6 +87,8 @@ struct ad7380_chip_info {
> =C2=A0	unsigned int num_channels;
> =C2=A0	unsigned int num_simult_channels;
> =C2=A0	bool has_mux;
> +	const char * const *supplies;
> +	unsigned int num_supplies;
> =C2=A0	const char * const *vcm_supplies;
> =C2=A0	unsigned int num_vcm_supplies;
> =C2=A0	const unsigned long *available_scan_masks;
> @@ -243,6 +246,10 @@ DEFINE_AD7380_8_CHANNEL(ad7386_4_channels, 16, 0, u)=
;
> =C2=A0DEFINE_AD7380_8_CHANNEL(ad7387_4_channels, 14, 0, u);
> =C2=A0DEFINE_AD7380_8_CHANNEL(ad7388_4_channels, 12, 0, u);
> =C2=A0
> +static const char * const ad7380_supplies[] =3D {
> +	"vcc", "vlogic",
> +};
> +
> =C2=A0static const char * const ad7380_2_channel_vcm_supplies[] =3D {
> =C2=A0	"aina", "ainb",
> =C2=A0};
> @@ -338,6 +345,8 @@ static const struct ad7380_chip_info ad7380_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7380_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7380_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> =C2=A0};
> @@ -347,6 +356,8 @@ static const struct ad7380_chip_info ad7381_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7381_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7381_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> =C2=A0};
> @@ -356,6 +367,8 @@ static const struct ad7380_chip_info ad7383_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7383_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7383_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.vcm_supplies =3D ad7380_2_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> @@ -367,6 +380,8 @@ static const struct ad7380_chip_info ad7384_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7384_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7384_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.vcm_supplies =3D ad7380_2_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_2_channel_scan_masks,
> @@ -378,6 +393,8 @@ static const struct ad7380_chip_info ad7386_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7386_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7386_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> @@ -388,6 +405,8 @@ static const struct ad7380_chip_info ad7387_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7387_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7387_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> @@ -398,6 +417,8 @@ static const struct ad7380_chip_info ad7388_chip_info=
 =3D {
> =C2=A0	.channels =3D ad7388_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7388_channels),
> =C2=A0	.num_simult_channels =3D 2,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x2_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_timing,
> @@ -408,6 +429,8 @@ static const struct ad7380_chip_info ad7380_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7380_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7380_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> =C2=A0};
> @@ -417,6 +440,8 @@ static const struct ad7380_chip_info ad7381_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7381_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7381_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> =C2=A0};
> @@ -426,6 +451,8 @@ static const struct ad7380_chip_info ad7383_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7383_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7383_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.vcm_supplies =3D ad7380_4_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> @@ -437,6 +464,8 @@ static const struct ad7380_chip_info ad7384_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7384_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7384_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.vcm_supplies =3D ad7380_4_channel_vcm_supplies,
> =C2=A0	.num_vcm_supplies =3D ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
> =C2=A0	.available_scan_masks =3D ad7380_4_channel_scan_masks,
> @@ -448,6 +477,8 @@ static const struct ad7380_chip_info ad7386_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7386_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7386_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -458,6 +489,8 @@ static const struct ad7380_chip_info ad7387_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7387_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7387_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -468,6 +501,8 @@ static const struct ad7380_chip_info ad7388_4_chip_in=
fo =3D
> {
> =C2=A0	.channels =3D ad7388_4_channels,
> =C2=A0	.num_channels =3D ARRAY_SIZE(ad7388_4_channels),
> =C2=A0	.num_simult_channels =3D 4,
> +	.supplies =3D ad7380_supplies,
> +	.num_supplies =3D ARRAY_SIZE(ad7380_supplies),
> =C2=A0	.has_mux =3D true,
> =C2=A0	.available_scan_masks =3D ad7380_2x4_channel_scan_masks,
> =C2=A0	.timing_specs =3D &ad7380_4_timing,
> @@ -1004,6 +1039,14 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0	if (!st->chip_info)
> =C2=A0		return dev_err_probe(&spi->dev, -EINVAL, "missing match
> data\n");
> =C2=A0
> +	ret =3D devm_regulator_bulk_get_enable(&spi->dev, st->chip_info-
> >num_supplies,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_info->supplies);
> +
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable power supplies\n");
> +	msleep(T_POWERUP_MS);

T_POWERUP_MS is 5ms so msleep() is not the advised API to use. In order to =
have
not to think about it, use fsleep(). This came up recently and this is one =
of
the reasons why I think (in most common cases at least) using fsleep() is a=
 good
practise even if we already know which function we need to call. Also makes
reviewers lives easier as we don't have to double check the time being slep=
t.

- Nuno S=C3=A1


