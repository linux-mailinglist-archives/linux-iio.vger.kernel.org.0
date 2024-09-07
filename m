Return-Path: <linux-iio+bounces-9296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB90970325
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03317283C2B
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94F115C131;
	Sat,  7 Sep 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw6lWf8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D522339;
	Sat,  7 Sep 2024 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725726163; cv=none; b=BcBncO3jkPMXOGz+AIMmjAX7bC6Zdj65N05ENB+CQEE/hly8uQwptRufpmaZAka5IHbBpmwYgWoDZpgSrqzm0lksovOMeu2TX5z0glvevCvJClYLolEMLQye0BodDzgzt54UvkpSvD7uUFkByeYserblLU1ECSv+MZa9ftYAfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725726163; c=relaxed/simple;
	bh=qlvtDpqtRmRNuIEJ/f3gSpaT8+zAc08swiUFE8ODqDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hn5DFjIIOIqa/FT+yz/H6XQuOWMo78JQPwcsS9UdUEtuYrriZuu4e/31JORhzq72ofpwJxsCP9b4KZ04OD6XmfVJjyzdvwuCUL5avKwi9WEjzajmWxwIrggh6/Q3z6RVKiH/O0fw1G9y38mZKrJeKETTxnHWteQXcvQoYYB6Kvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw6lWf8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E340C4CEC2;
	Sat,  7 Sep 2024 16:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725726162;
	bh=qlvtDpqtRmRNuIEJ/f3gSpaT8+zAc08swiUFE8ODqDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tw6lWf8E13fmEb5Zh8KLchzFCIPn/MngKipY8LjjHWJB0lqURss7aqbiE1LOjYlwX
	 f1+UxE5nNKB9DCIVBxU9BROLVTxW3dgwmW91xziEbACd8NRtuRAt4lnh6erIED4eM/
	 3WTaQmPWduTRNuDTDbCITigeJ6Yyt5XPzQomviD6R0NdZhnPdCUO1ei8mAnoF3qReX
	 z1PbZYrBNNRbyAhaP3+vBdImgwyc3deDpkabAGqki3TU8ROG+u7Ze0WX4KZ6yy2+u7
	 Qjm3VN2CY/j4NGcROdUrf513VAXl0NqMos+SHazbIXLS77K2NIBqUqlZEj2J726z0I
	 RMvix4Ybtdr4w==
Date: Sat, 7 Sep 2024 17:22:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Gyeyoung Baek <gye976@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to probe
 function
Message-ID: <20240907172236.4ea2f84b@jic23-huawei>
In-Reply-To: <FR3P281MB1757A2ECAB94077B8E250314CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240903163302.105268-1-gye976@gmail.com>
	<FR3P281MB1757A2ECAB94077B8E250314CE9D2@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sep 2024 09:29:58 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> nice improvement, thanks.
>=20
> But beware there is a fix pending in fixes-togreg branch and missing in t=
esting branch that is changing this part of code.
> To avoid a painful merge, it should be better to wait for the fix to be i=
ntegrated inside testing.
>=20
> Is that correct Jonathan?
Yes.  It is too late for new cleanups to hit this cycle anyway, so better t=
o just wait
for that fix to be in my togreg branch (6.12-rc1 probably)
>=20
> And I would prefer the wom_bits being inside the inv_mpu6050_reg_map stru=
cture.
>=20
> Thanks,
> JB
>=20
> ________________________________________
> From:=C2=A0Gyeyoung Baek <gye976@gmail.com>
> Sent:=C2=A0Tuesday, September 3, 2024 18:33
> To:=C2=A0jic23@kernel.org <jic23@kernel.org>
> Cc:=C2=A0linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-ker=
nel@vger.kernel.org <linux-kernel@vger.kernel.org>; Gyeyoung Baek <gye976@g=
mail.com>
> Subject:=C2=A0[PATCH] iio: imu: inv_mpu6050: Move setting 'wom_bits' to p=
robe function
> =C2=A0
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
> =C2=A0
> 'wom_bits' variable is defined by chip type,=20
> and chip type is statically defined by device tree.
> so 'wom_bits' need to be set once during probe function.
>=20
> but before code set it every time using 'switch statement' during
> threaded irq handler, so i move that to probe function.
>=20
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c =C2=A0 =C2=A0| 16 +++++++++++=
++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h =C2=A0 =C2=A0 | =C2=A01 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 20 ++-----------------
>  3 files changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 14d95f34e981..322ae664adc0 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -2076,6 +2076,22 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,
>  		return result;
>  	}
> =20
> +	switch (chip_type) {
> +	case INV_MPU6050:
> +	case INV_MPU6500:
> +	case INV_MPU6515:
> +	case INV_MPU6880:
> +	case INV_MPU6000:
> +	case INV_MPU9150:
> +	case INV_MPU9250:
> +	case INV_MPU9255:
> +		st->wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> +		break;
> +	default:
> +		st->wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> +		break;
> +	}
> +
>  	return 0;
> =20
>  error_power_off:
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h
> index e1c0c5146876..a91b9c2b26e4 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -212,6 +212,7 @@ struct inv_mpu6050_state {
>  	bool level_shifter;
>  	u8 *data;
>  	s64 it_timestamp;
> +	unsigned int wom_bits;
>  };
> =20
>  /*register and associated bit definition*/
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c
> index 84273660ca2e..b19556df1801 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -243,26 +243,10 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int=
 irq, void *p)
>  {
>  	struct iio_dev *indio_dev =3D p;
>  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> -	unsigned int int_status, wom_bits;
> +	unsigned int int_status;
>  	u64 ev_code;
>  	int result;
> =20
> -	switch (st->chip_type) {
> -	case INV_MPU6050:
> -	case INV_MPU6500:
> -	case INV_MPU6515:
> -	case INV_MPU6880:
> -	case INV_MPU6000:
> -	case INV_MPU9150:
> -	case INV_MPU9250:
> -	case INV_MPU9255:
> -		wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> -		break;
> -	default:
> -		wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> -		break;
> -	}
> -
>  	scoped_guard(mutex, &st->lock) {
>  		/* ack interrupt and check status */
>  		result =3D regmap_read(st->map, st->reg->int_status, &int_status);
> @@ -272,7 +256,7 @@ static irqreturn_t inv_mpu6050_interrupt_handle(int i=
rq, void *p)
>  		}
> =20
>  		/* handle WoM event */
> -		if (st->chip_config.wom_en && (int_status & wom_bits)) {
> +		if (st->chip_config.wom_en && (int_status & st->wom_bits)) {
>  			ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
>  						 =C2=A0 =C2=A0 IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
>  			iio_push_event(indio_dev, ev_code, st->it_timestamp);


