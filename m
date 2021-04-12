Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC11235C4B8
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 13:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhDLLKH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 07:10:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2836 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbhDLLJy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 07:09:54 -0400
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJm664jldz6845h;
        Mon, 12 Apr 2021 19:02:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 13:09:33 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 12:09:32 +0100
Date:   Mon, 12 Apr 2021 12:08:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tomas Melin <tomas.melin@vaisala.com>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: accel: Add driver for Murata SCA3300
 accelerometer
Message-ID: <20210412120807.000044d3@Huawei.com>
In-Reply-To: <20210412075056.56301-3-tomas.melin@vaisala.com>
References: <20210412075056.56301-1-tomas.melin@vaisala.com>
        <20210412075056.56301-3-tomas.melin@vaisala.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 10:50:56 +0300
Tomas Melin <tomas.melin@vaisala.com> wrote:

> Add initial support for Murata SCA3300 3-axis industrial
> accelerometer with digital SPI interface. This device also
> provides a temperature measurement.
> 
> Device product page including datasheet can be found at:
> https://www.murata.com/en-global/products/sensor/accel/sca3300
> 
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>

Hi Tomas,

Comments below.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/Kconfig   |  13 ++
>  drivers/iio/accel/Makefile  |   1 +
>  drivers/iio/accel/sca3300.c | 434 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 448 insertions(+)
>  create mode 100644 drivers/iio/accel/sca3300.c
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index cceda3cecbcf..0dbf7b648e8a 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -450,6 +450,19 @@ config SCA3000
>  	  To compile this driver as a module, say M here: the module will be
>  	  called sca3000.
>  
> +config SCA3300
> +	tristate "Murata SCA3300 3-Axis Accelerometer Driver"
> +	depends on SPI
> +	select CRC8
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say yes here to build support for Murata SCA3300 3-Axis
> +	  accelerometer.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called sca3300.
> +
>  config STK8312
>  	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>  	depends on I2C
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index 32cd1342a31a..4b56527a2b97 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -50,6 +50,7 @@ obj-$(CONFIG_MXC4005)		+= mxc4005.o
>  obj-$(CONFIG_MXC6255)		+= mxc6255.o
>  
>  obj-$(CONFIG_SCA3000)		+= sca3000.o
> +obj-$(CONFIG_SCA3300)		+= sca3300.o
>  
>  obj-$(CONFIG_STK8312)		+= stk8312.o
>  obj-$(CONFIG_STK8BA50)		+= stk8ba50.o
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> new file mode 100644
> index 000000000000..112fb88ecd3a
> --- /dev/null
> +++ b/drivers/iio/accel/sca3300.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Vaisala Oyj. All rights reserved.

Give a year for the copyright notice if you can.

> + */
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +
> +#define SCA3300_ALIAS "sca3300"
> +
> +#define SCA3300_REG_STATUS 0x6
> +#define SCA3300_REG_MODE 0xd
> +#define SCA3300_REG_WHOAMI 0x10
> +#define SCA3300_VALUE_SW_RESET 0x20
> +#define SCA3300_CRC8_POLYNOMIAL 0x1d
> +#define SCA3300_X_READ 0

I wouldn't bother defining this.

> +#define SCA3300_X_WRITE BIT(7)

Even this one is something I'd just put inline with a comment.

> +#define SCA3300_DEVICE_ID 0x51
> +#define SCA3300_RS_ERROR 0x3
> +
> +enum sca3300_scan_indexes {
> +	SCA3300_ACC_X = 0,
> +	SCA3300_ACC_Y,
> +	SCA3300_ACC_Z,
> +	SCA3300_TEMP,
> +	SCA3300_TIMESTAMP,
> +};
> +
> +#define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
> +		.type = IIO_ACCEL,					\
> +		.address = reg,						\
> +		.modified = 1,						\
> +		.channel2 = IIO_MOD_##axis,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +				      BIT(IIO_CHAN_INFO_PROCESSED),	\

As mentioned below, don't provide PROCESSED. Userspace is better at handling the
conversion so leave it to them.

> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = index,					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +			.shift = 0,					\
> +			.endianness = IIO_CPU,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec sca3300_channels[] = {
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> +	{
> +		.type = IIO_TEMP,
> +		.address = 0x5,
> +		.scan_index = SCA3300_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.shift = 0,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static const int sca3300_accel_scale[] = {2700, 1350, 5400, 5400};
> +
> +static const unsigned long sca3300_scan_masks[] = {
> +	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +	BIT(SCA3300_TEMP),
> +	0};
> +
> +/**
> + * SCA3300 device data

run scripts/kernel-doc over the file and fix the warnings + errors.

> + *
> + * @spi SPI device structure
> + * @opmode Device operation mode
> + * @lock Data buffer lock
> + * @txbuf Transmit buffer
> + * @rxbuf Receive buffer
> + * @scan Triggered buffer. Four channel 16-bit data + 64-bit timestamp
> + */
> +struct sca3300_data {
> +	struct spi_device *spi;
> +	u32 opmode;
> +	struct mutex lock;
> +	u8 txbuf[4];
> +	u8 rxbuf[4];
> +	struct {
> +		s16 channels[4];
> +		s64 ts __aligned(sizeof(s64));
> +	} scan;
> +};
> +
> +DECLARE_CRC8_TABLE(sca3300_crc_table);
> +
> +static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> +{
> +	struct spi_delay delay = {.value = 10, .unit = SPI_DELAY_UNIT_USECS};
> +	int32_t ret;
> +	int rs;
> +	u8 crc;
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = sca_data->txbuf,
> +			.rx_buf = NULL,
> +			.len = ARRAY_SIZE(sca_data->txbuf),
> +			.delay = delay,
> +			.cs_change = 1,
> +		},
> +		{
> +			.tx_buf = NULL,
> +			.rx_buf = sca_data->rxbuf,
> +			.len = ARRAY_SIZE(sca_data->rxbuf),
> +			.delay = delay,
> +			.cs_change = 0,
> +		}
> +	};
> +
> +	/* inverted crc value as described in device data sheet */
> +	crc = ~crc8(sca3300_crc_table, &sca_data->txbuf[0], 3, CRC8_INIT_VALUE);
> +	sca_data->txbuf[3] = crc;
> +
> +	ret = spi_sync_transfer(sca_data->spi, xfers, 2);

Use ARRAY_SIZE(xfers) instead of 2.

> +	if (ret < 0) {
> +		dev_err(&sca_data->spi->dev,
> +			"transfer error, error: %d\n", ret);
> +		return -EIO;
> +	}
> +
> +	crc = ~crc8(sca3300_crc_table, &sca_data->rxbuf[0], 3, CRC8_INIT_VALUE);
> +	if (sca_data->rxbuf[3] != crc) {
> +		dev_err(&sca_data->spi->dev, "CRC checksum mismatch");
> +		return -EIO;
> +	}
> +
> +	/* get return status */
> +	rs = sca_data->rxbuf[0] & 0x03;
> +	if (rs == SCA3300_RS_ERROR)
> +		return rs;
> +
> +	*val = (s16)(sca_data->rxbuf[2] | (sca_data->rxbuf[1] << 8));

Preference for an unaligned endian conversion here and explicit sign extend e.g
something like 

sign_extend32(get_unaligned_le16(&sca_data->rxbuf[1]), 15)

> +
> +	return 0;
> +}
> +
> +static int sca3300_read_reg(struct sca3300_data *sca_data, u8 reg, int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&sca_data->lock);
> +	sca_data->txbuf[0] = SCA3300_X_READ | (reg << 2);
> +	ret = sca3300_transfer(sca_data, val);
> +	if (ret > 0) {
> +		sca_data->txbuf[0] = SCA3300_X_READ | (SCA3300_REG_STATUS << 2);
> +		ret = sca3300_transfer(sca_data, val);
> +		/* status 0 = startup, 0x2 = mode change */
> +		if (ret > 0 && *val != 0 && *val != 0x2) {
> +			dev_err_ratelimited(&sca_data->spi->dev,
> +					    "device status: %x\n",
> +					    (u16)*val);
> +			mutex_unlock(&sca_data->lock);
> +			return -EIO;
> +		}
> +		if (ret > 0)
> +			ret = 0;
> +	}
> +	mutex_unlock(&sca_data->lock);
> +
> +	return ret;
> +}
> +
> +static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
> +{
> +	int reg_val = 0;
> +	int ret;
> +
> +	mutex_lock(&sca_data->lock);
> +	sca_data->txbuf[0] = SCA3300_X_WRITE | (reg << 2);
> +	sca_data->txbuf[1] = val >> 8;
> +	sca_data->txbuf[2] = val & 0xFF;

Prefer (Slightly) an unaligned put.

> +	ret = sca3300_transfer(sca_data, &reg_val);
> +	if (ret > 0) {

Factor this error handling out to another function, plus trigger it from an
appropriate standard error code rather than a positive return value.

> +		sca_data->txbuf[0] = SCA3300_X_READ | (SCA3300_REG_STATUS << 2);
> +		ret = sca3300_transfer(sca_data, &reg_val);
> +		/* status 0 = startup, 0x2 = mode change */
> +		if (ret > 0 && reg_val != 0 && reg_val != 0x2) {
> +			dev_err_ratelimited(&sca_data->spi->dev,
> +					    "device status: %x\n",
> +					    (u16)reg_val);
> +			mutex_unlock(&sca_data->lock);
> +			return -EIO;
> +		}
> +		if (ret > 0)
> +			ret = 0;

Whenever you get this sort of juggling it rather implies your design is
less than ideal.

> +	}
> +	mutex_unlock(&sca_data->lock);
> +
> +	return ret;
> +}
> +
> +static int sca3300_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct sca3300_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val < 0 || val > 3)
> +			return -EINVAL;

No.  Scale values need to be the value of 1LSB not a random integer
that requires you to look up the datasheet.

> +		return sca3300_write_reg(data, SCA3300_REG_MODE, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sca3300_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct sca3300_data *data = iio_priv(indio_dev);
> +	int ret;
> +	int reg_val;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = sca3300_read_reg(data, chan->address, val);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +		*val = sca3300_accel_scale[reg_val];

Scale is very very rarely an integer value which makes me wonder what
you are returning here...  It should be the multiplier needed to
take the raw value to a reading in m/sec^2  Given you use it as fractional
below, I'm guessing this is 1/scale_value?

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PROCESSED:
Don't provide processed here.   Userspace needs to do the conversion itself
(and given it has floating point easily available will probably do a better
 job than we can).   I'm assuming the mode can't autonomously change?

> +		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +		*val2 = sca3300_accel_scale[reg_val];
> +		ret = sca3300_read_reg(data, chan->address, val);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t sca3300_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct sca3300_data *data = iio_priv(indio_dev);
> +	s64 time_ns = iio_get_time_ns(indio_dev);

Is the timestamp at the start more accurate that that at the end
of reading the channels?  If not, just put this inline in the
iio_push_to_buffers_with_timestamp() call.

> +	int bit, ret, val, i = 0;
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		ret = sca3300_read_reg(data, sca3300_channels[bit].address,
> +				       &val);
> +		if (ret < 0)

Given we can't return an error code from interrupt handlers, it is usually
a good idea to print something to the log. Otherwise we get missing data
with no idea of why..

> +			goto out;
> +		if (ARRAY_SIZE(data->scan.channels) > i)

How could this not be true?  If it's always true, don't bother
checking i.

> +			((s16 *)data->scan.channels)[i++] = val;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sca3300_init(struct sca3300_data *sca_data,
> +			struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	int value = 0;
> +
> +	if (sca_data->opmode < 1 || sca_data->opmode > 4)
> +		return -EINVAL;

Whilst this is going anyway, better to check that next to where
it is read so we drop out immediately rather than buried in this
function.

> +
> +	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> +				SCA3300_VALUE_SW_RESET);
> +	if (ret != 0)
> +		return ret;

For sleeps, good to reference which section in data sheet gives the
timing.

> +	usleep_range(2e3, 10e3);
> +
> +	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> +				sca_data->opmode - 1);
> +	if (ret != 0)
if (ret) see below.

> +		return ret;
> +	msleep(100);

Again, document where the time comes from. Saves reviewers time if
they want to check it. (I'm too lazy :)

> +	ret = sca3300_read_reg(sca_data, SCA3300_REG_WHOAMI, &value);
> +	if (ret != 0)

if (ret) is more idiomatic in kernel code.

> +		return ret;
> +
> +	if (value != SCA3300_DEVICE_ID) {
> +		dev_err(&sca_data->spi->dev, "device id not expected value\n");

Perhaps useful to print what was expected and what was seen.  Maybe it's
a new variant and this might help the user to identify that and add it to the
driver.

> +		return -EIO;

-EINVAL probably more appropriate return.

> +	}
> +	return 0;
> +}
> +
> +static int sca3300_debugfs_reg_access(struct iio_dev *indio_dev,
> +				      unsigned int reg, unsigned int writeval,
> +				      unsigned int *readval)
> +{
> +	struct sca3300_data *data = iio_priv(indio_dev);
> +	int value;
> +	int ret;
> +
> +	if (reg > 0x1f)

Use a define that names that register.

> +		return -EINVAL;
> +
> +	if (!readval)
> +		return sca3300_write_reg(data, reg, writeval);
> +
> +	ret = sca3300_read_reg(data, reg, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	*readval = (unsigned int)value;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info sca3300_info = {
> +	.read_raw = sca3300_read_raw,
> +	.write_raw = sca3300_write_raw,
> +	.debugfs_reg_access = &sca3300_debugfs_reg_access,
> +};
> +
> +static int sca3300_probe(struct spi_device *spi)
> +{
> +	struct sca3300_data *sca_data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sca_data));
> +	if (!indio_dev) {
> +		dev_err(&spi->dev,
> +			"failed to allocate memory for iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	sca_data = iio_priv(indio_dev);
> +	mutex_init(&sca_data->lock);
> +	sca_data->spi = spi;
> +	spi_set_drvdata(spi, indio_dev);

Won't be used once using devm as below and remove() is dropped, so drop this.

> +
> +	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &sca3300_info;
> +	indio_dev->name = SCA3300_ALIAS;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

BUFFER_TRIGGERED bit now set by iio_triggered_buffer_setup() so shouldn't
be ehre as well.

> +	indio_dev->channels = sca3300_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
> +	indio_dev->available_scan_masks = sca3300_scan_masks;
> +
> +	if (spi->dev.of_node) {
> +		ret = of_property_read_u32(spi->dev.of_node, "murata,opmode",

Please use generic firmware access calls rather than the of specific ones.
That lets us get ACPI support for free :)

As per the binding review however, this one needs to go in favour of userspace
control of scale + filter frequencies / sampling freq.

> +					   &sca_data->opmode);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = sca3300_init(sca_data, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "failed to init device, error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, iio_pollfunc_store_time,
> +					 sca3300_trigger_handler, NULL);

devm_iio_triggered_buffer_setup() and you can drop the manual cleanup in remove()
and hence drop remove() entirely as nothing else left.

> +	if (ret < 0) {
> +		dev_err(&spi->dev,
> +			"iio triggered buffer setup failed, error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "iio device register failed, error: %d\n",
> +			ret);
> +		iio_triggered_buffer_cleanup(indio_dev);
With devm above, no need to manually clean this up.

> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sca3300_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id sca3300_dt_ids[] = {
> +	{ .compatible = "murata,sca3300"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sca3300_dt_ids);
> +
> +static struct spi_driver sca3300_driver = {
> +	.driver = {
> +		.name		= SCA3300_ALIAS,
> +		.owner		= THIS_MODULE,
> +		.of_match_table = of_match_ptr(sca3300_dt_ids),
> +	},
> +
> +	.probe	= sca3300_probe,
> +	.remove	= sca3300_remove,
> +};
> +
> +module_spi_driver(sca3300_driver);
> +
> +MODULE_AUTHOR("Tomas Melin <tomas.melin@vaisala.com>");
> +MODULE_DESCRIPTION("Murata SCA3300 SPI Accelerometer");
> +MODULE_LICENSE("GPL v2");

