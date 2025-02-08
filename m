Return-Path: <linux-iio+bounces-15175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD63A2D729
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 17:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D5D1674CA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3342451FB;
	Sat,  8 Feb 2025 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgGXwrCD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1350151989;
	Sat,  8 Feb 2025 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031310; cv=none; b=XAiRQjjby2lQZIP8zHaplfG3qeiflVdoWNp5JoiIBJ4vtMQvmI7kUaP0LuzSfNNbRRVhK7nn4V5fTZGV4LEHgM2Qxhqb4IFAq4clUA9adRAkdmg3gSYLbF0H/yczqLtq4m9zJAPCoMU13+iG82ULVSaFELX+m4iPfyy7ToA/qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031310; c=relaxed/simple;
	bh=0M4JQM20/XXv1inWZHMVZqMHkV7nbSONR0o/1XLqhAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hy7UscCoKtcXgJWnXzHRQznamrM4v0+4BTql54TerqcZUxT+UyIfviD3SkMpCfkHBEl4Y0W1v9+KPyODCZbnxyifF9JkRdsGb96eJnfkTdTvY4Vgb/5QDShk/Ji1VOmpTBIuM+j9TbVRhq9T4M41i+kYGadDImxUAiymo7TMnwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgGXwrCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D799C4CED6;
	Sat,  8 Feb 2025 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031310;
	bh=0M4JQM20/XXv1inWZHMVZqMHkV7nbSONR0o/1XLqhAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tgGXwrCDxBD22OjkDcumghm8xF/0ziexO/q+V9FgXv9mooaLB2A3Vr5anEp78RI3N
	 d9aBZIWgNqO4DTBgYE/CYja+vUYivwbY+N3pYKKO6yNDU+EH2sb8vm6kl09p+sM6bi
	 a5mGWyURsekXnmGN7DIKLAt1icmnC957/NN373gwCEoe1CVnihP0qVPlQzmqtxfGbD
	 Ykz9SBxAB2nsfM8JTp/txWX0YlbOEHc1qL3xkME1VYBGRu/ooEKqC49uSYLLtWelI5
	 jmY+1/7jzNMYcWSmlUa7ttENacrXST8HnxCR5JwFRIglj83oMtPlYf/kVwQjB071Ci
	 nXGaqbbdwGERQ==
Date: Sat, 8 Feb 2025 16:15:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Hermes Zhang <Hermes.Zhang@axis.com>
Cc: <robh@kernel.org>, <lars@metafoo.de>, <krzk+dt@kernel.org>,
 <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: chemical: add support for Sensirion
 SEN5x/SEN6x
Message-ID: <20250208161501.7b6c6c17@jic23-huawei>
In-Reply-To: <20250206061521.2546108-4-Hermes.Zhang@axis.com>
References: <20250206061521.2546108-1-Hermes.Zhang@axis.com>
	<20250206061521.2546108-4-Hermes.Zhang@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:15:17 +0800
Hermes Zhang <Hermes.Zhang@axis.com> wrote:

> Add support for the Senseair SEN5x/SEN6x environment sensor through the
> IIO subsystem, include SEN50, SEN54, SEN55, SEN60, SEN65 and SEN66.
> Different sensor channels will be supported in different models:
> 
> SEN50: PM1, PM2.5, PM4, PM10
> SEN54: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC
> SEN55: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC, NOx
> 
> SEN60: PM1, PM2.5, PM4, PM10
> SEN65: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC, NOx
> SEN66: PM1, PM2.5, PM4, PM10, Humidity, Temperature, VOC, NOx, CO2
> 
> The driver support to read sensor data from raw data or iio buffer with
> software trigger configured.
> 
> Signed-off-by: Hermes Zhang <Hermes.Zhang@axis.com>
Hi Hermes,

Various comments inline.

Thanks,

Jonathan
> ---
>  drivers/iio/chemical/Kconfig      |  27 ++
>  drivers/iio/chemical/Makefile     |   3 +
>  drivers/iio/chemical/sen5x.c      |  76 +++++
>  drivers/iio/chemical/sen6x.c      |  76 +++++

The two specific drivers are very small. Probably makes more sense to squash
this into one file that supports all the parts.

>  drivers/iio/chemical/sen_common.c | 464 ++++++++++++++++++++++++++++++
>  drivers/iio/chemical/sen_common.h |  29 ++
>  6 files changed, 675 insertions(+)
>  create mode 100644 drivers/iio/chemical/sen5x.c
>  create mode 100644 drivers/iio/chemical/sen6x.c
>  create mode 100644 drivers/iio/chemical/sen_common.c
>  create mode 100644 drivers/iio/chemical/sen_common.h
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 330fe0af946f..8a21ac74d12b 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -166,6 +166,33 @@ config SCD4X
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called scd4x.
>  
> +config SENSIRION_SEN_COMMON
> +	tristate
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Common Sensirion environmental sensor code
> +
> +config SENSIRION_SEN5X
Please avoid wildcards.  We have had too many problems with them in the
past so now we name everything after one particular supported part.

> +	tristate "Sensirion SEN5x environmental sensor"
> +	select SENSIRION_SEN_COMMON
> +	help
> +	  Say Y here to build support for the Sensirion SEN5x environmental
> +	  sensor driver.
It is useful to provide a list of support sensors in here.
> +
> +	  To compile this driver as module, choose M here: the module will
> +	  be called sen5x.
> +
> +config SENSIRION_SEN6X
> +	tristate "Sensirion SEN6x environmental sensor"
> +	select SENSIRION_SEN_COMMON
> +	help
> +	  Say Y here to build support for the Sensirion SEN6x environmental
> +	  sensor driver.
> +
> +	  To compile this driver as module, choose M here: the module will
> +	  be called sen6x.
> +
>  config SENSIRION_SGP30
>  	tristate "Sensirion SGPxx gas sensors"
>  	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 4866db06bdc9..988c929383d4 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -21,6 +21,9 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
>  obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
>  obj-$(CONFIG_SCD4X) += scd4x.o
>  obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
> +obj-$(CONFIG_SENSIRION_SEN_COMMON)	+= sen_common.o
> +obj-$(CONFIG_SENSIRION_SEN5X)	+= sen5x.o
> +obj-$(CONFIG_SENSIRION_SEN6X)	+= sen6x.o
>  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
>  obj-$(CONFIG_SENSIRION_SGP40)	+= sgp40.o
>  obj-$(CONFIG_SPS30) += sps30.o
> diff --git a/drivers/iio/chemical/sen5x.c b/drivers/iio/chemical/sen5x.c
> new file mode 100644
> index 000000000000..ddd1cbf18d0c
> --- /dev/null
> +++ b/drivers/iio/chemical/sen5x.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "sen_common.h"
> +
> +#define SEN50_NUM_CHANNELS 4 /* PM1,PM2.5,PM4,PM10 */
> +#define SEN54_NUM_CHANNELS 7 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC */
> +#define SEN55_NUM_CHANNELS 8 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC,NOx */

These defines aren't particularly useful.  Just put the numbers directly
in below and move the comments down there.

> +
> +#define SEN5X_RESET_DELAY 100
> +
> +#define SEN5X_READ_MEASURED 0x03C4
> +
> +enum {
> +	SEN50,
> +	SEN54,
> +	SEN55,
In more recent drivers we have moved away from arrays
of chip info structures indexed by enum values.  It
ends up being easier to read if we just have separate
static const struct sen_chip_info sen50_chip;
static const struct sen_chip_info sen54_chip;

etc and then us pointers to those in the id tables.

> +};
> +
> +static const struct sen_chip_info sen5x_chips[] = {
> +	[SEN50] = {
> +		.reset_delay = SEN5X_RESET_DELAY,
> +		.num_iio_channels = SEN50_NUM_CHANNELS,
> +		.read_measured_cmd = SEN5X_READ_MEASURED,
> +		.read_measured_rx_size = 24,
> +		.temperature_compensation_required = false,
> +	},
> +	[SEN54] = {
> +		.reset_delay = SEN5X_RESET_DELAY,
> +		.num_iio_channels = SEN54_NUM_CHANNELS,
> +		.read_measured_cmd = SEN5X_READ_MEASURED,
> +		.read_measured_rx_size = 24,
> +		.temperature_compensation_required = true,
> +	},
> +	[SEN55] = {
> +		.reset_delay = SEN5X_RESET_DELAY,
> +		.num_iio_channels = SEN55_NUM_CHANNELS,
> +		.read_measured_cmd = SEN5X_READ_MEASURED,
> +		.read_measured_rx_size = 24,
> +		.temperature_compensation_required = true,
> +	},
> +};
> +
> +static int sen5x_probe(struct i2c_client *client)
> +{
> +	return sen_common_probe(client);
> +}
> +
> +static const struct i2c_device_id sen5x_id[] = {
> +						 { "sen50", },
> +						 { "sen54", },
> +						 { "sen55", },
These should have the same das as in the of_device_id table
and look ups should use the i2c core provided functions that fallback
to this array if a match isn't found in the of_device_id one.
That avoids tightly coupling the two as sometimes they may be out
of sync for various reasons..

> +						 {} };
Formatting wise:
static const struct i2c_device_id sen5x_id[] = {
	{ "sens50", ...

Just one tab ore than the line above.

> +
> +MODULE_DEVICE_TABLE(i2c, sen5x_id);
> +
> +static const struct of_device_id sen5x_dt_ids[] = {
> +	{ .compatible = "sensirion,sen50", .data = &sen5x_chips[SEN50] },
> +	{ .compatible = "sensirion,sen54", .data = &sen5x_chips[SEN54] },
> +	{ .compatible = "sensirion,sen55", .data = &sen5x_chips[SEN55] },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, sen5x_dt_ids);
> +
> +static struct i2c_driver sen5x_driver = {
> +	.driver = {
> +		.name = "sen5x",
> +		.of_match_table = sen5x_dt_ids,
> +	},
> +	.probe = sen5x_probe,
> +	.id_table = sen5x_id,
> +};
> +module_i2c_driver(sen5x_driver);
> +
> +MODULE_DESCRIPTION("Sensirion SEN5x environmental sensor");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/chemical/sen6x.c b/drivers/iio/chemical/sen6x.c
> new file mode 100644
> index 000000000000..ba99242f30ef
> --- /dev/null
> +++ b/drivers/iio/chemical/sen6x.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "sen_common.h"
> +
> +#define SEN60_NUM_CHANNELS 4 /* PM1,PM2.5,PM4,PM10 */
> +#define SEN65_NUM_CHANNELS 8 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC,NOx */
> +#define SEN66_NUM_CHANNELS 9 /* PM1,PM2.5,PM4,PM10,RHT,TEMP,VOC,NOx,CO2 */
> +
> +#define SEN6X_RESET_DELAY 1200
> +
> +#define SEN6X_READ_MEASURED 0x0300
> +
> +enum {
> +	SEN60,
> +	SEN65,
> +	SEN66,
> +};
> +
> +static const struct sen_chip_info sen6x_chips[] = {
> +	[SEN60] = {
> +		.reset_delay = SEN6X_RESET_DELAY,
> +		.num_iio_channels = SEN60_NUM_CHANNELS,
> +		.read_measured_cmd = SEN6X_READ_MEASURED,
> +		.read_measured_rx_size = 27,
> +		.temperature_compensation_required = false,
> +	},
> +	[SEN65] = {
> +		.reset_delay = SEN6X_RESET_DELAY,
> +		.num_iio_channels = SEN65_NUM_CHANNELS,
> +		.read_measured_cmd = SEN6X_READ_MEASURED,
> +		.read_measured_rx_size = 27,
> +		.temperature_compensation_required = false,
> +	},
> +	[SEN66] = {
> +		.reset_delay = SEN6X_RESET_DELAY,
> +		.num_iio_channels = SEN66_NUM_CHANNELS,
> +		.read_measured_cmd = SEN6X_READ_MEASURED,
> +		.read_measured_rx_size = 27,
> +		.temperature_compensation_required = false,
> +	},
> +};
> +
> +static int sen6x_probe(struct i2c_client *client)
> +{
> +	return sen_common_probe(client);
> +}
> +
> +static const struct i2c_device_id sen6x_id[] = {
> +						 { "sen60", },
> +						 { "sen65", },
> +						 { "sen66", },
> +						 {} };
> +
> +MODULE_DEVICE_TABLE(i2c, sen6x_id);
> +
> +static const struct of_device_id sen6x_dt_ids[] = {
> +	{ .compatible = "sensirion,sen60", .data = &sen6x_chips[SEN60] },
> +	{ .compatible = "sensirion,sen65", .data = &sen6x_chips[SEN65] },
> +	{ .compatible = "sensirion,sen66", .data = &sen6x_chips[SEN66] },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, sen6x_dt_ids);
> +
> +static struct i2c_driver sen6x_driver = {
> +	.driver = {
> +		.name = "sen6x",
> +		.of_match_table = sen6x_dt_ids,
> +	},
> +	.probe = sen6x_probe,
> +	.id_table = sen6x_id,
> +};
> +module_i2c_driver(sen6x_driver);

As above, there seems to be no advantage in having two drivers. Just merge
them into one that supports all the parts directly. 

> +
> +MODULE_DESCRIPTION("Sensirion SEN6x environmental sensor");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/chemical/sen_common.c b/drivers/iio/chemical/sen_common.c
> new file mode 100644
> index 000000000000..5fad439c87d9
> --- /dev/null
> +++ b/drivers/iio/chemical/sen_common.c
> @@ -0,0 +1,464 @@

> +#define PACK_CMD_HEAD(value, buffer)               \
> +	do {                                       \
> +		(buffer)[0] = ((value) >> 8) & 0xFF; \
> +		(buffer)[1] = (value) & 0xFF;        \
> +	} while (0)
This is a put_unaligned_be16() so just use that.


> +
> +/* Convert a 16-bit value to big-endian, store in a 3-bytes buffer with calculated CRC */
> +#define PACK_TO_BUFFER_WITH_CRC(value, buffer)                       \
> +	do {                                                         \
Better as a function I think. Let the compiler figure out if it wants to inline it
or not.

> +		u16 __be_value = cpu_to_be16(value);                 \
> +		(buffer)[0] = (__be_value >> 8) & 0xFF;              \
> +		(buffer)[1] = __be_value & 0xFF;                     \

unaligned put.

> +		(buffer)[2] = crc8(sen_common_crc8_table, buffer, 2, \
> +				   CRC8_INIT_VALUE);                 \
> +	} while (0)

>
> +
> +static int sen_common_status(struct i2c_client *client, int *status)
> +{
> +	unsigned char txbuf[SENXX_CMD_HEAD_LEN];
> +	unsigned char rxbuf[SENXX_DEVICE_STATUS_RSP_LEN];
> +	int ret;
> +
> +	PACK_CMD_HEAD(SENXX_DEVICE_STATUS, &txbuf[0]);
> +
> +	ret = i2c_master_send(client, txbuf, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(20);
> +
> +	ret = sen_common_i2c_recv_reply(client, rxbuf, sizeof(rxbuf));
> +	if (ret < 0)
> +		return ret;
> +
> +	*status = (rxbuf[0] << 24) + (rxbuf[1] << 16) + (rxbuf[2] << 8) +
> +		  rxbuf[3];
get_unaligned_be32()?

> +
> +	return 0;
> +}
> +
> +static int sen5x_set_temperature_compensation(struct i2c_client *client,
> +					      s16 offset, s16 slope, u16 time)
> +{
> +	unsigned char txbuf[SENXX_CMD_HEAD_LEN + SEN5X_TEMPERATURE_REQ_LEN];
> +	int ret;
> +
> +	PACK_CMD_HEAD(SEN5X_TEMPERATURE, &txbuf[0]);
> +
> +	PACK_TO_BUFFER_WITH_CRC(offset, &txbuf[2]);
> +	PACK_TO_BUFFER_WITH_CRC(slope, &txbuf[5]);
> +	PACK_TO_BUFFER_WITH_CRC(time, &txbuf[8]);
> +
> +	ret = i2c_master_send(client, txbuf, sizeof(txbuf));
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(20);
> +
> +	return 0;
> +}
> +
> +static int sen_common_fetch_measured(struct sen_common_state *state)
> +{
> +	struct i2c_client *client = state->client;
> +	unsigned char txbuf[SENXX_CMD_HEAD_LEN];
> +	unsigned char rxbuf[SENXX_MAX_MEASURED_RSP_LEN];

u8 for these.

> +	int rx_size = state->chip->read_measured_rx_size;
> +	int ret;
> +
> +	if (rx_size > SENXX_MAX_MEASURED_RSP_LEN)
> +		return -EINVAL;
> +
> +	PACK_CMD_HEAD(state->chip->read_measured_cmd, &txbuf[0]);

As above, this is a put_unaligned_be16() I think, so use that instead
of custom code.

> +
> +	/* sensor can only be polled once a second max per datasheet */
> +	if (!time_after(jiffies, state->last_update + HZ))
> +		return 0;
> +
> +	ret = i2c_master_send(client, txbuf, sizeof(txbuf));
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(20);
> +
> +	ret = sen_common_i2c_recv_reply(client, rxbuf, rx_size);
> +	if (ret < 0)
> +		return ret;
> +
> +	memcpy(&state->data, rxbuf, ret);

Why not just do the recv directly into state->data?

> +
> +	state->last_update = jiffies;
> +
> +	return 0;
> +}
> +
> +static ssize_t status_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct sen_common_state *state = iio_priv(indio_dev);
> +	int status;
> +	int ret;
> +
> +	ret = sen_common_status(state->client, &status);

This is custom ABI. So it would need documentation and will need
to overcome quite a high barrier.

Superficially this looks like debug perhaps that should be
in debugfs?

> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "%x\n", status);
> +}
> +
> +static IIO_DEVICE_ATTR_RO(status, 0);
> +
> +static struct attribute *sen_common_attrs[] = {
> +	&iio_dev_attr_status.dev_attr.attr, NULL
> +};
> +
> +static const struct attribute_group sen_common_attr_group = {
> +	.attrs = sen_common_attrs,
> +};
>
> +static int sen_common_read_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan, int *val,
> +			       int *val2, long mask)
> +{
> +	struct sen_common_state *state = iio_priv(indio_dev);
> +	int ret = IIO_VAL_INT;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&state->lock);

Add scope with {} and use guard(mutex) + include cleanup.h
that means you don't need to manually release the mutex.


> +		ret = sen_common_fetch_measured(state);
> +		if (ret < 0) {
> +			mutex_unlock(&state->lock);
> +			return ret;
> +		}
> +
> +		*val = be16_to_cpu(state->data[chan->address]);
> +
> +		mutex_unlock(&state->lock);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MASSCONCENTRATION:
> +			*val = 0;
> +			*val2 = 100000;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = 0;
> +			*val2 = 10000;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
As these first two are the same combine them

		case IIO_MASSCONCENTRATION:
		case IIO_HUMIIDTYRELATIVE:
			*val = ..

> +		case IIO_TEMP:
> +			*val = 0;
> +			*val2 = 5000;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_CONCENTRATION:
> +			switch (chan->channel2) {
> +			case IIO_MOD_NOX:
> +			case IIO_MOD_VOC:
> +				*val = 0;
> +				*val2 = 100000;
> +
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			case IIO_MOD_CO2:
> +				*val = 1;
> +				*val2 = 0;

If the scale is 1, convention is don't provide the attribute / info_mask
element for that channel as it is the default value anyway.

> +
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:

> +		*val = 1;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}

> +
> +int sen_common_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	const struct sen_chip_info *chip;
> +	const char *name = client->name;
> +	struct sen_common_state *state;
> +	struct iio_dev *indio_dev;
> +	char senxx[8];
> +	int ret = 0;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct sen_common_state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = i2c_get_match_data(client);
> +
> +	state = iio_priv(indio_dev);
> +	state->client = client;
> +	state->dev = dev;
> +	mutex_init(&state->lock);
> +	state->chip = chip;
> +
> +	crc8_populate_msb(sen_common_crc8_table, SENXX_CRC8_POLYNOMIAL);
> +
> +	ret = sen_common_simple_command(client, SENXX_RESET, chip->reset_delay);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sen_common_product_name(client, senxx, sizeof(senxx));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (strncasecmp(senxx, name, sizeof(senxx)) != 0)
> +		dev_warn(dev, "chip mismatch: %s != %s\n", senxx, name);
> +
> +	/* Set default temperature compensation parameters */
> +	if (chip->temperature_compensation_required) {
> +		ret = sen5x_set_temperature_compensation(client, 0, 0, 0);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret = sen_common_simple_command(client, SENXX_START_MEASUREMENT, 50);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->name = name;
> +	indio_dev->info = &sen_common_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = sen_common_channels;
> +	indio_dev->num_channels = chip->num_iio_channels;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      sen_common_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		dev_err(dev, "failed to register iio device\n");
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sen_common_probe);

After changes requested above you will only have one file anyway, but
for future reference please namespace driver specific exports.
EXPORT_SYMBOL_NS_GPL()

> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Sensirion SEN5x/SEN6x common functionality");


