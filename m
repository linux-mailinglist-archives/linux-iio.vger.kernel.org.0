Return-Path: <linux-iio+bounces-9321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C75970716
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 13:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F5B20E2B
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C269157A4D;
	Sun,  8 Sep 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvVc/J39"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1892414EC50;
	Sun,  8 Sep 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796165; cv=none; b=rFsgEPOKZxURldWyRGnFZftrclXbAVtIuXgYodmvDn0ZVZVV2sAidMrU9z0MvZum5Bbs/ewP4mcFOEuup+uMH6k17xfF8wTytnOWn+r5EioA3OER0LA/O97oKUvU7LiHNAO2RM54Moyv5+t95aZfwYPW2RGfyjC28yzRBXkCYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796165; c=relaxed/simple;
	bh=MXp4a58z1kB6S38t3hQf0+ukYHwyuWSyTc7CyfbmzTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=md0QkWaxhITsJDkAwG2IYdsSOcRSs3qr9K7/J1pUsjeexhOzI5kiv5fCCVXyNdUgrZt8YIXSTMs19zZthRJXmT8u0s5rsQw4t8ja4JpdBcxHIR77JRuuUUY84iW25tDoOTEwK9WftYAu3/Il91cg/WDvky3KOyVkk5xg/1RuI10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvVc/J39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B3AC4CEC3;
	Sun,  8 Sep 2024 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725796164;
	bh=MXp4a58z1kB6S38t3hQf0+ukYHwyuWSyTc7CyfbmzTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvVc/J39J9yLcDeuN/SQNry9mTf11pLsBTza/NiqIWxy3iyyUW3oQW1EMWXb5frAn
	 9+lfBREAiPxDNn3KeScKsMLaQ49Vlrcafjt7w7t0Dk9P9WZ8RWgL3s4KJ2T81UYp+e
	 85jN4oqDHth/YZFE8MObNvhlXw7Bi7BwPKc2SidkYE6nSANt5q/Ki8xdms8VhI9REJ
	 O58cBl7UyIiKa7qwOKoZMxj+N8km+w8hegOQi8w/KkqPUUDYt7I+UUfLWQFBOfAsa4
	 Yul3LveKo/zdpWm0KX3GpdKEvTCj/t83cWYLO0rUwJTWR04duVK9hfiwotzOQ2giVr
	 hKLCPinHs//Pg==
Date: Sun, 8 Sep 2024 12:49:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <Jianping.Shen@de.bosch.com>
Cc: <lars@metafoo.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <dima.fedrau@gmail.com>,
 <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <Christian.Lorenz3@de.bosch.com>, <Ulrike.Frauendorf@de.bosch.com>,
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v5 2/2] iio: imu: smi240: add driver
Message-ID: <20240908124914.174074fe@jic23-huawei>
In-Reply-To: <20240904140506.4741-3-Jianping.Shen@de.bosch.com>
References: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
	<20240904140506.4741-3-Jianping.Shen@de.bosch.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Sep 2024 16:05:06 +0200
<Jianping.Shen@de.bosch.com> wrote:

> From: Shen Jianping <Jianping.Shen@de.bosch.com>
>=20
> Add the iio driver for bosch imu smi240. The smi240 is a combined
> three axis angular rate and three axis acceleration sensor module
> with a measurement range of +/-300=C2=B0/s and up to 16g. A synchronous
> acc and gyro sampling can be triggered by setting the capture bit
> in spi read command.
>=20
> Implemented features:
> * raw data access for each axis through sysfs
> * tiggered buffer for continuous sampling
> * synchronous acc and gyro data from tiggered buffer
>=20
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
Hi Shen,

A few additional comments inline,

thanks,

Jonathan

> ---
>  drivers/iio/imu/Kconfig  |  14 +
>  drivers/iio/imu/Makefile |   2 +
>  drivers/iio/imu/smi240.c | 578 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 594 insertions(+)
>  create mode 100644 drivers/iio/imu/smi240.c
>=20

> diff --git a/drivers/iio/imu/smi240.c b/drivers/iio/imu/smi240.c
> new file mode 100644
> index 00000000000..e69d81545eb
> --- /dev/null
> +++ b/drivers/iio/imu/smi240.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> +/*
> + * Copyright (c) 2024 Robert Bosch GmbH.
> + */
> +#include <asm/unaligned.h>
Convention is to list asm includes (as more specific in some sense)
as a separate block after the linux ones.

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
Also common to pull subsystem specific headers out
in their own block but I don't insist on this.

> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#define SMI240_CHIP_ID 0x0024
> +
> +#define SMI240_SOFT_CONFIG_EOC_MASK BIT_MASK(0)
> +#define SMI240_SOFT_CONFIG_GYR_BW_MASK BIT_MASK(1)
> +#define SMI240_SOFT_CONFIG_ACC_BW_MASK BIT_MASK(2)
> +#define SMI240_SOFT_CONFIG_BITE_AUTO_MASK BIT_MASK(3)
> +#define SMI240_SOFT_CONFIG_BITE_REP_MASK GENMASK(6, 4)
> +
> +#define SMI240_CHIP_ID_REG 0x00
> +#define SMI240_SOFT_CONFIG_REG 0x0A
> +#define SMI240_TEMP_CUR_REG 0x10
> +#define SMI240_ACCEL_X_CUR_REG 0x11
> +#define SMI240_GYRO_X_CUR_REG 0x14
> +#define SMI240_DATA_CAP_FIRST_REG 0x17
> +#define SMI240_CMD_REG 0x2F
> +
> +#define SMI240_SOFT_RESET_CMD 0xB6
> +
> +#define SMI240_BITE_SEQUENCE_DELAY_US 140000
> +#define SMI240_FILTER_FLUSH_DELAY_US 60000
> +#define SMI240_DIGITAL_STARTUP_DELAY_US 120000
> +#define SMI240_MECH_STARTUP_DELAY_US 100000
> +
> +#define SMI240_CRC_INIT 0x05
> +#define SMI240_CRC_POLY 0x0B
> +#define SMI240_BUS_ID 0x00
> +
> +#define SMI240_SD_BIT_MASK 0x80000000
> +#define SMI240_CS_BIT_MASK 0x00000008
> +
> +#define SMI240_BUS_ID_MASK GENMASK(31, 30)
> +#define SMI240_WRITE_ADDR_MASK GENMASK(29, 22)
> +#define SMI240_WRITE_BIT_MASK 0x00200000
> +#define SMI240_WRITE_DATA_MASK GENMASK(18, 3)
> +#define SMI240_CAP_BIT_MASK 0x00100000
> +#define SMI240_READ_DATA_MASK GENMASK(19, 4)
> +
> +/*
> + * T=C2=B0C =3D (temp / 256) + 25
> + * Tm=C2=B0C =3D 1000 * ((temp * 100 / 25600) + 25)
> + * scale: 100000 / 25600 =3D 3.906250
> + * offset: 25000
> + */
> +#define SMI240_TEMP_OFFSET 25000
> +#define SMI240_TEMP_SCALE 3906250
> +
> +#define SMI240_LOW_BANDWIDTH_HZ 50
> +#define SMI240_HIGH_BANDWIDTH_HZ 400
> +
> +#define SMI240_ACCEL_SCALE 2000
> +#define SMI240_GYRO_SCALE 100
> +
> +#define SMI240_DATA_CHANNEL(_type, _axis, _index) {			\
> +	.type =3D _type,							\
> +	.modified =3D 1,							\
> +	.channel2 =3D IIO_MOD_##_axis,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type =3D					\
> +		BIT(IIO_CHAN_INFO_SCALE) |				\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
> +	.info_mask_shared_by_type_available =3D				\
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
> +	.scan_index =3D _index,						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D 16,						\
> +		.storagebits =3D 16,					\
> +		.endianness =3D IIO_LE,					\

Is it little endian? There seems to be a be32_to_cpu() in the spi read
that suggests it might be CPU endian?

> +	},								\
> +}
> +
> +#define SMI240_TEMP_CHANNEL(_index) {			\
> +	.type =3D IIO_TEMP,				\
> +	.modified =3D 1,					\
> +	.channel2 =3D IIO_MOD_TEMP_OBJECT,		\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET) |		\
> +		BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index =3D _index,				\
> +	.scan_type =3D {					\
> +		.sign =3D 's',				\
> +		.realbits =3D 16,				\
> +		.storagebits =3D 16,			\
> +		.endianness =3D IIO_LE,			\
> +	},						\
> +}
> +
> +enum capture_mode { SMI240_CAPTURE_OFF =3D 0, SMI240_CAPTURE_ON =3D 1 };
> +
> +struct smi240_data {
> +	struct regmap *regmap;
> +	u16 accel_filter_freq;
> +	u16 anglvel_filter_freq;
> +	u8 bite_reps;
> +	enum capture_mode capture;
> +	/*
> +	 * Ensure natural alignment for timestamp if present.
> +	 * Channel size: 2 bytes.
> +	 * Max length needed: 2 * 3 channels + temp channel + 2 bytes padding +=
 8 byte ts.
> +	 * If fewer channels are enabled, less space may be needed, as
> +	 * long as the timestamp is still aligned to 8 bytes.
> +	 */
> +	s16 buf[12] __aligned(8);
> +
> +	__be32 spi_buf __aligned(IIO_DMA_MINALIGN);
> +};

> +
> +static const int smi240_low_pass_freqs[] =3D { SMI240_LOW_BANDWIDTH_HZ,
> +					     SMI240_HIGH_BANDWIDTH_HZ };

> +
> +static int smi240_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
Could simplify this with the fact we know val_size.
+ sanity check it is indeed what we expect.

Given that is known can use a local variable u16 *val =3D val_buf;
and then assign without the memcpy fun below.


> +{
> +	int ret;
> +	u32 request, response;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +
> +	request =3D FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
> +	request |=3D FIELD_PREP(SMI240_CAP_BIT_MASK, iio_priv_data->capture);
> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, *(u8 *)reg_buf);
> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
> +
> +	/*
> +	 * SMI240 module consists of a 32Bit Out Of Frame (OOF)
> +	 * SPI protocol, where the slave interface responds to
> +	 * the Master request in the next frame.
> +	 * CS signal must toggle (> 700 ns) between the frames.
> +	 */
> +	ret =3D spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D spi_read(spi, &iio_priv_data->spi_buf, sizeof(response));
> +	if (ret)
> +		return ret;
> +
> +	response =3D be32_to_cpu(iio_priv_data->spi_buf);
> +
> +	if (!smi240_sensor_data_is_valid(response))
> +		return -EIO;
> +
> +	response =3D FIELD_GET(SMI240_READ_DATA_MASK, response);

This is reusing response for something different. I'd use
a separately local variable for this.

> +	memcpy(val_buf, &response, val_size);
> +
> +	return 0;
> +}
> +
> +static int smi240_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	u32 request;
> +	struct spi_device *spi =3D context;
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(&spi->dev);
> +	struct smi240_data *iio_priv_data =3D iio_priv(indio_dev);
> +	u8 reg_addr =3D ((u8 *)data)[0];
> +	u16 reg_data =3D get_unaligned_le16(&((u8 *)data)[1]);

Should probably harden code by checking count for what is supported.
Might catch future bugs.


> +
> +	request =3D FIELD_PREP(SMI240_BUS_ID_MASK, SMI240_BUS_ID);
> +	request |=3D FIELD_PREP(SMI240_WRITE_BIT_MASK, 1);
> +	request |=3D FIELD_PREP(SMI240_WRITE_ADDR_MASK, reg_addr);
> +	request |=3D FIELD_PREP(SMI240_WRITE_DATA_MASK, reg_data);
> +	request |=3D smi240_crc3(request, SMI240_CRC_INIT, SMI240_CRC_POLY);
> +
> +	iio_priv_data->spi_buf =3D cpu_to_be32(request);
> +
> +	return spi_write(spi, &iio_priv_data->spi_buf, sizeof(request));
> +}

> +static int smi240_soft_config(struct smi240_data *data)
> +{
> +	int ret;
> +	u8 acc_bw, gyr_bw;
> +	u16 request;
> +
> +	switch (data->accel_filter_freq) {
> +	case SMI240_LOW_BANDWIDTH_HZ:
> +		acc_bw =3D 0x1;
> +		break;
> +	case SMI240_HIGH_BANDWIDTH_HZ:
> +		acc_bw =3D 0x0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (data->anglvel_filter_freq) {
> +	case SMI240_LOW_BANDWIDTH_HZ:
> +		gyr_bw =3D 0x1;
> +		break;
> +	case SMI240_HIGH_BANDWIDTH_HZ:
> +		gyr_bw =3D 0x0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	request =3D FIELD_PREP(SMI240_SOFT_CONFIG_EOC_MASK, 1);
> +	request |=3D FIELD_PREP(SMI240_SOFT_CONFIG_GYR_BW_MASK, gyr_bw);
> +	request |=3D FIELD_PREP(SMI240_SOFT_CONFIG_ACC_BW_MASK, acc_bw);
> +	request |=3D FIELD_PREP(SMI240_SOFT_CONFIG_BITE_AUTO_MASK, 1);
> +	request |=3D FIELD_PREP(SMI240_SOFT_CONFIG_BITE_REP_MASK,
> +			      data->bite_reps - 1);
> +
> +	ret =3D regmap_write(data->regmap, SMI240_SOFT_CONFIG_REG, request);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(SMI240_MECH_STARTUP_DELAY_US +
> +	       data->bite_reps * SMI240_BITE_SEQUENCE_DELAY_US +

bite?  or byte? in both cases.

> +	       SMI240_FILTER_FLUSH_DELAY_US);
> +
> +	return 0;
> +}
> +
> +static int smi240_get_low_pass_filter_freq(struct smi240_data *data,
> +					   int chan_type, int *val)
> +{
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		*val =3D data->accel_filter_freq;
> +		return 0;
> +	case IIO_ANGL_VEL:
> +		*val =3D data->anglvel_filter_freq;
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int smi240_get_data(struct smi240_data *data, int chan_type, int =
axis,
> +			   int *val)
> +{
> +	u8 reg;
> +	int ret, sample;
> +
> +	if (chan_type =3D=3D IIO_TEMP)

Switch statement is easier to read.

> +		reg =3D SMI240_TEMP_CUR_REG;
> +	else if (chan_type =3D=3D IIO_ACCEL)
> +		reg =3D SMI240_ACCEL_X_CUR_REG + (axis - IIO_MOD_X);
> +	else if (chan_type =3D=3D IIO_ANGL_VEL)
> +		reg =3D SMI240_GYRO_X_CUR_REG + (axis - IIO_MOD_X);
> +	else
> +		return -EINVAL;
> +
> +	ret =3D regmap_read(data->regmap, reg, &sample);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D sign_extend32(sample, 15);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t smi240_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct smi240_data *data =3D iio_priv(indio_dev);
> +	int ret, chan, i =3D 0;
Don't mix declarations that assign with ones that don't on the
same line.
	int ret, chan;
	int i =3D 0;

is easier to read.  This case was straight forward but with
a long list and assignments for some elements, it can be easy to
miss subtle bugs (though mostly the compiler will catch them).

> +
> +	data->capture =3D SMI240_CAPTURE_ON;
> +
> +	for_each_set_bit(chan, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {

Try building this on latest togreg branch of iio.git (or linux-next
if that is easier for you).

You an no longer access masklength directly like this.
Use iio_for_each_active_channel()


> +		ret =3D regmap_read(data->regmap,
> +				  SMI240_DATA_CAP_FIRST_REG + chan,
> +				  (int *)&data->buf[i]);

I'd put the i++ in there to make the point that it is moving
on the indexing of the buffer.

However, don't do this - use a local variable of the right type
because regmap_read will write the full integer (so probably 32 bits)
and so spill to later addresses which whilst not a bug (because
of padding for the timestamp) is certainly ugly.
		int val;

		ret =3D regmap_read(data->regmap,
				  SMI240_DATA_CAP_FIRST_REG + chan,
				  &val);
		data->capture =3D SMI240_CAPTURE_OFF;
		if (ret)
			goto out;

		data->buf[i++] =3D val;
=09


> +		data->capture =3D SMI240_CAPTURE_OFF;
> +		if (ret)
> +			goto out;
> +		i++;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

> +
> +static int smi240_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	int ret;
> +	struct smi240_data *data =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (iio_buffer_enabled(indio_dev))

This is racy as nothing stops the buffer being enabled immediately
after you check if it alreadyis.
We have iio_device_claim_direct_mode() and release() to close this race.

> +			return -EBUSY;
> +		ret =3D smi240_get_data(data, chan->type, chan->channel2, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret =3D smi240_get_low_pass_filter_freq(data, chan->type, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			*val =3D SMI240_TEMP_SCALE / MEGA;
> +			*val2 =3D SMI240_TEMP_SCALE % MEGA;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		} else if (chan->type =3D=3D IIO_ACCEL) {
> +			*val =3D SMI240_ACCEL_SCALE;
> +			return IIO_VAL_INT;
> +		} else if (chan->type =3D=3D IIO_ANGL_VEL) {
> +			*val =3D SMI240_GYRO_SCALE;
> +			return IIO_VAL_INT;
> +		} else
> +			return -EINVAL;

kernel coding style requires brackets for all branches if
any of them need them for multiple lines. Fix throughout.
Though in this case using a switch statement is probably cleaner.

> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			*val =3D SMI240_TEMP_OFFSET;
> +			return IIO_VAL_INT;
> +		} else
> +			return -EINVAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int smi240_probe(struct spi_device *spi)
> +{
> +	struct device *dev;
	struct device *dev =3D &spi->dev;

Usual convention is to combine declaration and assignment if
the assignment is something the compiler can figure out trivially.
Here it's just a fixed pointer offset.

If there is a complex function, or one that can return an error code
then assignment in the declaration block would not be a good idea.
Sometimes long lines make it a bad idea as well.
In this case it makes more sense to just do as suggested above.

> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct smi240_data *data;
> +	int ret, response;
> +
> +	dev =3D &spi->dev;

> +}
> +
> +static const struct spi_device_id smi240_spi_id[] =3D { { "smi240", 0 },=
 {} };
Format as:
static const struct spi_device_id smi240_spi_id[] =3D {
	{ "smi240" },
	{ }
};

Dropping the unused 0 makes it obvious we don't care about the value yet.
If support for additional devices is added in future then that value
can be set appropriately.

> +MODULE_DEVICE_TABLE(spi, smi240_spi_id);
> +
> +static const struct of_device_id smi240_of_match[] =3D {
> +	{ .compatible =3D "bosch,smi240" },
> +	{}
Trivial but I'm standardizing IIO _id tables with=20
	{ }

Mostly so that long term I never have to give review comments on these.

> +};
> +MODULE_DEVICE_TABLE(of, smi240_of_match);


