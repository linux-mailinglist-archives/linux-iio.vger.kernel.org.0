Return-Path: <linux-iio+bounces-8294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ED29495EE
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98FA1B21B88
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 16:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288936AF5;
	Tue,  6 Aug 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ4fjZlM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A235618EB0
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963222; cv=none; b=uV+UIDIo7qxTmqhUxEdZ39rtGUpxHgMMNElXxC+cRsBoMJRCTJVgxcz7DqUHCKObfT3ml90SAXwSOaCvmzjvSysc0iR1s6JXKlESw5nBnB6X2YXYsBtL4X8Vs/2xIcWns527iybTbi8ig+rGanh7i02dJHgshwSAyUxdlSr+pSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963222; c=relaxed/simple;
	bh=qZIjDkYiwI/nGOq+VEWDUuGCZC20Ohksa5GNKYk3IO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiQ20D4AqGlEi5g70ERrUMJHUNAUzMlJOcq7xYvkk/D4kOKzhAVkSyCsyNGaqtfN+2ga2MToulgc6ycyinhqv7OFgwHHrdUV/VMo9iUb4upSR3m/qaiqwvCBhWDg3UQ5gyhZZ/x2ooCn1OxRNK7TZElYJFjByb3d+S2hvuHqz3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ4fjZlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06208C32786;
	Tue,  6 Aug 2024 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722963222;
	bh=qZIjDkYiwI/nGOq+VEWDUuGCZC20Ohksa5GNKYk3IO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oZ4fjZlMWUCOkl8Qzct9LUZLqvISIgrcrfRhu7b8Qe1HLrRGCkdqCvWnsAwFg0oZy
	 lgK0mvSjCX8aaiYRmsCUwQwDiBkcIa+LPXEaDlgjneNbY30ZcPsrK54cFgOQvCEs7q
	 Kzbc8fAi1oh8kr/fX+2QvlWAOmSNOrxS4tulW554RGN6AJo109uik7iMrULGVrg9JA
	 h+4BAo0MC+XfYEcLMrXsVsF03ARD5EWo1LkBhGvjkfx0tDVBZoS3ke6u8uknaceo/c
	 t49bTei4ki1IPulpjPhqwZeqb4Dx4WxY53rAD5VcI+bEtsEuWWI75/tiT7YpjJaiJ5
	 xld/BQ9Q+WRDA==
Date: Tue, 6 Aug 2024 17:53:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: inv.git-commit@tdk.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v3 3/4] iio: imu: inv_mpu6050: add new interrupt handler
 for WoM events
Message-ID: <20240806175324.3eea67c7@jic23-huawei>
In-Reply-To: <0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
References: <20240311160557.437337-1-inv.git-commit@tdk.com>
	<20240311160557.437337-4-inv.git-commit@tdk.com>
	<0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jul 2024 11:25:03 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> 11.03.24 6:05 =D0=BF=D0=BF, inv.git-commit@tdk.com:
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >
> > Add new interrupt handler for generating WoM event from int status regi=
ster
> > bits. Launch from interrupt the trigger poll function for data buffer.
> >
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Jean-Baptiste,

Please take a look at this report.  I'd rather not revert the series
if we can figure out what is wrong and get a fix on top in reasonably
quickly.

I'd guess a power problem so we are getting interrupts when device is power=
ed down?
Hence the reads fail.

Jonathan

> > ---
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 11 ---
> >   drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 69 +++++++++++++++++--
> >   3 files changed, 66 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h
> > index d5b0465d1f74..ca5f7d45a6d4 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -185,6 +185,7 @@ struct inv_mpu6050_hw {
> >    *  @magn_orient:       magnetometer sensor chip orientation if avail=
able.
> >    *  @suspended_sensors:	sensors mask of sensors turned off for suspend
> >    *  @data:		read buffer used for bulk reads.
> > + *  @it_timestamp:	interrupt timestamp.
> >    */
> >   struct inv_mpu6050_state {
> >   	struct mutex lock;
> > @@ -210,6 +211,7 @@ struct inv_mpu6050_state {
> >   	unsigned int suspended_sensors;
> >   	bool level_shifter;
> >   	u8 *data;
> > +	s64 it_timestamp;
> >   };
> >  =20
> >   /*register and associated bit definition*/
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c
> > index 13da6f523ca2..e282378ee2ca 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > @@ -51,21 +51,10 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> >   	u32 fifo_period;
> >   	s64 timestamp;
> >   	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
> > -	int int_status;
> >   	size_t i, nb;
> >  =20
> >   	mutex_lock(&st->lock);
> >  =20
> > -	/* ack interrupt and check status */
> > -	result =3D regmap_read(st->map, st->reg->int_status, &int_status);
> > -	if (result) {
> > -		dev_err(regmap_get_device(st->map),
> > -			"failed to ack interrupt\n");
> > -		goto flush_fifo;
> > -	}
> > -	if (!(int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT))
> > -		goto end_session;
> > -
> >   	if (!(st->chip_config.accl_fifo_enable |
> >   		st->chip_config.gyro_fifo_enable |
> >   		st->chip_config.magn_fifo_enable))
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/ii=
o/imu/inv_mpu6050/inv_mpu_trigger.c
> > index ec2398a87f45..2514966f6495 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/pm_runtime.h>
> >  =20
> >   #include <linux/iio/common/inv_sensors_timestamp.h>
> > +#include <linux/iio/events.h>
> >  =20
> >   #include "inv_mpu_iio.h"
> >  =20
> > @@ -223,6 +224,65 @@ static const struct iio_trigger_ops inv_mpu_trigge=
r_ops =3D {
> >   	.set_trigger_state =3D &inv_mpu_data_rdy_trigger_set_state,
> >   };
> >  =20
> > +static irqreturn_t inv_mpu6050_interrupt_timestamp(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev =3D p;
> > +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > +
> > +	st->it_timestamp =3D iio_get_time_ns(indio_dev);
> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +static irqreturn_t inv_mpu6050_interrupt_handle(int irq, void *p)
> > +{
> > +	struct iio_dev *indio_dev =3D p;
> > +	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > +	unsigned int int_status, wom_bits;
> > +	u64 ev_code;
> > +	int result;
> > +
> > +	switch (st->chip_type) {
> > +	case INV_MPU6050:
> > +	case INV_MPU6500:
> > +	case INV_MPU6515:
> > +	case INV_MPU6880:
> > +	case INV_MPU6000:
> > +	case INV_MPU9150:
> > +	case INV_MPU9250:
> > +	case INV_MPU9255:
> > +		wom_bits =3D INV_MPU6500_BIT_WOM_INT;
> > +		break;
> > +	default:
> > +		wom_bits =3D INV_ICM20608_BIT_WOM_INT;
> > +		break;
> > +	}
> > +
> > +	scoped_guard(mutex, &st->lock) {
> > +		/* ack interrupt and check status */
> > +		result =3D regmap_read(st->map, st->reg->int_status, &int_status);
> > +		if (result) {
> > +			dev_err(regmap_get_device(st->map), "failed to ack interrupt\n");
> > +			return IRQ_HANDLED;
> > +		}
> > +
> > +		/* handle WoM event */
> > +		if (st->chip_config.wom_en && (int_status & wom_bits)) {
> > +			ev_code =3D IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
> > +						     IIO_EV_TYPE_ROC, IIO_EV_DIR_RISING);
> > +			iio_push_event(indio_dev, ev_code, st->it_timestamp);
> > +		}
> > +	}
> > +
> > +	/* handle raw data interrupt */
> > +	if (int_status & INV_MPU6050_BIT_RAW_DATA_RDY_INT) {
> > +		indio_dev->pollfunc->timestamp =3D st->it_timestamp;
> > +		iio_trigger_poll_nested(st->trig);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >   int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev, int irq_type)
> >   {
> >   	int ret;
> > @@ -235,11 +295,10 @@ int inv_mpu6050_probe_trigger(struct iio_dev *ind=
io_dev, int irq_type)
> >   	if (!st->trig)
> >   		return -ENOMEM;
> >  =20
> > -	ret =3D devm_request_irq(&indio_dev->dev, st->irq,
> > -			       &iio_trigger_generic_data_rdy_poll,
> > -			       irq_type,
> > -			       "inv_mpu",
> > -			       st->trig);
> > +	ret =3D devm_request_threaded_irq(&indio_dev->dev, st->irq,
> > +					&inv_mpu6050_interrupt_timestamp,
> > +					&inv_mpu6050_interrupt_handle,
> > +					irq_type, "inv_mpu", indio_dev);
> >   	if (ret)
> >   		return ret;
> >    =20
>=20
> Greetings!
>=20
> After this patch was applied to Linux kernel I faced a regression on my=20
> devices LG P895/P880.
>=20
> Dmesg is flooded with
>=20
> [ 50.035018] inv-mpu6050-i2c 0-0068: failed to ack interrupt -121
>=20
> and mpu6050 used on this device refuses to work. It did not occur before=
=20
> WoM patches were
>=20
> applied and reverting patches restores normal work of mpu6050.
>=20
>=20
> Best regards,
>=20
> Svyatoslav R.
>=20


