Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5722231135
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgG1SCl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:02:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2547 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728534AbgG1SCk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jul 2020 14:02:40 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 946A1671388ED8C1ABE0;
        Tue, 28 Jul 2020 19:02:38 +0100 (IST)
Received: from localhost (10.52.121.35) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 28 Jul
 2020 19:02:38 +0100
Date:   Tue, 28 Jul 2020 19:01:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christian Eggers <ceggers@arri.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: New driver
Message-ID: <20200728190114.00004636@Huawei.com>
In-Reply-To: <20200728062831.1143-3-ceggers@arri.de>
References: <20200728062831.1143-1-ceggers@arri.de>
        <20200728062831.1143-3-ceggers@arri.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.35]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 28 Jul 2020 08:28:31 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor.
> 
> This driver has no built-in trigger. In order for making triggered
> measurements, an external (software) trigger driver like
> iio-trig-hrtimer or iio-trig-sysfs is required.
> 
> The sensor supports single and continuous measurement modes. The latter
> is not used by design as this would require tight timing synchronization
> between hardware and driver without much benefit.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>

Hi Christian,

I took a fairly quick look. Not divided into the datasheet or anything yet!

Comments inline.

Thanks,

Jonathan

> ---
>  MAINTAINERS                 |   7 +
>  drivers/iio/light/Kconfig   |  15 +
>  drivers/iio/light/Makefile  |   1 +
>  drivers/iio/light/as73211.c | 825 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 848 insertions(+)
>  create mode 100644 drivers/iio/light/as73211.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 068d6e94122b..673570414147 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -934,6 +934,13 @@ S:	Supported
>  F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
>  F:	drivers/net/ethernet/amd/xgbe/
>  
> +AMS AS73211 DRIVER
> +M:	Christian Eggers <ceggers@arri.de>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
> +F:	drivers/iio/light/as73211.c
> +
>  ANALOG DEVICES INC AD5686 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 182bd18c4bb2..cade6dc0305b 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -86,6 +86,21 @@ config APDS9960
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called apds9960
>  
> +config AS73211
> +	tristate "AMS AS73211 XYZ color sensor"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	 If you say yes here you get support for the AMS AS73211
> +	 JENCOLOR(R) Digital XYZ Sensor.
> +
> +	 For triggered measurements, you will need an additional trigger driver
> +	 like IIO_HRTIMER_TRIGGER or IIO_SYSFS_TRIGGER.
> +
> +	 This driver can also be built as a module.  If so, the module
> +	 will be called as73211.
> +
>  config BH1750
>  	tristate "ROHM BH1750 ambient light sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index d1c8aa30b9a8..ea376deaca54 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_AL3010)		+= al3010.o
>  obj-$(CONFIG_AL3320A)		+= al3320a.o
>  obj-$(CONFIG_APDS9300)		+= apds9300.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
> +obj-$(CONFIG_AS73211)		+= as73211.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
>  obj-$(CONFIG_BH1780)		+= bh1780.o
>  obj-$(CONFIG_CM32181)		+= cm32181.o
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> new file mode 100644
> index 000000000000..354d82873549
> --- /dev/null
> +++ b/drivers/iio/light/as73211.c
> @@ -0,0 +1,825 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * as73211.c - Support for AMS AS73211 JENCOLOR(R) Digital XYZ Sensor
> + *
> + * Author: Christian Eggers <ceggers@arri.de>
> + *
> + * Copyright (c) 2020 ARRI Lighting
> + *
> + * Color light sensor with 16-bit channels for red, green, blue, clear);
> + * 7-bit I2C slave address 0x74 .. 0x77.
> + *
> + * Datasheet: https://ams.com/documents/20143/36005/AS73211_DS000556_3-01.pdf/a65474c0-b302-c2fd-e30a-c98df87616df
> + *
Drop this trailing blank line.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger.h>

Only a driver providing a trigger should need to include trigger.h unless
I'm missing something...

> +
> +#define AS73211_DRV_NAME "as73211"
> +
> +/* AS73211 configuration registers */
> +#define AS73211_REG_OSR    0x0
> +#define AS73211_REG_AGEN   0x2
> +#define AS73211_REG_CREG1  0x6
> +#define AS73211_REG_CREG2  0x7
> +#define AS73211_REG_CREG3  0x8
> +
> +/* AS73211 output register bank */
> +#define AS73211_OUT_OSR_STATUS    0
> +#define AS73211_OUT_TEMP          1
> +#define AS73211_OUT_MRES1         2
> +#define AS73211_OUT_MRES2         3
> +#define AS73211_OUT_MRES3         4
> +
> +/* OSR */
> +#define AS73211_OSR_SS            BIT(7)
> +#define AS73211_OSR_PD            BIT(6)
> +#define AS73211_OSR_SW_RES        BIT(3)
> +#define AS73211_OSR_DOS_SHIFT     0
> +#define AS73211_OSR_DOS_MASK      (0x7 << AS73211_OSR_DOS_SHIFT)
> +#define AS73211_OSR_DOS_CONFIG    (0x2 << AS73211_OSR_DOS_SHIFT)
> +#define AS73211_OSR_DOS_MEASURE   (0x3 << AS73211_OSR_DOS_SHIFT)
> +
> +/* AGEN */

Naming already makes the comment clear, which is great, so I'd
drop the comment.

> +#define AS73211_AGEN_DEVID_SHIFT  4
> +#define AS73211_AGEN_DEVID_MASK   (0xf << AS73211_AGEN_DEVID_SHIFT)

GENMASK preferred. Can be used with FIELD_PREP etc.

> +
> +/* CREG1 */
> +#define AS73211_CREG1_GAIN_SHIFT  4
> +#define AS73211_CREG1_GAIN_MASK   (0xf << AS73211_CREG1_GAIN_SHIFT)
> +#define AS73211_CREG1_TIME_SHIFT  0
> +#define AS73211_CREG1_TIME_MASK   (0xf << AS73211_CREG1_TIME_SHIFT)
> +
> +/* CREG3 */
> +#define AS73211_CREG3_CCLK_SHIFT  0
> +#define AS73211_CREG3_CCLK_MASK   (0x3 << AS73211_CREG3_CCLK_SHIFT)
> +
> +/* OSR_STATUS */
> +#define AS73211_OSR_STATUS_OUTCONVOF  BIT(15)
> +#define AS73211_OSR_STATUS_MRESOF     BIT(14)
> +#define AS73211_OSR_STATUS_ADCOF      BIT(13)
> +#define AS73211_OSR_STATUS_LDATA      BIT(12)
> +#define AS73211_OSR_STATUS_NDATA      BIT(11)
> +#define AS73211_OSR_STATUS_NOTREADY   BIT(10)
> +
> +
> +/**
> + * struct as73211_data - Instance data for one AS73211
> + * @client: I2C client.
> + * @osr:    Cached Operational State Register.
> + * @creg1:  Cached Configuration Register 1.
> + * @creg2:  Cached Configuration Register 2.
> + * @creg3:  Cached Configuration Register 3.

Just a thought, but why not creg[3]?;

> + * @buffer: Buffer for triggered measurements.

?  Run kernel-doc, or build with W=1 and to check docs.

> + * @mutex:  Device mutex. N.B: We do not use iio_dev::mlock because we need to
> + *          change device properties while in buffered mode.

No need for that comment.  mlock is clearly marked as internal use only
as it's not ever meant to be directly accessed by a driver.
(there are a few that still do it for historical reasons but we are
working on changing them all).

However, you should say what it does protect.  Here I think it
is mostly about keeping cached registers in sync with the device?

> + * @completion: Completion to wait for interrupt.
> + */
> +struct as73211_data {
> +	struct i2c_client *client;
> +	u8 osr;
> +	u8 creg1;
> +	u8 creg2;
> +	u8 creg3;
> +	struct mutex mutex;
> +	struct completion completion;
> +};
> +
> +#define AS73211_COLOR_CHANNEL(_color, _si, _addr) { \
> +	.type = IIO_INTENSITY, \
> +	.modified = 1, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_type = \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +		BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
> +		BIT(IIO_CHAN_INFO_INT_TIME), \
> +	.channel2 = IIO_MOD_##_color, \
> +	.address = _addr, \
> +	.scan_index = _si, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +}
> +
> +#define AS73211_TEMP_CHANNEL(_si, _addr) { \

As you only use this once, better to just put the content inline.

> +	.type = IIO_TEMP, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.channel2 = 0, \
No need to set channel2 to it's default value here.
> +	.address = _addr, \
> +	.scan_index = _si, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
As mentioned below, keep all these little endian.

> +	}, \
> +}
> +
> +#define AS73211_SCALE_X 277071108  /* nW/m^2 */
> +#define AS73211_SCALE_Y 298384270  /* nW/m^2 */
> +#define AS73211_SCALE_Z 160241927  /* nW/m^2 */
> +
> +/* Channel order MUST match devices result register order */
> +static const struct iio_chan_spec as73211_channels[] = {
> +	AS73211_TEMP_CHANNEL(0, AS73211_OUT_TEMP),
> +	AS73211_COLOR_CHANNEL(X, 1, AS73211_OUT_MRES1),
> +	AS73211_COLOR_CHANNEL(Y, 2, AS73211_OUT_MRES2),
> +	AS73211_COLOR_CHANNEL(Z, 3, AS73211_OUT_MRES3),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +static unsigned int as73211_integration_time_cycles(struct as73211_data *data)
> +{
> +	return 1 << (data->creg1 & AS73211_CREG1_TIME_MASK);
> +}
> +
> +/* return current integration time (in us) */
> +static unsigned int as73211_integration_time_us(struct as73211_data *data)
> +{
> +	/* Integration time has 15 steps, the step size depends on the clock. */
> +	unsigned int mul = 1 << (3 - (data->creg3 & 0b11));  /* 8 = 1.024 MHz, 4 = 2.048 MHz ...*/
> +	unsigned int time_cycles = as73211_integration_time_cycles(data);
> +	unsigned int time_us = time_cycles * 125 * mul;

This would be easier to read as

	unsigned int mul, time_cycles;

	mul = ...

	return time_cycles * 125 * mul;

> +
> +	return time_us;
> +}
> +
> +/* return gain (1, 2, 4, 8, ...) */
> +static unsigned int as73211_gain(struct as73211_data *data)
> +{
> +	return 1 << (0b1011 - (data->creg1 >> AS73211_CREG1_GAIN_SHIFT));
> +}
> +
> +/* must be called with as73211_data::mutex held. */
> +static int as73211_req_data(struct as73211_data *data)
> +{
> +	unsigned int time_us = as73211_integration_time_us(data), ret;
> +	union i2c_smbus_data smbus_data;
> +	s32 osr_status;
> +
> +	if (data->client->irq)
> +		init_completion(&data->completion);
> +
> +	/* During measurement, there should be no traffic on the i2c bus */
> +	i2c_lock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +
> +	data->osr &= ~AS73211_OSR_DOS_MASK;
> +	data->osr |= AS73211_OSR_DOS_MEASURE | AS73211_OSR_SS;
> +
> +	smbus_data.byte = data->osr;
> +	ret = __i2c_smbus_xfer(data->client->adapter, data->client->addr,
> +			data->client->flags, I2C_SMBUS_WRITE,
> +			AS73211_REG_OSR, I2C_SMBUS_BYTE_DATA, &smbus_data);
> +	if (ret) {
> +		i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +		return ret;
> +	}
> +
> +	/* Reset AS73211_OSR_SS (is self clearing) in order to avoid unintentional
/* 
 * Reset...

Same for all the other multiline comemnts.

> +	 * triggering of further measurements later.
> +	 */
> +	data->osr &= ~AS73211_OSR_SS;
> +
> +	/* Add some extra margin for the timeout. sensor timing is not as precise
> +	 * as our one ...
> +	 */
> +	time_us += time_us / 8;
> +	if (data->client->irq) {
> +		dev_dbg(&data->client->dev, "%s(): Waiting for completion...\n", __func__);
> +		ret = wait_for_completion_timeout(&data->completion,
> +					2 + usecs_to_jiffies(time_us));
> +		if (!ret) {
> +			dev_err(&data->client->dev,
> +				"timeout waiting for READY IRQ\n");
> +			i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		/* Wait integration time */
> +		dev_dbg(&data->client->dev, "%s(): Sleeping %d us\n", __func__, time_us);
> +		usleep_range(time_us, time_us + 100000);
> +	}
> +
> +	i2c_unlock_bus(data->client->adapter, I2C_LOCK_SEGMENT);
> +
> +	osr_status = i2c_smbus_read_word_data(data->client, AS73211_OUT_OSR_STATUS);
> +	if (osr_status < 0) {
> +		ret = osr_status;
> +		return ret;

return osr_status;

> +	}
> +
> +	dev_dbg(&data->client->dev, "%s: osr_status = 0x%04x\n", __func__, osr_status);
> +	if (osr_status != (AS73211_OSR_DOS_MEASURE | AS73211_OSR_STATUS_NDATA)) {
> +		if (osr_status & AS73211_OSR_SS) {
> +			dev_warn(&data->client->dev, "%s() Measurement has not stopped\n",
> +					__func__);
> +			return -ETIME;
> +		}
> +		if (osr_status & AS73211_OSR_STATUS_NOTREADY) {
> +			dev_warn(&data->client->dev, "%s() Data is not ready\n", __func__);
> +			return -ENODATA;
> +		}
> +		if (!(osr_status & AS73211_OSR_STATUS_NDATA)) {
> +			dev_warn(&data->client->dev, "%s() New new data available\n", __func__);
> +			return -ENODATA;
> +		}
> +		if (osr_status & AS73211_OSR_STATUS_LDATA) {
> +			dev_warn(&data->client->dev, "%s() Result buffer overrun\n", __func__);
> +			return -ENOBUFS;
> +		}
> +		if (osr_status & AS73211_OSR_STATUS_ADCOF) {
> +			dev_warn(&data->client->dev, "%s() ADC overflow\n", __func__);
> +			return -EOVERFLOW;
> +		}
> +		if (osr_status & AS73211_OSR_STATUS_MRESOF) {
> +			dev_warn(&data->client->dev, "%s() Measurement result overflow\n",
> +					__func__);
> +			return -EOVERFLOW;
> +		}
> +		if (osr_status & AS73211_OSR_STATUS_OUTCONVOF) {
> +			dev_warn(&data->client->dev, "%s() Timer overflow\n", __func__);
> +			return -EOVERFLOW;
> +		}
> +		dev_warn(&data->client->dev, "%s() Unexpected status value\n", __func__);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int as73211_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)

Align parameters with opening bracket.  Also fine to use up to 100chars in a line.

> +{
> +	struct as73211_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +	{
> +		int ret = iio_device_claim_direct_mode(indio_dev);
> +
> +		if (ret)
> +			return ret;
> +		ret = as73211_req_data(data);
> +		if (ret < 0) {
> +			iio_device_release_direct_mode(indio_dev);
> +			return ret;
> +		}
> +		ret = i2c_smbus_read_word_data(data->client, chan->address);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +	{
> +		unsigned int scale;
> +
> +		switch (chan->channel2) {
> +		case IIO_MOD_X:
> +			scale = AS73211_SCALE_X;
> +			break;
> +		case IIO_MOD_Y:
> +			scale = AS73211_SCALE_Y;
> +			break;
> +		case IIO_MOD_Z:
> +			scale = AS73211_SCALE_Z;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		scale /= as73211_gain(data);
> +		scale /= as73211_integration_time_cycles(data);
> +		*val = scale;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = (1 << (data->creg3 & 0b11)) * 1024 * 1000;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*val = as73211_gain(data);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_INT_TIME:
> +	{
> +		unsigned int time_us;
> +
> +		mutex_lock(&data->mutex);
> +		time_us = as73211_integration_time_us(data);
> +		mutex_unlock(&data->mutex);
> +		*val = time_us / 1000000;
> +		*val2 = time_us % 1000000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	}  // switch (mask)
As below. Drop this comment.

> +
> +	return -EINVAL;
> +}
> +
> +static int _as73211_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan __always_unused,

Whilst true, what's the benefit of marking that as __always_unused?

> +			int val, int val2, long mask)
> +{
> +	struct as73211_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +	{
> +		int reg_bits, freq_kHz = val / 1000;  /* 1024, 2048, ... */
> +
> +		if (val < 0 || (freq_kHz * 1000) != val || val2)
> +			return -EINVAL;
> +		if (!is_power_of_2(freq_kHz))
> +			return -EINVAL;
> +		reg_bits = ilog2(freq_kHz) - 10;
> +		if (reg_bits & ~AS73211_CREG3_CCLK_MASK)
> +			return -EINVAL;
> +
> +		data->creg3 &= ~AS73211_CREG3_CCLK_MASK;
> +		data->creg3 |= reg_bits;
> +		return i2c_smbus_write_byte_data(
> +			data->client, AS73211_REG_CREG3,
> +			data->creg3);
> +	}
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +	{
> +		int reg_bits;
> +
> +		if (val < 0 || !is_power_of_2(val) || val2)
> +			return -EINVAL;
> +		reg_bits = (0b1011 - ilog2(val)) << AS73211_CREG1_GAIN_SHIFT;
> +		if (reg_bits != (reg_bits & AS73211_CREG1_GAIN_MASK))
> +			return -EINVAL;
> +		data->creg1 &= ~AS73211_CREG1_GAIN_MASK;
> +		data->creg1 |= reg_bits;
> +
> +		return i2c_smbus_write_byte_data(
> +			data->client, AS73211_REG_CREG1,
> +			data->creg1);
> +	}
> +	case IIO_CHAN_INFO_INT_TIME:
> +	{
> +		int time_us = val * 1000000 + val2, time_ms;
> +		int reg_bits;
> +
> +		/* Integration time has 15 steps, the step size depends on the clock.
> +		 * 1 = 1.024 MHz, 2 = 2.048 MHz ..
> +		 */
> +		int mul = 1 << (data->creg3 & AS73211_CREG3_CCLK_MASK);
> +
> +		time_ms = (time_us * mul) / 1000;  /* 1 ms, 2 ms, ... (power of two) */
> +		if (time_ms < 0 || !is_power_of_2(time_ms) || time_ms > 16384)
> +			return -EINVAL;
> +		reg_bits = ilog2(time_ms) << AS73211_CREG1_TIME_SHIFT;
> +		data->creg1 &= ~AS73211_CREG1_TIME_MASK;
> +		data->creg1 |= reg_bits;
> +
> +		return i2c_smbus_write_byte_data(
> +			data->client, AS73211_REG_CREG1,
> +			data->creg1);
> +	}
> +	}  // switch (mask)

drop the // switch (mask)
same in other cases.

> +	return -EINVAL;
> +}
> +
> +static int as73211_write_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val, int val2, long mask)
> +{
> +	int ret;
> +	struct as73211_data *data = iio_priv(indio_dev);
> +
> +	/* Need to switch to config mode ... */
> +	mutex_lock(&data->mutex);
> +
> +	if ((data->osr & AS73211_OSR_DOS_MASK) != AS73211_OSR_DOS_CONFIG) {
> +		data->osr &= ~AS73211_OSR_DOS_MASK;
> +		data->osr |= AS73211_OSR_DOS_CONFIG;
> +
> +		dev_dbg(&indio_dev->dev, "%s(): Switching to configuration state...", __func__);
> +		ret = i2c_smbus_write_byte_data(
> +			data->client, AS73211_REG_OSR,
> +			data->osr);
> +		if (ret)
> +			goto error_release;
> +	}
> +
> +	ret = _as73211_write_raw(indio_dev, chan, val, val2, mask);
> +
> +error_release:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static irqreturn_t as73211_ready_handler(int irq __always_unused, void *priv)
> +{
> +	struct iio_dev *indio_dev = priv;
> +	struct as73211_data *data = iio_priv(indio_dev);
> +
> +	complete(&data->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct as73211_data *data = iio_priv(indio_dev);
> +	u16 iio_buffer[8];  /* 4 16-bit channels + 64-bit timestamp */
Any buffer passed to iio_push_to_buffers_with_timestamp needs
to enforce __aligned(8).

One approach we've started using for cases like this where there
is only one layout is to use a structure to make the layout explicit.

struct {
	__le16 chan[4];
	s64 ts __aligned(8);
} scan;


> +	int data_result, ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	data_result = as73211_req_data(data);
> +
> +	/* Optimization for reading all (color + temperature) channels */
> +	if (*indio_dev->active_scan_mask == 0xf) {
> +		u8 addr = as73211_channels[0].address;
> +		__le16 hw_buffer[4]; /* 4 16-bit channels */

Should be able to read directly into the destination I think...

> +		struct i2c_msg msgs[] = {
> +			{
> +				.addr = data->client->addr,
> +				.flags = 0,
> +				.len = 1,
> +				.buf = &addr
> +			},
> +			{
> +				.addr = data->client->addr,
> +				.flags = I2C_M_RD,
> +				.len = 4 * sizeof(hw_buffer[0]),

sizeof(hw_buffer)

> +				.buf = (u8 *)&hw_buffer[0]
> +			},
> +		};
> +		ret = i2c_transfer(data->client->adapter, msgs, ARRAY_SIZE(msgs));
> +		if (ret < 0)
> +			goto done;
> +
> +		/* Temperature channel is not affected by overflows */
> +		iio_buffer[0] = le16_to_cpu(hw_buffer[0]);
> +
> +		if (data_result == 0) {
> +			/* convert byte order (AS73211 sends LSB first) */
> +			iio_buffer[1] = le16_to_cpu(hw_buffer[1]);
> +			iio_buffer[2] = le16_to_cpu(hw_buffer[2]);
> +			iio_buffer[3] = le16_to_cpu(hw_buffer[3]);
Why?  If the buffer is little endian, leave this to userspace and mark it as such
in the chan_spec.

> +		} else {
> +			/* saturate all channels (useful for overflows) */
> +			iio_buffer[1] = 0xffff;
> +			iio_buffer[2] = 0xffff;
> +			iio_buffer[3] = 0xffff;
That is rather non standard. 
> +		}
> +
> +	}
> +	/* Optimization for reading all color channels */
> +	else if (*indio_dev->active_scan_mask == 0xe) {
> +		__le16 hw_buffer[3]; /* 3 16-bit channels */
> +
> +		/* AS73211 starts reading at address 2 */
> +		ret = i2c_master_recv(data->client,
> +				(char *)&hw_buffer[0], 3 * sizeof(hw_buffer[0]));
> +		if (ret < 0)
> +			goto done;
> +
> +		if (data_result == 0) {
> +			/* convert byte order (as73211 sends LSB first) */
> +			iio_buffer[1] = le16_to_cpu(hw_buffer[0]);
> +			iio_buffer[2] = le16_to_cpu(hw_buffer[1]);
> +			iio_buffer[3] = le16_to_cpu(hw_buffer[2]);
> +		} else {
> +			/* saturate all channels (useful for overflows) */
> +			iio_buffer[1] = 0xffff;
> +			iio_buffer[2] = 0xffff;
> +			iio_buffer[3] = 0xffff;
> +		}
> +	} else {
> +		unsigned int i, j = 0;
> +
> +		/* generic case */
Given the vast majority of users are going to want to read all the color channels,
I'd use avail_scan_mask to restrict to the above two cases.  The IIO core will then
deal with demux of any subset of channels for you.  

We will be doing slightly more reading from the device than necessary, but seems unlikely
that will be too much of an issue.

> +		for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
> +			struct iio_chan_spec const *channel = &as73211_channels[i];
> +
> +			/* Read data even on error in order to avoid "result buffer overrun" */
> +			ret = i2c_smbus_read_word_data(data->client,
> +				channel->address);
one line.

> +			if (ret < 0)
> +				goto done;
> +
> +			if (data_result == 0) {
> +				iio_buffer[j++] = ret;
> +			} else {
> +				/* saturate all channels (useful for overflows) */
> +				iio_buffer[j++] = 0xffff;
> +			}
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, iio_buffer,
> +		iio_get_time_ns(indio_dev));
> +
> +done:
> +	mutex_unlock(&data->mutex);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t as73211_show_samp_freq_available(
> +		struct device *dev __always_unused,
> +		struct device_attribute *attr __always_unused,
> +		char *buf)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +			(1 << (i + 10)) * 1000);
> +	}
> +
> +	/* replace trailing space by newline */
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t as73211_show_int_time_available(struct device *dev,
> +			struct device_attribute *attr __always_unused,
> +			char *buf)
> +{
> +	struct as73211_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
> +	size_t len = 0;
> +	int i;
> +
> +	/* Integration time has 15 steps, the step size depends on the clock. */
> +	int mul = 1 << (3 - (data->creg3 & 0b11));  /* 8 = 1.024 MHz, 4 = 2.048 MHz ...*/
> +
> +	for (i = 0; i < 15; i++) {
> +		int time_us = mul * (1 << i) * 125;
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%06d ",
> +			time_us / 1000000,
> +			time_us % 1000000);
> +	}
> +
> +	/* replace trailing space by newline */
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t as73211_show_hardwaregain_available(
> +		struct device *dev __always_unused,
> +		struct device_attribute *attr __always_unused,
> +		char *buf)
> +{
> +	size_t len = 0;
> +	int i;
> +
> +	for (i = 0; i < 12; i++) {
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +			1 << i);
> +	}
> +
> +	/* replace trailing space by newline */
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(as73211_show_samp_freq_available);
> +static IIO_DEV_ATTR_INT_TIME_AVAIL(as73211_show_int_time_available);
> +static IIO_DEVICE_ATTR(hardwaregain_available, S_IRUGO,
> +		as73211_show_hardwaregain_available, NULL, 0);
> +static IIO_CONST_ATTR_TEMP_OFFSET("-66.9");
> +static IIO_CONST_ATTR_TEMP_SCALE("0.05");
> +
> +static struct attribute *as73211_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_integration_time_available.dev_attr.attr,
> +	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
> +	&iio_const_attr_in_temp_offset.dev_attr.attr,
> +	&iio_const_attr_in_temp_scale.dev_attr.attr,

These should be handled via read_raw.
Ideally do the _available ones via the core callbacks
and _avail masks as well. For the more complex values,
compute the table on first read or at probe and cache it.


> +	NULL
> +};
> +
> +static const struct attribute_group as73211_attribute_group = {
> +	.attrs = as73211_attributes,
> +};
> +
> +static const struct iio_info as73211_info = {
> +	.read_raw = as73211_read_raw,
> +	.write_raw = as73211_write_raw,
> +	.attrs = &as73211_attribute_group,
> +};
> +
> +static int as73211_probe(struct i2c_client *client,
> +			struct i2c_device_id const *id __always_unused)
> +{
> +	struct as73211_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = &client->dev;

That is now set by the IIO core, so no need to set it manually.

> +	indio_dev->info = &as73211_info;
> +	indio_dev->name = AS73211_DRV_NAME;
> +	indio_dev->channels = as73211_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
> +	if (ret < 0)
> +		return ret;
> +	data->osr = ret;
> +
> +	/* reset device */
> +	data->osr |= AS73211_OSR_SW_RES;
> +	ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR,
> +		data->osr);

As mentioned below, can go a bit longer on lines for readability so
put this and similar cases on one line.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_OSR);
> +	if (ret < 0)
> +		return ret;
> +	data->osr = ret;
> +
> +	/* Reading AGEN is only possible after reset (AGEN is not available if

IIO and most of kernel use follow for multiline comments.
/*
 * Reading...
 */

> +	 * device is in measurement mode).
> +	 */
> +	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_AGEN);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((ret >> AS73211_AGEN_DEVID_SHIFT) == 0b0010)

Use a #define for that ID / magic number.

> +		dev_info(&client->dev, "AS73211 found\n");

This is noise in the log so dev_dbg maybe or drop ti entirely.


> +	else
> +		return -ENODEV;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_CREG1);
> +	if (ret < 0)
> +		return ret;
> +	data->creg1 = ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_CREG2);
> +	if (ret < 0)
> +		return ret;
> +	data->creg2 = ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, AS73211_REG_CREG3);
> +	if (ret < 0)
> +		return ret;
> +	data->creg3 = ret;
> +
> +	/* enable device */
> +	data->osr &= ~AS73211_OSR_PD;
> +	ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR,
> +		data->osr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +		as73211_trigger_handler, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret = request_threaded_irq(client->irq,
> +				NULL,
> +				as73211_ready_handler,
> +				IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				client->name, indio_dev);
> +		if (ret)
> +			goto buffer_cleanup;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto free_irq;
> +
> +	return 0;
> +
> +free_irq:
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
> +buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);

Should we not powerdown on error?

> +	return ret;
> +}
> +
> +static int as73211_powerdown(struct iio_dev *indio_dev)
> +{
> +	struct as73211_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	data->osr |= AS73211_OSR_PD;
> +	ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR,
> +		data->osr);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +
> +static int as73211_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +
> +	iio_device_unregister(indio_dev);
> +	if (client->irq)
> +		free_irq(client->irq, indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +	as73211_powerdown(indio_dev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
For PM functions, please use
__maybe_unused rather than ifdef protections.

It has proved far too easy to get odd build issues around these PM config
variables, so we just let the linker get rid of the code if it's not referenced.
The __maybe_unused just deals with compiler warnings.

> +static int as73211_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +
> +	return as73211_powerdown(indio_dev);
> +}
> +
> +static int as73211_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct as73211_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +
> +	data->osr &= ~AS73211_OSR_PD;
> +	ret = i2c_smbus_write_byte_data(data->client, AS73211_REG_OSR,
> +		data->osr);

Rules on line length got more relaxed recently, so where it helps for
readability we can go up to 100 chars.  I'd put the above on one line
as it will definitely look nicer.

Also rather feels like we should have a trivial powerup function to
match with powerdown.

> +
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(as73211_pm_ops, as73211_suspend, as73211_resume);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id as73211_of_match[] = {
> +	{
> +		.compatible = "ams,as73211",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, as73211_of_match);
> +#else
> +#define as73211_of_match NULL
> +#endif
> +
> +static const struct i2c_device_id as73211_id[] = {
> +	{ "as73211", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, as73211_id);
> +
> +static struct i2c_driver as73211_driver = {
> +	.driver = {
> +		.name           = AS73211_DRV_NAME,
> +		.of_match_table = of_match_ptr(as73211_of_match),

Please drop the of_match_ptr protection and the ifdef CONFIG_OF above.

I'm in the process of ripping those out of IIO drivers as they prevent
the use of ACPI based probing via a magic PRP0001 device
(lets you use dt bindings in ACPI)

> +		.pm             = &as73211_pm_ops,
> +	},
> +	.probe		= as73211_probe,
> +	.remove		= as73211_remove,
> +	.id_table	= as73211_id,
> +};
> +module_i2c_driver(as73211_driver);
> +
> +MODULE_AUTHOR("Christian Eggers <ceggers@arri.de>");
> +MODULE_DESCRIPTION("AS73211 XYZ True Color Sensor driver");
> +MODULE_LICENSE("GPL");


