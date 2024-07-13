Return-Path: <linux-iio+bounces-7593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851A930571
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8631F21D4B
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8A9130A66;
	Sat, 13 Jul 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icpo7R1X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96612FF8B;
	Sat, 13 Jul 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720871280; cv=none; b=TzqlpZQc1yT9egks/ojgexioZR73UFhkP2qDZYvuwxHK++h7FKgqHPvFQswsHKMsY11+Hp4lxKFXViI/mGKzOwHdUGY+WWg0B9oHcs0dIx/bekeRPEYx2weQWz/JJGgPik6qiPbjZUWOC0aqPRQDMEGIqWlk/JTJ1xAhRiQMZ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720871280; c=relaxed/simple;
	bh=8O+wfj3mdhT8wrDNeZzW84XVFXHIZvTWS/dtDMVgJbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hr8dNM46vEThAfbOBr5Ve4tTQFxzA3dKCiK0etyJoIOvge+jP1GSGinLR0TkkNhJkuXDaRKpQqEbMbx6S/AMTZ7RD3jZ5H/yhHDCaqHLOxdiDwA/Hr6CPPfnXUVLfYTXL2oo+OreYJq4VKhilV0M1ID8vXXmdGtu6Sni7zJxOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icpo7R1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437EDC32781;
	Sat, 13 Jul 2024 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720871279;
	bh=8O+wfj3mdhT8wrDNeZzW84XVFXHIZvTWS/dtDMVgJbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Icpo7R1XGtxiPeKlBK29lsr2im4dYqxAlgQGE7QGixZZbzxpzGp6+vX3Qa82Kd8Hc
	 zZ5MJ665EqnchTPTQP58Tngsp2S1nBRjY84MqoX4+RsQSQktefkOGpxxMOF/w7ynLi
	 I0Lv+pAQqRkgy2nFbyMtcxXWPkQxHdz1mSp6LKS+JsuMAWsxsT5hF+a25zn9dlnB3g
	 T4v5m+QPFWsvXrjBbczpMetfw0az7/Qf6TeVuVN+G4v56Mx3sYuOS6BDvYlm4S9Krb
	 ZiPn+Dr2T8doeWSqsdxKjsgY+TRYD4yrVDSgSOSxD/ImfOP5mXPTp8gHj1OVVh5ykO
	 YohhCrgRKRPzQ==
Date: Sat, 13 Jul 2024 12:47:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: humidity: Add support for ENS21x
Message-ID: <20240713124751.2add8526@jic23-huawei>
In-Reply-To: <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>
References: <20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk>
	<20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 14:24:05 +0100
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk> wrote:

> Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.
> 
> The ENS21x is a family of temperature and relative humidity sensors with
> accuracies tailored to the needs of specific applications.
> 
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Hi Joshua,

Various comments inline

Jonathan

> ---
>  drivers/iio/humidity/Kconfig  |  11 ++
>  drivers/iio/humidity/Makefile |   1 +
>  drivers/iio/humidity/ens21x.c | 346 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 358 insertions(+)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index b15b7a3b66d5..ff62abf730d1 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -25,6 +25,17 @@ config DHT11
>  	  Other sensors should work as well as long as they speak the
>  	  same protocol.
>  
> +config ENS21X
> +	tristate "ENS21X temperature and humidity sensor"
> +	depends on I2C
> +	help
> +	  Say yes here to get support for the ScioSense ENS21X family of
> +	  humidity and temperature sensors.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ens21x.
> +

Keep to local style, so one blank line only.

> +
>  config HDC100X
>  	tristate "TI HDC100x relative humidity and temperature sensor"
>  	depends on I2C

> diff --git a/drivers/iio/humidity/ens21x.c b/drivers/iio/humidity/ens21x.c
> new file mode 100644
> index 000000000000..7b2e279d1559
> --- /dev/null
> +++ b/drivers/iio/humidity/ens21x.c
> @@ -0,0 +1,346 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ens21x.c - Support for ScioSense ens21x
> + *           temperature & humidity sensor

Very short line wrap so odd looking formatting.

> + *
> + * (7-bit I2C slave address 0x43 ENS210)
> + * (7-bit I2C slave address 0x43 ENS210A)
> + * (7-bit I2C slave address 0x44 ENS211)
> + * (7-bit I2C slave address 0x45 ENS212)
> + * (7-bit I2C slave address 0x46 ENS213A)
> + * (7-bit I2C slave address 0x47 ENS215)
> + *
> + * Datasheet:
> + *  https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
> + *  https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
> + */
> +
> +#include <linux/types.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

Fix the various of stuff below and there won't be anything from either of these
headers but you should include
mod_devicetable.h for the various id tables.

> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Not seeing this used. It's for custom attributes only.

> +#include <linux/crc7.h>
> +
> +/* register definitions */
> +#define ENS21X_REG_PART_ID		0x00
> +#define ENS21X_REG_DIE_REV		0x02
> +#define ENS21X_REG_UID			0x04
> +#define ENS21X_REG_SYS_CTRL		0x10
> +#define ENS21X_REG_SYS_STAT		0x11
> +#define ENS21X_REG_SENS_RUN		0x21
> +#define ENS21X_REG_SENS_START		0x22
> +#define ENS21X_REG_SENS_STOP		0x23
> +#define ENS21X_REG_SENS_STAT		0x24
> +#define ENS21X_REG_T_VAL		0x30
> +#define ENS21X_REG_H_VAL		0x33
> +
> +/* value definitions */
> +#define ENS21X_SENS_START_T_START		BIT(0)
> +#define ENS21X_SENS_START_H_START		BIT(1)
> +
> +#define ENS21X_SENS_STAT_T_ACTIVE		BIT(0)
> +#define ENS21X_SENS_STAT_H_ACTIVE		BIT(1)
> +
> +#define ENS21X_SYS_CTRL_LOW_POWER_ENABLE	BIT(0)
> +#define ENS21X_SYS_CTRL_SYS_RESET		BIT(7)
> +
> +#define ENS21X_SYS_STAT_SYS_ACTIVE		BIT(0)
> +
> +/* magic constants */
> +#define ENS21X_CONST_TEMP_SCALE_INT 15 /* integer part of temperature scale (1/64) */
> +#define ENS21X_CONST_TEMP_SCALE_DEC 625000 /* decimal part of temperature scale */

These defines aren't magic in any sense! They are the actual values.
As such, just use them inline in the code where they will also
be self documenting (so probably no need for comments unless they are
relating them to maths used to find the values).


> +#define ENS21X_CONST_HUM_SCALE_INT 1 /* integer part of humidity scale (1/512) */
> +#define ENS21X_CONST_HUM_SCALE_DEC 953125 /* decimal part of humidity scale */
> +#define ENS21X_CONST_TEMP_OFFSET_INT -17481 /* temperature offset (64 * -273.15) */
> +#define ENS21X_CONST_TEMP_OFFSET_DEC 600000 /* decimal part of offset */
> +#define ENS210_CONST_CONVERSION_TIME 130

Conversion times are more reasonable things to have defines for if they
turn up in multiple places.  Good if the define tells us the units
though and no need for it to involve CONST.  Anything in capitals is assumed
to be a define.
ENS210_CONVERSION_TIME_MSECS etc


> +#define ENS212_CONST_CONVERSION_TIME 32
> +#define ENS215_CONST_CONVERSION_TIME 132
> +
> +static const struct of_device_id ens21x_of_match[];

This won't be needed after changes suggested below.

> +
> +struct ens21x_dev {
> +	struct i2c_client *client;
> +	struct mutex lock;
All locks need documentation of what data they are protecting.

> +	int part_id;

I'd expect to see this embedded in the chip_info structure suggested below.

> +};
> +
> +enum ens21x_partnumber {
> +	ENS210	= 0x0210,
> +	ENS210A	= 0xa210,
> +	ENS211	= 0x0211,
> +	ENS212	= 0x0212,
> +	ENS213A	= 0xa213,
> +	ENS215	= 0x0215,
> +};
> +
> +/* calculate 17-bit crc7 */
> +static u8 ens21x_crc7(u32 val)
> +{
> +	u32 val_be = (htonl(val & 0x1ffff) >> 0x8);
Long time since I've seen htonl in kernel code.

	__be32 val_be = cpu_to_be32(val);

I'm suspicious though. You take a le24 below, convert
that to CPU then to be24. That's just always byte
swapping.  If you need to flip the byte order, just do
that.


> +
> +	return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
> +}
> +
> +static int ens21x_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
> +{
> +	u32 regval, regval_le;
> +	int ret, tries;
> +	struct ens21x_dev *dev_data = iio_priv(indio_dev);

dev_data tends to suggest output dev_get_drvdata() or similar.
More common in IIO to name it after the part so ens210_data
or similar.


> +
> +	/* assert read */
> +	i2c_smbus_write_byte_data(dev_data->client, ENS21X_REG_SENS_START,
> +				  temp ? ENS21X_SENS_START_T_START :
> +					 ENS21X_SENS_START_H_START);

Check return values from all i2c calls.  If it's expected to return an
error (that happens for some corner cases) then document why we ignore it.


> +
> +	/* wait for conversion to be ready */
> +	switch (dev_data->part_id) {

This per chip type data belongs in a chip_info structure (see below)
so that this just ebcomes

	msleep(dev_data->chip_info.conv_time_msec);

or something like that. It is almost always preferable to make this
sort of stuff picking between data, rather than inline code as
it puts all the per device stuff in one place rather than scattered
throughout.


> +	case ENS210:
> +	case ENS210A:
> +		msleep(ENS210_CONST_CONVERSION_TIME);
> +		break;
> +	case ENS211:
> +	case ENS212:
> +		msleep(ENS212_CONST_CONVERSION_TIME);
> +		break;
> +	case ENS213A:
> +	case ENS215:
> +		msleep(ENS215_CONST_CONVERSION_TIME);
> +		break;
> +	default:
> +		dev_err(&dev_data->client->dev, "unrecognised device");
> +		return -ENODEV;
> +	}
> +
> +	tries = 10;
> +	while (tries-- > 0) {

A retry loop like this needs a comment on why it's needed and
why this particular number of retries.

> +		usleep_range(4000, 5000);
> +		ret = i2c_smbus_read_byte_data(dev_data->client,
> +					       ENS21X_REG_SENS_STAT);
> +		if (ret < 0)
> +			continue;
Error expected here?  That's nasty if true that the device stops
talking i2c right when capturing data.  If not, return an error,
not carry on, as it's a sign the comms is broken.

> +		if (!(ret & (temp ? ENS21X_SENS_STAT_T_ACTIVE :
> +				    ENS21X_SENS_STAT_H_ACTIVE)))
> +			break;
> +	}
> +	if (tries < 0) {
> +		dev_err(&indio_dev->dev, "timeout waiting for sensor reading\n");
> +		return -EIO;
> +	}
> +
> +	/* perform read */
> +	ret = i2c_smbus_read_i2c_block_data(
> +		dev_data->client, temp ? ENS21X_REG_T_VAL : ENS21X_REG_H_VAL, 3,
> +		(u8 *)&regval_le);

If it is 3 bytes, read into a u8[3] and use get_unaligned_le24()

> +	if (ret < 0) {
> +		dev_err(&dev_data->client->dev, "failed to read register");
> +		return -EIO;
> +	} else if (ret == 3) {
> +		regval = le32_to_cpu(regval_le);
> +		if (ens21x_crc7(regval) == ((regval >> 17) & 0x7f)) {

pull that bytes from the u8[3] mentioned above

> +			*val = regval & 0xffff;
> +			return IIO_VAL_INT;
Always prefer the good path to be the inline one for ease of code reading..
So flip the logic.
Generally we keep the IIO return values to the boundary code with
the IIO core, so I'd return 0 here and check for errors at the claller
before returning IIO_VAL_INT.  That way we don't need to check all callers
of this function handling the unusual return code right.

> +		}get_measurement
> +		/* crc fail */
> +		dev_err(&indio_dev->dev, "ens invalid crc\n");
> +		return -EIO;
> +	}
> +
> +	dev_err(&indio_dev->dev, "expected 3 bytes, received %d\n", ret);
Check that before the crc.  As then you can reduce indent of the more
complex code.

> +	return -EIO;
> +}
> +
> +static int ens21x_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
> +{
> +	struct ens21x_dev *dev_data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&dev_data->lock);

		scoped_guard(mutex)(&dev_data->lock) {
			ret = ens21x_get_measurement();
			if (ret)
				return ret;

			return IIO_VAL_INT;

		}	

> +		ret = ens21x_get_measurement(
> +			indio_dev, channel->type == IIO_TEMP, val);
> +		mutex_unlock(&dev_data->lock);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type == IIO_TEMP) {
> +			*val = ENS21X_CONST_TEMP_SCALE_INT;
> +			*val2 = ENS21X_CONST_TEMP_SCALE_DEC;
> +		} else {
> +			*val = ENS21X_CONST_HUM_SCALE_INT;
> +			*val2 = ENS21X_CONST_HUM_SCALE_DEC;
> +		}
> +		ret = IIO_VAL_INT_PLUS_MICRO;
		return IIO_VAL_INT_PLUS_MICRO;

> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (channel->type == IIO_TEMP) {
> +			*val = ENS21X_CONST_TEMP_OFFSET_INT;
> +			*val2 = ENS21X_CONST_TEMP_OFFSET_DEC;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		}
> +		*val = 0;
> +		ret =  IIO_VAL_INT;
Odd spacing + 
		return IIO_VAL_INT;
> +		break;
> +	default:
> +		break;
		return -EINVAL;
> +	}
> +	return ret;
get rid of this as after changes above this is unreachable.

For code readability reasons, early returns are good.
Someone interested in a given path has to look at the minimal amount
of code rather than having to chase through to a much later return
with nothing actually done on the way there.

> +}
> +
> +static const struct iio_chan_spec ens21x_channels[] = {
> +	/* Temperature channel */

Obvious from .type, so I'd drop the comments.

> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	/* Humidity channel */
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +	}
> +};
> +
> +static const struct iio_info ens21x_info = {
> +	.read_raw = ens21x_read_raw,
> +};
> +
> +static int ens21x_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	const struct of_device_id *match;
> +	struct ens21x_dev *dev_data;
> +	struct iio_dev *indio_dev;
> +	uint16_t part_id_le, part_id;
> +	int ret, tries;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +			I2C_FUNC_SMBUS_WRITE_BYTE |
> +			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		dev_err(&client->dev,
> +			"adapter does not support some i2c transactions\n");
> +		return -EOPNOTSUPP;
in probe, nicer to use dev_err_probe() throughout. Doesn't matter much in this
case, but good for consistency with where it might.

		return dev_err_probe(&client->dev, -EOPNOTSUPP,
				     "adapter does not...
> +	}
> +
> +	match = i2c_of_match_device(ens21x_of_match, client);
> +	if (!match)
> +		return -ENODEV;
Why?

I suspect what you actually want is i2c_get_match_data(client);
That gets the data for all supported firmware types including DT.



> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*dev_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	dev_data->client = client;
> +	mutex_init(&dev_data->lock);
> +
turn the power on?
	ret = devm_regulator_get_enabled() or similar

> +	/* reset device */
> +	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
> +					ENS21X_SYS_CTRL_SYS_RESET);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for device to become active */
> +	usleep_range(4000, 5000);
> +
> +	/* disable low power mode */
> +	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for device to become active */
Why this long?  Reference some power up delay in the datahseet?
> +	tries = 10;
> +	while (tries-- > 0) {
> +		msleep(20);
> +		ret = i2c_smbus_read_byte_data(client, ENS21X_REG_SYS_STAT);
> +		if (ret < 0)
> +			return ret;
> +		if (ret & ENS21X_SYS_STAT_SYS_ACTIVE)
> +			break;
> +	}
> +	if (tries < 0) {
> +		dev_err(&client->dev,
> +			"timeout waiting for ens21x to become active\n");
> +		return -EIO;
> +	}
> +
> +	/* get part_id */
> +	part_id_le = i2c_smbus_read_word_data(client, ENS21X_REG_PART_ID);


> +	if (part_id_le < 0)
> +		return part_id_le;
> +	part_id = le16_to_cpu(part_id_le);

Smbus has a byte order and the values returned from i2c_smbus_read_word_data()
are already cpu endian.  So this shouldn't be needed.
(that's the reason we have i2c_smbus_read_word_swapped() for when it is in
reverse order of the smbus spec - happens annoyingly commonly).

> +
> +	if (part_id != id->driver_data) {
> +		dev_err(&client->dev,
> +			"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,

dev_info() and no error return only.
This hard check is something we used to do, but DT maintainers pointed out a while
back that it breaks the use of fallback compatibles to allow old drivers to work
out of the box with new hardware.   It is useful to print a message though saying
we've seen something unexpected.

> +			id->driver_data);
> +		return -ENODEV;
> +	}
> +
> +	/* reenable low power */
> +	ret = i2c_smbus_write_byte_data(client, ENS21X_REG_SYS_CTRL,
> +					ENS21X_SYS_CTRL_LOW_POWER_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	dev_data->part_id = part_id;
> +
> +	indio_dev->name = id->name;

This tends to be fragile as we add other firmware types etc.  So
I'd prefer to see the name inside the chip_info structure suggested below.

> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens21x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens21x_channels);
> +	indio_dev->info = &ens21x_info;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +
> +static const struct of_device_id ens21x_of_match[] = {
> +	{ .compatible = "sciosense,ens210", .data = (void *)ENS210},

Putting enums into the data fields has a habit of causing bugs.
You've avoided the most common one which is a 0 value, but still
I'd prefer these to be a pointer to a ens210_chip_info structure.

> +	{ .compatible = "sciosense,ens210a", .data = (void *)ENS210A },
> +	{ .compatible = "sciosense,ens211", .data = (void *)ENS211},
> +	{ .compatible = "sciosense,ens212", .data = (void *)ENS212},
> +	{ .compatible = "sciosense,ens213a", .data = (void *)ENS213A },
> +	{ .compatible = "sciosense,ens215", .data = (void *)ENS215},
> +	{},
No comma after a 'terminator' like this as we don't want it to be easy
for people to put something here.

> +};
> +MODULE_DEVICE_TABLE(of, ens21x_of_match);
> +
> +static const struct i2c_device_id ens21x_id[] = {
> +	{"ens210", ENS210},
> +	{"ens210a", ENS210A},
> +	{"ens211", ENS211},
> +	{"ens212", ENS212},
> +	{"ens213a", ENS213A},
> +	{"ens215", ENS215},
> +	{}
Consistent spacing needed so after { and before } in all cases like htis.

> +};
> +MODULE_DEVICE_TABLE(i2c, ens21x_id);
> +
> +static struct i2c_driver ens21x_driver = {
> +	.probe = ens21x_probe,
> +	.id_table = ens21x_id,
> +	.driver = {
> +		.name = "ens21x",
> +		.of_match_table = ens21x_of_match,
> +	},
> +};
> +
> +module_i2c_driver(ens21x_driver);
> +
> +MODULE_DESCRIPTION("ScioSense ENS21x temperature and humidity sensor driver");
> +MODULE_AUTHOR("Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>");
> +MODULE_LICENSE("GPL");
> +

Unless I'm reading the diff wrong looks like a spare blank line at the end.
Trivial but delete that.

> 


