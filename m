Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56A47590
	for <lists+linux-iio@lfdr.de>; Sun, 16 Jun 2019 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfFPPjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Jun 2019 11:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfFPPjw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Jun 2019 11:39:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59FD32063F;
        Sun, 16 Jun 2019 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560699590;
        bh=dVR88/sNWQeeme03MbSWzBQUPU5rrEbkEISN2IUrdK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jbaqy2roDgmFYoH8xJjjhsDF9QC7l6pdYQnq+mSc1ypaPeZt8ZUPmVh2M+VdIUZ1j
         Tp9FQC5uR6rIrjIpBqdP+YWhvbhWaCP3QbrUurAILVv3b6xxFT3sWgmMVwVE/DWq+J
         qK538A8swHskCkbl/ZtExk6cSyVf70lDIb2/cv2s=
Date:   Sun, 16 Jun 2019 16:39:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: Add PAT9125 optical tracker sensor
Message-ID: <20190616163945.06bdbef0@archlinux>
In-Reply-To: <20190610092945.6330-4-amergnat@baylibre.com>
References: <20190610092945.6330-1-amergnat@baylibre.com>
        <20190610092945.6330-4-amergnat@baylibre.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 10 Jun 2019 11:29:45 +0200
Alexandre Mergnat <amergnat@baylibre.com> wrote:

> This adds support for PixArt Imaging=E2=80=99s miniature low power optical
> navigation chip using LASER light source enabling digital surface trackin=
g.
>=20
> Feature and datasheet: [0]
>=20
> This IIO driver allows to read delta or relative position on X and Y axis:
>   - The position relative to where the system started can be taken through
>   punctual "read_raw" which will issue a read in the device registers to
>   get the delta between last/current read and return the addition of all
>   the deltas.
>   - The delta can be retrieved using triggered buffer subscription
>   (i.e. iio_readdev). The buffer payload is:
>     |32 bits delta X|32 bits delta Y|timestamp|.
>=20
> The possible I2C addresses are 0x73, 0x75 and 0x79.
>=20
> X and Y axis CPI resolution can be get/set independently through IIO_SCAL=
E.
> The range value is 0-255 which means:
>   - 0 to ~1,275 Counts Per Inch on flat surface.
>   - 0 to ~630 Counts Per Rev on 1.0mm diameter STS shaft at 1.0mm distanc=
e.
> More details on the datasheet.
>=20
> The "position" directory is added to contain drivers which can provide
> position data.
>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>=20
> [0]: http://www.pixart.com/products-detail/72/PAT9125EL-TKIT___TKMT
>=20
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Hi Alexandre,

Getting close but a few more bits and pieces inline.

I'm a little confused on why the buffered reads are giving the delta
values whilst we have fixed up the sysfs reads to give the more useful
position values (and hence not need to know when last read was).
We should be consistent and give positions from the buffered path as well.

Thanks,

Jonathan

> ---
>  drivers/iio/Kconfig            |   1 +
>  drivers/iio/Makefile           |   1 +
>  drivers/iio/position/Kconfig   |  18 ++
>  drivers/iio/position/Makefile  |   6 +
>  drivers/iio/position/pat9125.c | 499 +++++++++++++++++++++++++++++++++
>  5 files changed, 525 insertions(+)
>  create mode 100644 drivers/iio/position/Kconfig
>  create mode 100644 drivers/iio/position/Makefile
>  create mode 100644 drivers/iio/position/pat9125.c
>=20
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 1d736a4952ab..23d9780640e7 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -85,6 +85,7 @@ source "drivers/iio/light/Kconfig"
>  source "drivers/iio/magnetometer/Kconfig"
>  source "drivers/iio/multiplexer/Kconfig"
>  source "drivers/iio/orientation/Kconfig"
> +source "drivers/iio/position/Kconfig"
>  if IIO_TRIGGER
>     source "drivers/iio/trigger/Kconfig"
>  endif #IIO_TRIGGER
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index bff682ad1cfb..1712011c0f4a 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -31,6 +31,7 @@ obj-y +=3D light/
>  obj-y +=3D magnetometer/
>  obj-y +=3D multiplexer/
>  obj-y +=3D orientation/
> +obj-y +=3D position/
>  obj-y +=3D potentiometer/
>  obj-y +=3D potentiostat/
>  obj-y +=3D pressure/
> diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
> new file mode 100644
> index 000000000000..1cf28896511c
> --- /dev/null
> +++ b/drivers/iio/position/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# Optical tracker sensors
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Optical tracker sensors"
> +
> +config PAT9125
> +	tristate "Optical tracker PAT9125 I2C driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	help
> +	  Say yes here to build support for PAT9125 optical tracker
> +	  sensors.
> +
> +          To compile this driver as a module, say M here: the module will
> +          be called pat9125.
> +endmenu
> diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
> new file mode 100644
> index 000000000000..cf294917ae2c
> --- /dev/null
> +++ b/drivers/iio/position/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for industrial I/O Optical tracker sensor drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_PAT9125) +=3D pat9125.o
> diff --git a/drivers/iio/position/pat9125.c b/drivers/iio/position/pat912=
5.c
> new file mode 100644
> index 000000000000..22bf729bec9b
> --- /dev/null
> +++ b/drivers/iio/position/pat9125.c
> @@ -0,0 +1,499 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Copyright (C) 2019 BayLibre, SAS
> + * Author: Alexandre Mergnat <amergnat@baylibre.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +/* I2C Address function to ID pin*/
> +#define PAT9125_I2C_ADDR_HI		0x73
> +#define PAT9125_I2C_ADDR_LO		0x75
> +#define PAT9125_I2C_ADDR_NC		0x79
> +
> +/* Registers */
> +#define PAT9125_PRD_ID1_REG		0x00
> +#define PAT9125_PRD_ID2_REG		0x01
> +#define PAT9125_MOTION_STATUS_REG	0x02
> +#define PAT9125_DELTA_X_LO_REG		0x03
> +#define PAT9125_DELTA_Y_LO_REG		0x04
> +#define PAT9125_OP_MODE_REG		0x05
> +#define PAT9125_CONFIG_REG		0x06
> +#define PAT9125_WRITE_PROTEC_REG	0x09
> +#define PAT9125_SLEEP1_REG		0x0A
> +#define PAT9125_SLEEP2_REG		0x0B
> +#define PAT9125_RES_X_REG		0x0D
> +#define PAT9125_RES_Y_REG		0x0E
> +#define PAT9125_DELTA_XY_HI_REG		0x12
> +#define PAT9125_SHUTER_REG		0x14
> +#define PAT9125_FRAME_AVG_REG		0x17
> +#define PAT9125_ORIENTATION_REG		0x19
> +
> +/* Bits */
> +#define PAT9125_VALID_MOTION_DATA_BIT	BIT(7)
> +#define PAT9125_RESET_BIT		BIT(7)
> +
> +/* Registers' values */
> +#define PAT9125_SENSOR_ID_VAL			0x31
> +#define PAT9125_DISABLE_WRITE_PROTECT_VAL	0x5A
> +#define PAT9125_ENABLE_WRITE_PROTECT_VAL	0x00
> +
> +/* Default Value of sampled value size */
> +#define PAT9125_SAMPLED_VAL_BIT_SIZE		12
> +
> +struct pat9125_data {
> +	struct regmap *regmap;
> +	struct iio_trigger *indio_trig;	/* Motion detection */
> +	s32 delta_x;
> +	s32 delta_y;
> +	s32 position_x;
> +	s32 position_y;
> +	bool sampling;
> +};
> +
> +static const struct iio_chan_spec pat9125_channels[] =3D {
> +	{
> +		.type =3D IIO_DISTANCE,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_X,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index =3D 0,
> +		.scan_type =3D {
> +			.sign =3D 's',
> +			.realbits =3D 32,
> +			.storagebits =3D 32,
> +			.endianness =3D IIO_CPU,
> +		},
> +	},
> +	{
> +		.type =3D IIO_DISTANCE,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_Y,
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index =3D 1,
> +		.scan_type =3D {
> +			.sign =3D 's',
> +			.realbits =3D 32,
> +			.storagebits =3D 32,
> +			.endianness =3D IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +/**
> + * pat9125_write_pretected_reg() - Write value in protected register.
> + *
> + * @regmap: Pointer to I2C register map.
> + * @reg_addr: Register address.
> + * @reg_value: Value to be write in register.
> + *
> + * A value of zero will be returned on success, a negative errno will
> + * be returned in error cases.
> + */
> +static int pat9125_write_pretected_reg(struct iio_dev *indio_dev,
> +	u8 reg_addr, u8 reg_value)
> +{
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_write(data->regmap,
> +			 PAT9125_WRITE_PROTEC_REG,
> +			 PAT9125_DISABLE_WRITE_PROTECT_VAL);
> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent, "register 0x%x access failed %d\n",
> +			PAT9125_WRITE_PROTEC_REG, ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(data->regmap, reg_addr, reg_value);
> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent, "register 0x%x access failed %d\n",
> +			reg_addr, ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(data->regmap,
> +			 PAT9125_WRITE_PROTEC_REG,
> +			 PAT9125_ENABLE_WRITE_PROTECT_VAL);
> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent, "register 0x%x access failed %d\n",
> +			PAT9125_WRITE_PROTEC_REG, ret);
> +		return ret;
We'll probably get a patch from some script for this so nice to
cleanup now.

regmap_write always returns 0 for success and negative otherwise.

Hence we can just check if (ret).  Having done that we can also drop
the return ret above out of the brackets and save a few lines of code
by getting rid of the return 0 that follows.

Just checkign if (ret) in general is probably a worthwhile cleanup
for these regmap calls.


> +	}
> +	return 0;
> +}
> +/**
> + * pat9125_read_delta() - Read delta value, update delta & position data.
> + *
> + * @data: Driver's data structure.
> + *
> + * A value of zero will be returned on success, a negative errno will
> + * be returned in error cases.
> + */
> +static int pat9125_read_delta(struct pat9125_data *data)
> +{
> +	struct regmap *regmap =3D data->regmap;
> +	int status =3D 0;
> +	int val_x =3D 0;
> +	int val_y =3D 0;
> +	int val_high_nibbles =3D 0;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Check if motion is detected */
> +	if (status & PAT9125_VALID_MOTION_DATA_BIT) {
> +		ret =3D regmap_read(regmap, PAT9125_DELTA_X_LO_REG, &val_x);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D regmap_read(regmap, PAT9125_DELTA_Y_LO_REG, &val_y);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D regmap_read(regmap, PAT9125_DELTA_XY_HI_REG,
> +			&val_high_nibbles);
> +		if (ret < 0)
> +			return ret;
> +
> +		val_x |=3D (val_high_nibbles << 4) & 0xF00;
> +		val_y |=3D (val_high_nibbles << 8) & 0xF00;
> +		val_x =3D sign_extend32(val_x,
> +			PAT9125_SAMPLED_VAL_BIT_SIZE - 1);
> +		val_y =3D sign_extend32(val_y,
> +			PAT9125_SAMPLED_VAL_BIT_SIZE - 1);
> +		data->position_x +=3D val_x;
> +		data->position_y +=3D val_y;
> +		data->delta_x =3D val_x;
> +		data->delta_y =3D val_y;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pat9125_read_raw() - Sample and return the value(s)
> + * function to the associated channel info enum.
> + **/
> +static int pat9125_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D pat9125_read_delta(data);
> +		if (ret)
> +			return ret;
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			*val =3D data->position_x;
> +			return IIO_VAL_INT;
> +		case IIO_MOD_Y:
> +			*val =3D data->position_y;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			ret =3D regmap_read(data->regmap, PAT9125_RES_X_REG, val);
> +			if (ret)
> +				return ret;
> +			else
> +				return IIO_VAL_INT;
> +		case IIO_MOD_Y:
> +			ret =3D regmap_read(data->regmap, PAT9125_RES_Y_REG, val);
> +			if (ret)
> +				return ret;
> +			else
> +				return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * pat9125_write_raw() - Write the value(s)
> + * function to the associated channel info enum.
> + **/
*/

Tidy these up throughout.  If you are going to do
kernel-doc (which is good) you should also document all of the
parameters.

> +static int pat9125_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			ret =3D pat9125_write_pretected_reg(indio_dev,
> +				PAT9125_RES_X_REG, val);
> +			return ret;
> +		case IIO_MOD_Y:
> +			ret =3D pat9125_write_pretected_reg(indio_dev,
> +				PAT9125_RES_Y_REG, val);
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t pat9125_threaded_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +	u8 buf[16]; /* Payload: Delta_X (4) | Delta_Y (4) | Timestamp (8) */
> +	int ret;
> +	s64 timestamp;
> +
> +	data->sampling =3D true;
> +	ret =3D pat9125_read_delta(data);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "Read delta failed %d\n", ret);
> +		return IRQ_NONE;
> +	}
> +	timestamp =3D iio_get_time_ns(indio_dev);
> +	*((s32 *)&buf[0]) =3D data->delta_x;
> +	*((s32 *)&buf[sizeof(s32)]) =3D data->delta_y;

Why are we putting the delta values in the buffer rather than the positions?

> +	data->delta_x =3D 0;
> +	data->delta_y =3D 0;
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, timestamp);
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * pat9125_threaded_event_handler() - Threaded motion detection event ha=
ndler
> + * @irq: The irq being handled.
> + * @private: struct iio_device pointer for the device.
> + */
> +static irqreturn_t pat9125_threaded_event_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev =3D private;
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +
> +	iio_trigger_poll_chained(data->indio_trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int pat9125_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct pat9125_data *data =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	ret =3D iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +	/* Release interrupt pin on the device */
> +	return pat9125_read_delta(data);

If this has an error, we should be handling the unwind of
iio_triggered_buffer_postenable.  That is
iio_triggered_buffer_predisable.

(Alexandru has been cleaning these up recently so I'm more
aware of this than normal!)

> +}
> +
> +static const struct iio_buffer_setup_ops pat9125_buffer_ops =3D {
> +	.postenable =3D pat9125_buffer_postenable,
> +	.predisable =3D iio_triggered_buffer_predisable,
> +};
> +
One blank line is almost always enough (nitpick of the day ;)
> +
> +static const struct regmap_config pat9125_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};
> +
> +static const struct iio_info pat9125_info =3D {
> +	.read_raw =3D pat9125_read_raw,
> +	.write_raw =3D pat9125_write_raw,
> +};
> +
> +/*
> + * To detect if a new value is available, register status is checked. Th=
is
> + * method is safer than using a flag on GPIO IRQ to track event while sa=
mpling
> + * because falling edge is missed when device trig just after a read reg=
 value
> + * (that happen for fast motions or high CPI setting).

So we have an edge triggered interrupt that doesn't have a 'minimum low'
period? If so then the only safe way to handle it would be as a level
interrupt. Can you do that here?
(I once had the delights of a sensor like this tied to a edge sensitive only
interrupt, but thankfully those are a rare thing these days).

> + *
> + * Note: To avoid infinite loop in "iio_trigger_notify_done" when it si =
not in

is

> + * buffer mode and kernel warning due to nested IRQ thread,
> + * this function must return 0.
> + */
> +static int pat9125_trig_try_reenable(struct iio_trigger *trig)
> +{
> +	struct pat9125_data *data =3D iio_trigger_get_drvdata(trig);
> +	struct regmap *regmap =3D data->regmap;
> +	int status =3D 0;
> +
> +	if (data->sampling) {
> +		regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
> +		if (status & PAT9125_VALID_MOTION_DATA_BIT) {
> +			data->sampling =3D false;
So we only ever do 2 reads?  Why can't we be unlucky on timing
twice in a row?

> +			iio_trigger_poll_chained(data->indio_trig);
> +			return 0;
> +		}
> +	}
> +	data->sampling =3D false;
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops pat9125_trigger_ops =3D {
> +	.try_reenable =3D pat9125_trig_try_reenable,
> +};
> +
> +static int pat9125_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct pat9125_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret, sensor_pid;
> +
> +	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev) {
> +		dev_err(&client->dev, "IIO device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	data =3D iio_priv(indio_dev);
> +	indio_dev->dev.parent =3D &client->dev;
> +	indio_dev->name =3D id->name;
> +	indio_dev->channels =3D pat9125_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(pat9125_channels);
> +	indio_dev->info =3D &pat9125_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +		pat9125_threaded_trigger_handler, &pat9125_buffer_ops);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to setup triggered buffer\n");
> +		return ret;
> +	}
> +
> +	data->indio_trig =3D devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +		indio_dev->name, indio_dev->id);
> +	if (!data->indio_trig)
> +		return -ENOMEM;
> +	data->indio_trig->dev.parent =3D &client->dev;
> +	data->indio_trig->ops =3D &pat9125_trigger_ops;
> +	iio_trigger_set_drvdata(data->indio_trig, data);
> +	ret =3D devm_iio_trigger_register(&client->dev, data->indio_trig);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to register trigger\n");
> +		return ret;
> +	}
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &pat9125_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "regmap init failed %ld\n",
> +			PTR_ERR(data->regmap));
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	/* Check device ID */
> +	ret =3D regmap_read(data->regmap, PAT9125_PRD_ID1_REG, &sensor_pid);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d\n",
> +			PAT9125_PRD_ID1_REG, ret);
> +		return ret;
> +	}
> +	if (sensor_pid !=3D PAT9125_SENSOR_ID_VAL)
> +		return -ENODEV;
> +
> +	/* Switch to bank0 (Magic number)*/
> +	ret =3D regmap_write(data->regmap, 0x7F, 0x00);
> +	if (ret < 0) {
> +		dev_err(indio_dev->dev.parent, "register 0x%x access failed %d\n",
> +			0x7F, ret);
> +		return ret;
> +	}
> +
> +	/* Software reset */
> +	ret =3D regmap_write_bits(data->regmap,
> +			      PAT9125_CONFIG_REG,
> +			      PAT9125_RESET_BIT,
> +			      1);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "register 0x%x access failed %d\n",
> +			PAT9125_CONFIG_REG, ret);
> +		return ret;
> +	}
> +
> +	msleep(20);
> +
> +	/* Init GPIO IRQ */
> +	if (client->irq) {
> +		ret =3D devm_request_threaded_irq(&client->dev,
> +			client->irq,
> +			NULL,
> +			pat9125_threaded_event_handler,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			"pat9125",
> +			indio_dev);
> +		if (ret) {
> +			dev_err(&client->dev, "GPIO IRQ init failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "IIO device register failed\n");
> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);

Why?  You have now gotten rid of remove (which is great).
I'm guessing that was using i2c_get_clientdata?

> +	return 0;
> +}
> +
> +static const struct i2c_device_id pat9125_id[] =3D {
> +	{ "pat9125", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, pat9125_id);
> +
> +static const unsigned short normal_i2c[] =3D {
> +	PAT9125_I2C_ADDR_HI,
> +	PAT9125_I2C_ADDR_LO,
> +	PAT9125_I2C_ADDR_NC,
> +	I2C_CLIENT_END
> +};
> +
> +static struct i2c_driver pat9125_driver =3D {
> +	.driver =3D {
> +		.name =3D "pat9125",
> +	},
> +	.probe =3D pat9125_probe,
> +	.address_list =3D normal_i2c,
> +	.id_table =3D pat9125_id,
> +};
> +
> +module_i2c_driver(pat9125_driver);
> +
> +MODULE_AUTHOR("Alexandre Mergnat <amergnat@baylibre.com>");
> +MODULE_DESCRIPTION("Optical Tracking sensor");
> +MODULE_LICENSE("GPL");

