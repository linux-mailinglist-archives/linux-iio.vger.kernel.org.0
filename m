Return-Path: <linux-iio+bounces-10849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA79A65D1
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 13:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6C21F23AFA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE51E4113;
	Mon, 21 Oct 2024 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N98tdp60"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9985D1E22E0;
	Mon, 21 Oct 2024 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508702; cv=none; b=i9mDM48yXbEdIPuT8Nysfy1H5ls6S+tULHcj3KFLEvKuZ3mTvchCEg0YrPPBU0r6eS7Jp4824DPwqzwmqEXWDTxWoVLhmze6nmtzKJ6A8WkoV28LjtFYu2GzQiqdLxOWQ3lK8BF2A3zdyMvgS/gD+q20WyEMRWoTZmq5wwMZfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508702; c=relaxed/simple;
	bh=g0XRn4bL8F+PTYYHuf+ssiQVBA3GRk+jCGwAwlGe9wY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTGbZAV34jTXdmE/glBzBnztUKrj/7uf6wFxHbZdvks12jVnBT7BEiB0dTlmqHrkwPN62xv8paH6GePoR/peJLmsiH5YCgtXnWzHi0Z4SDI9Z2dey8NwkmPJeLruH1SlmrS5pZCGB4AV43SnPQ3/EDqxthcxTeb6gPNXH9/D2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N98tdp60; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so5452115a12.2;
        Mon, 21 Oct 2024 04:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729508699; x=1730113499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8y6wsn+hwPGY3Mz4O0vA++AgJV95+UM0IhRExtgmsY=;
        b=N98tdp60sDzAtJu/Rb1eEE3WMq/rCx36pAlUOn4Uo4UDV8zRxtce+fQeE77ZIq5fzW
         BpaF7JqNnZf7VtfggEtCjC4zCXW8GNFunmvvcZxVYLbe2NDOyrdJD1H0WX95nOocZmEb
         m1YjtZXhv9WvAPMkpNf0RLKTaYz5uyrdeAi4jYVryJ0+qpF4NIWMfvpzWL2YWwmc6OlK
         sJkIcVnPEttuJ0KqxwHFiOjWE2yUn5LyCh7nFkimrerkFtLvtOuHZGZnDfedCZWHIDmn
         St+q6/ceMlnSnGz772DCTknS/RdzHnBTol/cKjKm4dVC3o1VaJBDcauhvpb5FF1tZhUv
         3wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508699; x=1730113499;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8y6wsn+hwPGY3Mz4O0vA++AgJV95+UM0IhRExtgmsY=;
        b=AtIg+mU6y5LkoPlg1KzUjMp1Qf0QvQd3V21L/nGDTpQQV8kHcyMRFAp6LvLNKdJ1br
         LEci/Hj7IUZf0Yjjhify3TMYmq9TBFfDSTcz1iHSRar3ixNr106FdPzt2iE0GWhXBFRC
         U8FruqiAwmjZcvwntPnAfsxxSseiwguz3oHLFl293SfIjs3U2WA0BMjaF1Ya9wUKKKFA
         nNYmDgLfO1u+bDf0M709CNPK8KUkLQR47jKFH+2upWSdWgqmOqhNDtHlJKa23xbLOOpA
         j22SAHQVbja4OOJbY6mJqsKJNUYyGkb73i/eUGa33JG7evVWfwwB1AhQqsbrTK/DOAtB
         M5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCWiiq6Ooz3ErbTUv3rD62T2ZSzdhSF5PtpU9cqWMdILwVDKdQaWV9KX3Sl5pRZgJlam7zfdvCaoJUn7pj@vger.kernel.org, AJvYcCWn1A2g/5bMLXW0Lnwx95ejcO/ZvFUli29kcVkbh4uSGLJhMJUpjAROSemeFpVw3B9yzsiF9vFIbFG3@vger.kernel.org, AJvYcCXBVsLWvgbWQBUgokJbHvLg85aPEjn+2lLfNXFejACPtOX+TwkrLL+00g8LejlbZ97/upbVn+ORfDkp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4t7DyS1dnl01KNd8EFXyVpOAo4oCs1iBd0bHtV5GDUF/nWo93
	cSne1lDEgzElEsPRU7qiNl3H7bb66qqP5wBHbhTPBskbtgtWQ89q
X-Google-Smtp-Source: AGHT+IGEtyi8VupGoBT33qoHmiwSF9tw2ilDsmKB1r8ZskLq3PAFf7t6swIjWVimig/TzwQhLAb/ag==
X-Received: by 2002:a17:906:dc92:b0:a99:5601:7dc1 with SMTP id a640c23a62f3a-a9a69c67619mr873431866b.49.1729508698497;
        Mon, 21 Oct 2024 04:04:58 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9157183bsm191928766b.143.2024.10.21.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:04:58 -0700 (PDT)
Message-ID: <81255bd6069702ee896562dc1a03451a5b455b6b.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] iio: adc: ad7380: use
 devm_regulator_get_enable_read_voltage()
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
Date: Mon, 21 Oct 2024 13:09:15 +0200
In-Reply-To: <20241021-ad7380-fix-supplies-v2-2-2ca551b3352a@baylibre.com>
References: <20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com>
	 <20241021-ad7380-fix-supplies-v2-2-2ca551b3352a@baylibre.com>
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
> Use devm_regulator_get_enable_read_voltage() to simplify the code.
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

LGTM,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7380.c | 81 +++++++++++++------------------------=
----------
> -
> =C2=A01 file changed, 21 insertions(+), 60 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index
> e8bddfb0d07dbcf3e2a43344a4e0516f4d617548..e033c734191143a25a490b09c730dbf=
95f79
> 6737 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -956,7 +956,7 @@ static const struct iio_info ad7380_info =3D {
> =C2=A0	.debugfs_reg_access =3D &ad7380_debugfs_reg_access,
> =C2=A0};
> =C2=A0
> -static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
> +static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> @@ -968,13 +968,13 @@ static int ad7380_init(struct ad7380_state *st, str=
uct
> regulator *vref)
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> -	/* select internal or external reference voltage */
> -	ret =3D regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> -				 AD7380_CONFIG1_REFSEL,
> -				 FIELD_PREP(AD7380_CONFIG1_REFSEL,
> -					=C2=A0=C2=A0=C2=A0 vref ? 1 : 0));
> -	if (ret < 0)
> -		return ret;
> +	if (external_ref_en) {
> +		/* select external reference voltage */
> +		ret =3D regmap_set_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7380_CONFIG1_REFSEL);
> +		if (ret < 0)
> +			return ret;
> +	}
> =C2=A0
> =C2=A0	/* This is the default value after reset. */
> =C2=A0	st->oversampling_ratio =3D 1;
> @@ -987,16 +987,11 @@ static int ad7380_init(struct ad7380_state *st, str=
uct
> regulator *vref)
> =C2=A0				=C2=A0 FIELD_PREP(AD7380_CONFIG2_SDO, 1));
> =C2=A0}
> =C2=A0
> -static void ad7380_regulator_disable(void *p)
> -{
> -	regulator_disable(p);
> -}
> -
> =C2=A0static int ad7380_probe(struct spi_device *spi)
> =C2=A0{
> =C2=A0	struct iio_dev *indio_dev;
> =C2=A0	struct ad7380_state *st;
> -	struct regulator *vref;
> +	bool external_ref_en;
> =C2=A0	int ret, i;
> =C2=A0
> =C2=A0	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -1009,37 +1004,17 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0	if (!st->chip_info)
> =C2=A0		return dev_err_probe(&spi->dev, -EINVAL, "missing match
> data\n");
> =C2=A0
> -	vref =3D devm_regulator_get_optional(&spi->dev, "refio");
> -	if (IS_ERR(vref)) {
> -		if (PTR_ERR(vref) !=3D -ENODEV)
> -			return dev_err_probe(&spi->dev, PTR_ERR(vref),
> -					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio
> regulator\n");
> -
> -		vref =3D NULL;
> -	}
> -
> =C2=A0	/*
> =C2=A0	 * If there is no REFIO supply, then it means that we are using
> =C2=A0	 * the internal 2.5V reference, otherwise REFIO is reference volta=
ge.
> =C2=A0	 */
> -	if (vref) {
> -		ret =3D regulator_enable(vref);
> -		if (ret)
> -			return ret;
> +	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "refio");
> +	if (ret < 0 && ret !=3D -ENODEV)
> +		return dev_err_probe(&spi->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get refio regulator\n");
> =C2=A0
> -		ret =3D devm_add_action_or_reset(&spi->dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7380_regulator_disable,
> vref);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D regulator_get_voltage(vref);
> -		if (ret < 0)
> -			return ret;
> -
> -		st->vref_mv =3D ret / 1000;
> -	} else {
> -		st->vref_mv =3D AD7380_INTERNAL_REF_MV;
> -	}
> +	external_ref_en =3D ret !=3D -ENODEV;
> +	st->vref_mv =3D external_ref_en ? ret / 1000 : AD7380_INTERNAL_REF_MV;
> =C2=A0
> =C2=A0	if (st->chip_info->num_vcm_supplies > ARRAY_SIZE(st->vcm_mv))
> =C2=A0		return dev_err_probe(&spi->dev, -EINVAL,
> @@ -1050,27 +1025,13 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0	 * input pin.
> =C2=A0	 */
> =C2=A0	for (i =3D 0; i < st->chip_info->num_vcm_supplies; i++) {
> -		struct regulator *vcm;
> -
> -		vcm =3D devm_regulator_get(&spi->dev,
> -					 st->chip_info->vcm_supplies[i]);
> -		if (IS_ERR(vcm))
> -			return dev_err_probe(&spi->dev, PTR_ERR(vcm),
> -					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get %s regulator\n",
> -					=C2=A0=C2=A0=C2=A0=C2=A0 st->chip_info->vcm_supplies[i]);
> +		const char *vcm =3D st->chip_info->vcm_supplies[i];
> =C2=A0
> -		ret =3D regulator_enable(vcm);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D devm_add_action_or_reset(&spi->dev,
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7380_regulator_disable,
> vcm);
> -		if (ret)
> -			return ret;
> -
> -		ret =3D regulator_get_voltage(vcm);
> +		ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, vcm);
> =C2=A0		if (ret < 0)
> -			return ret;
> +			return dev_err_probe(&spi->dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get %s regulator\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 vcm);
> =C2=A0
> =C2=A0		st->vcm_mv[i] =3D ret / 1000;
> =C2=A0	}
> @@ -1135,7 +1096,7 @@ static int ad7380_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D ad7380_init(st, vref);
> +	ret =3D ad7380_init(st, external_ref_en);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
>=20


