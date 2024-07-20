Return-Path: <linux-iio+bounces-7759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F993822F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB12A1F216A9
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2024 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0089F1474BA;
	Sat, 20 Jul 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzdouqRs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB61E481;
	Sat, 20 Jul 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721494487; cv=none; b=ZYjWDCdJO+GNZbZekUqQY3f9p3XQM/3eOMdO+MJCkNjCiN/A8063yH5Lje5Om6Uhztm4+k/8Mpci8mPCeXpvVRtYohRep94M4eKLqtS0Cv+tGv1e0SoOaiPLzzdg8yo7DZBLNU2L1c0tVQ1OFNq7dlE2cVeSmJdsWdNfbcMKUCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721494487; c=relaxed/simple;
	bh=nFKE0a+U26DTf1o65h/H0/T6Cwk7AXu/3eYhPRPJqts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPH5w8WfGTf4eWHZNyWOK0nECtfm5Rqn3VnL4JwtxG6r5VWtBHerGYkhIcuggzoTPWPedzBlTWMzFSkRKr1ehzKDHM+4X7RQU/A8TOSBN44rzN9s/9WnKc7FqIFuM5OGVNFEvI7nAQYtvMaVyKf4ZAwMQkMupCCXaJrYwOZ0Xjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzdouqRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BF5C2BD10;
	Sat, 20 Jul 2024 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721494487;
	bh=nFKE0a+U26DTf1o65h/H0/T6Cwk7AXu/3eYhPRPJqts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kzdouqRs1RQWFTpsyRaMxK6xzOF90H39M9tq1UFajHcW0k+rb+k1laDPq3UxmLPYZ
	 ZEe5kNzcTd0Ltu/9au8l9iv5tH9W0hvGjxZBQlGK6Rmj6NA2KpJ49q1lzgy8vLTkOo
	 mixnOtH5JJTlGe4f3xRMpUfvW3BEt5Vq/glzkzaNw9ZxJ/3nymffuGYUQPnuNun20y
	 /nwQHtcQYT+EESnMtT/0s+8uf+jbHr6kdZD2/XM/wNMd7C52IkJnjKy/VoZbOUuLJ1
	 KGTo/+E4XK1f4n0lRbzCgoE/L9z+yvYyU+G6P5tVqDiEYVwwA/MH1OwUpPCMpxVs6p
	 zprcOPjPk4OMw==
Date: Sat, 20 Jul 2024 17:54:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: humidity: Add support for ENS210
Message-ID: <20240720175439.54b73f2c@jic23-huawei>
In-Reply-To: <20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>
References: <20240719-ens21x-v4-0-6044e48a376a@thegoodpenguin.co.uk>
	<20240719-ens21x-v4-2-6044e48a376a@thegoodpenguin.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jul 2024 13:50:54 +0100
Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk> wrote:

> Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.
> 
> The ENS21x is a family of temperature and relative humidity sensors with
> accuracies tailored to the needs of specific applications.
> 
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Hi Joshua

Looking pretty good, but a few more minor comments.

Jonathan


> +
> +/**
> + * struct ens210_data - Humidity/Temperature sensor device structure
> + * @client:	i2c client
> + * @lock:	lock protecting the i2c conversion
> + * @res_index:	index to selected sensor resolution
> + */
> +struct ens210_data {
> +	struct i2c_client *client;
> +	const struct ens210_chip_info *chip_info;
> +	struct mutex lock;

Docs rather different to content. Make sure to run kernel-doc script
over the files and fix warnings.

> +};
> +
> +/* calculate 17-bit crc7 */
> +static u8 ens210_crc7(u32 val)
> +{
> +	__be32 val_be = (cpu_to_be32(val & 0x1ffff) >> 0x8);

drop excess outer brackets.

> +
> +	return crc7_be(0xde, (u8 *)&val_be, 3) >> 1;
> +}
> +
> +static int ens210_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
> +{
> +	u32 regval;
> +	u8 regval_le[3];
> +	int ret;
> +	struct ens210_data *data = iio_priv(indio_dev);
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
> +	if (ret < 0)
> +		return ret;
> +
> +	/* perform read */
> +	ret = i2c_smbus_read_i2c_block_data(
> +		data->client, temp ? ENS210_REG_T_VAL : ENS210_REG_H_VAL, 3,
> +		(u8 *)&regval_le);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "failed to read register");
> +		return -EIO;
> +	} else if (ret != 3) {
> +		dev_err(&indio_dev->dev, "expected 3 bytes, received %d\n", ret);

Use the i2c dev for all error messages.
The indio_dev->dev one is only available in some paths and not generally
as useful.

Add a local 
struct device *dev = &data->client->dev;
in places where you use it lots of times.

> +		return -EIO;
> +	}
> +
> +	regval = get_unaligned_le24(regval_le);
> +	if (ens210_crc7(regval) != ((regval >> 17) & 0x7f)) {

> +		/* crc fail */
> +		dev_err(&indio_dev->dev, "ens invalid crc\n");
> +		return -EIO;
> +	}
> +
> +	*val = regval & 0xffff;
I wondered what the 17th bit is and it seems to be a valid flag.
Should we be checking that before returning the data?

> +	return IIO_VAL_INT;
> +}
> +
> +static int ens210_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
> +{
> +	struct ens210_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->lock) {
> +			ret = ens210_get_measurement(
> +				indio_dev, channel->type == IIO_TEMP, val);
Odd line wrapping. I'd just use a slightly long line and format as
>			ret = ens210_get_measurement(indio_dev,
						     channel->type == IIO_TEMP,
						     val);


> +			if (ret)
> +				return ret;
> +			return IIO_VAL_INT;
> +		}
> +		return ret;
		unreachable();
The compiler may fail to figure out we can't get here so we tell it.
The drop the return ret;

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
> +		}
> +		*val = 0;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +	return ret;
Unreachable code I think, so drop it.

> +}
> +

> +static int ens210_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
Don't think this is used any more. 
> +	struct ens210_data *data;
> +	struct iio_dev *indio_dev;
> +	uint16_t part_id;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +			I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
> +			I2C_FUNC_SMBUS_WRITE_BYTE |
> +			I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +		dev_err_probe(&client->dev, -EOPNOTSUPP,
> +			"adapter does not support some i2c transactions\n");
> +		return -EOPNOTSUPP;
		return dev_err_probe()
don't worry about the slightly long line.

> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

Used?  If not drop it.

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
> +
> +	if (part_id != data->chip_info->part_id) {
> +		dev_info(&client->dev,
> +			"Part ID does not match (0x%04x != 0x%04lx)\n", part_id,
%04x as per the build bot warning.

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


