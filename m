Return-Path: <linux-iio+bounces-8289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D19495DD
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED11B292D0
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE283987D;
	Tue,  6 Aug 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5pMaJZs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D852CCB4;
	Tue,  6 Aug 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961574; cv=none; b=GevJgsfs++4ClQc3h2MlDt0dxDpY8CWl4wXXOhMZ49oh0ISMB1Gyzo33Wv4lhlXf9zDGxyryfaXIQ5lcQGqEChtyDJkYQoyyx0sWO3fJcQcu1tNEAwMvf3O1lh9c8vbcY9tiL4IeT9XqrPoERP/bqOVqa/oDKitXfkVY0F2b9FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961574; c=relaxed/simple;
	bh=Vjv0V/uG16R4fZgzBaumYU0oSr4O7jzDA1OaNjUL4f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muw7O2TVip+COXQ8aJAPu/Ey5jFpYlggnwX9A4rqS6QrJJoCLB8J3Jx4tU2wfTyKRKTDJ7JGt2arJLS4oYoy9pVy5QXMM8te4wCk3Wkcz2+THD8Vlma+Hw9+/0jv9K3rxwncep4mEP1cqCbmxSwulPzGA8JwBZ0F0GsBaHe81FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5pMaJZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7E2C32786;
	Tue,  6 Aug 2024 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722961574;
	bh=Vjv0V/uG16R4fZgzBaumYU0oSr4O7jzDA1OaNjUL4f0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5pMaJZsEJTwg5xVcaxfM7y+ZDa03a9I+qJMxZ3MaEhwv9Y3PASfpa6+9BfvXkalp
	 TJwwhdmA3aae/sKPrDoNYFWZnvyHFmS8VW0iwq3R3DXHhG2hRPdK9InNYRerLLGhn2
	 lWN/2y1lYGjYymk/Lrn0SyNpqNmoTxM+0KsUI9U0SzoOBuzE+Z5hUXlowdTfFK42pv
	 EMV3uK20gamsRSMQiweJ/mTil6TMCjVWSIDEIHZ0THtkB5omHo7NpTAAjrBKl4XBoS
	 MIaxiH+L435YESynZhHaELO286IQ9m4J9E2HPeRe4A/0PzOitHZ/CBSJ1gGWA0q2in
	 cTPDL/4uEZFTw==
Date: Tue, 6 Aug 2024 17:26:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org, Danila Tikhonov
 <danila@jiaxyga.com>
Subject: Re: [PATCH v2 3/3] iio: magnetometer: ak8975: Add AK09118 support
Message-ID: <20240806172606.70a07084@jic23-huawei>
In-Reply-To: <20240806-ak09918-v2-3-c300da66c198@mainlining.org>
References: <20240806-ak09918-v2-0-c300da66c198@mainlining.org>
	<20240806-ak09918-v2-3-c300da66c198@mainlining.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 06 Aug 2024 08:10:20 +0200
Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining.org> wrote:

> From: Danila Tikhonov <danila@jiaxyga.com>
>=20
> Add additional AK09118 to the magnetometer driver which has the same
> register mapping and scaling as the AK09112 device.
>=20
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

It definitely seems like a fallback compatible is suitable, but we
will still want the more precise match in the driver so that we can
avoid printing an info message to say we saw an unexpected ID.

Comments on that inline.

> ---
>  drivers/iio/magnetometer/Kconfig  |  2 +-
>  drivers/iio/magnetometer/ak8975.c | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/=
Kconfig
> index cd2917d71904..8eb718f5e50f 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -39,7 +39,7 @@ config AK8975
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
> -	  AK09911, AK09912 or AK09916 3-Axis Magnetometer.
> +	  AK09911, AK09912, AK09916 or AK09918 3-Axis Magnetometer.
> =20
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ak8975.
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer=
/ak8975.c
> index 925d76062b3e..9871fea67ae3 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -78,6 +78,7 @@
>   */
>  #define AK09912_REG_WIA1		0x00
>  #define AK09912_REG_WIA2		0x01
> +#define AK09918_DEVICE_ID		0x0C
>  #define AK09916_DEVICE_ID		0x09
>  #define AK09912_DEVICE_ID		0x04
>  #define AK09911_DEVICE_ID		0x05
> @@ -209,6 +210,7 @@ enum asahi_compass_chipset {
>  	AK09911,
>  	AK09912,
>  	AK09916,
> +	AK09918,
>  };
> =20
>  enum ak_ctrl_reg_addr {
> @@ -371,6 +373,31 @@ static const struct ak_def ak_def_array[] =3D {
>  			AK09912_REG_HXL,
>  			AK09912_REG_HYL,
>  			AK09912_REG_HZL},
> +	},
> +	[AK09918] =3D {
> +		.type =3D AK09918,
> +		.raw_to_gauss =3D ak09912_raw_to_gauss,
> +		.range =3D 32752,
> +		.ctrl_regs =3D {
> +			AK09912_REG_ST1,
> +			AK09912_REG_ST2,
> +			AK09912_REG_CNTL2,
> +			AK09912_REG_ASAX,
> +			AK09912_MAX_REGS},
> +		.ctrl_masks =3D {
> +			AK09912_REG_ST1_DRDY_MASK,
> +			AK09912_REG_ST2_HOFL_MASK,
> +			0,
> +			AK09912_REG_CNTL2_MODE_MASK},
> +		.ctrl_modes =3D {
> +			AK09912_REG_CNTL_MODE_POWER_DOWN,
> +			AK09912_REG_CNTL_MODE_ONCE,
> +			AK09912_REG_CNTL_MODE_SELF_TEST,
> +			AK09912_REG_CNTL_MODE_FUSE_ROM},
> +		.data_regs =3D {
> +			AK09912_REG_HXL,
> +			AK09912_REG_HYL,
> +			AK09912_REG_HZL},
>  	}
>  };
> =20
> @@ -452,6 +479,7 @@ static int ak8975_who_i_am(struct i2c_client *client,
>  	/*
>  	 * Signature for each device:
>  	 * Device   |  WIA1      |  WIA2
> +	 * AK09918  |  DEVICE_ID_|  AK09918_DEVICE_ID
>  	 * AK09916  |  DEVICE_ID_|  AK09916_DEVICE_ID
>  	 * AK09912  |  DEVICE_ID |  AK09912_DEVICE_ID
>  	 * AK09911  |  DEVICE_ID |  AK09911_DEVICE_ID
> @@ -484,6 +512,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
>  		if (wia_val[1] =3D=3D AK09916_DEVICE_ID)
>  			return 0;
>  		break;
> +	case AK09918:
> +		if (wia_val[1] =3D=3D AK09918_DEVICE_ID)
> +			return 0;
> +		break;
Whilst you are changing this code, please make it accept an unknown ID
with at most a dev_info() print. We used to get this wrong in IIO, but
this flexibility in matching Who Am I values is necessary to enable
fallback compatibles in DT.

Those allow you to use a newer DT with an older driver. It will
use the fallback ID to probe, so will get the ak09912 who am I value
and fail to probe currently.  We want it to succeed if they are
completely compatible other than this ID.

>  	default:
>  		dev_err(&client->dev, "Type %d unknown\n", type);
>  	}
> @@ -1066,6 +1098,7 @@ static const struct i2c_device_id ak8975_id[] =3D {
>  	{"ak09911", (kernel_ulong_t)&ak_def_array[AK09911] },
>  	{"ak09912", (kernel_ulong_t)&ak_def_array[AK09912] },
>  	{"ak09916", (kernel_ulong_t)&ak_def_array[AK09916] },
> +	{"ak09918", (kernel_ulong_t)&ak_def_array[AK09918] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, ak8975_id);
> @@ -1081,6 +1114,7 @@ static const struct of_device_id ak8975_of_match[] =
=3D {
>  	{ .compatible =3D "ak09912", .data =3D &ak_def_array[AK09912] },
>  	{ .compatible =3D "asahi-kasei,ak09916", .data =3D &ak_def_array[AK0991=
6] },
>  	{ .compatible =3D "ak09916", .data =3D &ak_def_array[AK09916] },
> +	{ .compatible =3D "asahi-kasei,ak09918", .data =3D &ak_def_array[AK0991=
8] },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, ak8975_of_match);
>=20


