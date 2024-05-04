Return-Path: <linux-iio+bounces-4797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758688BBAF0
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 13:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 004111F22087
	for <lists+linux-iio@lfdr.de>; Sat,  4 May 2024 11:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9874A208CE;
	Sat,  4 May 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJyjbFcy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504321CFB2;
	Sat,  4 May 2024 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714823391; cv=none; b=J0UkRUoAOSdoz2+PoAg2FOgCHnUI9ctRhsAO1ATjQh/476xggFVguG1RnQ9Cm/2OshV1nDq/jY1gB8051stl4wwTCQfuNzMF9qp4bEDR0figS+DVA+OSEck4tPll4sf+DR/Yx4MP/lumEiPLOcKea7sYqxzYXH1egXS6ejM1HZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714823391; c=relaxed/simple;
	bh=9un71h1CnJjVt8tBJvPZwVsdh4JYlqrTHLazMZbjLiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC+nyhBdFMkwF7ixhyeBK58s5bZIHx4eqH411W1k8aqkwKWK6MuN1SS/Ifi2dTsULLVGeq0o4GaoGO0MOrxFlGLMl6dSO8aJqHyxRe+kTmXl+XqrXTXrpJe2KihJejxdBFpUTJCm40b8Is6BOcKAwCP8divXgotlT+BQM/Xf0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJyjbFcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0F5C072AA;
	Sat,  4 May 2024 11:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714823390;
	bh=9un71h1CnJjVt8tBJvPZwVsdh4JYlqrTHLazMZbjLiQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aJyjbFcyaMaYDHOCIrP+p0a1e9+lsllBaB4bTlmUsb16OYh9zOhSy1lEtQT2GacEF
	 TH4a/scM8ke5sv3kru8wTVAR67jXP4pxpzWmuHzF+uPgJWjbB0ykhoAIqeFF9/IwLM
	 DmIVrZtQ0lIiJaF3Vrt9eQJz1dU+w4p6gctrGF3pc+AV0cfGF3AaxbD2S0zQ6Hhwq4
	 y4jgo2K3h4kc8J03SL8FCRUu/RxIj/zHRcNj3O3WhjzfbRWjwK+1iTKP3X+/uI75XC
	 qa+P7Mupl9WOFKgMd9t6GK15eeSuEp+OjCLtpK86H2WXFg+/pgX2OZy9prGEy04Uwe
	 9AK7zNI79c18Q==
Date: Sat, 4 May 2024 12:49:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Danila Tikhonov
 <danila@jiaxyga.com>
Subject: Re: [PATCH 1/2] iio: imu: bmi160: add support for bmi120
Message-ID: <20240504124939.5ba414ec@jic23-huawei>
In-Reply-To: <20240504-bmi120-v1-1-478470a85058@gmail.com>
References: <20240504-bmi120-v1-0-478470a85058@gmail.com>
	<20240504-bmi120-v1-1-478470a85058@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 04 May 2024 01:45:24 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com> wrote:

> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Add support for bmi120 low power variant of bmi160.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Co-developed-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <trabarni@gmail.com>

Hi. A comment inline that is more about us doing things wrong
in the past than the changes you are making.  However, I would
like to fix that up whilst we are here.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 24 ++++++++++++++++++++----
>  drivers/iio/imu/bmi160/bmi160_i2c.c  |  3 +++
>  drivers/iio/imu/bmi160/bmi160_spi.c  |  3 +++
>  3 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi16=
0/bmi160_core.c
> index a77f1a8348ff..015801ad4d9a 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -26,6 +26,7 @@
>  #include "bmi160.h"
> =20
>  #define BMI160_REG_CHIP_ID	0x00
> +#define BMI120_CHIP_ID_VAL	0xD3
>  #define BMI160_CHIP_ID_VAL	0xD1
> =20
>  #define BMI160_REG_PMU_STATUS	0x03
> @@ -112,6 +113,11 @@
>  	.ext_info =3D bmi160_ext_info,				\
>  }
> =20
> +const u8 bmi_chip_ids[] =3D {
> +	BMI120_CHIP_ID_VAL,
> +	BMI160_CHIP_ID_VAL,
> +};
> +
>  /* scan indexes follow DATA register order */
>  enum bmi160_scan_axis {
>  	BMI160_SCAN_EXT_MAGN_X =3D 0,
> @@ -704,6 +710,16 @@ static int bmi160_setup_irq(struct iio_dev *indio_de=
v, int irq,
>  	return bmi160_probe_trigger(indio_dev, irq, irq_type);
>  }
> =20
> +static int bmi160_check_chip_id(const u8 chip_id)
> +{
> +	for (int i =3D 0; i < ARRAY_SIZE(bmi_chip_ids); i++) {
> +		if (chip_id =3D=3D bmi_chip_ids[i])
> +			return 0;

This falls into a miss design issue on the original driver based on
my understanding of what we should do with chip IDs back then.

My current thinking after discussing with DT maintainers is we should
at most print a warning if we fail to match an ID.

The intent being to allow for cases exactly like this one to work with
an older kernel if a fallback compatible is in use.

So whilst you are here, please could you relax the below error path
to just do a dev_warn() or similar and return 0 anyway.

Or better yet, push that warning print to the caller...

> +	}
> +
> +	return -ENODEV;
> +}
> +
>  static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>  {
>  	int ret;
> @@ -737,10 +753,10 @@ static int bmi160_chip_init(struct bmi160_data *dat=
a, bool use_spi)
>  		dev_err(dev, "Error reading chip id\n");
>  		goto disable_regulator;
>  	}
> -	if (val !=3D BMI160_CHIP_ID_VAL) {
> -		dev_err(dev, "Wrong chip id, got %x expected %x\n",
> -			val, BMI160_CHIP_ID_VAL);
> -		ret =3D -ENODEV;
> +
> +	ret =3D bmi160_check_chip_id(val);
> +	if (ret) {
> +		dev_err(dev, "Wrong chip id %x\n", val);
>  		goto disable_regulator;

For reasons given above, whilst we are hear I'd like this to change to dev_=
warn() and
carry on as if we did have a match.

>  	}
> =20
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160=
/bmi160_i2c.c
> index a081305254db..d0ec5301ad9a 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -37,6 +37,7 @@ static int bmi160_i2c_probe(struct i2c_client *client)
>  }
> =20
>  static const struct i2c_device_id bmi160_i2c_id[] =3D {
> +	{"bmi120", 0},
>  	{"bmi160", 0},
>  	{}
>  };
> @@ -52,12 +53,14 @@ static const struct acpi_device_id bmi160_acpi_match[=
] =3D {
>  	 * the affected devices are from 2021/2022.
>  	 */
>  	{"10EC5280", 0},
> +	{"BMI0120", 0},
>  	{"BMI0160", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
> =20
>  static const struct of_device_id bmi160_of_match[] =3D {
> +	{ .compatible =3D "bosch,bmi120" },
>  	{ .compatible =3D "bosch,bmi160" },
>  	{ },
>  };
> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160=
/bmi160_spi.c
> index 8b573ea99af2..9f40500132f7 100644
> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
> @@ -34,18 +34,21 @@ static int bmi160_spi_probe(struct spi_device *spi)
>  }
> =20
>  static const struct spi_device_id bmi160_spi_id[] =3D {
> +	{"bmi120", 0},
>  	{"bmi160", 0},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, bmi160_spi_id);
> =20
>  static const struct acpi_device_id bmi160_acpi_match[] =3D {
> +	{"BMI0120", 0},
>  	{"BMI0160", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
> =20
>  static const struct of_device_id bmi160_of_match[] =3D {
> +	{ .compatible =3D "bosch,bmi120" },
>  	{ .compatible =3D "bosch,bmi160" },
>  	{ },
>  };
>=20


