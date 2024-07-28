Return-Path: <linux-iio+bounces-7996-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74D93E5D1
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D9A1C20AE9
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB09C535D4;
	Sun, 28 Jul 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIT/kSvf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEC5820E;
	Sun, 28 Jul 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180099; cv=none; b=MyRtrIAJ/mJzlrw9s5yXeEgLaV/5IjStTNrV7mMzIQ7fZdjrD4oFn+6xorxqhYMkhCCW+z3fnHzoZ6CsqkJ2zAyV+DoatxfVaE9FkzA6rJeqer/cNIbVB8ZJqUXss2zebrHf2C/gahX1GOtnrUhLjU19sE7QPcCjQwwtjqLK2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180099; c=relaxed/simple;
	bh=hIZ+VvnX+R4riv5JceJA06MGb2m7m03ksO2tDbjstio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwRS6wmYCsPxNiWeK7VRQqq/p83uVQJQzuT5mj/05Ung3tkIuO8bit0KXbpxi8vH/R1q7rmyYuJA1c32CCfrsmOatJbiDKAS+2Fy9AEOCQ/T7Kjlh+02haGYmVkQvxyfspFc+BUvCwvc3Hm7JmG9tQ9Tkc1st3RVySSihpHF/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIT/kSvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61843C116B1;
	Sun, 28 Jul 2024 15:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722180099;
	bh=hIZ+VvnX+R4riv5JceJA06MGb2m7m03ksO2tDbjstio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIT/kSvf9LLPaxdAC+n1uaajEx1XNqjnmxZahC/1PPaCpjZfvaxp0137RiJN8PLMx
	 ojtJ9OoIrPibs/1JvICUGX2tk7OXoTRuLRx0VCXIO2UWLO8fyh1du8uvOteFEJX2zA
	 PqDFk0Azoibv8AcYs3xffzzg3oo/2s5wvRc3Dx45W5i46HP+z4ewJU1mWf6JyptSQr
	 zP5Ji+OygCbYuAPN+uLlzz88yrCEU2jJMnI43knU3AGuJJxjyl9OIfxdwCh8xDBdXY
	 fHGW+SkPDgPhRqQOmjL+IVa2Q5rBr3cyqV13gThmBYrLzqnNtleYPbO8+m6Xy3t7uK
	 67v27GK16qg4A==
Date: Sun, 28 Jul 2024 16:21:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: humidity: Add support for ENS210
Message-ID: <20240728162131.5a49cdd3@jic23-huawei>
In-Reply-To: <20240722-ens21x-v5-2-cda88dce100e@thegoodpenguin.co.uk>
References: <20240722-ens21x-v5-0-cda88dce100e@thegoodpenguin.co.uk>
	<20240722-ens21x-v5-2-cda88dce100e@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 17:58:43 +0100
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk> wrote:

> Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.
> 
> The ENS21x is a family of temperature and relative humidity sensors with
> accuracies tailored to the needs of specific applications.
> 
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Hi Joshua,

I nearly took this with a few tweaks, but the address / casting issue for the
*_get_measurement looks to me like a more significant issue and the fix will need testing.

Various other minor bits and pieces inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
> new file mode 100644
> index 000000000000..9fe60a9eeef0
> --- /dev/null
> +++ b/drivers/iio/humidity/ens210.c
> @@ -0,0 +1,344 @@

...

> +
> +/**
> + * struct ens210_data - Humidity/Temperature sensor device structure
> + * @client:	i2c client
> + * @chip_info:	chip specific information
> + * @lock:	lock protecting the i2c conversion

That's not enough detail. I2C has it's own locks so we don't need to protect the
bus. I assume this is really about protecting a particular sequence of multiple
accesses?

> + */
> +struct ens210_data {
> +	struct i2c_client *client;
> +	const struct ens210_chip_info *chip_info;
> +	struct mutex lock;
> +};
> +
> +/* calculate 17-bit crc7 */
> +static u8 ens210_crc7(u32 val)
> +{
> +	unsigned int val_be = (val & 0x1ffff) >> 0x8;
> +
> +	return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
> +}
> +
> +static int ens210_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
> +{
> +	struct ens210_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	u32 regval;
> +	u8 regval_le[3];
> +	int ret;
> +
> +	/* assert read */
> +	ret = i2c_smbus_write_byte_data(data->client, ENS210_REG_SENS_START,
> +				  temp ? ENS210_SENS_START_T_START :
> +					 ENS210_SENS_START_H_START);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for conversion to be ready */
> +	msleep(data->chip_info->conv_time_msec);
> +
> +	ret = i2c_smbus_read_byte_data(data->client,
> +				       ENS210_REG_SENS_STAT);

Under 80 chars on one line.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* perform read */
> +	ret = i2c_smbus_read_i2c_block_data(
> +		data->client, temp ? ENS210_REG_T_VAL : ENS210_REG_H_VAL, 3,
> +		(u8 *)&regval_le);

This cast looks wrong and the need to have it indicates
a bigger issue.  regval_le is already u8 * so it's address is u8 ** and you
will be writing to the completely the wrong place.


> +	if (ret < 0) {
> +		dev_err(dev, "failed to read register");
> +		return -EIO;
you've returned so no need for an else for the next check.

	if (ret != 3)

> +	} else if (ret != 3) {
> +		dev_err(dev, "expected 3 bytes, received %d\n", ret);
> +		return -EIO;
> +	}
> +
> +	regval = get_unaligned_le24(regval_le);
> +	if (ens210_crc7(regval) != ((regval >> 17) & 0x7f)) {
> +		/* crc fail */
Comment very obvious. Drop it as such comments are just an opportunity for
becoming wrong in future as they bring no real value.

> +		dev_err(dev, "ens invalid crc\n");
> +		return -EIO;
> +	}
> +
> +	if (!((regval >> 16) & 0x1)) {
> +		dev_err(dev, "ens data is not valid");
> +		return -EIO;
> +	}
> +
> +	*val = regval & 0xffff;

	*val = regval & GENMASK(15, 0);
is, I think, slightly more readable.

> +	return IIO_VAL_INT;
> +}
> +
> +static int ens210_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
> +{
> +	struct ens210_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;

If we hit this value something went wrong..  Indeed see missing unreachable
below.  If that is confusing the compiler add a comment to say so.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->lock) {
> +			ret = ens210_get_measurement(indio_dev,
> +				channel->type == IIO_TEMP, val);
> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		}
> +		return ret;

unreachable()

> +	case IIO_CHAN_INFO_SCALE:
> +		if (channel->type == IIO_TEMP) {
> +			*val = 15;
> +			*val2 = 625000;
> +		} else {
> +			*val = 1;
> +			*val2 = 953125;
> +		}
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (channel->type == IIO_TEMP) {
> +			*val = -17481;
> +			*val2 = 600000;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;

return IIO_VAL_INT_PLUS_MICRO;
not break to an unreachable()!

> +		}
> +		*val = 0;

The default offset is 0 so don't report one for the humidity channel.
Just drop bit being set in info_mask_separate below.


> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +	unreachable();
> +}
> +
> +static const struct iio_chan_spec ens210_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
As above, drop the offset bit.
> +	}
> +};
> +
> +static const struct iio_info ens210_info = {
> +	.read_raw = ens210_read_raw,
> +};
> +
> +static int ens210_probe(struct i2c_client *client)
> +{
> +	struct ens210_data *data;
> +	struct iio_dev *indio_dev;
> +	uint16_t part_id;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +			I2C_FUNC_SMBUS_WRITE_BYTE |
> +			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		return dev_err_probe(&client->dev, -EOPNOTSUPP,
> +			"adapter does not support some i2c transactions\n");
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->lock);
> +	data->chip_info = i2c_get_match_data(client);
> +
> +	ret = devm_regulator_get_enable(&client->dev, "vdd");
> +	if (ret)
> +		return ret;
> +
> +	/* reset device */
> +	ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
> +					ENS210_SYS_CTRL_SYS_RESET);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for device to become active */
> +	usleep_range(4000, 5000);
> +
> +	/* disable low power mode */
> +	ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	/* wait for device to finish */
> +	usleep_range(4000, 5000);
> +
> +	/* get part_id */
> +	part_id = i2c_smbus_read_word_data(client, ENS210_REG_PART_ID);
This may return an error. So should check negative value separately
as if that happens we don't want to carry on.
	ret = i2c_...
	if (ret < 0)
		return ret;
	part_id = ret;

	...


> +
> +	if (part_id != data->chip_info->part_id) {
> +		dev_info(&client->dev,
> +			"Part ID does not match (0x%04x != 0x%04x)\n", part_id,
> +			data->chip_info->part_id);
> +	}
> +
> +	/* reenable low power */
> +	ret = i2c_smbus_write_byte_data(client, ENS210_REG_SYS_CTRL,
> +					ENS210_SYS_CTRL_LOW_POWER_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = data->chip_info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens210_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens210_channels);
> +	indio_dev->info = &ens210_info;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

> +static const struct of_device_id ens210_of_match[] = {
> +	{ .compatible = "sciosense,ens210", .data = &ens210_chip_info_data},
> +	{ .compatible = "sciosense,ens210a", .data = &ens210a_chip_info_data },
> +	{ .compatible = "sciosense,ens211", .data = &ens211_chip_info_data},
> +	{ .compatible = "sciosense,ens212", .data = &ens212_chip_info_data},

Trivial: should always be a space before }

> +	{ .compatible = "sciosense,ens213a", .data = &ens213a_chip_info_data },
> +	{ .compatible = "sciosense,ens215", .data = &ens215_chip_info_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ens210_of_match);
> +
> +static const struct i2c_device_id ens210_id_table[] = {
> +	{ "ens210", (kernel_ulong_t)&ens210_chip_info_data },
> +	{ "ens210a", (kernel_ulong_t)&ens210a_chip_info_data },
> +	{ "ens211", (kernel_ulong_t)&ens211_chip_info_data },
> +	{ "ens212", (kernel_ulong_t)&ens212_chip_info_data },
> +	{ "ens213a", (kernel_ulong_t)&ens213a_chip_info_data },
> +	{ "ens215", (kernel_ulong_t)&ens215_chip_info_data },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, ens210_id_table);
> +
> +static struct i2c_driver ens210_driver = {
> +	.probe = ens210_probe,
> +	.id_table = ens210_id_table,
> +	.driver = {
> +		.name = "ens210",
> +		.of_match_table = ens210_of_match,
> +	},
> +};
Trivial: Given close coupling between module_i2c_driver and the i2c_driver
structure it's common to not have a blank line here.

> +
> +module_i2c_driver(ens210_driver);
> +
> +MODULE_DESCRIPTION("ScioSense ENS210 temperature and humidity sensor driver");
> +MODULE_AUTHOR("Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>");
> +MODULE_LICENSE("GPL");
> 


