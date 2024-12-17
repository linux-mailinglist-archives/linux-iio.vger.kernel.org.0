Return-Path: <linux-iio+bounces-13568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140979F483D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD127188943E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D4CEEB2;
	Tue, 17 Dec 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUxwuvbo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFC1D1E74;
	Tue, 17 Dec 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429671; cv=none; b=hMAfelJUth7IcDCX7v/eJLF5yKgsS68iBsg5GSI11JK0/s24CQvVpOyUttAjojPSg5sJ7xBRUB1ZqDL5WFBALvq0S3g4KfPXaSmUIKSdwtkcTKnU7slMV1eN9/rd9Bc/Z67b1RT4+lVm0Sgg8SNSek5KejP58/OCDT0atan+dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429671; c=relaxed/simple;
	bh=Y26ngMJwmzLrecKXox6zLaQNcWVmYecAcG5gSb/BW3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jaL7b/AMj8stpYuwH9hpcRYUkZ0NUNJJtvmbUDsniVwGFZUQZPe/EluwNMBKJkvo2y3inQ4B2v+fuJnqOn+QBEH39tcDJkIG+xL2LO+KgPKLMUusWwLK1BK7FibsrlDpgckT0JvYljHqfhqY2+vdfiBnZmMBR2InoNnqB2vcG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUxwuvbo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso857460566b.3;
        Tue, 17 Dec 2024 02:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734429668; x=1735034468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T/KooR6IQJjeTGPNoTWcPk0AI9wdR/UJG41mcu5SvWU=;
        b=VUxwuvbod1Nun2iG3bouDNc1UQeoLEmqktvc2YzGm5xqDLVwavk7+puSJ9XWoPFSyp
         Ym6wKzjZFEGBEtzJ/lcifCJXYqNLJeT4v5ixXMHA53TBy+GaaolEGtcZpP5sNPXIb3DS
         APz0KBn5v6GiK98pKsiN7XQKNPqFQVty+YKBctirPOGtga6bNJbCEBDja7FqAqp0VuLG
         qwKP3Cna0rznUV2m9MNAMlze4gSqLUXwXs+BVHQ/UGwt2L2ipRiH+RSgyrI/c6ARUbtg
         4/vbmHZZBs8WtZfduYcwSLjzXQKRuUD5kGxYc2Xe1QoLmJNyH/5alKTcfgNhj4HlTXu1
         JE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734429668; x=1735034468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/KooR6IQJjeTGPNoTWcPk0AI9wdR/UJG41mcu5SvWU=;
        b=vHMmfCfc3XuxYQFk+8BRAXqvTZoAijLxGkUeO5tckKUeyCOQ2ixbxfd73hS5TSwJH0
         XaJvTXstzi+YLYqMi9uYmnBv0WMNi4MaA3pFcBcWks+SDN5W8Yeif86o+WDNnxX306T8
         EeV9z/olCzOLsWbkRKVAz3hGKhNccb3FwQwcE3w1crsfad05tz3aOauLI2so+/fPkUFq
         rAbcEfB2fHdEcHD+SZkdvTm0af+h5vtffThFVso8EodbkZEztFoKW5J/edldW3zdo952
         qlAIjTsiSW4fZ03UoDk6iboRUOB6m2iPbHehD3J9OIGYdyQonldxf99cCb49fKVarG8D
         6PmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0V+AKUELAXjJAUMD2NX9OwW+ltcl4MaxBzcrZJJpITizo/QgCylC64MK8aZW0nbbmZIsKfCSDGABiYTEZ@vger.kernel.org, AJvYcCWTENqHcIjCSNbnEz2E1POY5aCT+8ghspXl1KeUD55ISPR9ILIIN5ldS7UWwRng8FVxT7rt5IZxaAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZwl4AFIj3Ep9zCC+2n8c6Vt/57DwElNxmRApT4UayUqsHoVf+
	sDALFuVeWmUuWmIGEtcAlNP1YqRpGSWm9kKIJ/N4s4P/18g2Bl33
X-Gm-Gg: ASbGnctoTHVZHhqyobJPS3AYIL6PIZGs06yj0A3hkdaU2YJUGTFGpHNt8HV7+7lVjKR
	If60LSqhlGaR+OYa+1/iH3RVr03ddrX+htdjbxcDJh82IieSJMnYcfvMw6mRyXksKIzi88zSkY5
	eGD+0RfKoqLKzPAw9lM4r4o6hZmSTFaKHXwPQHg0nWXwm+LM/HoDGjT6kMztJfe1Aodxyd2Zy0S
	/0ADQkE3N07VyM3stup0jFMXluDVRDDjEZtWG9uW0YNxIQaLadIONrxw3FqI13PNzdqZLPtAg1Q
	/H+pyULD1cQ5PBebEorD61n2eaoYkcRS12YCP1nWE4tFobzOigvrX0b7JuBb93EVhmqDE+Ko9fb
	wC127dhKFYQ371Q==
X-Google-Smtp-Source: AGHT+IFzYJKhIqYUcWAJCCoFgQwgCGkoZ5FkRNxYWL4g0lWYIy/cSB5K0Fn22tTr1JWlMgO5CmKtlA==
X-Received: by 2002:a17:906:6bd4:b0:aab:9268:2626 with SMTP id a640c23a62f3a-aab92682666mr1148960166b.25.1734429667673;
        Tue, 17 Dec 2024 02:01:07 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabbe35c629sm249217166b.175.2024.12.17.02.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:01:07 -0800 (PST)
Message-ID: <f24abf927dcd21866bdb335d5ed27f3be4d94705.camel@gmail.com>
Subject: Re: [PATCH v2] iio: dac: ad7293: enable power before reset
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Liam Girdwood	
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Antoniu Miclaus	
 <antoniu.miclaus@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 17 Dec 2024 11:05:38 +0100
In-Reply-To: <20241216-iio-regulator-cleanup-round-6-v2-1-9482164b68cb@baylibre.com>
References: 
	<20241216-iio-regulator-cleanup-round-6-v2-1-9482164b68cb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-16 at 15:44 -0600, David Lechner wrote:
> Change the order of regulator enable and reset so that power supplies
> are turned on before touching the reset line. Generally, chips should
> have the VDRIVE supply enabled before applying voltage on any pins.
>=20
> While we are at it, remove the voltage level checks. If the power
> supplies are not supplying the correct voltage, this is a hardware
> design problem, not a software problem.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> Changes in v2:
> - Dropped patches from "iio: use devm_regulator_get_enable_read_voltage
> =C2=A0 round 6" that have already been applied.
> - New patch for ad7293 that just enables power supplies and no longer
> =C2=A0 reads the voltage.
> - Link to v1:
> https://lore.kernel.org/r/20241120-iio-regulator-cleanup-round-6-v1-0-d5a=
5360f7ec3@baylibre.com
> ---
> =C2=A0drivers/iio/dac/ad7293.c | 68 +++++++------------------------------=
----------
> -
> =C2=A01 file changed, 9 insertions(+), 59 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
> index
> 1d403267048240be1bf3d8b2a59685409b9087fd..d3f49b5337d2f512363d50b434d99d4=
e9b95
> 059f 100644
> --- a/drivers/iio/dac/ad7293.c
> +++ b/drivers/iio/dac/ad7293.c
> @@ -141,8 +141,6 @@ struct ad7293_state {
> =C2=A0	/* Protect against concurrent accesses to the device, page selecti=
on
> and data content */
> =C2=A0	struct mutex lock;
> =C2=A0	struct gpio_desc *gpio_reset;
> -	struct regulator *reg_avdd;
> -	struct regulator *reg_vdrive;
> =C2=A0	u8 page_select;
> =C2=A0	u8 data[3] __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> @@ -777,6 +775,15 @@ static int ad7293_reset(struct ad7293_state *st)
> =C2=A0static int ad7293_properties_parse(struct ad7293_state *st)
> =C2=A0{
> =C2=A0	struct spi_device *spi =3D st->spi;
> +	int ret;
> +
> +	ret =3D devm_regulator_get_enable(&spi->dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "failed to enable
> AVDD\n");
> +
> +	ret =3D devm_regulator_get_enable(&spi->dev, "vdrive");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "failed to enable
> VDRIVE\n");
> =C2=A0
> =C2=A0	st->gpio_reset =3D devm_gpiod_get_optional(&st->spi->dev, "reset",
> =C2=A0						 GPIOD_OUT_HIGH);
> @@ -784,24 +791,9 @@ static int ad7293_properties_parse(struct ad7293_sta=
te
> *st)
> =C2=A0		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_reset),
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get the reset GPIO\n");
> =C2=A0
> -	st->reg_avdd =3D devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(st->reg_avdd))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_avdd),
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get the AVDD voltage\n");
> -
> -	st->reg_vdrive =3D devm_regulator_get(&spi->dev, "vdrive");
> -	if (IS_ERR(st->reg_vdrive))
> -		return dev_err_probe(&spi->dev, PTR_ERR(st->reg_vdrive),
> -				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get the VDRIVE voltage\n");
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static void ad7293_reg_disable(void *data)
> -{
> -	regulator_disable(data);
> -}
> -
> =C2=A0static int ad7293_init(struct ad7293_state *st)
> =C2=A0{
> =C2=A0	int ret;
> @@ -816,48 +808,6 @@ static int ad7293_init(struct ad7293_state *st)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D regulator_enable(st->reg_avdd);
> -	if (ret) {
> -		dev_err(&spi->dev,
> -			"Failed to enable specified AVDD Voltage!\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->reg_avdd);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D regulator_enable(st->reg_vdrive);
> -	if (ret) {
> -		dev_err(&spi->dev,
> -			"Failed to enable specified VDRIVE Voltage!\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7293_reg_disable,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->reg_vdrive);
> -	if (ret)
> -		return ret;
> -
> -	ret =3D regulator_get_voltage(st->reg_avdd);
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "Failed to read avdd regulator: %d\n",
> ret);
> -		return ret;
> -	}
> -
> -	if (ret > 5500000 || ret < 4500000)
> -		return -EINVAL;
> -
> -	ret =3D regulator_get_voltage(st->reg_vdrive);
> -	if (ret < 0) {
> -		dev_err(&spi->dev,
> -			"Failed to read vdrive regulator: %d\n", ret);
> -		return ret;
> -	}
> -	if (ret > 5500000 || ret < 1700000)
> -		return -EINVAL;
> -
> =C2=A0	/* Check Chip ID */
> =C2=A0	ret =3D __ad7293_spi_read(st, AD7293_REG_DEVICE_ID, &chip_id);
> =C2=A0	if (ret)
>=20
> ---
> base-commit: 01958cb8a00d9721ae56ad1eef9cd7b22b5a34bb
> change-id: 20241120-iio-regulator-cleanup-round-6-78b05be06718
>=20
> Best regards,


