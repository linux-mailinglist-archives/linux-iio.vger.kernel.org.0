Return-Path: <linux-iio+bounces-12535-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D979D69AD
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62265B211C9
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 15:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F5E2868B;
	Sat, 23 Nov 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP/oM7eJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E223098E;
	Sat, 23 Nov 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732376022; cv=none; b=HX9/5tTlrL4PK7hB709z9q/OUmNUpgDFBFFxfRO0Rab5nLDRS8M9Tq8bmO0BI1RLHBCPK+LlsNK9/4u5i0suVUelvSyV7svAmhZCYaOnD4SNdbjHhTk+ZDA47KvbGdkQZxa6HB6CbFhCTi4VbU9TrOQwFJga6XtkKcRVaFlQdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732376022; c=relaxed/simple;
	bh=u7+nQ5KHKT2wllCPlN+E1ybOmaPbC4b2xmZSrKa8wKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+qh9JqzyQ75JRAL791qVFJMj/JQNWL18it00C1hL1dXpnt0VAcSuX4L2DovXuURjFh3X7fFROpvVnI8YbUycjzFRYfrcU5B2dJqG6yfQS7iwdazzhBDyM/smN2k4xr+m4OT2c5KCitrJ+FmMmlVi5yGB5VH/J50qKlbVGN0yWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP/oM7eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CF0C4CECD;
	Sat, 23 Nov 2024 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732376021;
	bh=u7+nQ5KHKT2wllCPlN+E1ybOmaPbC4b2xmZSrKa8wKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MP/oM7eJEvhrtyGvQnOtGXsCWD4cO5bRsyn4xVOV6cwMgRbeKK/CDgWkWrdkVhYCF
	 PWtYC+WNcmxMWGzof/YCA0UD7L1gQjBHHDO3U5GqYEJEhg86Inz3hS4ApXL1VDpJOA
	 JO8s8N6i9fKRRuDzeFa1RpuyHydFchuECRZwSdF2b7RshCv6d6ODEwTArHidXKGzmm
	 kAgMW8CbbEay4vRP+2Zc0fiBYpf4LF09tE+CYLr5NCFEHJi4FNUH+BqbAYB3cP34uZ
	 K8FDlLH/UAGRj4hEqDySyI+YoskClOVVqv2y9cMJo6VsKdVDANkMhE+1R/CR34LbXM
	 HgCMvdlpmHkbQ==
Date: Sat, 23 Nov 2024 15:33:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
Message-ID: <20241123153333.51e4a517@jic23-huawei>
In-Reply-To: <FR3P281MB17572DAAB3B3145EE7AD56E6CE212@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20241115-iam20380-v2-0-d8d9dc6891f5@nxp.com>
	<20241115-iam20380-v2-2-d8d9dc6891f5@nxp.com>
	<FR3P281MB17572DAAB3B3145EE7AD56E6CE212@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2024 11:05:23 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> overall looks good, but I've got one concern.
>=20
> The gyro bits used for scan mask are the same than other chips, meaning b=
its 4, 5, 6, and timestamp is bit 7, and these are the only bits since the =
chip is gyro only. Usually scan mask bits start at 0. I don't know if start=
ing from 4 will work or not.
>=20
> Jonathan,
> do you know if this can be an issue?

Shouldn't be an issue.  There are various drivers that do this.
https://elixir.bootlin.com/linux/v6.12/source/drivers/iio/imu/adis16400.c#L=
821
was one example that I remembered as IIRC that driver was the motivation fo=
r these
being sparse.

Normally we just pack them together because it feels neat and tidy plus
for high channel count devices means we can still use a single unsigned long
for the channel bitmaps.  It's not a requirement as such...

Jonathan

>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Frank Li <Frank.Li@nxp.com>
> Sent:=C2=A0Friday, November 15, 2024 23:37
> To:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Jonatha=
n Cameron <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Rob Her=
ring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Doo=
ley <conor+dt@kernel.org>
> Cc:=C2=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicetre=
e@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.or=
g <linux-kernel@vger.kernel.org>; Frank Li <Frank.Li@nxp.com>; Han Xu <han.=
xu@nxp.com>
> Subject:=C2=A0[PATCH v2 2/2] iio: gyro: Add support for iam20380 sensor
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> From: Han Xu <han.xu@nxp.com>
>=20
> Add support for the Invensense IAM20380 sensor to the MPU6050 driver. It =
is
> similar to the IAM20680. But IAM20380 only supports gyro and WHOAMI
> register data is difference.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 25 +++++++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 ++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 +++++
>  4 files changed, 38 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 40271352b02cf..a7535cbc214e9 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -277,6 +277,14 @@ static const struct inv_mpu6050_hw hw_info[] =3D {
>  		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
>  		.startup_time =3D {INV_ICM20690_GYRO_STARTUP_TIME, INV_ICM20690_ACCEL_=
STARTUP_TIME},
>  	},
> +	{	.whoami =3D INV_IAM20380_WHOAMI_VALUE,
> +		.name =3D "IAM20380",
> +		.reg =3D &reg_set_6500,
> +		.config =3D &chip_config_6500,
> +		.fifo_size =3D 512,
> +		.temp =3D {INV_ICM20608_TEMP_OFFSET, INV_ICM20608_TEMP_SCALE},
> +		.startup_time =3D {INV_MPU6500_GYRO_STARTUP_TIME, INV_MPU6500_ACCEL_ST=
ARTUP_TIME},
> +	},
>  	{
>  		.whoami =3D INV_IAM20680_WHOAMI_VALUE,
>  		.name =3D "IAM20680",
> @@ -1519,6 +1527,14 @@ static const struct iio_chan_spec inv_mpu6050_chan=
nels[] =3D {
>  	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
>  };
> =20
> +static const struct iio_chan_spec inv_iam20380_channels[] =3D {
> +	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
> +
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU6050_SCAN_GYRO_X),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU6050_SCAN_GYRO_Y),
> +	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU6050_SCAN_GYRO_Z),
> +};
> +
>  static const struct iio_chan_spec inv_mpu6500_channels[] =3D {
>  	IIO_CHAN_SOFT_TIMESTAMP(INV_MPU6050_SCAN_TIMESTAMP),
> =20
> @@ -1623,6 +1639,10 @@ static const struct iio_chan_spec inv_mpu9250_chan=
nels[] =3D {
>  	| BIT(INV_MPU9X50_SCAN_MAGN_Y)		\
>  	| BIT(INV_MPU9X50_SCAN_MAGN_Z))
> =20
> +static const unsigned long inv_iam20380_scan_masks[] =3D {
> +	INV_MPU6050_SCAN_MASK_3AXIS_GYRO,
> +};
> +
>  static const unsigned long inv_mpu9x50_scan_masks[] =3D {
>  	/* 3-axis accel */
>  	INV_MPU6050_SCAN_MASK_3AXIS_ACCEL,
> @@ -2026,6 +2046,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,
>  		indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu9250_channels);
>  		indio_dev->available_scan_masks =3D inv_mpu9x50_scan_masks;
>  		break;
> +	case INV_IAM20380:
> +		indio_dev->channels =3D inv_iam20380_channels;
> +		indio_dev->num_channels =3D ARRAY_SIZE(inv_iam20380_channels);
> +		indio_dev->available_scan_masks =3D inv_iam20380_scan_masks;
> +		break;
>  	case INV_ICM20600:
>  	case INV_ICM20602:
>  		indio_dev->channels =3D inv_mpu6500_channels;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_i2c.c
> index 7a5926ba6b97d..62f7d16c2ddcb 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -34,6 +34,7 @@ static bool inv_mpu_i2c_aux_bus(struct device *dev)
>  	case INV_ICM20689:
>  	case INV_ICM20600:
>  	case INV_ICM20602:
> +	case INV_IAM20380:
>  	case INV_IAM20680:
>  		/* no i2c auxiliary bus on the chip */
>  		return false;
> @@ -187,6 +188,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {
>  	{"icm20600", INV_ICM20600},
>  	{"icm20602", INV_ICM20602},
>  	{"icm20690", INV_ICM20690},
> +	{"iam20380", INV_IAM20380},
>  	{"iam20680", INV_IAM20680},
>  	{"iam20680hp", INV_IAM20680HP},
>  	{"iam20680ht", INV_IAM20680HT},
> @@ -252,6 +254,10 @@ static const struct of_device_id inv_of_match[] =3D {
>  		.compatible =3D "invensense,icm20690",
>  		.data =3D (void *)INV_ICM20690
>  	},
> +	{
> +		.compatible =3D "invensense,iam20380",
> +		.data =3D (void *)INV_IAM20380
> +	},
>  	{
>  		.compatible =3D "invensense,iam20680",
>  		.data =3D (void *)INV_IAM20680
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h
> index a6862cf426396..211901f8b8eb6 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -84,6 +84,7 @@ enum inv_devices {
>  	INV_ICM20600,
>  	INV_ICM20602,
>  	INV_ICM20690,
> +	INV_IAM20380,
>  	INV_IAM20680,
>  	INV_IAM20680HP,
>  	INV_IAM20680HT,
> @@ -425,6 +426,7 @@ struct inv_mpu6050_state {
>  #define INV_ICM20600_WHOAMI_VALUE		0x11
>  #define INV_ICM20602_WHOAMI_VALUE		0x12
>  #define INV_ICM20690_WHOAMI_VALUE		0x20
> +#define INV_IAM20380_WHOAMI_VALUE		0xB5
>  #define INV_IAM20680_WHOAMI_VALUE		0xA9
>  #define INV_IAM20680HP_WHOAMI_VALUE		0xF8
>  #define INV_IAM20680HT_WHOAMI_VALUE		0xFA
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_spi.c
> index e6a291fcda958..cd54e9dbf99ce 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -79,6 +79,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {
>  	{"icm20600", INV_ICM20600},
>  	{"icm20602", INV_ICM20602},
>  	{"icm20690", INV_ICM20690},
> +	{"iam20380", INV_IAM20380},
>  	{"iam20680", INV_IAM20680},
>  	{"iam20680hp", INV_IAM20680HP},
>  	{"iam20680ht", INV_IAM20680HT},
> @@ -140,6 +141,10 @@ static const struct of_device_id inv_of_match[] =3D {
>  		.compatible =3D "invensense,icm20690",
>  		.data =3D (void *)INV_ICM20690
>  	},
> +	{
> +		.compatible =3D "invensense,iam20380",
> +		.data =3D (void *)INV_IAM20380
> +	},
>  	{
>  		.compatible =3D "invensense,iam20680",
>  		.data =3D (void *)INV_IAM20680
>=20


