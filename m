Return-Path: <linux-iio+bounces-5814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65058FC6AC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70237281543
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D534964C;
	Wed,  5 Jun 2024 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIYiYo8A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDA1946A3;
	Wed,  5 Jun 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576601; cv=none; b=rIffdCmZw74sfuo6EEoCITcRmdRknNO5K3LbOJYjzMo0vIFogd36bzw4AhR7AVEew5mvS4YlhUitadtAD+7sRx6QyP+ZSrReEFlKyZ/Baky3CvIhdJeaRBHAkfQYKZeiCuxbHKZqCCRc/BHS4a3gjpbpBt9pLwEgrptTqEE4KZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576601; c=relaxed/simple;
	bh=zAVgnrzt8gY1Pai8QXInmX9wwGv+TNFf8YSvs/17vS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZVkmbYHjnpbRX79JQNbOflMiItsMFZiUNUCRjMFnMfulHJpV0m+ozxIRIZWbJwcBjsl15+zvMHJ3QNl+WEMVmpxu76HZpNaSnoY5TKx1a9P7Pv+1CwsHdUZqWKfIU8JZ/jCQfHbgaNxqE6XsQG0TEPPR7DLbnndZH/k1D2D6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIYiYo8A; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a50ac2ca1so4756875a12.0;
        Wed, 05 Jun 2024 01:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717576598; x=1718181398; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yi0V3FoRMnhomLDSAL9Tbb7CDsRMdBKoZbPY2dwYGfs=;
        b=aIYiYo8Akt9HX/5QM2SUmYzD9DevhUwEHrweB3a4fSXYUIxKN89e9H0YfBQJyaLLY9
         t/pqJ01gipKcvPiJya+KqT0wAfCD50vpiN0UrCsD9Q9ZsnQzXWtlL9BJmSTXTAsffHUM
         AxEjZvQ17RTBxRwGC9HweoLwAJa8+NxFewMN5k+7PpY7+8Sl6EqrNMr03IZZECO8u2AN
         /6ifXNqWEIcUrSgjv1WA1O1hdjtMOiOPw8ZPmtuokAfp0AWcRFNtiW6XO5DB6zSC7SZo
         aPuKYzTRjkgdRgD9KF+S5II6NAp3kiVtTNzki6jM9CAAkQaD8+opbx6t5eJ9tVTGUuJ3
         3ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576598; x=1718181398;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yi0V3FoRMnhomLDSAL9Tbb7CDsRMdBKoZbPY2dwYGfs=;
        b=uekorm6g1RBKCGvoi1Wy80OBBZDmImDx1D1NuGri8eJmtY0cyU+AHKE34ANXAby+up
         3E4rlo5JGOo/A73ntxFYelVuGWANEd5VMbHa1/b9E0lT8cETaKAWZbm3ovSJ6OKUs47j
         OB8Q4pBcct2mp+9jOzLo04+fHVLG21xLRoM8GZwhMwLbwUHv0ZZDg3RNpeMB+6RKKGwW
         FOVwKkKzFE9oJhoQ3G8V+au5BrcZQjAuJ/R65XO97htlpO1CF8EGbjWgKWtFj2Z33ph8
         x7KELiTYkResgmyoSQbyUZvmnoYUB9v211oCmU7y02swOlmHGbzzaoOeaGCh1nJtxAmi
         8vwA==
X-Forwarded-Encrypted: i=1; AJvYcCW778hZuKKTiEpk0E+Gzk4eTaAvLI93grB5L+giOBGFBKxMerA4j6hMYGyTzj248ps1YxsUoGWbYEABMQEYHzv9S+YULlWwYC23HmcmrQpr3hUwpLJsA2bpEQCmae7y72QMr5D4DbU40WaN7uHbPLUQjJF8pPLphe0ZOckM/n3pztt88w==
X-Gm-Message-State: AOJu0YzHzLVvZoiPD4vkgWnjmgRlRvBeFAXVSudoezS14yZ3Qbg5VaSk
	BJQ+//9Jsr8lP33AAiRTF4iRKXjuNARpRwcOtRCfUxlwnPbQ/QsM
X-Google-Smtp-Source: AGHT+IEsOv/Y++AYE6WBz0+6lZYXrgd9hU1+hxAMq8HpK742apAlPquziV6tPAtaRPsg427g/BzC0A==
X-Received: by 2002:a50:d75a:0:b0:579:d01a:938b with SMTP id 4fb4d7f45d1cf-57a8bcc82e8mr1164301a12.35.1717576597686;
        Wed, 05 Jun 2024 01:36:37 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a7a25aba9sm3415705a12.66.2024.06.05.01.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:36:37 -0700 (PDT)
Message-ID: <131231eb77014ce38bbe611e99be5ebb713c471d.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] iio: adc: ad7192: Clean up dev
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
Date: Wed, 05 Jun 2024 10:40:24 +0200
In-Reply-To: <20240605075154.625123-1-alisa.roman@analog.com>
References: <20240605075154.625123-1-alisa.roman@analog.com>
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
> Clean up by using a local variable struct device *dev.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7192.c | 45 ++++++++++++++++++++-----------------=
---
> =C2=A01 file changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 0789121236d6..f06cb7ac4b42 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -1196,17 +1196,18 @@ static void ad7192_reg_disable(void *reg)
> =C2=A0
> =C2=A0static int ad7192_probe(struct spi_device *spi)
> =C2=A0{
> +	struct device *dev =3D &spi->dev;
> =C2=A0	struct ad7192_state *st;
> =C2=A0	struct iio_dev *indio_dev;
> =C2=A0	struct regulator *aincom;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	if (!spi->irq) {
> -		dev_err(&spi->dev, "no IRQ?\n");
> +		dev_err(dev, "no IRQ?\n");

Since you're here, dev_err_probe()?

> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> -	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> =C2=A0	if (!indio_dev)
> =C2=A0		return -ENOMEM;
> =C2=A0
> @@ -1219,71 +1220,71 @@ static int ad7192_probe(struct spi_device *spi)
> =C2=A0	 * Newer firmware should provide a zero volt fixed supply if wired=
 to
> =C2=A0	 * ground.
> =C2=A0	 */
> -	aincom =3D devm_regulator_get_optional(&spi->dev, "aincom");
> +	aincom =3D devm_regulator_get_optional(dev, "aincom");
> =C2=A0	if (IS_ERR(aincom)) {
> =C2=A0		if (PTR_ERR(aincom) !=3D -ENODEV)
> -			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
> +			return dev_err_probe(dev, PTR_ERR(aincom),
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get AINCOM
> supply\n");
> =C2=A0
> =C2=A0		st->aincom_mv =3D 0;
> =C2=A0	} else {
> =C2=A0		ret =3D regulator_enable(aincom);
> =C2=A0		if (ret)
> -			return dev_err_probe(&spi->dev, ret,
> +			return dev_err_probe(dev, ret,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable specified
> AINCOM supply\n");
> =C2=A0
> -		ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable,
> aincom);
> +		ret =3D devm_add_action_or_reset(dev, ad7192_reg_disable,
> aincom);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> =C2=A0		ret =3D regulator_get_voltage(aincom);
> =C2=A0		if (ret < 0)
> -			return dev_err_probe(&spi->dev, ret,
> +			return dev_err_probe(dev, ret,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Device tree error, AINCOM
> voltage undefined\n");
> =C2=A0		st->aincom_mv =3D ret / MILLI;
> =C2=A0	}
> =C2=A0
> -	st->avdd =3D devm_regulator_get(&spi->dev, "avdd");
> +	st->avdd =3D devm_regulator_get(dev, "avdd");
> =C2=A0	if (IS_ERR(st->avdd))
> =C2=A0		return PTR_ERR(st->avdd);
> =C2=A0
> =C2=A0	ret =3D regulator_enable(st->avdd);
> =C2=A0	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVdd
> supply\n");
> +		dev_err(dev, "Failed to enable specified AVdd supply\n");

ditto

> =C2=A0		return ret;
> =C2=A0	}
> =C2=A0
> -	ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, st-
> >avdd);
> +	ret =3D devm_add_action_or_reset(dev, ad7192_reg_disable, st->avdd);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_regulator_get_enable(&spi->dev, "dvdd");
> +	ret =3D devm_regulator_get_enable(dev, "dvdd");
> =C2=A0	if (ret)
> -		return dev_err_probe(&spi->dev, ret, "Failed to enable
> specified DVdd supply\n");
> +		return dev_err_probe(dev, ret, "Failed to enable specified
> DVdd supply\n");
> =C2=A0
> -	st->vref =3D devm_regulator_get_optional(&spi->dev, "vref");
> +	st->vref =3D devm_regulator_get_optional(dev, "vref");
> =C2=A0	if (IS_ERR(st->vref)) {
> =C2=A0		if (PTR_ERR(st->vref) !=3D -ENODEV)
> =C2=A0			return PTR_ERR(st->vref);
> =C2=A0
> =C2=A0		ret =3D regulator_get_voltage(st->avdd);
> =C2=A0		if (ret < 0)
> -			return dev_err_probe(&spi->dev, ret,
> +			return dev_err_probe(dev, ret,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Device tree error, AVdd voltage
> undefined\n");
> =C2=A0	} else {
> =C2=A0		ret =3D regulator_enable(st->vref);
> =C2=A0		if (ret) {
> -			dev_err(&spi->dev, "Failed to enable specified Vref
> supply\n");
> +			dev_err(dev, "Failed to enable specified Vref
> supply\n");

ditto

> =C2=A0			return ret;
> =C2=A0		}
> =C2=A0
> -		ret =3D devm_add_action_or_reset(&spi->dev, ad7192_reg_disable,
> st->vref);
> +		ret =3D devm_add_action_or_reset(dev, ad7192_reg_disable, st-
> >vref);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> =C2=A0		ret =3D regulator_get_voltage(st->vref);
> =C2=A0		if (ret < 0)
> -			return dev_err_probe(&spi->dev, ret,
> +			return dev_err_probe(dev, ret,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Device tree error, Vref voltage
> undefined\n");
> =C2=A0	}
> =C2=A0	st->int_vref_mv =3D ret / 1000;
> @@ -1305,13 +1306,13 @@ static int ad7192_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_ad_sd_setup_buffer_and_trigger(&spi->dev, indio_dev);
> +	ret =3D devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> =C2=A0	st->fclk =3D AD7192_INT_FREQ_MHZ;
> =C2=A0
> -	st->mclk =3D devm_clk_get_optional_enabled(&spi->dev, "mclk");
> +	st->mclk =3D devm_clk_get_optional_enabled(dev, "mclk");
> =C2=A0	if (IS_ERR(st->mclk))
> =C2=A0		return PTR_ERR(st->mclk);
> =C2=A0
> @@ -1321,17 +1322,17 @@ static int ad7192_probe(struct spi_device *spi)
> =C2=A0	=C2=A0=C2=A0=C2=A0 st->clock_sel =3D=3D AD7192_CLK_EXT_MCLK2) {
> =C2=A0		st->fclk =3D clk_get_rate(st->mclk);
> =C2=A0		if (!ad7192_valid_external_frequency(st->fclk)) {
> -			dev_err(&spi->dev,
> +			dev_err(dev,
> =C2=A0				"External clock frequency out of bounds\n");

ditto=20

- Nuno S=C3=A1

