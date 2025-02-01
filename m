Return-Path: <linux-iio+bounces-14820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F569A249C0
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF82165241
	for <lists+linux-iio@lfdr.de>; Sat,  1 Feb 2025 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AFD1C2309;
	Sat,  1 Feb 2025 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdbAL2l7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6221BEF85;
	Sat,  1 Feb 2025 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738423322; cv=none; b=VdE166hKVrKKRbXBb7rLWZkRiRWWq7D1NohzGAlTxcdjjqtS29FseKgCSpexqzkY8TNDOrCBgsklYdcQqTLWRVVOrrw7Qr71ABqXqcBRSOwep3wrIK0tZDbtToz3e1VkbMJYDGLV6LxT9c1jsxWdi3cPZF79CLAdygxYNxbvl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738423322; c=relaxed/simple;
	bh=yKYMgbRqLSiIXVvtLJKRels8Tl5p6SsFmWmOGLuvhdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QH3FeKrMk7b/DOS9LmFReWqyCTKsviNA0OcJUEQUh5IRQHY5+3qOJ92Ngk9vJ6EWI+K3S5jqnN/602ShgR8+zTtxqKVFU5/wzG2OQSHGNNAoaDc52jSoJzyVfEwvUw+1uDH7ZvL1eeMMvQsqlFoZSAKtPHvirr2vLFkn7UEoAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdbAL2l7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E92C4CED3;
	Sat,  1 Feb 2025 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738423321;
	bh=yKYMgbRqLSiIXVvtLJKRels8Tl5p6SsFmWmOGLuvhdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdbAL2l7zqAFfYZYKyWPUFPQMzZtGh7ZiL+NP3xYEd2sbX+Fb9QPmhRtGxieDFnbp
	 FskH94gtkZd4YCtoWQs2afOCHw5z1+flKYmW9PLVXPYGUVWhC4ORCxwg6BVdxI0Olr
	 Csjgk+IWHIxZEURf9TJVXaR6e1OaWVBf+6arqZyvZbiv91N7X4agGocGJCYE2ANnyp
	 ml1neaykxm5wcnFa1id/MOrMVE5oFTU83IszzRIq7Y1DEkald0fcUDoBXKJQYmEYEv
	 v5aAlDH8+wQTmaU/ZE/SOvALWJI+F29c53IwFhcBc8WUPP9dmr9M/4u+qYur8EpM4P
	 Wh4Yp3pd4CQxA==
Date: Sat, 1 Feb 2025 15:21:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <ramona.gradinariu@analog.com>, <antoniu.miclaus@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <20250201152151.6ed1b3e5@jic23-huawei>
In-Reply-To: <20250129082053.19077-6-robert.budai@analog.com>
References: <20250129082053.19077-1-robert.budai@analog.com>
	<20250129082053.19077-6-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Jan 2025 10:20:45 +0200
Robert Budai <robert.budai@analog.com> wrote:

> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in
> the ADIS16550 combines industry leading MEMS only technology
> with signal conditioning that optimizes dynamic performance. The
> factory calibration characterizes each sensor for sensitivity, bias,
> and alignment. As a result, each sensor has its own dynamic com-
> pensation formulas that provide accurate sensor measurements

Oddly short wrap and don't break compensation across lines.
Wrap for commit messages should be 75 chars approximately.

>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
Various comments inline.

Jonathan

> ---
>=20
> v5:
> - corrected module MODULE_IMPORT_NS
> - memory allocation for buffer handled by device entirely now
> - changed scaled sync mode logic to be based on external clock-frequency
> - corrected formating according to suggestions
>=20
>  drivers/iio/imu/Kconfig     |   13 +
>  drivers/iio/imu/Makefile    |    1 +
>  drivers/iio/imu/adis16550.c | 1182 +++++++++++++++++++++++++++++++++++
>  3 files changed, 1196 insertions(+)
>  create mode 100644 drivers/iio/imu/adis16550.c
>=20
> diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
> index ca0efecb5b5c..c4e06ebbe058 100644
> --- a/drivers/iio/imu/Kconfig
> +++ b/drivers/iio/imu/Kconfig
> @@ -52,6 +52,19 @@ config ADIS16480
>  	  Say yes here to build support for Analog Devices ADIS16375, ADIS16480,
>  	  ADIS16485, ADIS16488 inertial sensors.
> =20
> +config ADIS16550
> +	tristate "Analog Devices ADIS16550 and similar IMU driver"
> +	depends on SPI
> +	select IIO_ADIS_LIB
> +	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
> +	select CRC32
> +	help
> +	  Say yes here to build support for Analog Devices ADIS16550 inertial
> +	  sensor.
Add a little more detail on what data it measures etc.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called adis16550.
> +

> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000000..57b666db141d
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c
> @@ -0,0 +1,1182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADIS16550 IMU driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/crc32.h>
> +#include <linux/debugfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/imu/adis.h>
> +#include <linux/iio/sysfs.h>

That is very rarely needed in a modern driver. Why is it here?

> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/lcm.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/swab.h>
> +#include <linux/unaligned.h>
> +
> +#define ADIS16550_REG_BURST_GYRO_ACCEL		0x0a
> +#define ADIS16550_REG_BURST_DELTA_ANG_VEL	0x0b
> +#define ADIS16550_BURST_DATA_GYRO_ACCEL_MASK	GENMASK(6, 1)
> +#define ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK	GENMASK(12, 7)
> +
> +#define ADIS16550_REG_STATUS		0x0e
> +#define ADIS16550_REG_TEMP		0x10
> +#define ADIS16550_REG_X_GYRO		0x12
> +#define ADIS16550_REG_Y_GYRO		0x14
> +#define ADIS16550_REG_Z_GYRO		0x16
> +#define ADIS16550_REG_X_ACCEL		0x18
> +#define ADIS16550_REG_Y_ACCEL		0x1a
> +#define ADIS16550_REG_Z_ACCEL		0x1c
> +#define ADIS16550_REG_X_DELTANG_L	0x1E
> +#define ADIS16550_REG_Y_DELTANG_L	0x20
> +#define ADIS16550_REG_Z_DELTANG_L	0x22
> +#define ADIS16550_REG_X_DELTVEL_L	0x24
> +#define ADIS16550_REG_Y_DELTVEL_L	0x26
> +#define ADIS16550_REG_Z_DELTVEL_L	0x28
> +#define ADIS16550_REG_X_GYRO_SCALE	0x30
> +#define ADIS16550_REG_Y_GYRO_SCALE	0x32
> +#define ADIS16550_REG_Z_GYRO_SCALE	0x34
> +#define ADIS16550_REG_X_ACCEL_SCALE	0x36
> +#define ADIS16550_REG_Y_ACCEL_SCALE	0x38
> +#define ADIS16550_REG_Z_ACCEL_SCALE	0x3a
> +#define ADIS16550_REG_X_GYRO_BIAS	0x40
> +#define ADIS16550_REG_Y_GYRO_BIAS	0x42
> +#define ADIS16550_REG_Z_GYRO_BIAS	0x44
> +#define ADIS16550_REG_X_ACCEL_BIAS	0x46
> +#define ADIS16550_REG_Y_ACCEL_BIAS	0x48
> +#define ADIS16550_REG_Z_ACCEL_BIAS	0x4a
> +#define ADIS16550_REG_COMMAND		0x50
> +#define ADIS16550_REG_CONFIG		0x52
> +#define ADIS16550_GYRO_FIR_EN_MASK	BIT(3)
> +#define ADIS16550_ACCL_FIR_EN_MASK	BIT(2)
> +#define ADIS16550_SYNC_MASK	\
> +			(ADIS16550_SYNC_EN_MASK | ADIS16550_SYNC_MODE_MASK)

Indent just one tab.

> +#define ADIS16550_SYNC_MODE_MASK	BIT(1)
> +#define ADIS16550_SYNC_EN_MASK		BIT(0)
> +/* max of 4000 SPS in scale sync */
> +#define ADIS16550_SYNC_SCALE_MAX_RATE	(4000 * 1000)
> +#define ADIS16550_REG_DEC_RATE		0x54
> +#define ADIS16550_REG_SYNC_SCALE	0x56
> +#define ADIS16550_REG_SERIAL_NUM	0x76
> +#define ADIS16550_REG_FW_REV		0x7A
> +#define ADIS16550_REG_FW_DATE		0x7C
> +#define ADIS16550_REG_PROD_ID		0x7E
> +#define ADIS16550_REG_FLASH_CNT		0x72
> +/* spi protocol*/
/* SPI protocol */
> +#define ADIS16550_SPI_DATA_MASK		GENMASK(31, 16)
> +#define ADIS16550_SPI_REG_MASK		GENMASK(14, 8)
> +#define ADIS16550_SPI_R_W_MASK		BIT(7)
> +#define ADIS16550_SPI_CRC_MASK		GENMASK(3, 0)
> +#define ADIS16550_SPI_SV_MASK		GENMASK(7, 6)
> +/* burst read */
> +#define ADIS16550_BURST_N_ELEM		12
> +#define ADIS16550_BURST_DATA_LEN	(ADIS16550_BURST_N_ELEM * 4)

This is not very big.  Can you use an __aligned(IIO_DMA_MINALIGN) buffer
at the end of iio_priv() for this instead and avoid the separate
allocation?

> +#define ADIS16550_MAX_SCAN_DATA		12
> +
> +struct adis16550_sync {
> +	u16 sync_mode;
> +	u16 min_rate;
> +	u16 max_rate;
> +};
> +
> +struct adis16550_chip_info {
> +	const struct iio_chan_spec *channels;
> +	const struct adis16550_sync *sync_mode;
> +	char *name;
> +	u32 num_channels;
> +	u32 gyro_max_val;
> +	u32 gyro_max_scale;
> +	u32 accel_max_val;
> +	u32 accel_max_scale;
> +	u32 temp_scale;
> +	u32 deltang_max_val;
> +	u32 deltvel_max_val;
> +	u32 int_clk;
> +	u16 max_dec;
> +	u16 num_sync;
> +};
> +
> +struct adis16550 {
> +	const struct adis16550_chip_info *info;
> +	struct adis adis;
> +	unsigned long clk_freq_hz;
> +	u32 sync_mode;
> +	struct spi_transfer *xfer;
> +	void *buffer;
> +
This blank line should go. It doesn't add anything useful.

> +};

...

> +static void adis16550_spi_msg_prepare(const u32 reg, const bool write,
> +				      const u16 data, __be32 *din)
> +{
> +	u8 crc;
> +	u32 __din;
> +
> +	__din =3D FIELD_PREP(ADIS16550_SPI_REG_MASK, reg);
> +
> +	if (write) {
> +		__din |=3D FIELD_PREP(ADIS16550_SPI_R_W_MASK, true);

I'd put 1 in there. FIELD_PREP takes an integer not a boolean.
Ends up the same but still good to make the code show it is an integer.

> +		__din |=3D FIELD_PREP(ADIS16550_SPI_DATA_MASK, data);
> +	}
> +
> +	crc =3D spi_crc4(__din);
> +	__din |=3D FIELD_PREP(ADIS16550_SPI_CRC_MASK, crc);
> +
> +	*din =3D cpu_to_be32(__din);
> +}
> +
> +static int adis16550_spi_xfer(const struct adis *adis, u32 reg, u32 len,
> +			      u32 *readval, u32 writeval)
> +{
> +	int ret;
> +	u16 data =3D 0;
> +	struct spi_message msg;
> +	__be32 __din[2], __dout[2];

These are not DMA safe buffers.  You can't use them like this for
SPI transfers.  There are two paths to dma safe buffers, either
kzalloc them or __aligned(IIO_DMA_MINALIGN) to create a new cacheline
at the end of the iio_priv() structure.

> +	bool wr =3D readval ? false : true;
> +	struct spi_device *spi =3D adis->spi;
> +	struct spi_transfer xfers[] =3D {
> +		{
> +			.tx_buf =3D &__din[0],
> +			.len =3D 4,
> +			.cs_change =3D 1,
> +		}, {
> +			.tx_buf =3D &__din[1],
> +			.len =3D 4,
> +			.cs_change =3D 1,
> +			.rx_buf =3D __dout,
> +		}, {
> +			.tx_buf =3D &__din[1],
> +			.rx_buf =3D &__dout[1],
> +			.len =3D 4,
> +		},
> +	};
> +
> +	spi_message_init(&msg);
> +
> +	switch (len) {
> +	case 4:
> +		adis16550_spi_msg_prepare(reg + 1, wr, writeval >> 16,
> +					  &__din[0]);
> +		spi_message_add_tail(&xfers[0], &msg);
> +		fallthrough;
> +	case 2:
> +		adis16550_spi_msg_prepare(reg, wr, writeval, &__din[1]);
> +		spi_message_add_tail(&xfers[1], &msg);
> +		spi_message_add_tail(&xfers[2], &msg);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D spi_sync(spi, &msg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Spi failure %d\n", ret);
> +		return ret;
> +	}
> +	/*
> +	 * When writing a register, the device will reply with a readback on the
> +	 * transfer so that we can validate if our data was actually written..
> +	 */
> +	switch (len) {
> +	case 4:
> +		ret =3D adis16550_spi_validate(adis, __dout[0], &data);
> +		if (ret)
> +			return ret;
> +
> +		if (readval) {
> +			*readval =3D data << 16;
> +		} else if ((writeval >> 16) !=3D data && reg !=3D ADIS16550_REG_COMMAN=
D) {
> +			dev_err(&spi->dev,
> +				"Data not written: wr: 0x%04X, rcv: 0x%04X\n",
> +				writeval >> 16, data);
> +			return -EIO;
> +		}
> +
> +		fallthrough;
> +	case 2:
> +		ret =3D adis16550_spi_validate(adis, __dout[1], &data);
> +		if (ret)
> +			return ret;
> +
> +		if (readval) {
> +			*readval =3D (*readval & GENMASK(31, 16)) | data;
> +		} else if ((writeval & GENMASK(15, 0)) !=3D data && reg !=3D ADIS16550=
_REG_COMMAND) {
> +			dev_err(&spi->dev,
> +				"Data not written: wr: 0x%04X, rcv: 0x%04X\n",
> +				(u16)writeval, data);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int adis16550_spi_read(struct adis *adis, const u32 reg,
> +			      u32 *value, const u32 len)
> +{
> +	return adis16550_spi_xfer(adis, reg, len, value, 0);
> +}
> +
> +static int adis16550_spi_write(struct adis *adis, const u32 reg,
> +			       const u32 value, const u32 len)
> +{
> +	return adis16550_spi_xfer(adis, reg, len, NULL, value);
> +}

> +
> +static ssize_t adis16550_show_firmware_date(struct file *file,
> +					    char __user *userbuf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct adis16550 *st =3D file->private_data;
> +	u32 date;
> +	char buf[12];
> +	size_t len;
> +	int ret;
It is normally a good idea to pick an ordering convention and stick
to it.  I don't really care what it is, but if nothing else comes
to mind reverse xmas at least looks prettier!

> +
> +	ret =3D adis_read_reg_32(&st->adis, ADIS16550_REG_FW_DATE, &date);
> +	if (ret)
> +		return ret;
> +
> +	len =3D scnprintf(buf, sizeof(buf), "%.2x-%.2x-%.4x\n", date & 0xff,
> +			(date >> 8) & 0xff, date >> 16);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
> +}

> +static void adis16550_debugfs_init(struct iio_dev *indio_dev)
> +{
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	struct dentry *d =3D iio_get_debugfs_dentry(indio_dev);
> +
> +	debugfs_create_file_unsafe("serial_number", 0400,
> +				   d, st, &adis16550_serial_number_fops);

Strange wrap. Why not drag d and st to the line above?

> +	debugfs_create_file_unsafe("product_id", 0400,
> +				   d, st, &adis16550_product_id_fops);
> +	debugfs_create_file("firmware_revision", 0400,
> +			    d, st, &adis16550_firmware_revision_fops);
> +	debugfs_create_file("firmware_date", 0400, d,
> +			    st, &adis16550_firmware_date_fops);
> +	debugfs_create_file_unsafe("flash_count", 0400,
> +				   d, st, &adis16550_flash_count_fops);
> +}

> +static const unsigned long adis16550_channel_masks[] =3D {
> +	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP),

This need to be terminated with a 0.

> +};
> +
> +static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	u16 burst_length =3D ADIS16550_BURST_DATA_LEN;
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	u8 burst_cmd;
> +	u8 *tx;
> +
> +	memset(st->buffer, 0, burst_length + sizeof(u32));

Given you treat tx as a set of 4 u8, sizeof(u32) doesn't make much
sense.  Can you just use the size define that was used to allocate this
buffer?

> +
> +	if (*scan_mask & ADIS16550_BURST_DATA_GYRO_ACCEL_MASK)
> +		burst_cmd =3D ADIS16550_REG_BURST_GYRO_ACCEL;
> +	else
> +		burst_cmd =3D ADIS16550_REG_BURST_DELTA_ANG_VEL;
> +
> +	tx =3D st->buffer + burst_length;
> +	tx[0] =3D 0x00;
> +	tx[1] =3D 0x00;
> +	tx[2] =3D burst_cmd;
> +	/* crc4 is 0 on burst command */
> +	tx[3] =3D spi_crc4(get_unaligned_le32(tx));
> +
> +	spi_message_init_with_transfers(&adis->msg, st->xfer, 2);

=46rom what I recall spi_message_init_with_transfers doesn't care
about changes to the contents of the tx buffer.  So I think you
can just do this once when you fill in those transfers.
No need to do it everytime you change the data sent.

> +
> +	return 0;
> +}
> +
> +static int adis16550_reset(struct adis *adis)
> +{
> +	return __adis_write_reg_16(adis, ADIS16550_REG_COMMAND, BIT(15));
> +}
> +
> +static int adis16550_config_sync(struct adis16550 *st)
> +{
> +	struct device *dev =3D &st->adis.spi->dev;
> +	const struct adis16550_sync *sync;
> +	struct clk *clk;
> +	int ret, i;
> +	u16 mode;
> +
> +	clk =3D devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +	if (!clk) {
> +		st->clk_freq_hz =3D st->info->int_clk * 1000;
> +		return 0;
> +	}
> +
> +	st->clk_freq_hz =3D clk_get_rate(clk);
> +
> +	for (i =3D 0; i < st->info->num_sync; i++) {
> +		if (st->clk_freq_hz >=3D st->info->sync_mode[i].min_rate &&
> +		    st->clk_freq_hz <=3D st->info->sync_mode[i].max_rate) {
> +			sync =3D &st->info->sync_mode[i];
Odd that a thing called sync is set to an element of an array called sync_m=
ode
but then contains sync->sync_mode. Something wants renaming here.

Maybe call the structure something like sync_mode_data so that
it incorporates sync mode and stuff about it? I don't really mind what exact
naming is as long as it ends up less confusing than currnetly.


> +			break;
> +		}
> +	}
> +
> +	if (i =3D=3D st->info->num_sync)
> +		return dev_err_probe(dev, -EINVAL, "Clk rate: %lu not in a valid range=
",
> +				     st->clk_freq_hz);
> +
> +	if (sync->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> +		u16 sync_scale;
> +		/*
> +		 * In sps scaled sync we must scale the input clock to a range
> +		 * of [3000 4500].
> +		 */
> +
> +		sync_scale =3D DIV_ROUND_CLOSEST(st->info->int_clk, st->clk_freq_hz);
> +
> +		if (3000 > sync_scale || 4500 > sync_scale)

That looks implausible.  Only actually tests in sync_scale is less than 3000
I'd guess one test is backwards.  Make sure to test the values that can go
into code like this.

> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid value:%u for sync_scale",
> +					     sync_scale);
> +
> +		ret =3D adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
> +					sync_scale);
> +		if (ret)
> +			return ret;
> +
> +		st->clk_freq_hz =3D st->info->int_clk;
> +	}
> +
> +	st->clk_freq_hz *=3D 1000;
> +
> +	mode =3D FIELD_PREP(ADIS16550_SYNC_MODE_MASK, sync->sync_mode) |
> +	       FIELD_PREP(ADIS16550_SYNC_EN_MASK, true);
> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				  ADIS16550_SYNC_MASK, mode);
> +}

> +static int adis16550_probe(struct spi_device *spi)
> +{
> +	u16 burst_length =3D ADIS16550_BURST_DATA_LEN;
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->available_scan_masks =3D adis16550_channel_masks;
> +	indio_dev->info =3D &adis16550_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	st->adis.ops =3D &adis16550_ops;
> +	st->adis.xfer =3D NULL;
> +	st->xfer =3D kzalloc(2 * sizeof(*st->xfer),
> +			   GFP_KERNEL);

Why not a devm_kzalloc or better yet devm_kcalloc()
given it is two of a particular size.

Alternatively if it is always 2 why not just embed an array
of two xfer in st and don't have an extra allocation at all?


> +	if (!st->xfer)
> +		return -ENOMEM;
> +
> +	st->adis.buffer =3D NULL;
> +	st->buffer =3D kzalloc(burst_length + sizeof(u32),
> +			     GFP_KERNEL);

devm_kzalloc() so it is cleaned up automatically on error or remove.

If you were going to continue not using devm for these you'd
need to free them in every error path.  Use devm to avoid
that.

> +	if (!st->buffer)
> +		return -ENOMEM;
> +
> +	st->xfer[0].tx_buf =3D st->buffer + burst_length;
> +	st->xfer[0].len =3D 4;
> +	st->xfer[0].cs_change =3D 1;
> +	st->xfer[0].delay.value =3D 8;
> +	st->xfer[0].delay.unit =3D SPI_DELAY_UNIT_USECS;
> +	st->xfer[1].rx_buf =3D st->buffer;
> +	st->xfer[1].len =3D burst_length;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			      "Failed to get vdd regulator\n");
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16550_config_sync(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static void adis16550_remove(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));

You are allocating in the remove path. That makes no sense.

> +	st =3D iio_priv(indio_dev);
> +
> +	kfree(st->xfer);
> +	kfree(st->buffer);

As above. Embed xfer directly as an array of 2 structures in
st, and for st->buffer use devm_kzalloc()

Then no need to have a remove at all.

> +}
> +
> +static const struct spi_device_id adis16550_id[] =3D {
> +	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16550_id);
> +
> +static const struct of_device_id adis16550_of_match[] =3D {
> +	{ .compatible =3D "adi,adis16550", .data =3D &adis16550_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adis16550_of_match);
> +
> +static struct spi_driver adis16550_driver =3D {
> +	.driver =3D {
> +		.name =3D "adis16550",
> +		.of_match_table =3D adis16550_of_match,
> +	},
> +	.probe =3D adis16550_probe,
> +	.id_table =3D adis16550_id,
> +	.remove =3D adis16550_remove,
> +};
> +module_spi_driver(adis16550_driver);
> +
> +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> +MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
> +MODULE_IMPORT_NS("IIO_ADISLIB");
> +MODULE_LICENSE("GPL");


