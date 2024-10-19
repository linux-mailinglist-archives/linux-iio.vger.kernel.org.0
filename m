Return-Path: <linux-iio+bounces-10793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBE9A4EB9
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 16:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66DB288127
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF813635F;
	Sat, 19 Oct 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH8rXmOB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131B20E31D;
	Sat, 19 Oct 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729348769; cv=none; b=FXS+2p+W61MhHL/rQE4kpMJpVv+gVZLRsQ4I5J6d8sWXHY0jSME+F+EM4BudFg+qXwJhvdVfN4LlzW2wbUmTtOpH8A55WxEUbZw95Hbcq13mMmF0h5uU5cO9sx1iafBuTSOrS5J/SYGNt0Ycgphis/EXXbGYxZuNltjxpm6NZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729348769; c=relaxed/simple;
	bh=81/ghkAOqgeLnz35EXcMjWBh9WQm0EeXKaLcwBuu/8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT6+3KNZ2X6tAofB5BhlT/cTHc/nAde8Vd6bXsIdjGJAqfcq56bl1gyyd3VhyTRbUD/L+nS0RSeYcXk0Cjef2S18r5JHLIBRD3M3lhgRsjtLqC3b4++09i5PHCV/ELcLNiGmcYU1xh/n4aXRnq20M5RuYrjsTw2besO6m0/AhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZH8rXmOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB06C4CEC5;
	Sat, 19 Oct 2024 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729348768;
	bh=81/ghkAOqgeLnz35EXcMjWBh9WQm0EeXKaLcwBuu/8w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZH8rXmOBb6jVVc+F9rJKG75/ImbMTrNvM6UMJMOMmfZ6ZtHr1+qZO9eTSdVxFP8nZ
	 awMNWJ4r9qixwgqwqjq/G4Kmz7Oh1BZmMGu7VEPojyD6EfIjGzWT2SvnYdwTuRqqxy
	 Tpm7UfuMQoTtnlwffSc4Tpreh5BEioU43fM8q8M/oOElrDbJhoA99bUzPus4JM9oPf
	 mmVPgamTbXJdYCouKKcOB94OjlCGiSfkQISBFvllHXq5+ENTNSU5K1blzrw67maC46
	 jECOfhTGgrYoN1MZ1AtrdOQI/+c2nDJndEpMQ5ZnGihW01dc+NHkrFpuNLBKhGXrdG
	 OSmgTB/7BgRsg==
Date: Sat, 19 Oct 2024 15:39:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: invensense: fix multiple odr switch when FIFO is
 off
Message-ID: <20241019153912.43e050a0@jic23-huawei>
In-Reply-To: <20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b@tdk.com>
References: <20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-v1-1-1bcfa70a747b@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Oct 2024 16:06:28 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> When multiple ODR switch happens during FIFO off, the change could
> not be taken into account if you get back to previous FIFO on value.
> For example, if you run sensor buffer at 50Hz, stop, change to
> 200Hz, then back to 50Hz and restart buffer, data will be timestamped
> at 200Hz. This due to testing against mult and not new_mult.
>=20
> To prevent this, let's just run apply_odr automatically when FIFO is
> off. It will also simplify driver code.
>=20
> Update inv_mpu6050 and inv_icm42600 to delete now useless apply_odr.
>=20
> Fixes: 95444b9eeb8c ("iio: invensense: fix odr switching to same value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

In at least some of the cases ts is no longer used:

  CHECK   drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c: In function =E2=80=98inv_=
icm42600_gyro_update_scan_mode=E2=80=99:
drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c:103:39: warning: unused va=
riable =E2=80=98ts=E2=80=99 [-Wunused-variable]
  103 |         struct inv_sensors_timestamp *ts =3D &gyro_st->ts;
      |                                       ^~
drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c: In function =E2=80=98inv=
_icm42600_accel_update_scan_mode=E2=80=99:
drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:203:39: warning: unused v=
ariable =E2=80=98ts=E2=80=99 [-Wunused-variable]
  203 |         struct inv_sensors_timestamp *ts =3D &accel_st->ts;
      |                                       ^~

So drop those as well for v2.


> ---
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 4 ++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c      | 1 -
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c       | 1 -
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c          | 1 -
>  4 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c b/dri=
vers/iio/common/inv_sensors/inv_sensors_timestamp.c
> index f44458c380d92823ce2e7e5f78ca877ea4c06118..37d0bdaa8d824f79dcd2f341b=
e7501d249926951 100644
> --- a/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> +++ b/drivers/iio/common/inv_sensors/inv_sensors_timestamp.c
> @@ -70,6 +70,10 @@ int inv_sensors_timestamp_update_odr(struct inv_sensor=
s_timestamp *ts,
>  	if (mult !=3D ts->mult)
>  		ts->new_mult =3D mult;
> =20
> +	/* When FIFO is off, directly apply the new ODR */
> +	if (!fifo)
> +		inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_sensors_timestamp_update_odr, IIO_INV_SENSORS_T=
IMESTAMP);
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/=
iio/imu/inv_icm42600/inv_icm42600_accel.c
> index 56ac198142500a2e1fc40b62cdd465cc736d8bf0..d061a64ebbf71859a3bc44644=
a14137dff0f9efe 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -229,7 +229,6 @@ static int inv_icm42600_accel_update_scan_mode(struct=
 iio_dev *indio_dev,
>  	}
> =20
>  	/* update data FIFO write */
> -	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
>  	ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> =20
>  out_unlock:
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_gyro.c
> index 938af5b640b00f58d2b8185f752c4755edfb0d25..f1e5a9648c4f5dd34f40136d0=
2c72c90473eff37 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
> @@ -128,7 +128,6 @@ static int inv_icm42600_gyro_update_scan_mode(struct =
iio_dev *indio_dev,
>  	}
> =20
>  	/* update data FIFO write */
> -	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
>  	ret =3D inv_icm42600_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
> =20
>  out_unlock:
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/=
imu/inv_mpu6050/inv_mpu_trigger.c
> index 3bfeabab0ec4f6fa28fbbcd47afe92af5b8a58e2..5b1088cc3704f1ad1288a0d65=
b2f957b91455d7f 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -112,7 +112,6 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state=
 *st, bool enable)
>  	if (enable) {
>  		/* reset timestamping */
>  		inv_sensors_timestamp_reset(&st->timestamp);
> -		inv_sensors_timestamp_apply_odr(&st->timestamp, 0, 0, 0);
>  		/* reset FIFO */
>  		d =3D st->chip_config.user_ctrl | INV_MPU6050_BIT_FIFO_RST;
>  		ret =3D regmap_write(st->map, st->reg->user_ctrl, d);
>=20
> ---
> base-commit: c3e9df514041ec6c46be83801b1891392f4522f7
> change-id: 20241017-invn-inv-sensors-timestamp-fix-switch-fifo-off-3f2911=
0e95d0
>=20
> Best regards,


