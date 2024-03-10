Return-Path: <linux-iio+bounces-3442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E6877766
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93776282165
	for <lists+linux-iio@lfdr.de>; Sun, 10 Mar 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A79364C4;
	Sun, 10 Mar 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDqoaKSG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5F376E2
	for <linux-iio@vger.kernel.org>; Sun, 10 Mar 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082807; cv=none; b=KBDEgD7jGc2w1XlQB9Iq5B+Ujx9MWN0WVl9Rmw+OF/MlCqpBagnfODmce+o95hGDF9VFey4QmqSd5ib4HyS0LhjkinG/Qn23iqCncsYzHSxpn50pr+aQ5OnvQZFOoWpCzWzrgiwPHe4mpIqw3hbDtGJkWA6qZZOMz1hytkWxT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082807; c=relaxed/simple;
	bh=RZt5sXMp18QvIHxn5X+nf6hbuHessx+Zin7nDOpCH+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M4nWh0UoHmDjvd3wBq4zIrqsl84QGu2x20cvILdCoodwBXNO5UwWl4EyITchIQSaSfi1bjKv3TUnOFEUmpEjP3hkeNDS9NSAlGOIRZ2iZjkrqToQTlRNyXT13mTFRWVo55oATPhnft+nN2XE56e+WNb3VufA9UB9/iPr+p4uXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDqoaKSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73713C433F1;
	Sun, 10 Mar 2024 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710082807;
	bh=RZt5sXMp18QvIHxn5X+nf6hbuHessx+Zin7nDOpCH+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XDqoaKSGBMKX1wYkOwj0x3P0jqqarBg99RA2d8LadEZecAh5wmQSSIbtEdZTIdySb
	 pdI2m5YoOzWKM5N47g7B2FU6XQCNYgbtEqFEvm9J6/Kb3iDZ/ROJXloQs9GNidoAcc
	 QRfmWfELpoDjX7pNEGNxm7a1qIY2QyKUlQU9sEoa8ODDVCxFrYmAPGR/GP21j9jJjm
	 DoE3w5RPPXEE4zfESYAQipz4hpjffxndEZY9nu0rKW0kIPny+tRwYfyUieKv4SAddf
	 SospJEhcoaHh0OHSSbl5H6xQ18+25DnppNzoJie/bRWqzOOrcUzqEgmaM0uuW0vU4L
	 Ucz/yx0NgRsNg==
Date: Sun, 10 Mar 2024 14:59:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: inv.git-commit@tdk.com
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v2 1/4] iio: imu: inv_mpu6050: add WoM (Wake-on-Motion)
 sensor
Message-ID: <20240310145953.2c630f95@jic23-huawei>
In-Reply-To: <20240308151023.379705-2-inv.git-commit@tdk.com>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
	<20240308151023.379705-2-inv.git-commit@tdk.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  8 Mar 2024 15:10:20 +0000
inv.git-commit@tdk.com wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> WoM is a threshold test on accel value comparing actual sample

Very short wrap on this message. Wrap at 75 chars for commit messages.

> with previous one. It maps best to roc rising event.
> Add support of a new WOM sensor and functions for handling the
> corresponding roc_rising event. The event value is in SI units.
> Ensure WOM is stopped and restarted at suspend-resume, handle
> usage with buffer data ready interrupt, and handle change in
> sampling rate impacting already set roc value.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Hi Jean-Baptiste

Some minor comments inline

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 293 +++++++++++++++++-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  19 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    |   6 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  14 +-
>  4 files changed, 319 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 0e94e5335e93..ad42be809f09 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -15,6 +15,7 @@

> +static u64 inv_mpu6050_convert_wom_to_roc(unsigned int threshold, unsign=
ed int freq_div)
> +{
> +	/* 4mg per LSB converted in m/s=C2=B2 in micro (1000000) */
> +	const unsigned int convert =3D 4U * 9807U;
> +	u64 value;
> +
> +	value =3D threshold * convert;
> +	/* compute the differential by multiplying by the frequency */
> +	value =3D div_u64(value * INV_MPU6050_INTERNAL_FREQ_HZ, freq_div);

	return div_u64();


> +
> +	return value;
> +}
> +
> +static unsigned int inv_mpu6050_convert_roc_to_wom(u64 roc, unsigned int=
 freq_div)
> +{
> +	/* 4mg per LSB converted in m/s=C2=B2 in micro (1000000) */
> +	const unsigned int convert =3D 4U * 9807U;
> +	u64 value;
> +	unsigned int threshold;
> +
> +	/* return 0 only if roc is 0 */
> +	if (roc =3D=3D 0)
> +		return 0;
> +
> +	value =3D div_u64(roc * freq_div, convert * INV_MPU6050_INTERNAL_FREQ_H=
Z);
> +	/* limit value to 8 bits and prevent 0*/
> +	if (value =3D=3D 0)
> +		threshold =3D 1;

	return min(255, max(1, value));

unless this open code flow is needed for later changes.


> +	else if (value > 255)
> +		threshold =3D 255;
> +	else
> +		threshold =3D value;
> +
> +	return threshold;
> +}
> +

...

> +static int inv_mpu6050_set_wom_threshold(struct inv_mpu6050_state *st, u=
64 value,
> +					 unsigned int freq_div)
> +{
> +	unsigned int threshold;
> +	int result;
> +
> +	/* convert roc to wom threshold and convert back to handle clipping */
> +	threshold =3D inv_mpu6050_convert_roc_to_wom(value, freq_div);
> +	value =3D inv_mpu6050_convert_wom_to_roc(threshold, freq_div);
> +
> +	dev_dbg(regmap_get_device(st->map), "wom_threshold: 0x%x\n", threshold);
> +
> +	switch (st->chip_type) {
> +	case INV_ICM20609:
> +	case INV_ICM20689:
> +	case INV_ICM20600:
> +	case INV_ICM20602:
> +	case INV_ICM20690:
> +		st->data[0] =3D threshold;
> +		st->data[1] =3D threshold;
> +		st->data[2] =3D threshold;
> +		result =3D regmap_bulk_write(st->map, INV_ICM20609_REG_ACCEL_WOM_X_THR,
> +					   st->data, 3);
> +		break;
> +	default:
> +		result =3D regmap_write(st->map, INV_MPU6500_REG_WOM_THRESHOLD, thresh=
old);
> +		break;
> +	}
> +	if (!result)
> +		st->chip_config.roc_threshold =3D value;

	if (result)
		return result;

	st->chip_config.roc_threshold =3D value;

	return 0;

More code, but keeping all error handling out of line makes for easier code=
 review.

> +
> +	return result;
> +}
> +

> +static int inv_mpu6050_write_event_config(struct iio_dev *indio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  int state)
> +{
> +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> +	int enable;
> +	int result;
> +
> +	/* support only WoM (accel roc rising) event */
> +	if (chan->type !=3D IIO_ACCEL || type !=3D IIO_EV_TYPE_ROC || dir !=3D =
IIO_EV_DIR_RISING)

Long line - consider a line break.  I don't think it will hurt readability
and I'd still prefer IIO mostly stays under 80 chars

> +		return -EINVAL;
> +
> +	enable =3D !!state;
> +
> +	mutex_lock(&st->lock);

At some point we should switch to automated unlocking.
	guard(mutex)(&st->lock);
as can do nice simple direct returns without the goto.


> +
> +	if (st->chip_config.wom_en =3D=3D enable) {
> +		result =3D 0;
> +		goto exit_unlock;
> +	}
> +
> +	result =3D inv_mpu6050_enable_wom(st, enable);
> +
> +exit_unlock:
> +	mutex_unlock(&st->lock);
> +	return result;
> +}
> +
> +static int inv_mpu6050_read_event_value(struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan,
> +					enum iio_event_type type,
> +					enum iio_event_direction dir,
> +					enum iio_event_info info, int *val, int *val2)
> +{
> +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> +	u32 rem;
> +
> +	/* support only WoM (accel roc rising) event value */
> +	if (chan->type !=3D IIO_ACCEL || type !=3D IIO_EV_TYPE_ROC ||
> +			dir !=3D IIO_EV_DIR_RISING || info !=3D IIO_EV_INFO_VALUE)

Odd alignment.  dir should align with chan.

> +		return -EINVAL;
> +
> +	/* return value in micro */
> +	*val =3D div_u64_rem(st->chip_config.roc_threshold, 1000000U, &rem);
> +	*val2 =3D rem;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int inv_mpu6050_write_event_value(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 enum iio_event_type type,
> +					 enum iio_event_direction dir,
> +					 enum iio_event_info info, int val, int val2)
> +{
> +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> +	struct device *pdev =3D regmap_get_device(st->map);
> +	u64 value;
> +	int result;
> +
> +	/* support only WoM (accel roc rising) event value */
> +	if (chan->type !=3D IIO_ACCEL || type !=3D IIO_EV_TYPE_ROC ||
> +			dir !=3D IIO_EV_DIR_RISING || info !=3D IIO_EV_INFO_VALUE)

As above, odd alignment.

> +		return -EINVAL;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +
> +	result =3D pm_runtime_resume_and_get(pdev);
> +	if (result)
> +		goto exit_unlock;
> +
> +	value =3D (u64)val * 1000000ULL + (u64)val2;
> +	result =3D inv_mpu6050_set_wom_threshold(st, value, INV_MPU6050_FREQ_DI=
VIDER(st));
> +
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
> +
> +exit_unlock:
> +	mutex_unlock(&st->lock);
> +	return result;
> +}
> +
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h
> index 5950e2419ebb..19adccf388cf 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -88,11 +88,12 @@ enum inv_devices {
>  	INV_NUM_PARTS
>  };
> =20
> -/* chip sensors mask: accelerometer, gyroscope, temperature, magnetomete=
r */
> +/* chip sensors mask: accelerometer, gyroscope, temperature, magnetomete=
r, WoM */
>  #define INV_MPU6050_SENSOR_ACCL		BIT(0)
>  #define INV_MPU6050_SENSOR_GYRO		BIT(1)
>  #define INV_MPU6050_SENSOR_TEMP		BIT(2)
>  #define INV_MPU6050_SENSOR_MAGN		BIT(3)
> +#define INV_MPU6050_SENSOR_WOM		BIT(4)
> =20
>  /**
>   *  struct inv_mpu6050_chip_config - Cached chip configuration data.
> @@ -104,6 +105,7 @@ enum inv_devices {
>   *  @gyro_en:		gyro engine enabled
>   *  @temp_en:		temperature sensor enabled
>   *  @magn_en:		magn engine (i2c master) enabled
> + *  @wom_en:		Wake-on-Motion enabled
>   *  @accl_fifo_enable:	enable accel data output
>   *  @gyro_fifo_enable:	enable gyro data output
>   *  @temp_fifo_enable:	enable temp data output
> @@ -119,12 +121,14 @@ struct inv_mpu6050_chip_config {
>  	unsigned int gyro_en:1;
>  	unsigned int temp_en:1;
>  	unsigned int magn_en:1;
> +	unsigned int wom_en:1;
>  	unsigned int accl_fifo_enable:1;
>  	unsigned int gyro_fifo_enable:1;
>  	unsigned int temp_fifo_enable:1;
>  	unsigned int magn_fifo_enable:1;
>  	u8 divider;
>  	u8 user_ctrl;
> +	u64 roc_threshold;
No docs?
>  };
>

